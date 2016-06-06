This is experemental template skeleton for future django-docker-seed project

&#x1F534; FOR MAC USERS: THIS SETUP WORKS ON DOCKER-BETA ONLY! (Docker version >1.11.1)


It uses:
---------
- python 3
- django 1.9.x
- redis for cache/sessions
- postgresql for database
- nginx for production webserver
- ./dc.sh for development docker-compose shortcut
- app container uses sshd for PyCharm's remote project interpretier


Todo
------------
- make nginx logs mapped on host or something?
- make production configs


Development
------------
1. ./dc.sh up
2. point your browser to http://127.0.0.1:8000/ => ./manage.py runserver 8000
3. point your browser to http://127.0.0.1:8080/ => nginx with static files
4. In another terminal do ./dc.sh test or ./dc.sh shell -> cd src -> ./runtests.sh
5. If you whant - point your postgresql app to 127.0.0.1:8032

Production
------------

*Not ready yet!*

1. Use docker-compose instead of dc.sh, Luke! :)
2. Point your main balancer to 8080 port

License
-----------
MIT

Inspired by
------------
https://github.com/nikitinsm/seed-django
