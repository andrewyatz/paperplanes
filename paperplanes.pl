#!/usr/bin/env perl
use strict;
use warnings;
use Mojolicious::Lite;
use Mojo::UserAgent;
use XML::Simple;
use Mojo::JSON;

use PaperPlanes::Schema;
my $schema = PaperPlanes::Schema->connect('dbi:SQLite:dbname=paperplanes.db');

helper get_object_by_id => sub {
  my ($c, $resultset, $id) = @_;
  $id //= $c->stash('id');
  my $key = lc($resultset).'_id';
  my $obj = $schema->resultset($resultset)->find({$key => $id});
  return $obj;
};

helper getall => sub {
  my ($c, $resultset) = @_;
  my @all = $schema->resultset($resultset)->all();
  $c->respond_to(
    json => sub {
      $c->render(json => [ @all ] )
    }
  );
};

helper get => sub {
  my ($c, $resultset) = @_;
  my $obj = $c->get_object_by_id($resultset);
  $c->respond_to(
    json => sub {
      $c->render(json => $obj);
    }
  );
};

helper create => sub {
  my ($c, $resultset) = @_;
  my $obj = $schema->resultset($resultset)->create(
    $c->req->json()
  );
  $c->respond_to(
    json => sub {
      $c->render(json => $obj);
    }
  );
};

# Update based on by id. We also pass the hash into an optional sub before inflating
helper update => sub {
  my ($c, $resultset, $update_sub) = @_;
  my $json = $c->req->json;
  my $obj = $c->get_object_by_id($resultset);
  $json = $update_sub->($c, $resultset, $json, $obj) if defined $update_sub;
  $obj->set_inflated_columns($json);
  $obj->update();
  $c->respond_to(
    json => sub {
      $c->render(json => $obj);
    }
  );
};

# Remove by :id
helper del => sub {
  my ($c, $resultset) = @_;
  my $obj = $c->get_object_by_id($resultset);
  my $ret = {};
  if(defined $obj) {
    $obj->delete() if defined $obj;
    $ret = $obj;
  }
  $c->respond_to(
    json => sub {
      $c->render(json => $ret);
    }
  );
};

sub create_endpoints {
  my ($resultset, $url_base, $update_sub) = @_;
  my $id_url = $url_base.'/:id';
  
  get $url_base => sub {
    my $c = shift;
    $c->getall($resultset);
  };

  post $url_base => sub {
    my $c = shift;
    $c->create($resultset);
  };

  get $id_url => sub {
    my $c = shift;
    $c->get($resultset);
  };

  put $id_url => sub {
    my $c = shift;
    $c->update($resultset, $update_sub);
  };
  
  del $id_url => sub {
    my $c = shift;
    $c->del($resultset);
  };
}

create_endpoints('Agency', '/agency');

create_endpoints('Award', '/award', sub {
  my ($c, $resultset, $json, $obj) = @_;
  $json->{agency} = $c->get_object_by_id('Agency', $json->{agency}->{agency_id});
  return $json;
});

create_endpoints('Project', '/project');

create_endpoints('Team', '/team');

create_endpoints('Person', '/person', sub {
  my ($c, $resultset, $json, $obj) = @_;
  $json->{default_project} = $c->get_object_by_id('Project', $json->{default_project}->{project_id});
  $json->{default_team} = $c->get_object_by_id('Team', $json->{default_team}->{team_id});
  return $json;
});

############## SEARCH EUROPMC

get '/searchpmc' => sub {
  my $c = shift;
  my $q = $c->param('q');
  my $resulttype = $c->param('resulttype') // 'lite';
  my $url = sprintf('http://www.ebi.ac.uk/europepmc/webservices/rest/search/format=json&resulttype=%s&query=%s', $resulttype, $q);
  my $ua = Mojo::UserAgent->new;
  my $body = $ua->get($url => {Accept => '*/*'})->res->json;
  my $results = [];
  if(exists $body->{resultList}) {
    $results = $body->{resultList}->{result};
    foreach my $record (@{$results}) {
      my $authors = $record->{authorString};
      if(! defined $authors) {
        $record->{authors} = [];
        $record->{author_count} = 0;
        next;
      }
      $authors =~ s/\.$//;
      my $position = 1;
      my @split_authors = 
        map { 
          my ($name, $inital) = $_ =~ /\s*(.+) (.+)$/; 
          my @split_initals = split(//, $inital);
          { initals => $inital, split_initals => \@split_initals, last_name => $name, position => $position++ }; 
        } 
        split(/,/, $authors);
      $record->{authors} = \@split_authors;
      $record->{author_count} = scalar(@split_authors);
    }
  }
  $c->respond_to(
    json => sub {
      $c->render(json => { results => $results } );
    }
  );
};

# Assumes input like so (position is optional but will be copied back across):
# [
#   {initals => "A", split_initals => ["A"], last_name => "Yates", position => 1},
# ]
#
# Output looks like (input plus major objects for output):
#
# [
#   {
#     person_id => 1, first_name => 'Andy', orcid => 'XXX', initals => "A", split_initals => ["A"], last_name => "Yates", position => 1, default_project => {}, default_team => {}, project => {}, team => {}
#   },
# ]
#
post '/paper/matchauthors' => sub {
  my $c = shift;
  my $body = $c->req->json();
  my @results;
  
  my $rs = $schema->resultset('Person');
  
  foreach my $author_hash (@{$body}) {
    my @possible_hits = $rs->search({ 
      last_name => $author_hash->{last_name}, 
      first_name => { 'like', $author_hash->{split_initals}->[0].'%' }
    });

    my $person;
    if(@possible_hits) {
      if(scalar(@possible_hits) > 1) {
        warn 'Found too many hits. Need to build logic here if it happens ...';
      }
      else {
        $person = $possible_hits[0]->TO_JSON();
        $person->{initals} = $author_hash->{initals};
        $person->{split_initals} = $author_hash->{split_initals};
        $person->{position} = $author_hash->{position} if $author_hash->{position};
        $person->{team} = $person->{default_team};
        $person->{project} = $person->{default_project};
        $person->{ignore} = Mojo::JSON->false;
      }
    }
    else {
      $person = $author_hash;
      $person->{ignore} = Mojo::JSON->true;
    }
    push(@results, $person);
  }
  
  
  $c->respond_to(
    json => sub {
      $c->render(json => { results => \@results } );
    }
  );
};

# get '/' => sub {
#   my $c = shift;
#   $c->render;
# } => 'index';

app->start;

__DATA__
