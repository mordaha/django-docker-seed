FROM python:3

# Prepare os libs
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y \
    python-dev python-setuptools python-pip
RUN apt-get autoremove -y

# upgrade pip
RUN pip install --upgrade pip

# Prepare app specific modules
COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt
RUN rm /tmp/requirements.txt

# Prepare initial
COPY deploy/django/entrypoint.sh /bin/entrypoint.sh
RUN chmod 700 /bin/entrypoint.sh

# Static and media dir to expose out container onto nginx-service
RUN mkdir -p /static /media
ENV DJANGO_STATIC_ROOT="/static"
ENV DJANGO_MEDIA_ROOT="/media"

# Prepare user
RUN useradd -u 33 www-data | true
RUN chown -R www-data /media

# Prepare code
COPY src /code
ENV PYTHONPATH="${PYTHONPATH}:/code"
WORKDIR /code

# Prepare ports
# django
EXPOSE 8000

ENTRYPOINT ["/bin/entrypoint.sh"]
