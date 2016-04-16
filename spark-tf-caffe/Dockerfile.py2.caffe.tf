FROM kaixhin/caffe

MAINTAINER Huichao Zhao

##############################
# Install basic dependencies
##############################
# Update the base ubuntu image with dependencies needed for Spark
RUN sudo apt-get update
RUN apt-get install -y wget unzip vim

##############################
#   Spark dependencies
##############################
ENV APACHE_SPARK_VERSION 1.6.0
RUN apt-get -y update && \
    apt-get install -y --no-install-recommends openjdk-7-jre-headless && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN cd /tmp && \
        wget -q http://d3kbcqa49mib13.cloudfront.net/spark-${APACHE_SPARK_VERSION}-bin-hadoop2.6.tgz && \
        echo "439fe7793e0725492d3d36448adcd1db38f438dd1392bffd556b58bb9a3a2601 *spark-${APACHE_SPARK_VERSION}-bin-hadoop2.6.tgz" | sha256sum -c - && \
        tar xzf spark-${APACHE_SPARK_VERSION}-bin-hadoop2.6.tgz -C /usr/local && \
        rm spark-${APACHE_SPARK_VERSION}-bin-hadoop2.6.tgz && \
        rm /usr/local/spark-${APACHE_SPARK_VERSION}-bin-hadoop2.6/lib/spark-examples-*.jar
RUN cd /usr/local && ln -s spark-${APACHE_SPARK_VERSION}-bin-hadoop2.6 spark

##############################
# Mesos dependencies
##############################
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
    DISTRO=debian && \
    CODENAME=wheezy && \
    echo "deb http://repos.mesosphere.io/${DISTRO} ${CODENAME} main" > /etc/apt/sources.list.d/mesosphere.list && \
    apt-get -y update && \
    apt-get --no-install-recommends -y --force-yes install mesos=0.22.1-1.0.debian78 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Spark and Mesos config
ENV SPARK_HOME /usr/local/spark
ENV PYSPARK_PYTHON python
ENV PYTHONPATH $SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.9-src.zip
ENV PYTHONPATH=/root/caffe/python:$PYTHONPATH
ENV MESOS_NATIVE_LIBRARY /usr/local/lib/libmesos.so
ENV SPARK_OPTS --driver-java-options=-Xms1024M --driver-java-options=-Xmx4096M --driver-java-options=-Dlog4j.logLevel=info
ENV PATH $PATH:/usr/local/spark/bin

##############################
# TensorFlow
##############################
RUN sudo pip install --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.7.1-cp27-none-linux_x86_64.whl

# TensorFlow Ubuntu/Linux 64-bit, GPU enabled:
# RUN pip install --upgrade https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow-0.7.1-cp27-none-linux_x86_64.whl

##############################
# Python Data Science Libraries
##############################
RUN apt-get update
RUN apt-get install -y python-scipy python-matplotlib python-pandas
RUN pip install scikit-learn

##############################
# Autoshift related
##############################
# Install pykafka
RUN wget https://github.com/Parsely/pykafka/archive/master.zip
RUN unzip master.zip
RUN cd pykafka-master; python setup.py install

# autoshift dependenices Script
#ADD code/*.py /
#ADD scripts/*.sh /
#RUN sudo chmod +x /*.py && sudo chmod +x /pyspark-submit.sh

# Empty kakfa msg data dir, so that our init script can start from a clean slate
RUN rm -rf /var/data/pysparkoutput/*

# Define mountable directories.
VOLUME ["/var/data/kafka/pysparkoutput"]
##############################
CMD ["/pyspark-submit.sh"]


