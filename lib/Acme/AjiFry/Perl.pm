package Acme::AjiFry::Perl;

use warnings;
use strict;
use utf8;

use Acme::AjiFry::EN;
use Filter::Simple;

my $ajifry = Acme::AjiFry::EN->new();

FILTER_ONLY executable => sub {
    s/(.+)/$ajifry->translate_to_ajifry($1)/eg;
}, all => sub {
    open my $fh,'+<',"$0" or die "Can't rewrite '$0'\n";
    seek $fh,0,0;
    print $fh "use Acme::AjiFry::Perl;\n";
    print $fh $_;
}, executable => sub {
    s/(.+)/$ajifry->translate_from_ajifry($1)/eg;
};

1;

=encoding utf8

=head1 NAME

Acme::AjiFry::Perl - AjiFry Language Translator for Perl


=head1 SYNOPSIS

    use Acme::AjiFry::Perl;

    print 'hello';


=head1 DESCRIPTION

Acme::AjiFry::Perl is the AjiFry-Language translator for Perl program.
This module rewrites a program of using this module.


=head1 DEPENDENCIES

Acme::AjiFry::EN


=head1 SEE ALSO

L<Acme::AjiFry>.
L<Acme::AjiFry::EN>.


=head1 AUTHOR

moznion  C<< <moznion[at]gmail.com> >>


=head1 LICENCE AND COPYRIGHT

Copyright (c) 2012, moznion C<< <moznion[at]gmail.com> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.
