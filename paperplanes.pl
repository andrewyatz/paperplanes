#!/usr/bin/env perl
use strict;
use warnings;
use Mojolicious::Lite;
use Mojo::UserAgent;
use Mojo::JSON qw/decode_json/;
use Mojo::URL;
use Mojolicious::Static;
use FindBin qw/$Bin/;
use File::Spec;
use PaperPlanes::Schema;
use DateTime::Format::ISO8601;

# use DBI; DBI->trace(1);

my @dbargs;
if($ENV{SQLITE}) {
  push(@dbargs, 'dbi:SQLite:dbname=paperplanes.db');
}
elsif($ENV{PG}) {
  $ENV{PGDATABASE} //= 'paperplanes';
  $ENV{PGHOST} //= 'localhost';
  $ENV{PGPORT} //= 5432;
  push(@dbargs, sprintf('dbi:Pg:dbname=%s;host=%s;port=%s', $ENV{PGDATABASE}, $ENV{PGHOST}, $ENV{PGPORT}));
  push(@dbargs, $ENV{PGUSER}) if exists $ENV{PGUSER};
  push(@dbargs, $ENV{PGPASSWORD}) if exists $ENV{PGPASSWORD};
}
elsif($ENV{DATABASE_URL}) {
  my $url = Mojo::URL->new($ENV{DATABASE_URL});
  my ($user,$pass) = split(/:/, $url->userinfo());
  my $db = $url->path();
  $db =~ s/^\///;
  push(@dbargs, sprintf('dbi:Pg:dbname=%s;host=%s;port=%s', $db, $url->host(), $url->port()));
  push(@dbargs, $user, $pass);
}

my $schema = PaperPlanes::Schema->connect(@dbargs);
my $static = Mojolicious::Static->new();
push @{$static->paths}, File::Spec->catdir($Bin, 'public');

helper get_id_attrib_name => sub {
  my ($c, $resultset) = @_;
  my $key = lc($resultset).'_id';
  return $key;
};

helper get_object_by_id => sub {
  my ($c, $resultset, $id) = @_;
  $id //= $c->stash('id');
  my $key = $c->get_id_attrib_name($resultset);
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
  my ($c, $resultset, $create_sub) = @_;
  my $json = $c->req->json();
  $json = $create_sub->($c, $resultset, $json) if defined $create_sub;
  my $obj = $schema->resultset($resultset)->create($json);
  my $id = $obj->can($c->get_id_attrib_name($resultset))->($obj);
  my $new_obj = $c->get_object_by_id($resultset, $id);
  $c->respond_to(
    json => sub {
      $c->render(json => $new_obj)
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
  my $new_obj = $c->get_object_by_id($resultset);
  $c->respond_to(
    json => sub {
      $c->render(json => $new_obj);
    }
  );
};

# Remove by :id
helper del => sub {
  my ($c, $resultset, $delete_sub) = @_;
  my $obj = $c->get_object_by_id($resultset);
  my $ret = {};
  if(defined $obj) {
    my $guard = $schema->txn_scope_guard();
    warn $delete_sub;
    $delete_sub->($c, $resultset, $obj) if defined $delete_sub;
    $obj->delete();
    $ret = $obj;
    $guard->commit();
  }
  $c->respond_to(
    json => sub {
      $c->render(json => $ret);
    }
  );
};

sub create_endpoints {
  my ($resultset, $url_base, $create_sub, $update_sub, $delete_sub) = @_;
  my $id_url = $url_base.'/:id';
  
  get $url_base => sub {
    my $c = shift;
    $c->getall($resultset);
  };

  post $url_base => sub {
    my $c = shift;
    $c->create($resultset, $create_sub);
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
    $c->del($resultset, $delete_sub);
  };
}

create_endpoints('Agency', '/agency');

create_endpoints('Award', '/award', 
sub {
  my ($c, $resultset, $json) = @_;
  $json->{start} = DateTime::Format::ISO8601->parse_datetime($json->{start});
  $json->{finish} = DateTime::Format::ISO8601->parse_datetime($json->{finish});
  return $json;
},
sub {
  my ($c, $resultset, $json, $obj) = @_;
  $json->{agency} = $c->get_object_by_id('Agency', $json->{agency}->{agency_id});
  return $json;
});

create_endpoints('Project', '/project');

create_endpoints('Team', '/team');

create_endpoints('Person', '/person', 
sub {
  my ($c, $resultset, $json) = @_;
  return $json;
},
sub {
  my ($c, $resultset, $json, $obj) = @_;
  $json->{default_project} = $c->get_object_by_id('Project', $json->{default_project}->{project_id});
  $json->{default_team} = $c->get_object_by_id('Team', $json->{default_team}->{team_id});
  return $json;
});

create_endpoints('Paper', '/paper',
#Create additional processing
sub {
  my ($c, $resultset, $json) = @_;
  my @filtered_projects;
  my @filtered_people;
  foreach my $el (@{$json->{paper_projects}}) {
    if(defined $el->{project_id}) {
      push(@filtered_projects, $el);
    }
  }
  foreach my $el (@{$json->{paper_people}}) {
    if(defined $el->{person_id}) {
      push(@filtered_people, $el);
    }
  }
  $json->{paper_projects} = \@filtered_projects;
  $json->{paper_people} = \@filtered_people;
  return $json;
},
#Update additional processing
sub {
  my ($c, $resultset, $json, $obj) = @_;
  
  return $json;
},
#Delete additional processing
sub {
  my ($c, $resultset, $obj) = @_;
  $obj->delete_related('paper_people');
  $obj->delete_related('paper_projects');
  return;
}
);

############## SEARCH EUROPMC

get '/searchpmc' => sub {
  my $c = shift;
  my $q = $c->param('q');
  my $resulttype = $c->param('resulttype') // 'lite';
  my $url = sprintf('http://www.ebi.ac.uk/europepmc/webservices/rest/search?format=json&resulttype=%s&query=%s', $resulttype, $q);
  my $ua = Mojo::UserAgent->new;
  my $res = $ua->get($url => {Accept => 'application/json', 'Access-Control-Allow-Origin' => 'http://apps.ensembl.org'})->res;
  # my $body = $res->body;
  # $body =~ s/^jsonp\(//;
  # $body =~ s/\)$//;
  # my $json = decode_json($body);
  my $json = $res->json;
  my $results = [];
  if(exists $json->{resultList}) {
    $results = $json->{resultList}->{result};
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
        $person->{ignore} = ($person->{active_member}) ? Mojo::JSON->false : Mojo::JSON->true;
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
