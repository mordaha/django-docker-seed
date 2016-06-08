# -*- coding: utf-8 -*-
from django.conf.urls import url
from .views import (
    index,
)


urlpatterns = [
    url(r'^S', index, name='index'),
]
