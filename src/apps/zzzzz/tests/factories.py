# coding: utf-8
import factory

from apps.zzzzz.models import (
    TestModel,
)


class TestModelFactory(factory.DjangoModelFactory):
    class Meta:
        model = TestModel
