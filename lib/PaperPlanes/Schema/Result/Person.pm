use utf8;
package PaperPlanes::Schema::Result::Person;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PaperPlanes::Schema::Result::Person

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<person>

=cut

__PACKAGE__->table("person");

=head1 ACCESSORS

=head2 person_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 last_name

  data_type: 'text'
  is_nullable: 0

=head2 first_name

  data_type: 'text'
  is_nullable: 0

=head2 orcid

  data_type: 'text'
  is_nullable: 0

=head2 default_team

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 default_project

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "person_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "last_name",
  { data_type => "text", is_nullable => 0 },
  "first_name",
  { data_type => "text", is_nullable => 0 },
  "orcid",
  { data_type => "text", is_nullable => 0 },
  "default_team",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "default_project",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</person_id>

=back

=cut

__PACKAGE__->set_primary_key("person_id");

=head1 RELATIONS

=head2 default_project

Type: belongs_to

Related object: L<PaperPlanes::Schema::Result::Project>

=cut

__PACKAGE__->belongs_to(
  "default_project",
  "PaperPlanes::Schema::Result::Project",
  { project_id => "default_project" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 default_team

Type: belongs_to

Related object: L<PaperPlanes::Schema::Result::Team>

=cut

__PACKAGE__->belongs_to(
  "default_team",
  "PaperPlanes::Schema::Result::Team",
  { team_id => "default_team" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-09-25 11:22:09
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:o0r/flwPvKpxHJWM97lJKw


# You can replace this text with custom code or comments, and it will be preserved on regeneration

sub TO_JSON {
  my ($self) = @_;
  my $hash = {
    person_id => $self->person_id(),
    last_name => $self->last_name(),
    first_name => $self->first_name(),
    orcid => $self->orcid()
  };
  $hash->{default_team} = $self->default_team()->TO_JSON() if $self->default_team();
  $hash->{default_project} = $self->default_project()->TO_JSON() if $self->default_project();
  return $hash;
}

1;
