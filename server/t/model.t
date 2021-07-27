
use Test::Mojo;
use Test::More;

my $t = Test::Mojo->new( 'CPAN::Testers' );
my $m = $t->app->model;

subtest 'create new report' => sub {
    my $row = $m->schema( 'Reports' )->create({
        # XXX: Accept report directly from API, removing the need for
        # the extra hashref with a single key?
        report => {
            tester => {
                name => 'Doug Bell',
                email => 'doug@preaction.me',
            },
            system => {
                osname => 'Linux',
                osversion => '3.2.43',
                hostname => 'example.com',
            },
            language => {
                name => 'Perl',
                version => '5.23.4',
                build => '069b264',
            },
            distribution => {
                name => 'Yancy',
                version => '1.074',
            },
            result => {
                grade => 'pass',
                output => {
                    uncategorized => 'It worked',
                },
            },
        },
    });

    isa_ok $row, 'CPAN::Testers::Item::Reports';
    ok $row->{report_id}, 'id is created';
    ok $row->{guid}, 'guid is created';

    my $res = $t->pg->db->select( reports => '*', { $row->%{'report_id'} } );
    is $res->count, 1;
    ...;
};

subtest 'load report summary' => sub {
    $t->pg->db->insert('');

    ok 0, 'lang is created';
    ok 0, 'lang release is created';
};

done_testing;
