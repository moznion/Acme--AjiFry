#!perl

use strict;
use utf8;
use Cwd;
use File::Basename;
use File::Compare;
use File::Copy;

use Test::More;

my $tests_dir = Cwd::getcwd() . '/' . File::Basename::dirname($0);
my $rewrite = $tests_dir . '/rewrite';
my $original_rewrite = $tests_dir . '/rewrite.orig';
my $translated_rewrite = $tests_dir . '/rewrite.translated';
File::Copy::copy $original_rewrite, $rewrite;

my $got;
$got = `$^X $rewrite`;
is($got, 'hello', 'rewrite: stdout-1');
$got = File::Compare::compare($rewrite, $translated_rewrite);
is($got, 0, 'rewrite: Translate truly?');
$got = `$^X $rewrite`;
is($got, 'hello', 'rewrite: stdout-2');

done_testing();
