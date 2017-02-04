&#x1F534; UNDER CONSTRUCTION! :)

This is experemental template skeleton for future django-docker-seed

&#x1F534; FOR MAC USERS: THIS SETUP WORKS ONLY WITH DOCKER-BETA! (Docker version >1.11.1)


It uses:
---------
- python 3.6.x
- django 1.10.x
- redis for django cache/sessions
- postgresql for django database
- nginx as production webserver
- elasticsearch + logstash + kibana (ELK) for logging
- ./dc.sh for "docker-compose with development config" shortcut
- app container uses sshd for PyCharm's remote project interpretier


Todo
------------
- make production configs


Development
------------
1. Run `$ ./dc.sh`
2. point your browser to http://127.0.0.1:8000/ => ./manage.py runserver 8000
3. point your browser to http://127.0.0.1:8080/ => nginx with static files
4. point your browser to http://127.0.0.1:8056/ => kibana
5. In another terminal do: `./dc.sh test` or `./dc.sh shell` -> `cd src` -> `./runtests.sh`
6. If you want - point your postgresql app to 127.0.0.1:8032

Production
------------

*Not ready yet!*

1. Use `docker-compose build/start` instead of `./dc.sh`, Luke! :)
2. Point your main balancer to 8080 port

License
-----------
MIT

Inspired by
------------
https://github.com/nikitinsm/seed-django
