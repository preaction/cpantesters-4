
use Test::Mojo;
use Test::More;

my $t = Test::Mojo->new( 'CPAN::Testers' );
my $m = $t->app->model;

subtest 'create new report' => sub {
    my $row = $m->schema( 'Reports' )->create({
        # XXX: Accept report directly from API, removing the need for
        # the extra hashref with a single key?
        report => {
        },
    });
};

subtest 'load report summary' => sub {
    $t->pg->db->insert('');

    ok 0, 'lang is created';
    ok 0, 'lang release is created';
};

done_testing;
