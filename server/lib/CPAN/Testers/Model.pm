package CPAN::Testers::Model;
use Mojo::Base 'Yancy::Model', -signatures;
use Mojo::JSON qw( encode_json );
use Mojo::Loader qw( data_section );
use Scalar::Util qw( blessed );

has namespaces => sub { [qw( CPAN::Testers Yancy::Model )] };

sub migrate( $self ) {
    # XXX: This should be done automatically by Yancy::Model
    my $migrations = data_section blessed( $self ), 'migrations.pg.sql';
    $self->backend->mojodb->migrations->from_string( $migrations )->migrate;
}


1;
__DATA__
@@ migrations.pg.sql
-- 1 up
CREATE TABLE testers (
    tester_id SERIAL,
    name STRING,
    email STRING
);

CREATE TABLE tester_systems (
    tester_system_id SERIAL,
    tester_id FOREIGN KEY REFERENCES testers,
    osname STRING,
    osversion STRING,
    hostname STRING
);

CREATE TABLE langs (
    lang_id SERIAL,
    name STRING,
);

CREATE TABLE lang_releases (
    lang_release_id SERIAL,
    lang_id FOREIGN KEY REFERENCES langs,
    released TIMESTAMP WITHOUT TIME ZONE,
    version STRING,
    build STRING DEFAULT ''
);

CREATE TABLE dists (
    dist_id SERIAL,
    lang_id FOREIGN KEY REFERENCES langs,
    name STRING
);

CREATE TABLE dist_releases (
    dist_release_id SERIAL,
    dist_id FOREIGN KEY REFERENCES dists,
    released TIMESTAMP WITHOUT TIME ZONE,
    version STRING,
    build STRING DEFAULT ''
);

CREATE TABLE reports (
    report_id SERIAL,
    report JSON
);

CREATE TABLE report_stats (
    report_id FOREIGN KEY REFERENCES reports,
    lang_release_id FOREIGN KEY REFERENCES lang_releases,
    tester_system_id FOREIGN KEY REFERENCES tester_systems,
    dist_release_id FOREIGN KEY REFERENCES dist_releases,
    reported TIMESTAMP WITHOUT TIME ZONE,
    grade STRING
);
