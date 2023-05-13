#! /bin/sh

echo 'Stopping swagger'
docker-compose stop swagger && docker-compose rm -f swagger

echo 'Updating swagger'
docker-compose build swagger

echo 'Restarting swagger'
docker-compose up -d swagger