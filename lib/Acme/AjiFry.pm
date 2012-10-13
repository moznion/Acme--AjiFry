package Acme::AjiFry;

use warnings;
use strict;
use utf8;
use feature qw(switch);

use Encode;
use List::Util;
use base 'Class::Accessor::Fast';

use version; our $VERSION = '0.03';

our %cols;
our %rows;
our @dullness;
our @p_sound;
our @double_consonant;

sub new {
    my $class = shift;

    $cols{a} = [
        'あ', 'か', 'さ', 'た', 'な', 'は', 'ま', 'や', 'ら', 'わ',
        'が', 'ざ', 'だ', 'ば', 'ぱ', 'ぁ', 'ゃ', 'ゎ'
    ];
    $cols{i} = [
        'い', 'き', 'し', 'ち', 'に', 'ひ', 'み', 'り',
        'ぎ', 'じ', 'ぢ', 'び', 'ぴ', 'ぃ'
    ];
    $cols{u} = [
        'う', 'く', 'す', 'つ', 'ぬ', 'ふ', 'む', 'ゆ', 'る', 'ぐ',
        'ず', 'づ', 'ぶ', 'ぷ', 'ぅ', 'っ', 'ゅ'
    ];
    $cols{e} = [
        'え', 'け', 'せ', 'て', 'ね', 'へ', 'め', 'れ',
        'げ', 'ぜ', 'で', 'べ', 'ぺ', 'ぇ',
    ];
    $cols{o} = [
        'お', 'こ', 'そ', 'と', 'の', 'ほ', 'も', 'よ', 'ろ', 'を',
        'ご', 'ぞ', 'ど', 'ぼ', 'ぽ', 'ぉ', 'ょ'
    ];
    $cols{n} = ['ん'];

    $rows{a} =
      [ 'あ', 'い', 'う', 'え', 'お', 'ぁ', 'ぃ', 'ぅ', 'ぇ', 'ぉ' ];
    $rows{k} =
      [ 'か', 'き', 'く', 'け', 'こ', 'が', 'ぎ', 'ぐ', 'げ', 'ご' ];
    $rows{s} =
      [ 'さ', 'し', 'す', 'せ', 'そ', 'ざ', 'じ', 'ず', 'ぜ', 'ぞ' ];
    $rows{t} = [
        'た', 'ち', 'つ', 'て', 'と', 'だ',
        'ぢ', 'づ', 'で', 'ど', 'っ'
    ];
    $rows{n} = [ 'な', 'に', 'ぬ', 'ね', 'の' ];
    $rows{h} = [
        'は', 'ひ', 'ふ', 'へ', 'ほ', 'ば', 'び', 'ぶ',
        'べ', 'ぼ', 'ぱ', 'ぴ', 'ぷ', 'ぺ', 'ぽ'
    ];
    $rows{m} = [ 'ま', 'み', 'む', 'め', 'も' ];
    $rows{y} = [ 'や', 'ゆ', 'よ', 'ゃ', 'ゅ', 'ょ' ];
    $rows{r} = [ 'ら', 'り', 'る', 'れ', 'ろ' ];
    $rows{w} = [ 'わ', 'を', 'ゎ' ];

    @dullness = (
        'が', 'ぎ', 'ぐ', 'げ', 'ご', 'ざ', 'じ', 'ず', 'ぜ', 'ぞ',
        'だ', 'ぢ', 'づ', 'で', 'ど', 'ば', 'び', 'ぶ', 'べ', 'ぼ'
    );
    @p_sound = ( 'ぱ', 'ぴ', 'ぷ', 'ぺ', 'ぽ' );
    @double_consonant =
      ( 'ぁ', 'ぃ', 'ぅ', 'ぇ', 'ぉ', 'っ', 'ゃ', 'ゅ', 'ょ', 'ゎ' );

    my $self = $class->SUPER::new();
    return $self;
}

sub _search_key_of_element {
    my ( $self, $element, %hash ) = @_;

    foreach my $key ( sort keys %hash ) {
        if ( List::Util::first { $_ eq $element } @{ $hash{$key} } ) {
            return $key;
        }
    }
}

sub _find_first {
    my $self = shift;
    my ( $key, @list ) = @_;

    return ( List::Util::first { $_ eq $key } @list ) ? 1 : 0;
}

sub _find_duplicate_element_in_both_lists {
    my $self = shift;
    my ( $list_A, $list_B ) = @_;

    my @duplicate_elements;
    foreach my $element_A ( @{$list_A} ) {
        foreach my $element_B ( @{$list_B} ) {
            if ( $element_A ~~ $element_B ) {
                push( @duplicate_elements, $element_A );
            }
        }
    }
    return @duplicate_elements;
}

sub _get_ajifry_word_by_consonant {
    my $self      = shift;
    my $consonant = shift;

    given ($consonant) {
        when ('a') { return "食え" }
        when ('k') { return "フライ" }
        when ('s') { return "お刺身" }
        when ('t') { return "アジ" }
        when ('n') { return "ドボ" }
        when ('h') { return "山岡" }
        when ('m') { return "岡星" }
        when ('y') { return "ゴク･･･" }
        when ('r') { return "ああ" }
        when ('w') { return "雄山" }
        default    { return "" }
    }
}

sub _get_ajifry_word_by_vowel {
    my $self  = shift;
    my $vowel = shift;

    given ($vowel) {
        when ('a') { return "食え食え" }
        when ('i') { return "ドボドボ" }
        when ('u') { return "お刺身" }
        when ('e') { return "むむ･･･" }
        when ('o') { return "アジフライ" }
        when ('n') { return "京極" }
        default    { return "" }
    }
}

sub _get_consonant_by_ajifry_word {
    my $self        = shift;
    my $ajifry_word = shift;

    given ($ajifry_word) {
        when ('食え')       { return 'a' }
        when ('フライ')     { return 'k' }
        when ('お刺身')     { return 's' }
        when ('アジ')       { return 't' }
        when ('ドボ')       { return 'n' }
        when ('山岡')       { return 'h' }
        when ('岡星')       { return 'm' }
        when ('ゴク・・・') { return 'y' }
        when ('ゴク･･･')    { return 'y' }
        when ('ゴク…')      { return 'y' }
        when ('ああ')       { return 'r' }
        when ('雄山')       { return 'w' }
        default             { return }
    }
}

sub _get_vowel_by_ajifry_word {
    my $self        = shift;
    my $ajifry_word = shift;

    given ($ajifry_word) {
        when ('食え食え')   { return 'a' }
        when ('ドボドボ')   { return 'i' }
        when ('お刺身')     { return 'u' }
        when ('むむ・・・') { return 'e' }
        when ('むむ･･･')    { return 'e' }
        when ('むむ…')      { return 'e' }
        when ('アジフライ') { return 'o' }
        default             { return }
    }
}

sub _to_ajifry {
    my $self       = shift;
    my $raw_string = shift;

    my @raw_chars = split //, $raw_string;
    my $ajifry_word;
    foreach my $raw_char (@raw_chars) {
        my $vowel     = $self->_search_key_of_element( $raw_char, %cols );
        my $consonant = $self->_search_key_of_element( $raw_char, %rows );

        if ( !$vowel && !$consonant ) {
            $ajifry_word .= $raw_char;    # not HIRAGANA
            next;
        }

        $ajifry_word .= "中川"
          if $self->_find_first( $raw_char, @double_consonant );
        $ajifry_word .= $self->_get_ajifry_word_by_consonant($consonant);
        $ajifry_word .= $self->_get_ajifry_word_by_vowel($vowel);
        $ajifry_word .= "社主" if $self->_find_first( $raw_char, @p_sound );
        $ajifry_word .= "陶人" if $self->_find_first( $raw_char, @dullness );
    }
    return $ajifry_word;
}

sub _from_ajifry {
    my $self        = shift;
    my $ajifry_word = shift;

    my $translated_word;
    while (1) {
        unless ($ajifry_word) {
            last;
        }

        my $is_double_consonant = 0;
        if ( $ajifry_word =~ s/^京極// ) {
            $translated_word .= 'ん';
            next;
        }
        elsif ( $ajifry_word =~ s/^中川// ) {
            $is_double_consonant = 1;
        }

        my $consonant;
        if ( $ajifry_word =~ s/^(食え|フライ|お刺身|アジ|ドボ|山岡|岡星|ゴク・・・|ゴク･･･|ゴク…|ああ|雄山)// ) {
            $consonant = $1;
        }
        unless ($consonant) {
            $ajifry_word =~ s/^(.)//;
            $translated_word .= $1;
            next;
        }
        my $vowel;
        if ( $ajifry_word =~ s/^(食え食え|ドボドボ|お刺身|むむ・・・|むむ･･･|むむ…|アジフライ)// ) {
            $vowel = $1;
        }
        unless ($vowel) {
            $translated_word .= $consonant;
            $ajifry_word =~ s/^(.)//;
            $translated_word .= $1;
            next;
        }

        my $is_dullness;
        $is_dullness = $1 if $ajifry_word =~ s/^(陶人)//;
        my $is_p_sound;
        $is_p_sound = $1 if $ajifry_word =~ s/^(社主)//;

        $consonant = $self->_get_consonant_by_ajifry_word($consonant);
        $vowel     = $self->_get_vowel_by_ajifry_word($vowel);

        my @match_characters =
          $self->_find_duplicate_element_in_both_lists( $rows{$consonant}, $cols{$vowel} );
        if ($is_p_sound) {
            $translated_word .= $match_characters[2];
        }
        elsif ($is_dullness) {
            $translated_word .= $match_characters[1];
        }
        elsif ( $is_double_consonant && $consonant ~~ 't' ) {
            $translated_word .= $match_characters[2];
        }
        elsif ($is_double_consonant) {
            $translated_word .= $match_characters[1];
        }
        else {
            $translated_word .= $match_characters[0];
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

Acme::AjiFry - AjiFry Language (アジフライ語) Translator


=head1 VERSION

This document describes Acme::AjiFry version 0.0.3


=head1 SYNOPSIS

    use Acme::AjiFry;

    my $ajifry = Acme::AjiFry->new();

    print $ajifry->translate_to_ajifry('おさしみ')."\n"; # outputs => "食えアジフライお刺身食え食えお刺身ドボドボ岡星ドボドボ"
    print $ajifry->translate_from_ajifry('食えアジフライお刺身食え食えお刺身ドボドボ岡星ドボドボ')."\n"; # outputs => "食えアジフライお刺身食え食えお刺身ドボドボ岡星ドボドボ"


=head1 DESCRIPTION

Acme::AjiFry is the AjiFry-Language translator.
This module can translate Japanese into AjiFry-Language, and vice versa.
If you would like to know about AjiFry-Language, please refer to the following web site (Japanese Web Site).
L<http://ja.uncyclopedia.info/wiki/%E3%82%A2%E3%82%B8%E3%83%95%E3%83%A9%E3%82%A4%E8%AA%9E>

=head1 METHODS

=over

=item new
new is the constructor of this module.

=item translate_from_ajifry
This module needs a AjiFry-Language string as parameter.
It returns Japanese which was translated from AjiFry-Language.

=item translate_to_ajifry
This module needs a string as parameter.
It returns AjiFry-Language which was translated from Japanese.

=back

=head1 DEPENDENCIES

Perl 5.10.0 or later.
Class::Accessor::Fast 0.34 or later.

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
