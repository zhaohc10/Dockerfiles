#!/bin/bash
while :
do
  echo "start spark streaming ...";
  #ping google.com& PID=$!
  #/autoshift-ml/scripts/anomalyDetection/run.sh & PID=$!;
  spark-submit --driver-memory 2G --master local[2] --conf "spark.executor.extraJavaOptions=-XX:+PrintGCDetails -XX:+PrintGCTimeStamps" --jars ../../lib/jars/spark-streaming-kafka-assembly_2.10-1.6.0.jar main.py --topic 'filtered-metrics-acme-air' > output.txt & PID=$!;
  sleep 5400;
  #kill -9 $(ps -ef | grep 'spark-streaming-kafka-assembly_2.10-1.6.0.jar main.py --topic filtered-metrics');
  kill $PID
  sleep 30;
done
