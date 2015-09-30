#!/usr/bin/env perl
use strict;
use warnings;
use Mojolicious::Lite;

use PaperPlanes::Schema;
my $schema = PaperPlanes::Schema->connect('dbi:SQLite:dbname=paperplanes.db');

helper get_object_by_id => sub {
  my ($c, $resultset) = @_;
  my $id = $c->stash('id');
  my $key = lc($resultset).'_id';
  my $obj = $schema->resultset($resultset)->find({$key => $id});
  return $obj;
};

helper getall => sub {
  my ($c, $resultset) = @_;
  my @all = $schema->resultset($resultset)->all();
  $c->respond_to(
    json => sub {
      $c->render(json => [ map { $_->TO_JSON()} @all ] )
    }
  );
};

helper get => sub {
  my ($c, $resultset) = @_;
  my $obj = $c->get_object_by_id($resultset);
  $c->respond_to(
    json => sub {
      $c->render(json => $obj->TO_JSON());
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
      $c->render(json => $obj->TO_JSON());
    }
  );
};

# Update based on by id
helper update => sub {
  my ($c, $resultset) = @_;
  my $obj = $c->get_object_by_id($resultset);
  my $json = $c->req->json;
  $obj->FROM_JSON($json);
  $obj->update();
  $c->respond_to(
    json => sub {
      $c->render(json => $obj->TO_JSON());
    }
  );
};

# Remove by :id
helper del => sub {
  my ($c, $resultset) = @_;
  my $obj = $c->get_object_by_id($resultset);
  $obj->delete() if defined $obj;
  return;
};

sub create_endpoints {
  my ($resultset, $url_base) = @_;
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
    $c->update($resultset);
  };
  
  del $id_url => sub {
    my $c = shift;
    $c->del($resultset);
  };
}

create_endpoints('Agency', '/agency');
create_endpoints('Award', '/award');
create_endpoints('Project', '/project');
create_endpoints('Team', '/team');
create_endpoints('Person', '/person');

# get '/' => sub {
#   my $c = shift;
#   $c->render;
# } => 'index';

app->start;

__DATA__
