use strict;
use utf8;
use Encode;

use Acme::AjiFry;

BEGIN {
    use Test::More tests => 4;
}

my $got;
my $aji_fry = Acme::AjiFry->new();

$got = Encode::decode_utf8($aji_fry->translate_from_ajifry($aji_fry->translate_to_ajifry("おさしみ")));
is($got, "おさしみ", "Translate reciprocally Ja: 1");

$got = Encode::decode_utf8($aji_fry->translate_from_ajifry($aji_fry->translate_to_ajifry("ぱりーぐ")));
is($got, "ぱりーぐ", "Translate reciprocally Ja: 2");

$got = Encode::decode_utf8($aji_fry->translate_from_ajifry($aji_fry->translate_to_ajifry("あきらめたらそこでしあいしゅうりょうだよ")));
is($got, "あきらめたらそこでしあいしゅうりょうだよ", "Translate reciprocally Ja: 3");

$got = Encode::decode_utf8($aji_fry->translate_from_ajifry($aji_fry->translate_to_ajifry("んじゃめな")));
is($got, "んじゃめな", "Translate reciprocally Ja: 4");

done_testing();
