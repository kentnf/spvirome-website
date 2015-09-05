#!/usr/bin/perl

use strict;
use warnings;

my $file = shift || die "USAGE: $0 input > output\n";

# load data to hash
my %vname;
while(<DATA>) 
{
	chomp;
	my @a = split(/\t\|\|\t/, $_);
	if (defined $a[1] && $a[1] =~ m/\S+/) {
		$vname{$a[0]} = $a[1];
	} else {
		$vname{$a[0]} = $a[0];
	}
}

open(FH, $file) || die $!;
while(<FH>)
{
	chomp;
	# AO-S001 known   FJ560943        badnavirus      Sweetpotato badnavirus A, complete genome.
	my @a = split(/\t/, $_);
	my $desc = $a[4];
	my $name = "unknown";
	for(my $i=10; $i<length($desc); $i++) 
	{
		my $sub_desc = substr($desc, 0, $i);
		if (defined $vname{$sub_desc}) {
			$name = $vname{$sub_desc};
			last;
		}
	}
	print $_."\t".$name."\n";
}
close(FH);




__DATA__
Ageratum leaf curl	||	Ageratum leaf curl virus
Ageratum yellow vein	||	Ageratum yellow vein virus
Andean potato latent virus
Apple mosaic virus
Apple stem pitting virus
Arracacha mottle virus
Asystasia begomovirus
Banana mild mosaic virus
Banana streak	||	Banana streak virus
Bean golden mosaic virus
Beet ringspot virus
Beet western yellows virus
Bhendi yellow vein mosaic virus
Caper latent virus
Carrot mottle mimic umbravirus
Carrot virus Y
Centrosema yellow spot virus
Chilli veinal mottle virus
Citrus exocortis viroid
Citrus psorosis virus
Citrus yellow mosaic virus
Citrus yellow mosaic virus
Cladosporium cladosporioides virus
Cotton leaf curl	||	Cotton leaf curl virus
Cowpea aphid-borne mosaic	||	Cowpea aphid-borne mosaic virus
Cucumber mosaic virus
Cucurbit aphid-borne yellows virus
Cytospora ribis mitovirus
Dioscorea alata bacilliform virus
Dioscorea bacilliform virus
Freesia sneak virus
Fusarium circinatum mitovirus
Grapevine Anatolian ringspot virus
Grapevine leafroll-associated virus
Grapevine yellow speckle viroid
Gremmeniella abietina mitochondrial RNA virus
Hollyhock yellow vein virus
Hop stunt viroid
Hungarian grapevine chrome mosaic nepovirus || Hungarian grapevine chrome mosaic virus
Hungarian grapevine chrome mosaic virus
Hymenoscyphus fraxineus mitovirus
Ipomoea yellow vein virus
Leonurus mosaic virus
Lettuce ring necrosis virus
Lupine mosaic virus
Maize dwarf mosaic virus
Malvastrum yellow mosaic virus
Melon yellowing-associated virus
Merremia leaf curl virus
Mimosa yellow leaf curl virus
Moroccan watermelon mosaic virus
Musa accuminata endogenous badnavirus
Musa acuminata endogenous badnavirus	||	Musa accuminata endogenous badnavirus
Musa balbisiana endogenous badnavirus
Nanovirus-like particle
Narcissus yellow stripe virus
Okra leaf curl	||	Okra leaf curl virus
Okra yellow crinkle
Onion yellow dwarf virus
Opium poppy mosaic virus
Papaya leaf curl	||	Papaya leaf curl virus
Papaya ringspot virus
Pea enation mosaic virus
Peanut chlorotic streak caulimovirus
Pepper mild mottle virus
Pepper yellow vein Mali virus
Phlox Virus
Pineapple bacilliform comosus virus
Piper DNA virus
Plum bark necrosis stem pitting-associated virus
Potato leaf roll virus
Potato leafroll	||	Potato leaf roll virus
Potato virus X
Potato virus Y
Potato yellow mosaic	||	Potato yellow mosaic virus
Potato yellow vein virus
Red clover bacilliform virus
Sclerotinia homoeocarpa mitovirus
Sclerotinia sclerotiorum mitovirus
Sida golden mosaic virus
Sida yellow vein Vietnam virus
Soybean crinkle leaf virus
Stilbocarpa mosaic bacilliform virus
Strawberry crinivirus
Sugarcane bacilliform virus
Sweetpotato badnavirus A
Sweetpotato badnavirus B
Sweetpotato badnavirus C
Sweet potato begomovirus
Sweet potato caulimo-like virus
Sweet potato chlorotic fleck virus
Sweet potato feathery mottle virus
Sweet potato golden vein associated virus
Sweet potato latent virus
Sweet potato leaf curl	||	Sweet potato leaf curl virus
Sweet potato leaf speckling virus
Sweet potato mild mottle virus
Sweet potato chlorotic stunt virus
Sweetpotato mild mottle virus	||	Sweet potato mild mottle virus
Sweet potato mosaic virus
Sweetpotato symptomless mastrevirus	||	Sweet potato symptomless mastrevirus
Sweet potato vein clearing virus
Sweet potato virus 2
Sweet potato virus C
Sweet potato virus G
Sweet potato virus Y
Thielaviopsis basicola mitovirus
Tobacco bushy top virus
Tobacco etch virus
Tobacco leaf curl	||	Tobacco leaf curl virus
Tobacco vein-clearing virus
Tobacco vein distorting virus
Tomato apical stunt viroid
Tomato black ring virus
Tomato leaf curl	||	Tomato leaf curl virus
Tomato matilda virus
Tomato Venezuela begomovirus
Tomato yellow leaf curl	||	Tomato yellow leaf curl virus
Tomato yellow spot virus
Valsa malicola mitovirus
Watermelon chlorotic stunt virus
Watermelon mosaic virus
Yam mosaic virus
Zucchini yellow mosaic virus
