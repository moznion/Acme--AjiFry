#!/usr/bin/env perl

use strict;
use warnings;
use utf8;

use FindBin;
use lib ("$FindBin::Bin/../lib");
use Encode;
use Acme::AjiFry::EN;

BEGIN {
    use Test::More;
}

my $got;
my $aji_fry_en = Acme::AjiFry::EN->new();

$got = Encode::decode_utf8($aji_fry_en->translate_from_ajifry($aji_fry_en->translate_to_ajifry("0123456789")));
is($got, "0123456789", Encode::encode_utf8("Decode and Encode: Number"));

$got = Encode::decode_utf8($aji_fry_en->translate_from_ajifry($aji_fry_en->translate_to_ajifry("abcdefghijklmnopqrstuvwxyz")));
is($got, "abcdefghijklmnopqrstuvwxyz", Encode::encode_utf8("Decode and Encode: Small Letter"));

$got = Encode::decode_utf8($aji_fry_en->translate_from_ajifry($aji_fry_en->translate_to_ajifry("ABCDEFGHIJKLMNOPQRSTUVWXYZ")));
is($got, "ABCDEFGHIJKLMNOPQRSTUVWXYZ", Encode::encode_utf8("Decode and Encode: Capital Letter"));

$got = Encode::decode_utf8($aji_fry_en->translate_from_ajifry($aji_fry_en->translate_to_ajifry("012abcDEFgH!4~-+::Z")));
is($got, "012abcDEFgH!4~-+::Z", Encode::encode_utf8("Decode and Encode: Mix"));

done_testing();
