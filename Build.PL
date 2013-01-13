use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    name              => 'Acme-AjiFry',
    module_name       => 'Acme::AjiFry',
    license           => 'perl',
    dist_author       => 'moznion <moznion@gmail.com>',
    dist_version_from => 'lib/Acme/AjiFry.pm',
    dynamic_config    => 0,
    build_requires    => {
        'Test::More'     => '0.98',
        'Cwd'            => 0,
        'File::Basename' => '2.78',
        'File::Compare'  => '1.1006',
        'File::Copy'     => '2.18',
        'Encode'         => '2.39',
    },
    configure_requires => { 'Module::Build' => '0.40' },
    requires           => {
        perl                    => '5.010000',
        'base'                  => 0,
        'Carp'                  => 0,
        'List::Util'            => '1.22',
        'Class::Accessor::Fast' => '0.34',
        'Filter::Simple'        => '0.84',
    },
    no_index   => { 'directory' => ['inc'] },
    meta_merge => {
        'resources' => {
            'license'    => 'http://dev.perl.org/licenses/',
            'repository' => 'git://github.com/moznion/Acme--AjiFry.git'
        },
    },
    test_files => ( -d '.git' || $ENV{RELEASE_TESTING} ) ? 't/ xt/' : 't/',
    recursive_test_files => 1,
    add_to_cleanup       => ['Acme-AjiFry-*'],
    create_readme        => 1,
    create_license       => 1,
);

$builder->create_build_script();
