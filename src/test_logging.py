#!/usr/local/bin/python

import os
import django
import datetime

if __name__ == "__main__":
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "project.settings")
    django.setup()
    import logging

    logger = logging.getLogger('app.logger')
    logger.info('test log entry %s' % datetime.datetime.now())
    logger.info({'jsonentry': 'test json %s' % datetime.datetime.now()})
