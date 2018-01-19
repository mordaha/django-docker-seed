#!/bin/sh

#ifconfig lo0 alias 172.17.17.17 <-- for mac os 

# on linuxes for example ubuntu make lo alias in /etc/network/interfaces
#lo:1      Link encap:Local Loopback
#          inet addr:172.17.17.17  Mask:255.255.255.240
#          UP LOOPBACK RUNNING  MTU:65536  Metric:1
#
# bind your postgresql to 172.17.17.17

export DJANGO_DATABASE_HOST=172.17.17.17
export DJANGO_DATABASE_NAME=zzzzz
export DJANGO_DATABASE_USER=zzzzz
export DJANGO_DATABASE_PASSWORD=12345

DC="docker-compose -f docker-compose.yml -f docker-compose.images.yml -f docker-compose.production.yml"

${DC} down
${DC} pull
${DC} up -d

