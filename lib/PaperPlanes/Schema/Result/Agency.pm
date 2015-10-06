use utf8;
package PaperPlanes::Schema::Result::Agency;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PaperPlanes::Schema::Result::Agency

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

=head1 TABLE: C<agency>

=cut

__PACKAGE__->table("agency");

=head1 ACCESSORS

=head2 agency_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "agency_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</agency_id>

=back

=cut

__PACKAGE__->set_primary_key("agency_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<name_unique>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("name_unique", ["name"]);

=head1 RELATIONS

=head2 awards

Type: has_many

Related object: L<PaperPlanes::Schema::Result::Award>

=cut

__PACKAGE__->has_many(
  "awards",
  "PaperPlanes::Schema::Result::Award",
  { "foreign.agency_id" => "self.agency_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-10-05 13:33:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:HsP2h7i/QNwxZn8292ZZzQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration

sub TO_JSON {
  my ($self) = @_;
  return {
    agency_id => $self->agency_id(),
    name => $self->name()
  };
}

1;
