#!/bin/sh

export APP_ENV=test

# run tests
coverage run --source="apps" /usr/local/bin/django-admin test -v 2 $@

# flake8 python files
if test "$?" = "0"; then
    if test "${1}" = ""; then
        echo "\n\nflake8 all files:"
        flake8 .
        RESULT=$?
        if test "$RESULT" = "0"; then
            echo "\nOK\n\n"
        else
            echo "\n\nFAIL\n\n"
        fi
    else
        # flake only diffed files
        echo "\n\nflake diff:"
        git diff --ignore-space-at-eol -- "*.py" | grep "[+][+][+]" | cut -c11- | xargs flake8
        RESULT1=$?
        # echo "cached:"
        # git diff --cached --ignore-space-at-eol -- "*.py" | grep "[+][+][+]" | cut -c11- | xargs flake8
        # RESULT2=$?
        
        # if test "$RESULT1" = "0" && test "$RESULT2" = "0"; then
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
if test -n "$TEAMCITY_TESTS"; then
    coverage html
else
    if test "${RESULT}" = "0"; then
        coverage report
    fi
fi
