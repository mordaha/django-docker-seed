#!/bin/bash

BASEDIR=$(dirname "${0}")
DC="docker-compose -f ${BASEDIR}/docker-compose-dev.yml"

if ! test -f "${BASEDIR}/deploy/id_rsa.pub"; then
    cp ~/.ssh/id_rsa.pub ${BASEDIR}/deploy/
fi

if test -z "${1}" ; then
    # ${DC} build
    ${DC} up
else
    case ${1} in
        shell)
            ${DC} exec service-zzzzz-app /bin/bash
            ;;
        exec)
            ${DC} exec service-zzzzz-app /bin/bash -c "${@:2}"
            ;;
        test)
            ${DC} exec service-zzzzz-app /bin/bash -c "cd /opt/zzzzz/repository/src && ./runtests.sh ${@:2}"
            ;;
        log)
            ${DC} exec service-zzzzz-app /bin/bash -c "tail -n 100 -f /var/log/app.error.log"
            ;;
        clean_all)
            docker stop $(docker ps -a -q)
            docker rm $(docker ps -a -q)
            ;;
        *)
            ${DC} $@
            ;;
    esac
fi
