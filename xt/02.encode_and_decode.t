#!/usr/bin/env perl

use strict;
use warnings;
use utf8;

use FindBin;
use lib ("$FindBin::Bin/../lib");
use Encode;
use Acme::AjiFry;

BEGIN {
    use Test::More;
}

my $got;
my $aji_fry = Acme::AjiFry->new();

$got = Encode::decode_utf8($aji_fry->translate_from_ajifry($aji_fry->translate_to_ajifry("おさしみ")));
is($got, "おさしみ", Encode::encode_utf8("Decode and Encode: おさしみ"));

$got = Encode::decode_utf8($aji_fry->translate_from_ajifry($aji_fry->translate_to_ajifry("ぱりーぐ")));
is($got, "ぱりーぐ", Encode::encode_utf8("Decode and Encode: ぱりーぐ"));

$got = Encode::decode_utf8($aji_fry->translate_from_ajifry($aji_fry->translate_to_ajifry("あきらめたらそこでしあいしゅうりょうだよ")));
is($got, "あきらめたらそこでしあいしゅうりょうだよ", Encode::encode_utf8("Decode and Encode: あきらめたらそこでしあいしゅうりょうだよ"));

$got = Encode::decode_utf8($aji_fry->translate_from_ajifry($aji_fry->translate_to_ajifry("んじゃめな")));
is($got, "んじゃめな", Encode::encode_utf8("Decode and Encode: んじゃめな"));

done_testing();
