#!/usr/bin/python
import os, sys
import os.path
from django.conf import settings

# convert GPS location
# from degree,min,sec to decimal_system
# must be stay with load data
def convert_GPS(gps_unit):
	gps_unit = str(gps_unit)
	ma = gps_unit.split(".")  
	degree = abs(int(ma[0]))
	minute = ma[1][0:2]

	second = '0'
	if ma[1][2:4]:
		second = ma[1][2:4]
	s2 = '0'
	if ma[1][4:]:
		s2 = ma[1][4:]    
	minute = minute + "." + second + s2
	minute = float(minute)

	gps_decimal = degree + (minute / float(60))
	if float(gps_unit) < 0:
		gps_decimal = float(gps_decimal) * float(-1)
	gps_decimal = "%.5f" % gps_decimal
	return gps_decimal

# load dataset
def load_data():
	datafile = os.path.abspath(os.path.dirname(os.path.realpath(__file__))) + "/../../static/data.txt"
	data_obj = {}       # data object for store all data
	sample_uniq = {}    # dict for check the sample uniq
	dh = open(datafile, "r")
	for line in dh:
		if line[0] == "#":
			continue
		line = line.strip("\n")
		m = line.split("\t")
		# print len(m)

		# attribute for sample
		sampleID = m[0]
		sdate = m[1]
		sage  = m[9]
		simgs = m[12].split("/")
		slimgs = m[13].split("/")
		sintercrop = m[14]
		scultivar = m[15]

		if sampleID in sample_uniq.keys():
			sys.stderr.write('[ERR]dup sample ID ', sampleID, "\n")
		else:
			sample_uniq[sampleID] = 1

		# attribute for field
		region = m[2]
		district = m[3]
		locality = m[4]
		fid = m[5]
		lng = m[6]
		lat = m[7]
		#lng = convert_GPS(m[6])
		#lat = convert_GPS(m[7])
		alt = m[8]
		fsize = m[10]
		fimgs = m[11].split("/")

		if fid not in data_obj.keys():
			data_obj[fid] = {}
			data_obj[fid]['attr'] = [region, district, locality, lat, lng, alt, fsize, fimgs]
			data_obj[fid]['samp'] = []
			data_obj[fid]['samp'].append([sampleID, sdate, sage, simgs, slimgs, sintercrop, scultivar])
		else:
			data_obj[fid]['samp'].append([sampleID, sdate, sage, simgs, slimgs, sintercrop, scultivar])
	return data_obj

# load data clean
def load_data_clean():
	dataCleanFile = os.path.abspath(os.path.dirname(os.path.realpath(__file__))) + "/../../static/data_clean.txt"
	dataCleanObj = {}	# data clean obj for store all data clean
	dh=open(dataCleanFile, "r")
	for line in dh:
		if line[0] == "#":
			continue
		line = line.strip("\n")
		m = line.split("\t")

		# title
		# 0		 1      2       3           4          5     6          7       8        9     10    11      12     13   14     15    16   17   18          19
		# sample rename barcode Data-set-ID Library-ID total 3P-unmatch 3P-null 3P-match baseN short cleaned %clean tRNA snoRNA snRNA chol rRNA final-clean %final-clean 
		if m[5] < 10000:
			continue

		sid = m[0];
		if len(m[1])>=3:
			sid = m[1]

		if sid not in dataCleanObj.keys():
			dataCleanObj[sid] = {}
			dataCleanObj[sid]['total'] = m[5]
			dataCleanObj[sid]['clean'] = m[11]
			dataCleanObj[sid]['cleanP']= m[12]
			dataCleanObj[sid]['tRNA']  = m[13]
			dataCleanObj[sid]['snoRNA']= m[14]
			dataCleanObj[sid]['snRNA'] = m[15]
			dataCleanObj[sid]['chlo']  = m[16]
			dataCleanObj[sid]['rRNA']  = m[17]
			dataCleanObj[sid]['final'] = m[18]
			dataCleanObj[sid]['finalP']= m[19]

	return dataCleanObj

def load_data_virus():
	dataVirusFile = os.path.abspath(os.path.dirname(os.path.realpath(__file__))) + "/../../static/data_virus.txt"
	dataVirusObj = {}	# data virus obj for store all virus data
	dh=open(dataVirusFile, 'r')
	for line in dh:
		if line[0] == "#":
			continue
		line = line.strip("\n")
		m = line.split("\t")
	
		# 0	       1                 2       3           4           5		   6     78 
		# sampleID type(known/novel) virusID virusFamily Description ShortDesc Field GPS
		if len(m) != 9:
			continue
		vid = m[2]
		if vid not in dataVirusObj.keys():
			dataVirusObj[vid] = {}
			dataVirusObj[vid]['type'] = m[1]
			dataVirusObj[vid]['family'] = m[3]
			dataVirusObj[vid]['desc'] = m[4]
			dataVirusObj[vid]['short'] = m[5]
			dataVirusObj[vid]['sample'] = []
			dataVirusObj[vid]['sample'].append([m[0], m[6], m[7], m[8]])
		else:
			dataVirusObj[vid]['sample'].append([m[0], m[6], m[7], m[8]])
	return dataVirusObj
