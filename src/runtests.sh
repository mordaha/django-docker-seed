#!/bin/sh

export APP_ENV=test
coverage run --source="apps" /usr/local/bin/django-admin test -v 2 $@


if test "$?" = "0"; then
    flake8 .
fi

RESULT=$?

if test -n "$TEAMCITY_TESTS"; then
    coverage html
else
    if test "${RESULT}" = "0"; then
        coverage report
    fi
fi
