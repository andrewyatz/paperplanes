use strict;
use warnings;
use Test::More;

use PaperPlanes::Schema;

my $schema = PaperPlanes::Schema->connect('dbi:SQLite:dbname=paperplanes.db');
my $agency_rs = $schema->resultset('Agency');
my $id = 1;
foreach my $agency (qw/BBSRC NSF WT/) {
  my $agency_obj = $agency_rs->find_or_create({name => $agency},{ key => 'name_unique' });
  is($agency_obj->agency_id(), $id++, 'Inserted '.$agency);
}
