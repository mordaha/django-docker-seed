#!/bin/bash

BASEDIR=$(dirname "${0}")
DC="docker-compose -f ${BASEDIR}/docker-compose-dev.yml"
DC_EXEC="${DC} exec app"

if ! test -f "${BASEDIR}/deploy/id_rsa.pub"; then
    cp ~/.ssh/id_rsa.pub ${BASEDIR}/deploy/
fi

if test -z "${1}" ; then
    ${DC} build && ${DC} up
else
    case ${1} in
        shell)
            ${DC_EXEC} /bin/bash
            ;;
        exec)
            ${DC_EXEC} /bin/bash -c "${@:2}"
            ;;
        test)
            ${DC_EXEC} /bin/bash -c "cd /app && ./runtests.sh ${@:2}"
            ;;
        flake)
            ${DC_EXEC} /bin/bash -c "cd /app && flake8 . ${@:2}"
            ;;
        log)
            ${DC_EXEC} /bin/bash -c "tail -n 100 -f /var/log/app.error.log"
            ;;
        clean_all)
            docker stop $(docker ps -a -q)
            docker rm $(docker ps -a -q)
            docker volume rm $(docker volume ls -q)
            ;;
        es_low_disk_warnings)
            curl -XPUT localhost:8020/_cluster/settings -d '{ 
                               "transient" : { 
                                   "cluster.routing.allocation.disk.threshold_enabled" : false 
                               } 
                           }'
            ;;
        *)
            ${DC} $@
            ;;
    esac
fi
