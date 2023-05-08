#! /bin/bash

echo 'Stopping services'
docker-compose down

echo 'Restarting services'
docker-compose up -d