use strict;
use utf8;
use Encode;

use Acme::AjiFry::EN;

BEGIN {
    use Test::More tests => 4;
}

my $got;
my $aji_fry_en = Acme::AjiFry::EN->new();

$got = Encode::decode_utf8($aji_fry_en->translate_from_ajifry($aji_fry_en->translate_to_ajifry("0123456789")));
is($got, "0123456789", "Translate reciprocally En: Number");

$got = Encode::decode_utf8($aji_fry_en->translate_from_ajifry($aji_fry_en->translate_to_ajifry("abcdefghijklmnopqrstuvwxyz")));
is($got, "abcdefghijklmnopqrstuvwxyz", "Translate reciprocally En: Small Letter");

$got = Encode::decode_utf8($aji_fry_en->translate_from_ajifry($aji_fry_en->translate_to_ajifry("ABCDEFGHIJKLMNOPQRSTUVWXYZ")));
is($got, "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "Translate reciprocally En: Capital Letter");

$got = Encode::decode_utf8($aji_fry_en->translate_from_ajifry($aji_fry_en->translate_to_ajifry("012abcDEFgH!4~-+::Z")));
is($got, "012abcDEFgH!4~-+::Z", "Translate reciprocally En: Mix");

done_testing();
