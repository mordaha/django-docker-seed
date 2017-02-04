#!/bin/bash


export PYTHONUNBUFFERED=1


# wait for postges
echo "Waiting for postgresql database"
while true
do
  curl -s http://pgsql:5432
  if [ "$?" = "0" -o  "$?" = "52" ]; then
    break
  fi
  echo "$(date) - still trying"
  sleep 2
done
echo "$(date) - connected successfully"


if ! [ -z "$DJANGO_RESET_DB" ]; then
    django-admin reset_db --noinput
fi

django-admin migrate --noinput
django-admin collectstatic --noinput

# for PyCharm remote python interpretator
if ! [ -z "${DEV}" ]; then
    /usr/sbin/sshd
fi

# run
if ! [ -z "$DJANGO_SHELL" ]; then
    django-admin shell
else
    if ! [ -z "$DEBUG" ]; then
        django-admin runserver 0.0.0.0:8000
    else
      exec gunicorn project.wsgi:application \
          --bind 0.0.0.0:8000 \
          --workers 3 \
          --log-level=info \
          --log-file=/var/log/gunicorn.log \
          --access-logfile=/var/log/gunicorn-access.log \
          "$@"
    fi
fi
