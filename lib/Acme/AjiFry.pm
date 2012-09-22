package Acme::AjiFry;

use 5.10.0;
use warnings;
use strict;
use Carp;

use version; our $VERSION = '0.01';

use utf8;
use Encode;
use List::Util;
use Data::Dumper;
use base 'Class::Accessor::Fast';

__PACKAGE__->mk_accessors(qw//);

our %cols;
our %rows;
our @dullness;
our @p_sound;
our @double_consonant;

sub new {
    my $class = shift;

    $cols{a} = ['あ', 'か', 'さ', 'た', 'な', 'は', 'ま', 'や', 'ら', 'わ', 'が', 'ざ', 'だ', 'ば', 'ぱ', 'ぁ',       'ゃ', 'ゎ'];
    $cols{i} = ['い', 'き', 'し', 'ち', 'に', 'ひ', 'み',       'り'      , 'ぎ', 'じ', 'ぢ', 'び', 'ぴ', 'ぃ'];
    $cols{u} = ['う', 'く', 'す', 'つ', 'ぬ', 'ふ', 'む', 'ゆ', 'る'      , 'ぐ', 'ず', 'づ', 'ぶ', 'ぷ', 'ぅ', 'っ', 'ゅ'];
    $cols{e} = ['え', 'け', 'せ', 'て', 'ね', 'へ', 'め',       'れ'      , 'げ', 'ぜ', 'で', 'べ', 'ぺ', 'ぇ', ];
    $cols{o} = ['お', 'こ', 'そ', 'と', 'の', 'ほ', 'も', 'よ', 'ろ', 'を', 'ご', 'ぞ', 'ど', 'ぼ', 'ぽ', 'ぉ',       'ょ'];
    $cols{n} = ['ん'];

    $rows{a} = ['あ', 'い', 'う', 'え', 'お', 'ぁ', 'ぃ', 'ぅ', 'ぇ', 'ぉ'];
    $rows{k} = ['か', 'き', 'く', 'け', 'こ', 'が', 'ぎ', 'ぐ', 'げ', 'ご'];
    $rows{s} = ['さ', 'し', 'す', 'せ', 'そ', 'ざ', 'じ', 'ず', 'ぜ', 'ぞ'];
    $rows{t} = ['た', 'ち', 'つ', 'て', 'と', 'だ', 'ぢ', 'づ', 'で', 'ど', 'っ'];
    $rows{n} = ['な', 'に', 'ぬ', 'ね', 'の'];
    $rows{h} = ['は', 'ひ', 'ふ', 'へ', 'ほ', 'ば', 'び', 'ぶ', 'べ', 'ぼ', 'ぱ', 'ぴ', 'ぷ', 'ぺ', 'ぽ'];
    $rows{m} = ['ま', 'み', 'む', 'め', 'も'];
    $rows{y} = ['や', 'ゆ', 'よ', 'ゃ', 'ゅ', 'ょ'];
    $rows{r} = ['ら', 'り', 'る', 'れ', 'ろ'];
    $rows{w} = ['わ', 'を', 'ゎ'];

    @dullness         = ('が', 'ぎ', 'ぐ', 'げ', 'ご', 'ざ', 'じ', 'ず', 'ぜ', 'ぞ',
                         'だ', 'ぢ', 'づ', 'で', 'ど', 'ば', 'び', 'ぶ', 'べ', 'ぼ');
    @p_sound          = ('ぱ', 'ぴ', 'ぷ', 'ぺ', 'ぽ');
    @double_consonant = ('ぁ', 'ぃ', 'ぅ', 'ぇ', 'ぉ', 'っ', 'ゃ', 'ゅ', 'ょ', 'ゎ');

    my $self = $class->SUPER::new();
    return $self;
}

sub check_include_element {
    my ($self, $element, %hash) = @_;

    foreach my $key (sort keys %hash) {
        if (List::Util::first {$_ eq $element} @{$hash{$key}}) {
            return $key;
        }
    }
}

sub replacement{
    my $self = shift;
    my $raw_char = shift;

    my $vowel     = $self->check_include_element($raw_char, %cols);
    my $consonant = $self->check_include_element($raw_char, %rows);

    if (!$vowel && !$consonant) {
        return $raw_char; # not HIRAGANA
    }

    my $ajifry_nized_string;
    if (List::Util::first {$_ eq $raw_char} @double_consonant) {
        $ajifry_nized_string .= "中川";
    }
    given ($consonant) {
        when ('a') { $ajifry_nized_string .= "食え" }
        when ('k') { $ajifry_nized_string .= "フライ" }
        when ('s') { $ajifry_nized_string .= "お刺身" }
        when ('t') { $ajifry_nized_string .= "アジ" }
        when ('n') { $ajifry_nized_string .= "ドボ" }
        when ('h') { $ajifry_nized_string .= "山岡" }
        when ('m') { $ajifry_nized_string .= "岡星" }
        when ('y') { $ajifry_nized_string .= "ゴク・・・" }
        when ('r') { $ajifry_nized_string .= "ああ" }
        when ('w') { $ajifry_nized_string .= "雄山" }
    }
    given ($vowel) {
        when ('a') { $ajifry_nized_string .= "食え食え" }
        when ('i') { $ajifry_nized_string .= "ドボドボ" }
        when ('u') { $ajifry_nized_string .= "お刺身" }
        when ('e') { $ajifry_nized_string .= "むむ・・・" }
        when ('o') { $ajifry_nized_string .= "アジフライ" }
        when ('n') { $ajifry_nized_string .= "京極" }
    }

    if (List::Util::first {$_ eq $raw_char} @p_sound) {
        $ajifry_nized_string .= "社主";
    } elsif (List::Util::first {$_ eq $raw_char} @dullness) {
        $ajifry_nized_string .= "陶人";
    }

    return $ajifry_nized_string;
}

sub encode_to_ajifry {
    my $self       = shift;
    my $raw_string = shift;
    $raw_string = Encode::decode_utf8($raw_string);

    my $ajifry_word;
    my @chars = split //, $raw_string;
    foreach my $char (@chars) {
        $ajifry_word .= $self->replacement($char);
    }

    $ajifry_word = Encode::encode_utf8($ajifry_word);
    return $ajifry_word;
}

1;
# Magic true value required at end of module
__END__

=head1 NAME

Acme::AjiFry - [One line description of module's purpose here]


=head1 VERSION

This document describes Acme::AjiFry version 0.0.1


=head1 SYNOPSIS

use Acme::AjiFry;

=for author to fill in:
Brief code example(s) here showing commonest usage(s).
This section will be as far as many users bother reading
so make it as educational and exeplary as possible.


=head1 DESCRIPTION

=for author to fill in:
Write a full description of the module and its features here.
Use subsections (=head2, =head3) as appropriate.


=head1 INTERFACE 

=for author to fill in:
Write a separate section listing the public components of the modules
interface. These normally consist of either subroutines that may be
exported, or methods that may be called on objects belonging to the
classes provided by the module.


=head1 DIAGNOSTICS

=for author to fill in:
List every single error and warning message that the module can
generate (even the ones that will "never happen"), with a full
explanation of each problem, one or more likely causes, and any
suggested remedies.

=over

=item C<< Error message here, perhaps with %s placeholders >>

[Description of error here]

=item C<< Another error message here >>

[Description of error here]

[Et cetera, et cetera]

=back


=head1 CONFIGURATION AND ENVIRONMENT

=for author to fill in:
A full explanation of any configuration system(s) used by the
module, including the names and locations of any configuration
files, and the meaning of any environment variables or properties
that can be set. These descriptions must also include details of any
configuration language used.

Acme::AjiFry requires no configuration files or environment variables.


=head1 DEPENDENCIES

=for author to fill in:
A list of all the other modules that this module relies upon,
  including any restrictions on versions, and an indication whether
  the module is part of the standard Perl distribution, part of the
  module's distribution, or must be installed separately. ]

  None.


  =head1 INCOMPATIBILITIES

  =for author to fill in:
  A list of any modules that this module cannot be used in conjunction
  with. This may be due to name conflicts in the interface, or
  competition for system or program resources, or due to internal
  limitations of Perl (for example, many modules that use source code
          filters are mutually incompatible).

  None reported.


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

  moznion  C<< <moznion@gmail.com> >>


  =head1 LICENCE AND COPYRIGHT

  Copyright (c) 2012, moznion C<< <moznion@gmail.com> >>. All rights reserved.

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
