#!/usr/bin/env bash

sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer

sudo apt-get remove scala-library scala
sudo wget www.scala-lang.org/files/archive/scala-2.10.4.deb
sudo dpkg -i scala-2.10.4.deb
sudo apt-get update
sudo apt-get install scala
wget http://scalasbt.artifactoryonline.com/scalasbt/sbt-native-packages/org/scala-sbt/sbt/0.12.4/sbt.deb
sudo dpkg -i sbt.deb
sudo apt-get update
sudo apt-get install sbt