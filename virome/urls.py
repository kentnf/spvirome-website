"""virome URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.8/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Add an import:  from blog import urls as blog_urls
    2. Add a URL to urlpatterns:  url(r'^blog/', include(blog_urls))
"""
from django.conf.urls import include, url
from django.contrib import admin
from virome.views import static
from virome.views import pageDisplay 
from virome.views import listViews

urlpatterns = [
	# for data display
	url(r'^flist', pageDisplay.flist),
	url(r'^sinfo', pageDisplay.sinfo),
	url(r'^sctg',  pageDisplay.sctg),
	url(r'^download', pageDisplay.download),

	# for map view
	url(r'^dmap', static.dmap),

	# for list view
	url(r'^dlist', listViews.dlist),

	# for data load
	url(r'^geo_list', pageDisplay.geo_list),

	# for static pages
	url(r'^$', static.index),
	url(r'^index', static.index),
	url(r'^participant', static.participant),
	url(r'^sample', static.sample),
	url(r'^publication', static.publication),
	url(r'^link', static.link),

	# for system 
	url(r'^admin/', include(admin.site.urls)),
]

