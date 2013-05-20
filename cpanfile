requires 'Filter::Simple', '0.84';
requires 'List::Util', '1.22';
requires 'perl', '5.008009';
requires 'Encode', '2.39';

on 'build' => sub {
    requires 'Test::More', '0.98';
    requires 'File::Basename', '2.77';
    requires 'File::Compare', '1.1005';
    requires 'File::Copy', '2.13';
    requires 'Cwd', 0;
};

on 'configure' => sub {
    requires 'Module::Build', '0.4003';
}
