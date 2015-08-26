#!/usr/bin/python
import os, sys
import os.path
import re
from django.conf import settings
from django.http import HttpResponse
from django.http import JsonResponse
from django.shortcuts import render

# convert GPS location
# from degree,min,sec to decimal_system
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
    datafile = os.path.abspath(os.path.dirname(os.path.realpath(__file__))) + "/../static/data.txt"
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
        lng = convert_GPS(m[6])
        lat = convert_GPS(m[7])
        alt = m[8]
        fsize = m[10]
	fimgs = m[11].split("/")

        if fid not in data_obj.keys():
            data_obj[fid] = {}
            data_obj[fid]['attr'] = [region, district, locality, lat, lng, alt, fsize, fimgs]
            data_obj[fid]['samp'] = []
            data_obj[fid]['samp'].append([sampleID, sdate, sage, simgs, slimgs, sintercrop, scultivar])
            # pass
        else:
            data_obj[fid]['samp'].append([sampleID, sdate, sage, simgs, slimgs, sintercrop, scultivar])
            # pass
    return data_obj

# load data clean
def load_data_clean():
	dataCleanFile = os.path.abspath(os.path.dirname(os.path.realpath(__file__))) + "/../static/data_clean.txt"
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

# basic static pages
def index(request):
    context = {}
    return render(request, 'index.html', context)

def dlist(request):
	context = {}
	return render(request, 'dlist.html', context)

def participant(request):
    context = {}
    return render(request, 'participant.html', context)

def sample(request):
    context = {}
    return render(request, 'sample.html', context)

def data(request):
    context = {}
    return render(request, 'data.html', context)

def publication(request):
    context = {}
    return render(request, 'publication.html', context)

def link(request):
    context = {}
    return render(request, 'link.html', context)

# dynamic pages
def flist(request):
    data = load_data()
    context = {}
    fid = request.GET.get('fid', '')
    if fid:
	if fid in data:
	    context['fid'] = fid
	    context['prefix'] = fid[0] + fid[1]
	    context['region'] = data[fid]['attr'][0]
            context['district'] = data[fid]['attr'][1]
            context['locality'] = data[fid]['attr'][2]
            context['lat'] = data[fid]['attr'][3]
            context['lng'] = data[fid]['attr'][4]
            context['alt'] = data[fid]['attr'][5]
            context['fsize'] = data[fid]['attr'][6]
            context['img'] = data[fid]['attr'][7]
            context['sample'] = data[fid]['samp']
	else:
	    context['ERRMSG'] = 'field ID ' + fid + ' is not correct'
    else:
        context['ERRMSG'] = 'no field was selected'
    return render(request, 'flist.html', context)

def sinfo(request):
    context = {}
    sid = request.GET.get('sid', '')
    if sid:
        context['sid'] = sid
        html = os.path.abspath(os.path.dirname(os.path.realpath(__file__))) + "/../static/sample/result_" + sid + "/known.html"
        html_info = ""
        if os.path.exists(html):
            dh = open(html, "r")
            for line in dh:
                line = re.sub(r'<table.*center', "<table class=\"table table\-striped\" width=700", line) # adjust table style
                # line = re.sub(r'width=780', "width=700", line) # adjust page width
                matchObj = re.search( r'known_references/(.*)\.html', line) # convet the link
                if matchObj:
                    link = "/virome/sctg?sid=" + sid + "&vid=" + matchObj.group(1)
                    line = re.sub(r'known_references/.*html', link, line)
                html_info = html_info + line + "\n"
        else:
            html_info = "No virus was identified"

        context['html'] = html
        context['html_info'] = html_info

		# get sample clean information 
        context['total']   = 'NA'
        context['clean']   = 'NA'
        context['cleanP']  = 'NA'
        context['rRNA']    = 'NA'
        context['tsnoRNA'] = 'NA'
        context['final']   = 'NA'
        context['finalP']  = 'NA'

        data_clean = load_data_clean()
        if sid in data_clean:
            context['total']   = data_clean[sid]['total']
            context['clean']   = data_clean[sid]['clean']
            context['cleanP']  = data_clean[sid]['cleanP']
            context['rRNA']    = str(data_clean[sid]['chlo']) + '/' + str(data_clean[sid]['rRNA'])
            context['tsnoRNA'] = str(data_clean[sid]['tRNA']) + '/' + str(data_clean[sid]['snoRNA']) + '/' + str(data_clean[sid]['snRNA'])
            context['final']   = data_clean[sid]['final']
            context['finalP']  = data_clean[sid]['finalP']
    else:
	    context['ERRMSG'] = 'no sample was selected'
    return render(request, 'sinfo.html', context)

def sctg(request):
    context = {}
    sid = request.GET.get('sid', '')
    vid = request.GET.get('vid', '')
    if sid and vid:
	html = os.path.abspath(os.path.dirname(os.path.realpath(__file__))) + "/../static/sample/result_" + sid + "/known_references/" + vid + ".html"
	html_info = ""
	dh = open(html, "r")
    	for line in dh:
            line = re.sub(r'<table.*center', "<table class=\"table table\-striped\"", line) # adjust table style
            matchObj = re.search(r'img src="(.*)\.png', line) # convet the png
            if matchObj:
                link = "img src =\"/static/sample/result_" + sid + "/known_references/" + matchObj.group(1) + ".png\" \""
                line = re.sub(r'img src.*\.png"', link, line)
            html_info = html_info + line + "\n"
        context['html'] = html
        context['html_info'] = html_info
        context['sid'] = sid
        context['vid'] = vid
    else:
        context['ERRMSG'] = 'no sample or virus was selected'
    return render(request, 'sctg.html', context)

def geo_list(request):
    data = load_data()
    return JsonResponse(data)
