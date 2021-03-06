#!/usr/bin/perl

use strict;
use warnings;
use IO::File;

my $inF = shift || die "USAGE: $0 input_list\n";

# put sample id to hash
# key: sample ID
# value: virus information
my %sample_virus; 

open(OUT, ">data_virus.txt") || die $!;
open(FH, $inF) || die $!;
while(<FH>) {
	chomp;
	my @a = split(/\t/, $_);
	my $known_file = `ls $_/*.known.xls`; chomp($known_file);
	my $novel_file = `ls $_/*.novel.xls`; chomp($novel_file);

	# get sample ID
	my $sample_id = $_;
	$sample_id =~ s/result_//;

	# link the sample to feild information later for GPS location
	
	# parse known virus
	my %uniq_virus;

	if (-s $known_file) {
		my $in = IO::File->new($known_file) || die $!;
		while(<$in>) {
			chomp;
			next if $_ =~ m/^#/;
			my @a = split(/\t/, $_);
			# 0         1          2          3      4       5     6
			# Contig_ID Contig_Seq Contig_Len Hit_ID Hit_Len Genus Description Contig_start Contig_end Hit_start Hit_end Hsp_identity E_value Hsp_strand
			unless (defined $uniq_virus{$a[3]})	{
				$uniq_virus{$a[3]} = 1;
				print OUT $sample_id."\tknown\t".$a[3]."\t".$a[5]."\t".$a[6]."\n";
			}
		}
		$in->close;
	}

	if (-s $novel_file) {
		my $in = IO::File->new($novel_file) || die $!;
		while(<$in>) {
			chomp;
			next if $_ =~ m/^#/;
			my @a = split(/\t/, $_);
			unless (defined $uniq_virus{$a[3]}) {
				$uniq_virus{$a[3]} = 1;
				print OUT $sample_id."\tnovel\t".$a[3]."\t".$a[5]."\t".$a[6]."\n";
			}
		}
		$in->close;
	}
}
close(FH);
close(OUT);

__DATA__
result_AO-S001
result_AO-S002
result_AO-S003
result_AO-S006
result_AO-S011
result_AO-S012
result_AO-S016
result_AO-S017
result_AO-S019
result_AO-S020
result_AO-S021
result_AO-S022
result_AO-S055
result_AO-S058
result_AO-S065
result_AO-S068
result_AO-S075
result_AO-S083
result_AO-S085
result_AO-S086
result_AO-S087
result_AO-S088
result_AO-S089
result_AO-S095
result_AO-S098
result_AO-S104
result_AO-S107
result_AO-S109
result_AO-S110
result_AO-S111
result_AO-S112
result_AO-S113
result_AO-S119
result_AO-S120
result_AO-S121
result_AO-S128
result_AO-S131
result_AO-S143
result_AO-S151
result_AO-S154
result_AO-S160
result_AO-S172
result_AO-S178
result_AO-S185
result_BE-01
result_BE-04
result_BE-05
result_BE-06
result_BE-10
result_BE-11
result_BE-12
result_BE-19
result_BE-2
result_BE-20
result_BE-21
result_BE-23
result_BE-24
result_BE-25
result_BE-26
result_BE-27
result_BE-3
result_BE-31
result_BE-32
result_BE-33
result_BE-7
result_BE-8
result_BE-9
result_BE-S014
result_BE-S015
result_BE-S016
result_BE-S017
result_BE-S018
result_ET1
result_ET10
result_ET102
result_ET104
result_ET105
result_ET107
result_ET108
result_ET109
result_ET11
result_ET110
result_ET111
result_ET112
result_ET113
result_ET114
result_ET115
result_ET116
result_ET117
result_ET118
result_ET119
result_ET12
result_ET120
result_ET121
result_ET126
result_ET13
result_ET14
result_ET15
result_ET16
result_ET17
result_ET18
result_ET19
result_ET20
result_ET207
result_ET21
result_ET22
result_ET23
result_ET24
result_ET248
result_ET25
result_ET250
result_ET251
result_ET252
result_ET26
result_ET27
result_ET28
result_ET3
result_ET30
result_ET31
result_ET32
result_ET33
result_ET34
result_ET35
result_ET36
result_ET38
result_ET39
result_ET4
result_ET40
result_ET41
result_ET43
result_ET44
result_ET45
result_ET46
result_ET47
result_ET48
result_ET49
result_ET50
result_ET51
result_ET52
result_ET53
result_ET54
result_ET55
result_ET56
result_ET57
result_ET58
result_ET59
result_ET6
result_ET61
result_ET62
result_ET63
result_ET64
result_ET67
result_ET68
result_ET69
result_ET70
result_ET71
result_ET72
result_ET73
result_ET74
result_ET75
result_ET76
result_ET77
result_ET78
result_ET79
result_ET8
result_ET81
result_ET82
result_ET83
result_ET84
result_ET85
result_ET86
result_ET87
result_ET88
result_ET89
result_ET9
result_ET90
result_ET94
result_ET95
result_ET96
result_ET97
result_ET99
result_GAF-128
result_GAF-133
result_GAF-142
result_GAF-143
result_GAF-144
result_GAF-145
result_GAF-146
result_GAF-147
result_GAF-148
result_GAF-149
result_GAF-150
result_GAF-151
result_GAF-152
result_GAF-153
result_GAF-154
result_GAF-155
result_GAF-156
result_GAF-157
result_GAF-158
result_GAF-159
result_GAF-160
result_GAF-161
result_GAF-164
result_GAF-166
result_GAF-169
result_GAF-171
result_GAF-173
result_GAF-174
result_GAF-175
result_GAF-175_R1
result_GAF-176
result_GAF-177
result_GAF-178
result_GAF-179
result_GAF-180
result_GAF-181
result_GAF-182
result_GAF-183
result_GAF-184
result_GAF-185
result_GAF-186
result_GAF-187
result_GAF-188
result_GAF-189
result_GAF-190
result_GAF-191
result_GAF-192
result_GAF-193
result_GAF-194
result_GAF-195
result_GAF-196
result_GAF-197
result_GAF-198
result_GAF-199
result_GAF-200
result_GAF-201
result_GAF-202
result_GAF-202_R1
result_GAF-203
result_GAF-204
result_GAF-205
result_GAF-206
result_GAF-207
result_GAF-207_R1
result_GAF-208
result_GAF-208_R1
result_GAF-210
result_GAF-211
result_GAF-212
result_GAF-212_R1
result_GAF-213
result_GAF-214
result_GAF-215
result_GAF-216
result_GAF-217
result_GAF-218
result_GAF-219
result_GAF-222
result_GAF-223
result_GAF-224
result_GAF-225
result_GAF-225_R1
result_GAF-226
result_GAF-226_R1
result_GAF-238
result_GAF-239
result_GAF-240
result_GAF-241
result_GAF-241_R1
result_GAF-242
result_GAF-242_R1
result_GAF-243
result_GAF-243_R1
result_GAF-244
result_GAF-249
result_GAF-257
result_GAF-258
result_GAF-259
result_GAF-260
result_GAF-261
result_GAF-261_R1
result_GAF-262
result_GAF-263
result_GAF-264
result_GAF-265
result_GAF-265_R1
result_GAF-267
result_GAF-268
result_GAF-269
result_GAF-271
result_GAF-271_R1
result_GAF-272
result_GAF-274
result_GAF-277
result_GAF-278
result_GAF-280
result_GAF-281
result_GAF-282
result_GAF-283
result_GAF-285
result_GAF-286
result_GAF-290
result_GAF-291
result_GAF-292
result_GAF-293
result_GAF-294
result_GAF-295
result_GAF-296
result_GAF-297
result_GAF-298
result_GAF-299
result_GAF-300
result_GAF-301
result_GAF-302
result_GU-100
result_GU-102
result_GU-104
result_GU-25
result_GU-47
result_GU-60
result_GU-61
result_GU-62
result_GU-63
result_GU-66
result_GU-68
result_GU-70
result_GU-72
result_GU-73
result_GU-74
result_GU-75
result_GU-76
result_GU-77
result_GU-78
result_GU-90
result_GU-92
result_GU-94
result_GU-95
result_GU-96
result_GU-97
result_GU-98
result_GU-99
result_GU-S001
result_GU-S006
result_GU-S021
result_MW-S002
result_MW-S003
result_MW-S004
result_MW-S011
result_MW-S012
result_MW-S028
result_MW-S029
result_MW-S034
result_MW-S037
result_MW-S042
result_MW-S046
result_MW-S047
result_MW-S052
result_MW-S053
result_MW-S061
result_MW-S064
result_MW-S066
result_MW-S067
result_MW-S081
result_MW-S082
result_MW-S084
result_MW-S085
result_MW-S086
result_MW-S087
result_MW-S091
result_MW-S094
result_MW-S097
result_MW-S104
result_MW-S106
result_MW-S109
result_NI-10
result_NI-11
result_NI-13
result_NI-14
result_NI-15
result_NI-18
result_NI-21
result_NI-24
result_NI-27
result_NI-30
result_NI-33
result_NI-37
result_NI-38
result_NI-55
result_NI-56
result_NI-57
result_NI-61
result_NI-67
result_NI-68
result_NI-69
result_NI-74
result_NI-78
result_NI-79
result_NI-80
result_NI-81
result_NI-S001
result_NI-S002
result_NI-S003
result_NI-S004
result_NI-S005
result_NI-S006
result_NI-S007
result_NI-S008
result_NI-S043
result_NI-S044
result_NI-S045
result_NI-S046
result_NI-S047
result_NI-S048
result_NI-S049
result_NI-S050
result_NI-S051
result_NI-S052
result_NI-S053
result_NI-S054
result_TZ01
result_TZ02
result_TZ03
result_TZ10
result_TZ107
result_TZ112
result_TZ116
result_TZ151
result_TZ154
result_TZ155
result_TZ156
result_TZ164
result_TZ170
result_TZ171
result_TZ181
result_TZ188
result_TZ191
result_TZ196
result_TZ198
result_TZ201
result_TZ208
result_TZ211
result_TZ214
result_TZ216
result_TZ217
result_TZ222
result_TZ227
result_TZ228
result_TZ231
result_TZ232
result_TZ241
result_TZ242
result_TZ253
result_TZ257
result_TZ261
result_TZ262
result_TZ268
result_TZ27
result_TZ36
result_TZ46
result_TZ57
result_TZ6
result_TZ61
result_TZ66
result_TZ9
result_TZ97
result_UG-103
result_UG-104
result_UG-105
result_UG-107
result_UG-110
result_UG-112
result_UG-114
result_UG-116
result_UG-117
result_UG-118
result_UG-119
result_UG-123
result_UG-124
result_UG-125
result_UG-126
result_UG-127
result_UG-128
result_UG-129
result_UG-13
result_UG-134
result_UG-135
result_UG-136
result_UG-137
result_UG-139
result_UG-140
result_UG-141
result_UG-143
result_UG-144
result_UG-145
result_UG-146
result_UG-147
result_UG-148
result_UG-149
result_UG-15
result_UG-150
result_UG-155
result_UG-158
result_UG-161
result_UG-164
result_UG-165
result_UG-166
result_UG-168
result_UG-171
result_UG-172
result_UG-173
result_UG-175
result_UG-176
result_UG-177
result_UG-179
result_UG-180
result_UG-181
result_UG-182
result_UG-183
result_UG-184
result_UG-185
result_UG-186
result_UG-187
result_UG-188
result_UG-189
result_UG-190
result_UG-191
result_UG-192
result_UG-193
result_UG-194
result_UG-195
result_UG-196
result_UG-197
result_UG-198
result_UG-199
result_UG-20
result_UG-22
result_UG-25
result_UG-30
result_UG-31
result_UG-34
result_UG-36
result_UG-40
result_UG-42
result_UG-45
result_UG-49
result_UG-5
result_UG-50
result_UG-55
result_UG-59
result_UG-65
result_UG-68
result_UG-73
result_UG-77
result_UG-81
result_UG-84
result_UG-89
result_UG-9
result_UG-92
result_UG-94
result_UG-97
result_UG-99
result_ZW-S001
result_ZW-S002
result_ZW-S006
result_ZW-S007
result_ZW-S008
result_ZW-S009
result_ZW-S010
result_ZW-S011
result_ZW-S012
result_ZW-S013
result_ZW-S014
result_ZW-S015
result_ZW-S016
result_ZW-S017
result_ZW-S018
result_ZW-S021
result_ZW-S023
result_ZW-S024
result_ZW-S025
result_ZW-S026
result_ZW-S027
result_ZW-S028
result_ZW-S029
result_ZW-S030
result_ZW-S031
result_ZW-S037
result_ZW-S038
result_ZW-S039
result_ZW-S040
result_ZW-S041
result_ZW-S043
result_ZW-S049
result_ZW-S058
result_ZW-S064
result_ZW-S070
result_ZW-S071
result_ZW-S072
result_ZW-S082
result_ZW-S083
result_ZW-S084
result_ZW-S088
result_ZW-S094
result_ZW-S100
result_ZW-S106
result_ZW-S118
result_ZW-S124
result_ZW-S130
result_ZW-S136
result_ZW-S142
result_ZW-S148
