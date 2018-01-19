#!/bin/bash

DUMPFILE=deploy/dumpdata.json

BASEDIR=$(dirname "${0}")
DC="docker-compose -f docker-compose.yml -f docker-compose.build.yml -f docker-compose.development.yml"
DC_BUILD="docker-compose -f docker-compose.yml -f docker-compose.build.yml -f docker-compose.images.yml"
DC_PROD="docker-compose -f docker-compose.yml -f docker-compose.images.yml -f docker-compose.production.yml"
DC_EXEC="${DC} exec django"
DC_EXEC_NO_TTY="${DC} exec -T django"

# copy your id_rsa into django container to have access via ssh for PyCharm's remote python interpretier
if ! test -f "${BASEDIR}/deploy/id_rsa.pub"; then
    cp ~/.ssh/id_rsa.pub ${BASEDIR}/deploy/django/
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
            ${DC_EXEC} /bin/bash -c "cd /code && ./runtests.sh ${@:2}"
            ;;
        flake)
            ${DC_EXEC} /bin/bash -c "cd /code && flake8 . ${@:2}"
            ;;
        log)
            ${DC_EXEC} /bin/bash -c "tail -n 100 -f /var/log/django.error.log"
            ;;
        clean_all)
            docker stop $(docker ps -a -q)
            docker rm $(docker ps -a -q)
            docker volume rm $(docker volume ls -q)
            ;;
        es_low)
            curl -XPUT localhost:8020/_cluster/settings -d '{ 
                               "transient" : { 
                                   "cluster.routing.allocation.disk.threshold_enabled" : false 
                               } 
                           }'
            ;;

        dump)
            set -e
            echo Dumping database...

            if ! test -z "${2}"; then
              echo Dumping database into ${2}
              DUMPFILE=${2}
            fi

            if test -f "${DUMPFILE}"; then
              echo "File ${DUMPFILE} exists, making backup copy."
              NOW=$(date +"%Y%m%d")
              bakfile="${DUMPFILE}.bak-${NOW}"
              cp ${DUMPFILE} ${bakfile}
            fi

            ${DC_EXEC_NO_TTY} /bin/bash -c "DEBUG=0 django-admin dumpdata \
              --natural-foreign \
              --natural-primary \
              --indent 4 \
              auth.user \
              flatpages \
              sites \
              zzzzz \
              > dumpdata.json.new"

            if test -z "`cat src/dumpdata.json.new`"; then
              echo ERROR DUMPING DATA, ABORTING...
              rm src/dumpdata.json.new
            else
              mv src/dumpdata.json.new ${DUMPFILE}
            fi
            ls -al ${DUMPFILE}
            echo Done.
            ;;

        load)
            cp ${DUMPFILE} src/tmp.json
            ${DC_EXEC_NO_TTY} /bin/bash -c "DEBUG=0 django-admin loaddata tmp.json"
            rm src/tmp.json
            ;;

        build)
            ${DC_BUILD} -f docker-compose.images.yml build
            ;;

        prod)
            ${DC_PROD} ${@:2}
            ;;

        push)
            ${DC_BUILD} -f docker-compose.images.yml push
            ;;

        *)
            ${DC} $@
            ;;
    esac
fi
