package Acme::AjiFry::EN;

use warnings;
use strict;
use utf8;
use feature qw(switch);

use Encode;
use List::Util;
use base 'Class::Accessor::Fast';

our %map;

sub new {
    my $class = shift;

    $map{a} = '食え食え食え';      $map{b} = '食えドボドボ';   $map{c} = '食えお刺身';
    $map{d} = '食えむむ･･･';       $map{e} = '食えアジフライ'; $map{f} = 'フライ食え食え';
    $map{g} = 'フライドボドボ';    $map{h} = 'フライお刺身';   $map{i} = 'フライむむ･･･';
    $map{j} = 'フライアジフライ';  $map{k} = 'お刺身食え食え'; $map{l} = 'お刺身ドボドボ';
    $map{m} = 'お刺身お刺身';      $map{n} = 'お刺身むむ･･･';  $map{o} = 'お刺身アジフライ';
    $map{p} = 'アジ食え食え';      $map{q} = 'アジドボドボ';   $map{r} = 'アジお刺身';
    $map{s} = 'アジむむ･･･';       $map{t} = 'アジアジフライ'; $map{u} = 'ドボ食え食え';
    $map{v} = 'ドボドボドボ';      $map{w} = 'ドボお刺身';     $map{x} = 'ドボむむ･･･';
    $map{y} = 'ドボアジフライ';    $map{z} = '山岡食え食え';   $map{A} = '山岡ドボドボ';
    $map{B} = '山岡お刺身';        $map{C} = '山岡むむ･･･';    $map{D} = '山岡アジフライ';
    $map{E} = '岡星食え食え';      $map{F} = '岡星ドボドボ';   $map{G} = '岡星お刺身';
    $map{H} = '岡星むむ･･･';       $map{I} = '岡星アジフライ'; $map{J} = 'ゴク･･･食え食え';
    $map{K} = 'ゴク･･･ドボドボ';   $map{L} = 'ゴク･･･お刺身';  $map{M} = 'ゴク･･･むむ･･･';
    $map{N} = 'ゴク･･･アジフライ'; $map{O} = 'ああ食え食え';   $map{P} = 'ああドボドボ';
    $map{Q} = 'ああお刺身';        $map{R} = 'ああむむ･･･';    $map{S} = 'ああアジフライ';
    $map{T} = '雄山食え食え';      $map{U} = '雄山ドボドボ';   $map{V} = '雄山お刺身';
    $map{W} = '雄山むむ･･･';       $map{X} = '雄山アジフライ'; $map{Y} = '京極食え食え';
    $map{Z} = '京極ドボドボ';

    $map{0} = '京極お刺身';   $map{1} = '京極むむ･･･';    $map{2} = '京極アジフライ';
    $map{3} = '陶人食え食え'; $map{4} = '陶人ドボドボ';   $map{5} = '陶人お刺身';
    $map{6} = '陶人むむ･･･';  $map{7} = '陶人アジフライ'; $map{8} = '社主食え食え';
    $map{9} = '社主ドボドボ';

    $map{space} = '中川';

    my $self = $class->SUPER::new();
    return $self;
}

sub _to_ajifry {
    my $self       = shift;
    my $raw_string = shift;

    my @raw_chars = split //, $raw_string;
    my $ajifry_word;
    foreach my $raw_char (@raw_chars) {
        given ($raw_char) {
            when (' ')         { $ajifry_word .= $map{space} }
            when (/[a-zA-Z0-9]/) { $ajifry_word .= $map{$raw_char} }
            default            { $ajifry_word .= $raw_char }
        }
    }

    return $ajifry_word;
}

sub _from_ajifry {
    my $self        = shift;
    my $ajifry_word = shift;

    my $translated_word;
    while (1) {
        my $unmatch = 0;

        unless ($ajifry_word) {
            last;
        }

        foreach my $key (keys %map) {
            if ($ajifry_word =~ s/^$map{$key}//) {
                if ($key ~~ 'space') {
                    $translated_word .= ' ';
                } else {
                    $translated_word .= $key;
                }
                $unmatch = 1;
                last;
            }
        }

        unless ($unmatch) {
            $ajifry_word =~ s/^(.)//;
            $translated_word .= $1;
        }
    }

    return $translated_word;
}

sub translate_to_ajifry {
    my $self       = shift;
    my $raw_string = shift;
    $raw_string = Encode::decode_utf8($raw_string);

    return Encode::encode_utf8($self->_to_ajifry($raw_string));
}

sub translate_from_ajifry {
    my $self        = shift;
    my $ajifry_word = shift;
    $ajifry_word = Encode::decode_utf8($ajifry_word);

    return Encode::encode_utf8($self->_from_ajifry($ajifry_word));
}
1;

__END__

=head1 NAME

Acme::AjiFry - AjiFry Language (アジフライ語) Translater


=head1 VERSION

This document describes Acme::AjiFry version 0.0.1


=head1 SYNOPSIS

    use Acme::AjiFry;

    my $ajifry = Acme::AjiFry->new();

    print $ajifry->translate_to_ajifry("おさしみ")."\n"; # outputs words translated from Japanese into AjiFry-Language => "食えアジフライお刺身食え食えお刺身ドボドボ岡星ドボドボ"
    print $ajifry->translate_from_ajifry("食えアジフライお刺身食え食えお刺身ドボドボ岡星ドボドボ")."\n"; # outputs words translated from AjiFry-Language into Japanese => "食えアジフライお刺身食え食えお刺身ドボドボ岡星ドボドボ"


=head1 DESCRIPTION

Acme::AjiFry is the AjiFry-Language translator.
This module can translate Japanese into AjiFry-Language, and vice versa.
If you would like to know about AjiFry-Language, please refer to the folowing web site (Japanese Web Site).
L<http://ja.uncyclopedia.info/wiki/%E3%82%A2%E3%82%B8%E3%83%95%E3%83%A9%E3%82%A4%E8%AA%9E>


=head1 DEPENDENCIES

Perl 5.10.0 or later.

=head1 BUGS AND LIMITATIONS

=for author to fill in:
A list of known problems with the module, together with some
indication Whether they are likely to be fixed in an upcoming
release. Also a list of restrictions on the features the module
does provide: data types that cannot be handled, performance issues
and the circumstances in which they may arise, practical
limitations on the size of data sets, special cases that are not
(yet) handled, etc.

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-acme-ajifry@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.


=head1 AUTHOR

moznion  C<< <moznion[at]gmail.com> >>


=head1 LICENCE AND COPYRIGHT

Copyright (c) 2012, moznion C<< <moznion[at]gmail.com> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.


=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.
