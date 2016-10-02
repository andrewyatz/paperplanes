use utf8;
package PaperPlanes::Schema::Result::PaperPerson;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PaperPlanes::Schema::Result::PaperPerson

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

=head1 TABLE: C<paper_people>

=cut

__PACKAGE__->table("paper_people");

=head1 ACCESSORS

=head2 paper_persons_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 paper_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 person_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 team_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 project_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 person_order

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "paper_persons_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "paper_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "person_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "team_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "project_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "person_order",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</paper_persons_id>

=back

=cut

__PACKAGE__->set_primary_key("paper_persons_id");

=head1 RELATIONS

=head2 paper

Type: belongs_to

Related object: L<PaperPlanes::Schema::Result::Paper>

=cut

__PACKAGE__->belongs_to(
  "paper",
  "PaperPlanes::Schema::Result::Paper",
  { paper_id => "paper_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 person

Type: belongs_to

Related object: L<PaperPlanes::Schema::Result::Person>

=cut

__PACKAGE__->belongs_to(
  "person",
  "PaperPlanes::Schema::Result::Person",
  { person_id => "person_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 project

Type: belongs_to

Related object: L<PaperPlanes::Schema::Result::Project>

=cut

__PACKAGE__->belongs_to(
  "project",
  "PaperPlanes::Schema::Result::Project",
  { project_id => "project_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 team

Type: belongs_to

Related object: L<PaperPlanes::Schema::Result::Team>

=cut

__PACKAGE__->belongs_to(
  "team",
  "PaperPlanes::Schema::Result::Team",
  { team_id => "team_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2016-09-30 19:46:07
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:3ElIKYSiDRUPcINYm6TOJg


sub TO_JSON {
  my ($self) = @_;
  return {
    paper_persons_id => $self->paper_persons_id(),
    paper_id => $self->paper_id(),
    
    person_id => $self->person_id(), 
    person_order => $self->person_order(),
    person => $self->person()->TO_JSON(),
    
    team_id => $self->team_id(),
    team => $self->team()->TO_JSON(),
    
    project_id => $self->project_id(),
    project => $self->project(),
  };
}

1;
