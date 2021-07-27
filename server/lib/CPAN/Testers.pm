package CPAN::Testers;
use Mojo::Base 'Yancy', -signatures;
use CPAN::Testers::Model;

has moniker => 'cpantesters';

sub pg( $self ) {
    # XXX: Make standard way to get driver from backend
    return $self->yancy->backend->mojodb;
}

sub startup( $self ) {
    $self->SUPER::startup;
}

1;
