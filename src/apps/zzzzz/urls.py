#!python
# coding: utf8

from django.urls import re_path
from django.views.generic.base import RedirectView

from .views import (
    test_view,
)

app_name = 'zzzzz'
urlpatterns = [
    re_path(
        r'^$',
        RedirectView.as_view(pattern_name='zzzzz:test_view'),
        name='index'
    ),
    re_path(
        r'^test_view/$',
        test_view,
        name='test_view'
    ),
]
