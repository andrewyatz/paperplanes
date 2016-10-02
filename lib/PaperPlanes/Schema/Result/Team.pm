use utf8;
package PaperPlanes::Schema::Result::Team;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PaperPlanes::Schema::Result::Team

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

=head1 TABLE: C<team>

=cut

__PACKAGE__->table("team");

=head1 ACCESSORS

=head2 team_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "team_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</team_id>

=back

=cut

__PACKAGE__->set_primary_key("team_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<name_unique>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("name_unique", ["name"]);

=head1 RELATIONS

=head2 paper_people

Type: has_many

Related object: L<PaperPlanes::Schema::Result::PaperPerson>

=cut

__PACKAGE__->has_many(
  "paper_people",
  "PaperPlanes::Schema::Result::PaperPerson",
  { "foreign.team_id" => "self.team_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 people

Type: has_many

Related object: L<PaperPlanes::Schema::Result::Person>

=cut

__PACKAGE__->has_many(
  "people",
  "PaperPlanes::Schema::Result::Person",
  { "foreign.default_team" => "self.team_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2016-09-30 19:46:07
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Mxi5PDHM5FRzKefgxzTRvg


# You can replace this text with custom code or comments, and it will be preserved on regeneration

sub TO_JSON {
  my ($self) = @_;
  return {
    team_id => $self->team_id(),
    name => $self->name()
  };
}

1;
