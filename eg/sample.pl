#!/usr/bin/env perl

use strict;
use warnings;
use utf8;

use FindBin;
use lib ("$FindBin::Bin/../lib");
use Acme::AjiFry;

my $aji_fry = Acme::AjiFry->new();

print $aji_fry->encode_to_ajifry("おさしみ") . "\n";
