use utf8;
package PaperPlanes::Schema::Result::Project;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PaperPlanes::Schema::Result::Project

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<project>

=cut

__PACKAGE__->table("project");

=head1 ACCESSORS

=head2 project_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "project_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</project_id>

=back

=cut

__PACKAGE__->set_primary_key("project_id");

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
  { "foreign.default_project" => "self.project_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-09-25 18:30:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:t348+IUg3732ov5xUi+sMw


# You can replace this text with custom code or comments, and it will be preserved on regeneration

sub TO_JSON {
  my ($self) = @_;
  return {
    project_id => $self->project_id(),
    name => $self->name()
  };
}

sub FROM_JSON {
  my ($self, $hash) = @_;
  $self->project_id($hash->{project_id}) if defined $hash->{project_id};
  $self->name($hash->{name});
  return;
}

1;
