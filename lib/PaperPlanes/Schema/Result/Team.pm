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


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-09-25 18:30:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ll78uC37f4c7d0tjhLuFDg


# You can replace this text with custom code or comments, and it will be preserved on regeneration

sub TO_JSON {
  my ($self) = @_;
  return {
    team_id => $self->team_id(),
    name => $self->name()
  };
}

sub FROM_JSON {
  my ($self, $hash) = @_;
  $self->team_id($hash->{team_id}) if defined $hash->{team_id};
  $self->name($hash->{name});
  return;
}
1;
