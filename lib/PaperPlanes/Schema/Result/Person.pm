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

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

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

=head2 active_member

  data_type: 'tinyint'
  default_value: 1
  is_nullable: 1
  size: 1

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
  "active_member",
  { data_type => "tinyint", default_value => 1, is_nullable => 1, size => 1 },
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

=head2 paper_people

Type: has_many

Related object: L<PaperPlanes::Schema::Result::PaperPerson>

=cut

__PACKAGE__->has_many(
  "paper_people",
  "PaperPlanes::Schema::Result::PaperPerson",
  { "foreign.person_id" => "self.person_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2016-09-29 18:24:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:SVCWPivBPocAgRSDUVljWQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration

sub TO_JSON {
  my ($self) = @_;
  my $hash = {
    person_id => $self->person_id(),
    last_name => $self->last_name(),
    first_name => $self->first_name(),
    orcid => $self->orcid(),
    active_member => ( ($self->active_member()) ? Mojo::JSON->true : Mojo::JSON->false),
    full_name => $self->first_name().' '.$self->last_name(),
  };
  $hash->{default_team} = $self->default_team()->TO_JSON() if $self->default_team();
  $hash->{default_project} = $self->default_project()->TO_JSON() if $self->default_project();
  return $hash;
}

1;
