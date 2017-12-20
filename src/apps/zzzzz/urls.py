# -*- coding: utf-8 -*-
from django.conf.urls import url
from django.views.generic.base import RedirectView

from .views import (
    test_view,
)

app_name='zzzzz'
urlpatterns = [
    url(
        r'^$',
        RedirectView.as_view(pattern_name='zzzzz:test_view'),
        name='index'
    ),
    url(
        r'^test_view/$',
        test_view,
        name='test_view'
    ),
]
