## DJANGO SITE DEV/PRODUCTION SETUP IN DOCKER CONTAINERS WITH NGINX LOGS IN ELK-STACK

This is my docker-composed setup for develop/deploy django-based sites

## It uses:

- python 3.6.x
- django 2.x
- redis for django cache/sessions
- postgresql for django database (dockerized for development, host-based for production)
- nginx as production webserver, with send_file && secure_link for serve uploaded files
- elasticsearch + logstash + kibana (ELK) for logging
- ./dc.sh for "docker-compose with development config" shortcut
- development django container uses sshd for PyCharm's remote project interpretier

## Development

1. Run `$ ./dc.sh`
2. Wait until all containers start, then run `./es_index.sh_`
3. point your browser to http://127.0.0.1:8000/ => ./manage.py runserver 8000
4. point your browser to http://127.0.0.1:8080/ => nginx with static files, first log entry will be created
5. point your browser to http://127.0.0.1:8056/ => kibana, choose logstash-* index, and @timestamp field.
6. In another terminal do: `./dc.sh test` or `./dc.sh shell` -> `./runtests.sh`
7. If you want - point your postgresql app to 127.0.0.1:8032

## Production (this all must be ansibled)

### Setup

You must run your own docker hub for this scenario.

1. Add docker image names to `docker-compose.images.yml`
2. Change settings for django's `SECRET_KEY` and make sure it equals with secure_link settings (L:72 in nginx.conf)_

### First run

#### local
1. Run on the dev-computer `./dc.sh build && ./dc.sh push` to push images in your hub
2. Copy all `docker-compose*` and `*.sh` files to the server

#### remote (on the server)
3. Prepare production postgresql server on local interface (but not 127.0)
4. Edit database environment variables in `run-in-production.sh`
3. Run `run-in-production.sh`
4. Prepare dir for uploads `mkdir public/media/files && chown www-data public/media/files`
5. Run `./es_index.sh`
6. Point your main balancer to `127.0.0.1:8080` (dockerized nginx port, docker-compose.yml L:62)

### Release cycle (no CD)
1. Locally (or on CI): `./dc.sh build && ./dc.sh push`
2. Remote (on the server): run `./run-in-production.sh`


## License

MIT

## TODO

- Make all configs as templates (to place SECRET_KEY for example)
- Add ansible deployment setup for this
- Make deployment continuos (without stop the service)
