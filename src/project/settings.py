#!python
# coding: utf8

import os

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

SITE_ID = 1

SECRET_KEY = '123123'

DEBUG = os.environ.get('DJANGO_DEBUG', False)

ALLOWED_HOSTS = ['*', ]

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'django.contrib.sites',
    'django.contrib.flatpages',

    #    "compressor",
    #    'easy_thumbnails',
    #    'captcha',
    #    'import_export',

    # Local apps
    'apps.zzzzz'
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'django.contrib.flatpages.middleware.FlatpageFallbackMiddleware',
]

ROOT_URLCONF = 'project.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [
            '/code/templates/',
        ],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'project.wsgi.application'

DATABASES = {
    'default': {
        'ENGINE': os.environ.get("DJANGO_DATABASE_ENGINE"),
        'HOST': os.environ.get("DJANGO_DATABASE_HOST"),
        'NAME': os.environ.get("DJANGO_DATABASE_NAME"),
        'USER': os.environ.get("DJANGO_DATABASE_USER"),
        'PASSWORD': os.environ.get("DJANGO_DATABASE_PASSWORD")
    }
}

CACHES = {
    'default': {
        'BACKEND': 'redis_cache.RedisCache',
        'LOCATION': 'redis:6379',
        'OPTIONS': {
            'DB': 1,
            'PARSER_CLASS': 'redis.connection.HiredisParser',
            'CONNECTION_POOL_CLASS': 'redis.BlockingConnectionPool',
            'CONNECTION_POOL_CLASS_KWARGS': {
                'max_connections': 50,
                'timeout': 20,
            },
            'MAX_CONNECTIONS': 1000,
            'PICKLE_VERSION': -1,

        }
    }
}

if DEBUG:
    CACHES = {
        'default': {
            'BACKEND': 'django.core.cache.backends.dummy.DummyCache'
        }
    }

if not DEBUG:
    SESSION_ENGINE = 'django.contrib.sessions.backends.cache'

LANGUAGE_CODE = 'ru-ru'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_L10N = True

USE_TZ = True

STATIC_URL = '/static/'
STATIC_ROOT = os.environ.get('DJANGO_STATIC_ROOT', '/static')

MEDIA_URL = '/media/'
MEDIA_ROOT = os.environ.get('DJANGO_MEDIA_ROOT', '/media')

LOGGING = {

    'version': 1,
    'disable_existing_loggers': False,

    'formatters': {
        'console': {
            'format': '[%(module)s].%(levelname)s %(message)s'
        }
    },

    'handlers': {
        'logstash': {
            'level': 'INFO',
            'class': 'logstash.TCPLogstashHandler',
            'host': os.environ.get('DJANGO_LOGSTASH_HOST'),
            'port': os.environ.get('DJANGO_LOGSTASH_PORT'),
            'version': 1,
            'message_type': 'logstash',
            'fqdn': True,
            'tags': ['django'],
        },
        'console': {
            'class': 'logging.StreamHandler',
            'formatter': 'console'
        },
    },

    'loggers': {
        'app.logger': {
            'handlers': ['logstash', 'console'],
            'level': 'DEBUG',
            'propagate': True,
        },
        'django': {
            'handlers': ['console'],
            'level': 'INFO',
        },
        'django.request': {
            'handlers': ['console'],
            'level': 'DEBUG',
        }
    },
}

EMAIL_SUBJECT_PREFIX = '[SITE] '

INTERNAL_IPS = ('127.0.0.1',)

LOCALE_PATHS = (
    os.path.join(BASE_DIR, 'locale'),
)

UPLOAD_FILES_DIR = 'upload/files/'

CAPTCHA_FONT_SIZE = 28
CAPTCHA_LENGTH = 4
CAPTCHA_CHALLENGE_FUNCT = 'captcha.helpers.random_char_challenge'

FILE_UPLOAD_PERMISSIONS = 0o644

THUMBNAIL_ALIASES = {
    '': {
        'im300': {'size': (300, 300), 'crop': True},
    },
}

SECURE_LINK_EXPIRES = 600

SENDFILE_BACKEND = 'sendfile.backends.nginx'
SENDFILE_ROOT = os.path.join(MEDIA_ROOT, 'upload/files')
SENDFILE_URL = '/files'

if os.environ.get('APP_ENV') == 'test':
    from .test_settings import *  # NOQA
