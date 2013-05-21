requires 'Carp';
requires 'Class::Accessor::Fast', '0.34';
requires 'Filter::Simple', '0.84';
requires 'List::Util', '1.22';
requires 'base';
requires 'perl', '5.010000';

on build => sub {
    requires 'Cwd';
    requires 'Encode', '2.39';
    requires 'File::Basename', '2.78';
    requires 'File::Compare', '1.1006';
    requires 'File::Copy', '2.18';
    requires 'Test::More', '0.98';
};
