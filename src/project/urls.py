#!python
# coding: utf8

import os

from django.conf.urls import include
from django.urls import re_path

from django.contrib import admin
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    #    re_path(r'^captcha/', include('captcha.urls')),
    re_path(r'^django-admin/', admin.site.urls),
    re_path(r'', include('apps.zzzzz.urls', namespace='mmcat')),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=os.path.join(settings.MEDIA_ROOT))
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
