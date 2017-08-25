#!/bin/bash
wget "http://mirrors.m247.ro/apache/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz"
tar -xzf apache-maven-3.5.0-bin.tar.gz
mv apache-maven-3.5.0-bin.tar.gz /opt/maven

cp maven.sh /etc/profile.d/
source /etc/profile.d/
