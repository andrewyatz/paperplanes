#!/usr/bin/env perl
use strict;
use warnings;
use Mojolicious::Lite;

use PaperPlanes::Schema;
my $schema = PaperPlanes::Schema->connect('dbi:SQLite:dbname=paperplanes.db');

helper hashit => sub {
  my ($c, $keys, @objs) = @_;
  my @output;
  foreach my $o (@objs) {
    my %conv;
    foreach my $key (@{$keys}) {
      $conv{$key} = $o->$key();
    }
    push(@output, \%conv);
  }
  return \@output;
};

helper simpleget => sub {
  my ($c, $resultset) = @_;
  my $keys = [lc($resultset).'_id', 'name'];
  $c->respond_to(
    json => sub {
      my @all = $schema->resultset($resultset)->all();
      $c->render(json => $c->hashit($keys, @all));
    }
  );
};

# Assumes name is the only important thing in the world!
helper simplepost => sub {
  my ($c, $resultset) = @_;
  my $keys = [lc($resultset).'_id', 'name'];
  my $json = $c->req->json;
  my $obj = $schema->resultset($resultset)->find_or_create({name => $json->{name}},{ key => 'name_unique' });
  $c->respond_to(
    json => sub {
      $c->render(json => $c->hashit($keys, $obj)->[0]);
    }
  );
};

get '/agency' => sub {
  my $c = shift;
  $c->simpleget('Agency');
};

post '/agency' => sub {
  my $c = shift;
  $c->simplepost('Agency');
};

####### 

get '/team' => sub {
  my $c = shift;
  $c->simpleget('Team');
};

post '/team' => sub {
  my $c = shift;
  $c->simplepost('Team');
};

####### 
get '/project' => sub {
  my $c = shift;
  $c->simpleget('Project');
};

post '/project' => sub {
  my $c = shift;
  $c->simplepost('Project');
};

app->start;

__DATA__

@@index.html
<!doctype html>
<html ng-app>
  <head>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.6/angular.min.js"></script>
  </head>
  <body>
    <div>
      <label>Name:</label>
      <input type="text" ng-model="yourName" placeholder="Enter a name here">
      <hr>
      <h1>Hello {{yourName}}!</h1>
    </div>
  </body>
</html>