use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Acme::AjiFry',
    license             => 'perl',
    dist_author         => 'moznion <moznion@gmail.com>',
    dist_version_from   => 'lib/Acme/AjiFry.pm',
    requires => {
        'Test::More' => 0,
        'version'    => 0,
    },
    add_to_cleanup      => [ 'Acme-AjiFry-*' ],
);

$builder->create_build_script();
