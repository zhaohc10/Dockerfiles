#!/usr/bin/env bash
#
# This script install Hadoop locally

wget http://apache.arvixe.com/hadoop/common/hadoop-2.6.4/hadoop-2.6.4.tar.gz
gunzip hadoop-2.6.4.tar.gz 
tar -xvf hadoop-2.6.4.tar 


# This script install Spark locally

wget http://apache.arvixe.com/spark/spark-1.6.0/spark-1.6.0-bin-hadoop2.6.tgz
gunzip spark-1.6.0-bin-hadoop2.6.tgz 
tar -xvf spark-1.6.0-bin-hadoop2.6.tar 