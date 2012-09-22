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

$got = Encode::decode_utf8($aji_fry->encode_to_ajifry("おさしみ"));
is($got, "食えアジフライお刺身食え食えお刺身ドボドボ岡星ドボドボ", Encode::encode_utf8("Encode: おさしみ"));

$got = Encode::decode_utf8($aji_fry->encode_to_ajifry("やまおか"));
is($got, "ゴク・・・食え食え岡星食え食え食えアジフライフライ食え食え", Encode::encode_utf8("Encode: やまおか"));

$got = Encode::decode_utf8($aji_fry->encode_to_ajifry("あきらめたらそこでしあいしゅうりょうだよ"));
is($got, "食え食え食えフライドボドボああ食え食え岡星むむ・・・アジ食え食えああ食え食えお刺身アジフライフライアジフライアジむむ・・・陶人お刺身ドボドボ食え食え食え食えドボドボお刺身ドボドボ中川ゴク・・・お刺身食えお刺身ああドボドボ中川ゴク・・・アジフライ食えお刺身アジ食え食え陶人ゴク・・・アジフライ", Encode::encode_utf8("Encode: あきらめたらそこでしあいしゅうりょうだよ"));

$got = Encode::decode_utf8($aji_fry->encode_to_ajifry("ぱりーぐ"));
is($got, "山岡食え食え社主ああドボドボーフライお刺身陶人", Encode::encode_utf8("Encode: ぱりーぐ"));

$got = Encode::decode_utf8($aji_fry->encode_to_ajifry("んじゃめな"));
is($got, "京極お刺身ドボドボ陶人中川ゴク・・・食え食え岡星むむ・・・ドボ食え食え", Encode::encode_utf8("Encode: んじゃめな"));

done_testing();
