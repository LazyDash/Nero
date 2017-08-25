#!/bin/bash

MAVEN_VERSION=apache-maven-3.5.0

wget "http://mirrors.m247.ro/apache/maven/maven-3/3.5.0/binaries/$MAVEN_VERSION-bin.tar.gz"
tar -xzf $MAVEN_VERSION-bin.tar.gz
mv $MAVEN_VERSION-bin /opt/maven

cp maven.sh /etc/profile.d/
source /etc/profile.d/
