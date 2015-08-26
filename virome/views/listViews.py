#!/usr/bin/python
import os, sys
import os.path
import re
from django.conf import settings
from django.http import HttpResponse
from django.http import JsonResponse
from django.shortcuts import render

currentdir = os.path.abspath(os.path.dirname(os.path.realpath(__file__)))
sys.path.append(currentdir)
import loadData

# dynamic pages
def dlist(request):
	data = loadData.load_data()
	context = {}
	context.update(settings.GLOBAL_SETTINGS)
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
	return render(request, 'dlist.html', context)
