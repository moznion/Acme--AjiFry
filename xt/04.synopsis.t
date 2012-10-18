#!perl -w
use strict;
use Test::More;
eval q{use Test::Synopsis};
plan skip_all => 'Test::Synopsis required for testing' if $@;
synopsis_ok("blib/lib/Acme/AjiFry.pm");
synopsis_ok("blib/lib/Acme/AjiFry/EN.pm");
synopsis_ok("blib/lib/Acme/AjiFry/Perl.pm");
done_testing();
