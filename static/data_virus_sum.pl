#!/usr/bin/perl

# convert data virus sum to my format

while(<>) {
	chomp;
	# from : AO-S001 FJ560943    badnavirus  Sweet potato badnavirus A   87.24
	# from : AO-S001 known   FJ560943        badnavirus      Sweetpotato badnavirus A, complete genome.	Sweetpotato badnavirus	87.24 
	my @a = split(/\t/, $_);
	print "$a[0]\tknown\t$a[1]\t$a[2]\t$a[3]\t$a[3]\t$a[4]\n";
}
