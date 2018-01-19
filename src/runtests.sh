#!/bin/sh

export APP_ENV=test

FLAKE8="flake8 --max-line-length=120"

# run tests
coverage run --source="apps" /usr/local/bin/django-admin test -v 2 $@

# flake8 python files
if test "$?" = "0"; then
    if test "${1}" = ""; then
        echo "\n\nflake8 all files:"
        ${FLAKE8} .
        RESULT=$?
        if test "$RESULT" = "0"; then
            echo "\nOK\n\n"
        else
            echo "\n\nFAIL\n\n"
        fi
    else
        # flake only diffed files
        echo "\n\nflake diff:"
        git diff --ignore-space-at-eol -- "*.py" | grep "[+][+][+]" | cut -c11- | xargs ${FLAKE8}
        RESULT1=$?

        if test "$RESULT1" = "0"; then
            RESULT=0
            echo "\nOK\n\n"
        else
            RESULT=-1
            echo "\nFAIL\n\n"
        fi
    fi
fi

# coverage report
if test "${RESULT}" = "0"; then
    coverage report
fi
