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

=head2 end

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
  "end",
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


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-09-25 18:30:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:rahGmiyekxOT8WgjsAOtHw


# You can replace this text with custom code or comments, and it will be preserved on regeneration

sub TO_JSON {
  my ($self) = @_;
  my $hash = {
    award_id => $self->award_id(),
    name => $self->name(),
    start => $self->start(),
    end => $self->end(),
  };
  warn $self->agency();
  $hash->{agency} = $self->agency()->TO_JSON() if $self->agency();
  return $hash;
}

1;
