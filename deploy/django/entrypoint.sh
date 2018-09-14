#!/bin/bash


export PYTHONUNBUFFERED=1


# wait for postges
echo "Waiting for postgresql database"
while true
do
  if ! [ -z "${DJANGO_NOWAIT}" ]; then
    break
  fi

  curl -s http://${DJANGO_DATABASE_HOST}:5432
  if [ "$?" = "0" -o  "$?" = "52" ]; then
    break
  fi
  echo "$(date) - still trying"
  sleep 5
done

if [ "DJANGO_DATABASE_HOST" = "pgsql" ]; then
    sleep 5 # wait for dockerized postgress will warm up
fi

echo "$(date) - connected successfully"

django-admin migrate --noinput
django-admin collectstatic --noinput

# for PyCharm remote python interpretator
if ! [ -z "${DJANGO_DEV}" ]; then
    /usr/sbin/sshd
fi

if ! [ -z "${DJANGO_DEBUG}" ]; then
    django-admin runserver 0.0.0.0:8000
else
    exec gunicorn \
      --user=www-data \
      --bind 0.0.0.0:8000 \
      --workers 3 \
      --max-requests 1000 \
      --worker-class=gevent \
      --log-level=info \
      --capture-output \
      project.wsgi:application
fi
