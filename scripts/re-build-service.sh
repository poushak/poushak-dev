#! /bin/bash

echo 'Stopping' $1
docker-compose stop $1 && docker-compose rm -f $1

if [ $1 = 'swagger' ]; then
    echo 'Updating swagger'
    docker-compose build $1
fi

echo 'Restarting' $1
docker-compose up -d $1