#!/bin/bash
MAVEN_URL=http://apache.javapipe.com/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz
wget $MAVEN_URL -O maven.tar.gz

mkdir maven
tar -xzf maven.tar.gz -C maven --strip-components=1

mv maven /opt/maven
rm -rf maven.tar.gz
cp maven.sh /etc/profile.d/maven.sh

echo "run: source /etc/profile.d/maven.sh to load mvn into the env"
