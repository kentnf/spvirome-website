#!/usr/bin/perl

use strict;
use warnings;

my $f = 'data.txt';
my $f2 = shift || die "perl $0 input_virus > output\n";

my %gps;

# put sample location to hash
open(F, $f) || die $!;
while(<F>)
{
	chomp;
	next if $_ =~ m/^#/;
	my @a = split(/\t/, $_);
	$gps{$a[0]} = "$a[5]\t$a[6]\t$a[7]";
}
close(F);

open(F2, $f2) || die $!;
while(<F2>)
{
	chomp;
	if ($_ =~ m/^#/) {
		print $_."\n";
		next;
	}
	my @a = split(/\t/, $_);
	
	if (defined $gps{$a[0]}) {
		print $_."\t".$gps{$a[0]}."\n";
	} else {
		# append FID LAT LNG
		print $_."\tNA\tNA\tNA\n";
	}
}
close(F2);

