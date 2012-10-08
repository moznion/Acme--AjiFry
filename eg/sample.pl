#!/usr/bin/env perl

use strict;
use warnings;
use utf8;

use FindBin;
use lib ("$FindBin::Bin/../lib");
use Acme::AjiFry;

my $ajifry = Acme::AjiFry->new();

print $ajifry->translate_to_ajifry("おさしみ")."\n";
print $ajifry->translate_from_ajifry("食えアジフライお刺身食え食えお刺身ドボドボ岡星ドボドボ")."\n";
