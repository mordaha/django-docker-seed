# coding: utf8

# import os
from .settings import *  # NOQA

DATABASES['default'] = {'ENGINE': 'django.db.backends.sqlite3'}  # noqa: F405

PASSWORD_HASHERS = (
    'django.contrib.auth.hashers.MD5PasswordHasher',
)

EMAIL_BACKEND = 'django.core.mail.backends.locmem.EmailBackend'

SECRET_KEY = '123'

# if os.environ.get('TEAMCITY_TESTS'):
#    TEST_RUNNER = "teamcity.django.TeamcityDjangoRunner"
