use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Acme::AjiFry',
    AUTHOR              => 'moznion <moznion@gmail.com>',
    VERSION_FROM        => 'lib/Acme/AjiFry.pm',
    ABSTRACT_FROM       => 'lib/Acme/AjiFry.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'Class::Accessor::Fast' => 0.34,
        'version'    => 5.10.0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Acme-AjiFry-*' },
);
