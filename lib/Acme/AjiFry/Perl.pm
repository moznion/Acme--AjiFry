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
            chomp $line;
            push @executable_code, $ajifry->translate_from_ajifry($line) . "\n";
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
