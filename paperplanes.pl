#!/usr/bin/env perl
use strict;
use warnings;
use Mojolicious::Lite;

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

# get '/' => sub {
#   my $c = shift;
#   $c->render;
# } => 'index';

app->start;

__DATA__
