use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Acme::AjiFry',
    AUTHOR              => 'moznion <moznion@gmail.com>',
    VERSION_FROM        => 'lib/Acme/AjiFry.pm',
    ABSTRACT_FROM       => 'lib/Acme/AjiFry.pm',
    PL_FILES            => {},
    BUILD_REQUIRES => {
        'Test::More' => 0.98,
        'ExtUtils::MakeMaker' => 6.63,
    },
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 6.63,
    },
    PREREQ_PM => {
        'Class::Accessor::Fast' => 0.34,
        'Filter::Simple' => 0.84,
    },
    META_MERGE => {
        resources => {
            license => 'http://dev.perl.org/licenses/',
            repository => 'git://github.com/moznion/Acme--AjiFry.git'
        },
    },
    LICENSE             => 'perl',
    MIN_PERL_VERSION    => '5.10.0',
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Acme-AjiFry-*' },
);
