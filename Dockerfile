FROM python:2.7

# Prepare os libs
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y \
    python-dev python-setuptools python-pip \
    git-core \
    nginx
RUN pip install -U pip supervisor

# Prepare app specific modules
COPY ./requirements.pip /tmp/requirements.pip
RUN pip install -r /tmp/requirements.pip
RUN rm /tmp/requirements.pip

# Prepare environment
ENV APP_NAME="zzzzz"
ENV APP_ROOT="/opt/${APP_NAME}"
ENV APP_REPOSITORY="${APP_ROOT}/repository"
ENV PYTHONPATH="${PYTHONPATH}:${APP_REPOSITORY}/src"

ENV DJANGO_STATIC_ROOT="/var/www/static"
ENV DJANGO_MEDIA_ROOT="/var/www/media"

# Prepare nginx
RUN rm -Rf /etc/nginx/sites-enabled /etc/nginx/sites-available /etc/nginx/conf.d
COPY ./deploy/nginx/. /etc/nginx

# Prepare supervisord
COPY ./deploy/supervisord/supervisord.conf /etc/supervisord.conf

# Prepare app
ENV DJANGO_SETTINGS_MODULE=zzzzz.settings
COPY ./deploy/run_app.sh /bin/run_app.sh
RUN chmod 777 /bin/run_app.sh
WORKDIR ${APP_REPOSITORY}/src/

# Prepare initial
COPY ./deploy/entrypoint.sh /bin/entrypoint.sh
RUN chmod 700 /bin/entrypoint.sh

# Prepare project
COPY . ${APP_REPOSITORY}/
WORKDIR ${APP_REPOSITORY}

# Prepare ports
EXPOSE 80
EXPOSE 443

# Prepare volumes
VOLUME ["/var/www/media"]

ENTRYPOINT ["/bin/entrypoint.sh"]
