use utf8;
package PaperPlanes::Schema::Result::Award;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PaperPlanes::Schema::Result::Award

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<award>

=cut

__PACKAGE__->table("award");

=head1 ACCESSORS

=head2 award_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 start

  data_type: 'text'
  is_nullable: 0

=head2 finish

  data_type: 'text'
  is_nullable: 0

=head2 agency_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "award_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "text", is_nullable => 0 },
  "start",
  { data_type => "text", is_nullable => 0 },
  "finish",
  { data_type => "text", is_nullable => 0 },
  "agency_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</award_id>

=back

=cut

__PACKAGE__->set_primary_key("award_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<name_unique>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("name_unique", ["name"]);

=head1 RELATIONS

=head2 agency

Type: belongs_to

Related object: L<PaperPlanes::Schema::Result::Agency>

=cut

__PACKAGE__->belongs_to(
  "agency",
  "PaperPlanes::Schema::Result::Agency",
  { agency_id => "agency_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-10-05 13:33:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:RdXbU1gxLtQ9/vDCCGOQ8Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration

# GARRGGHH doesn't work. Try later ...
__PACKAGE__->add_column(
  start => { inflate_datetime => 1, timezone => 'UTC', locale => 'en_GB' }
);
__PACKAGE__->add_column(
  finish => { inflate_datetime => 1, timezone => 'UTC', locale => 'en_GB' }
);

sub TO_JSON {
  my ($self) = @_;
  my $hash = {
    award_id => $self->award_id(),
    name => $self->name(),
    start => $self->start(),
    finish => $self->finish(),
  };
  $hash->{agency} = $self->agency()->TO_JSON() if $self->agency();
  return $hash;
}

1;
