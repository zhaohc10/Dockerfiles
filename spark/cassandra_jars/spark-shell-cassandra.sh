#!/bin/bash

cd /usr/local/spark

spark-shell --jars "lib/cassandra-driver-core-2.2.0-rc3.jar,lib/spark-cassandra-connector_2.10-1.5.0-M2.jar,lib/joda-convert-1.8.1.jar,lib/joda-time-2.3.jar,lib/jsr166e-1.1.0.jar,lib/guava-16.0.1.jar" --conf spark.cassandra.connection.host=ml_cassandra

