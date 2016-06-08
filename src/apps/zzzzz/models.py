# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models


# Create your models here.
class TestModel(models.Model):
    test_str = models.CharField(max_length=20)

    def __str__(self):
        return self.test_str
