package CPAN::Testers::Item::Reports;
use Mojo::Base 'Yancy::Model::Item', -signatures;
use Mojo::JSON qw( decode_json encode_json );

# XXX: Yancy command to generate model classes

=method load_summary

Create or update the report summary from this report, including any related data
(language, distribution, tester, system, etc...)

=cut

sub load_summary( $self ) {
    my $report = decode_json $self->{report};

    #   "tester": {
    #       "name": "Doug Bell",
    #       "email": "doug@preaction.me",
    #   },
    my $tester = $self->schema( 'testers' )->get_or_create( $report->{tester} );

    #   "system": {
    #       "osname":
    #       "osversion":
    #       "hostname":
    #       "cpu_count":
    #       "cpu_type":
    #       "cpu_description":
    #       "filesystem":
    #   },
    my $system = $self->schema( 'tester_systems' )->get_or_create( { $report->{system}->%*, $tester->%{'tester_id'} } );

    #   "language": {
    #       "name": "Perl",
    #       "version": "5.23.4",
    #       "build": "0x1231sfj",
    #   },
    my $lang = $self->schema( 'lang_releases' )->get_or_create( $report->{language} );

    #   "distribution": {
    #       "name": "Yancy-Backend-Static",
    #       "version": "1.005",
    #   },
    my $dist = $self->schema( 'dist_releases' )->get_or_create( $report->{distribution} );

    #   "result": {
    #       "grade"
    #       "output": {
    #           "uncategorized"
    #           "configure"
    #           "build"
    #           "test"
    #           "install"
    #       },
    #   },
    $self->schema( 'report_stat' )->create({
        $lang->%{'lang_release_id'},
        $system->%{'tester_system_id'},
        $dist->%{'dist_release_id'},
        $self->%{'report_id'},
        grade => $report->{result}{grade},
    });
}

