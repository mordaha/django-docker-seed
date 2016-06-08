# coding: utf8

import os
from .settings import *  # NOQA


class NoMigrations(object):
    def __contains__(self, item):
        return True

    def __getitem__(self, item):
        return "notmigrations"


DATABASES['default'] = {'ENGINE': 'django.db.backends.sqlite3'}

PASSWORD_HASHERS = (
    'django.contrib.auth.hashers.MD5PasswordHasher',
)

EMAIL_BACKEND = 'django.core.mail.backends.locmem.EmailBackend'

MIGRATION_MODULES = NoMigrations()

SECRET_KEY = '123'

if os.environ.get('TEAMCITY_TESTS'):
    TEST_RUNNER = "teamcity.django.TeamcityDjangoRunner"
