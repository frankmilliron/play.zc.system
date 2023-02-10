#!/usr/bin/env perl

# Convert Mono 16-bit PCM WAV to Zero Crossing Audio
#
# Usage:
# chmod a+x convert.pl
# ./convert.pl < INFILE.wav > OUTFILE.zc

use strict;
use warnings;
use Fcntl qw(SEEK_SET SEEK_CUR SEEK_END);

# Skip WAV metadata
seek(STDIN, 44, SEEK_SET);

my $b;
my $prev = 0;
my $bc = 7;
my $byte = 0;
my $w = 44;
while (read(STDIN, $b, 2)) {

    $b = substr($b,1,1); # data is little-endian

    my $cur = (ord($b) > 127)||0;

    my $bit = ($prev ^ $cur);
    $prev = $cur;

    #print $w." | ".$cur." | ".$bit." | ".$bc."\n";

    $byte = ($byte << 1) | $bit;
    --$bc;

    $w += 2;
    if ($bc == -1) {
        #print "  ".$byte."\n";
        print chr($byte);
        $byte = 0;
        $bc = 7;
    }
}
