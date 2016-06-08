# coding: utf-8

from django.test import TestCase
from django.core.urlresolvers import reverse


from .factories import (
    TestModelFactory,
)


class TestViewTestCase(TestCase):
    def test_status(self):
        response = self.client.get(reverse('zzzzz:test_view'))

        self.assertEqual(response.status_code, 200)
        self.assertContains(response, 'TestModel')

    def test_with_model(self):
        TestModelFactory.create_batch(size=112, test_str='test str')
        response = self.client.get(reverse('zzzzz:test_view'))
        self.assertEqual(response.status_code, 200)
        self.assertContains(response, '112')
