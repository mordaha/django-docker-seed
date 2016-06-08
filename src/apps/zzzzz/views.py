# -*- coding: utf-8 -*-
from django.shortcuts import render
from apps.zzzzz.models import TestModel


# Create your views here.
def test_view(request):
    test_var = TestModel.objects.count()

    return render(request, 'zzzzz/test_template.html', {
        "test_var": test_var,
    })
