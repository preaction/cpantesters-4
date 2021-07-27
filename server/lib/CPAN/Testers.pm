package CPAN::Testers;
use Mojo::Base 'Yancy', -signatures;
use CPAN::Testers::Model;

has moniker => 'cpantesters';

sub startup( $self ) {
    $self->SUPER::startup;
}

1;
