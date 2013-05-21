requires 'Filter::Simple', '0.84';
requires 'List::Util', '1.22';
requires 'perl', '5.010000';
requires 'Encode', '2.39';

on 'build' => sub {
    requires 'Test::More', '0.98';
    requires 'Cwd', 0;
    requires 'File::Basename', '2.78';
    requires 'File::Compare', '1.1006';
    requires 'File::Copy', '2.18';
};

on 'configure' => sub {
    requires 'Module::Build';
}
