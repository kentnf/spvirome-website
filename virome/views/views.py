#!/usr/bin/python
import os, sys
import os.path
import re
from django.conf import settings
from django.http import HttpResponse
from django.http import JsonResponse
from django.shortcuts import render

def geo_list(request):
	data = load_data()
	return JsonResponse(data)
