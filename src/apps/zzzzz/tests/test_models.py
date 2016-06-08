# coding: utf-8

from django.test import TestCase
# from django.db import IntegrityError

from .factories import (
    TestModelFactory
)


class TestModelTestCase(TestCase):
    def test_creation(self):
        obj = TestModelFactory(test_str='test model')
        self.assertGreater(obj.pk, 0)
        self.assertEqual(str(obj), 'test model')
