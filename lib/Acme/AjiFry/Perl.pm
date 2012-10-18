package Acme::AjiFry::Perl;

use warnings;
use strict;
use utf8;

use Acme::AjiFry::EN;
use File::Copy;
use base 'Class::Accessor::Fast';

sub _parse_and_translate {
    my $filename_to_read = shift;

    my $ajifry = Acme::AjiFry::EN->new();
    my ( $executable_code, $replace_code );
    open my $fh_to_read, '<', $filename_to_read or die "$filename_to_read: $!";

    my $after_line_of_using_this_module = 0;
    foreach my $line (<$fh_to_read>) {
        if ($after_line_of_using_this_module) {    #translate
            $replace_code    .= $ajifry->translate_to_ajifry($line);
            $executable_code .= $ajifry->translate_from_ajifry($line);
            next;
        }
        else {                                     #not translate
            $replace_code .= $line;
            if ( $line =~ /^\s*use\s*Acme::AjiFry::Perl/ ) {
                $after_line_of_using_this_module = 1;
            }
            else {
                $executable_code .= $line;
            }
        }
    }

    close $fh_to_read;
    return ( $executable_code, $replace_code );
}

sub _self_rewrite {
    my $target_filename = $0;

    my ( $executable_code, $replace_code ) =
      _parse_and_translate($target_filename);

    open my $fh_to_rewrite, '>', $target_filename
      or die "$target_filename: $!";
    print $fh_to_rewrite $replace_code;
    close $fh_to_rewrite;

    eval $executable_code;
    exit(0);
}
_self_rewrite();

__END__

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
