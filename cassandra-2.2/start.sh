#!/bin/bash

set -m

echo "calling docker-compose up in ml_cassandra ..."
sudo mkdir -p /dataCassandra
exec docker-compose up 
