#!/bin/bash

set -m

#echo "calling docker-compose up in ml_cassandra ..."
#exec docker-compose up 
docker rm spark-tf
docker rmi ml_spark:tf
docker build -t ml_spark:tf -f Dockerfile.py.tensorflow .
exec docker run --name spark-tf -it ml_spark:tf bash

