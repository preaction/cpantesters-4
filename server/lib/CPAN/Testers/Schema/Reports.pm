package CPAN::Testers::Schema::Reports;
use Mojo::Base 'Yancy::Model::Schema', -signatures;
use Mojo::JSON qw( decode_json encode_json );

=method create

Create a new report.

=cut

# XXX: Should be a class method on Item class?
sub create( $self, $item ) {
    $item->{report} &&= encode_json $item->{report};
    return $self->SUPER::create( $item );
}

1;
