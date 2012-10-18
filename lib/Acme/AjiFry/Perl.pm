package Acme::AjiFry::Perl;

use warnings;
use strict;
use utf8;

use Acme::AjiFry::EN;
use File::Copy;
use base 'Class::Accessor::Fast';

sub _self_rewrite {
    my $ajifry = Acme::AjiFry::EN->new();
    my @executable_code;
    my $filename_to_write_out = 'temp_replace_' . time . '_' . $$;
    my $filename_to_execute   = 'temp_executable_' . time . '_' . $$;
    my $filename_to_read      = $0;

    open my $fh_to_read, '<', $filename_to_read or die "$filename_to_read: $!";
    open my $fh_to_write_replace_file, '>', $filename_to_write_out or die "$filename_to_write_out: $!";
    open my $fh_to_write_executable_file, '>', $filename_to_execute or die "$filename_to_execute: $!";

    my $after_line_of_use_this_module = 0;
    foreach my $line (<$fh_to_read>) {
        if ($after_line_of_use_this_module) {
            print $fh_to_write_replace_file ($ajifry->translate_to_ajifry($line));
            push @executable_code, $ajifry->translate_from_ajifry($line);
            next;
        } else {
            print $fh_to_write_replace_file $line;
            push @executable_code, $line;
        }
        if ($line =~ /^\s*use\s*Acme::AjiFry::Perl/) {
            pop @executable_code;
            $after_line_of_use_this_module = 1;
        }
    }

    foreach my $code (@executable_code) {
        print $fh_to_write_executable_file $code;
    }

    close $fh_to_read;
    close $fh_to_write_replace_file;
    close $fh_to_write_executable_file;

    system("$^X $filename_to_execute");
    File::Copy::copy $filename_to_write_out, $filename_to_read;
    unlink $filename_to_write_out;
    unlink $filename_to_execute;
    exit(0);
}
_self_rewrite();

__END__


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
