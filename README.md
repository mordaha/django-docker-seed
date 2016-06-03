This is experemental template sceleton for future django-docker-seed project

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
- make nginx logs mapped on host or something
- working with volumes - reconsider



Development
------------
1. ./dc.sh up
2. point your browser to http://192.168.99.100:8000/ => ./manage.py runserver 8000
3. point your browser to http://192.168.99.100:8080/ => nginx with static files
4. In another terminal do ./dc.sh test or ./dc.sh shell -> cd src -> ./runtests.sh


Production
------------

*Not ready yet!*

1. Use docker-compose instead of dc.sh, Luke! :)
2. Point your main balancer to 8080 port of container

License
-----------
MIT

Inspired by
------------
https://github.com/nikitinsm/seed-django
