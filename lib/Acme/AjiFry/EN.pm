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

    $map{a} = '食え食え食え';
    $map{b} = '食えドボドボ';
    $map{c} = '食えお刺身';
    $map{d} = '食えむむ･･･';
    $map{e} = '食えアジフライ';
    $map{f} = 'フライ食え食え';
    $map{g} = 'フライドボドボ';
    $map{h} = 'フライお刺身';
    $map{i} = 'フライむむ･･･';
    $map{j} = 'フライアジフライ';
    $map{k} = 'お刺身食え食え';
    $map{l} = 'お刺身ドボドボ';
    $map{m} = 'お刺身お刺身';
    $map{n} = 'お刺身むむ･･･';
    $map{o} = 'お刺身アジフライ';
    $map{p} = 'アジ食え食え';
    $map{q} = 'アジドボドボ';
    $map{r} = 'アジお刺身';
    $map{s} = 'アジむむ･･･';
    $map{t} = 'アジアジフライ';
    $map{u} = 'ドボ食え食え';
    $map{v} = 'ドボドボドボ';
    $map{w} = 'ドボお刺身';
    $map{x} = 'ドボむむ･･･';
    $map{y} = 'ドボアジフライ';
    $map{z} = '山岡食え食え';
    $map{A} = '山岡ドボドボ';
    $map{B} = '山岡お刺身';
    $map{C} = '山岡むむ･･･';
    $map{D} = '山岡アジフライ';
    $map{E} = '岡星食え食え';
    $map{F} = '岡星ドボドボ';
    $map{G} = '岡星お刺身';
    $map{H} = '岡星むむ･･･';
    $map{I} = '岡星アジフライ';
    $map{J} = 'ゴク･･･食え食え';
    $map{K} = 'ゴク･･･ドボドボ';
    $map{L} = 'ゴク･･･お刺身';
    $map{M} = 'ゴク･･･むむ･･･';
    $map{N} = 'ゴク･･･アジフライ';
    $map{O} = 'ああ食え食え';
    $map{P} = 'ああドボドボ';
    $map{Q} = 'ああお刺身';
    $map{R} = 'ああむむ･･･';
    $map{S} = 'ああアジフライ';
    $map{T} = '雄山食え食え';
    $map{U} = '雄山ドボドボ';
    $map{V} = '雄山お刺身';
    $map{W} = '雄山むむ･･･';
    $map{X} = '雄山アジフライ';
    $map{Y} = '京極食え食え';
    $map{Z} = '京極ドボドボ';

    $map{0} = '京極お刺身';
    $map{1} = '京極むむ･･･';
    $map{2} = '京極アジフライ';
    $map{3} = '陶人食え食え';
    $map{4} = '陶人ドボドボ';
    $map{5} = '陶人お刺身';
    $map{6} = '陶人むむ･･･';
    $map{7} = '陶人アジフライ';
    $map{8} = '社主食え食え';
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
            when (' ')           { $ajifry_word .= $map{space} }
            when (/[a-zA-Z0-9]/) { $ajifry_word .= $map{$raw_char} }
            default              { $ajifry_word .= $raw_char }
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

        foreach my $key ( keys %map ) {
            if ( $ajifry_word =~ s/^$map{$key}// ) {
                if ( $key ~~ 'space' ) {
                    $translated_word .= ' ';
                }
                else {
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

    return Encode::encode_utf8( $self->_to_ajifry($raw_string) );
}

sub translate_from_ajifry {
    my $self        = shift;
    my $ajifry_word = shift;
    $ajifry_word = Encode::decode_utf8($ajifry_word);

    return Encode::encode_utf8( $self->_from_ajifry($ajifry_word) );
}
1;

__END__

=head1 NAME

Acme::AjiFry::EN - AjiFry Language Translator for English

=head1 SYNOPSIS

    use Acme::AjiFry::EN;

    my $ajifry_en = Acme::AjiFry::EN->new();

    print $ajifry_en->translate_to_ajifry('012abcABC!!!')."\n"; # outputs => '京極お刺身京極むむ･･･京極アジフライ食え食え食え食えドボドボ食えお刺身山岡ドボドボ山岡お刺身山岡むむ･･･!!!'
    print $ajifry_en->translate_from_ajifry('京極お刺身京極むむ･･･京極アジフライ食え食え食え食えドボドボ食えお刺身山岡ドボドボ山岡お刺身山岡むむ･･･!!!')."\n"; # outputs => '012abcABC!!!'


=head1 DESCRIPTION

Acme::AjiFry::EN is the AjiFry-Language translator.
This module can translate English into AjiFry-Language, and vice versa.

=head1 SEE ALSO
L<Acme::AjiFry>.

=head1 METHODS

=over

=item new
new is the constructor of this module.

=item translate_from_ajifry
This module needs a AjiFry-Language string as parameter.
It returns English which was translated from AjiFry-Language.

=item translate_to_ajifry
This module needs a string as parameter.
It returns AjiFry-Language which was translated from English.

=back

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
