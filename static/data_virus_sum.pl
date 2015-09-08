#!/usr/bin/perl

# convert data virus sum to my format

while(<>) {
	chomp;
	# from : AO-S001 known   FJ560943        badnavirus      Sweetpotato badnavirus A, complete genome.      Sweetpotato badnavirus  Sweetpotato badnavirus A
	# to : AO-S001 badnavirus      Sweetpotato badnavirus A 
	my @a = split(/\t/, $_);
	print "$a[0]\tknown\t$a[2]\t$a[1]\t$a[2]\t$a[2]\n";
}
