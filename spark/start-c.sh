#!/bin/bash

set -m

#echo "calling docker-compose up in ml_cassandra ..."
#exec docker-compose up 
docker rm spark
docker rmi ml_spark:1.6.0
docker build -t ml_spark:1.6.0 .

exec docker run --name spark -it --link devops_kafka --link ml_cassandra ml_spark:1.6.0 /spark-shell-kafka-cassandra.sh

