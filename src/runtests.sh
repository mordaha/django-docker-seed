#!/bin/sh

export APP_ENV=test
coverage run --source="apps" /usr/local/bin/django-admin test -v 2 $@

RESULT=$?

if test -n "$TEAMCITY_TESTS"; then
    coverage html
else
    if test "${RESULT}" = "0"; then
        coverage report
    fi
fi
