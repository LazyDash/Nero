#!/bin/bash

MAVEN_VERSION=apache-maven-3.5.0

wget "http://mirrors.m247.ro/apache/maven/maven-3/3.5.0/binaries/$MAVEN_VERSION-bin.tar.gz"
tar -xzf $MAVEN_VERSION-bin.tar.gz
mv $MAVEN_VERSION /opt/maven
rm -rf $MAVEN_VERSION-bin.tar.gz

cp maven.sh /etc/profile.d/maven.sh

echo "run: source /etc/profile.d/maven.sh to load mvn into the env"
