use utf8;
package PaperPlanes::Schema::Result::Paper;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PaperPlanes::Schema::Result::Paper

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

=head1 TABLE: C<paper>

=cut

__PACKAGE__->table("paper");

=head1 ACCESSORS

=head2 paper_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 title

  data_type: 'text'
  is_nullable: 0

=head2 journal

  data_type: 'text'
  is_nullable: 0

=head2 pub_year

  data_type: 'text'
  is_nullable: 0

=head2 doi

  data_type: 'text'
  is_nullable: 0

=head2 author_count

  data_type: 'integer'
  is_nullable: 0

=head2 author_string

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "paper_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "title",
  { data_type => "text", is_nullable => 0 },
  "journal",
  { data_type => "text", is_nullable => 0 },
  "pub_year",
  { data_type => "text", is_nullable => 0 },
  "doi",
  { data_type => "text", is_nullable => 0 },
  "author_count",
  { data_type => "integer", is_nullable => 0 },
  "author_string",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</paper_id>

=back

=cut

__PACKAGE__->set_primary_key("paper_id");

=head1 RELATIONS

=head2 paper_awards

Type: has_many

Related object: L<PaperPlanes::Schema::Result::PaperAward>

=cut

__PACKAGE__->has_many(
  "paper_awards",
  "PaperPlanes::Schema::Result::PaperAward",
  { "foreign.paper_id" => "self.paper_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 paper_people

Type: has_many

Related object: L<PaperPlanes::Schema::Result::PaperPerson>

=cut

__PACKAGE__->has_many(
  "paper_people",
  "PaperPlanes::Schema::Result::PaperPerson",
  { "foreign.paper_id" => "self.paper_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2016-09-30 19:52:16
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:eafC/h0HxAaqdSeF0xEmQQ

sub TO_JSON {
  my ($self) = @_;
  my $hash = {
    paper_id => $self->paper_id(),
    title => $self->title(),
    doi => $self->doi(),
    journal => $self->journal(),
    pub_year => $self->pub_year(),
    author_count => $self->author_count(),
    author_string => $self->author_string(),
  };
  my @awards = $self->paper_awards()->all();
  my @people = $self->paper_people()->all();
  $hash->{paper_awards} = [map {$_->TO_JSON} @awards];
  $hash->{paper_people} = [map {$_->TO_JSON} @people];
  return $hash;
}

1;
