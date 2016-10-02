use utf8;
package PaperPlanes::Schema::Result::PaperAward;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PaperPlanes::Schema::Result::PaperAward

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

=head1 TABLE: C<paper_awards>

=cut

__PACKAGE__->table("paper_awards");

=head1 ACCESSORS

=head2 paper_awards_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 paper_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 award_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "paper_awards_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "paper_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "award_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</paper_awards_id>

=back

=cut

__PACKAGE__->set_primary_key("paper_awards_id");

=head1 RELATIONS

=head2 award

Type: belongs_to

Related object: L<PaperPlanes::Schema::Result::Award>

=cut

__PACKAGE__->belongs_to(
  "award",
  "PaperPlanes::Schema::Result::Award",
  { award_id => "award_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 paper

Type: belongs_to

Related object: L<PaperPlanes::Schema::Result::Paper>

=cut

__PACKAGE__->belongs_to(
  "paper",
  "PaperPlanes::Schema::Result::Paper",
  { paper_id => "paper_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2016-09-30 14:31:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:x0iSHt+fSs6DHhTEur3AgQ

sub TO_JSON {
  my ($self) = @_;
  return {
    paper_awards_id => $self->paper_projects_id(),
    paper_id => $self->paper_id(),
    award_id => $self->award_id(), 
    award => $self->award()->TO_JSON()
  };
}

1;
