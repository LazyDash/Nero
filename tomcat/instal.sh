#!/bin/bash

#Prerequisites:
#  - havedge

TOMCAT_VERSION=apache-tomcat-9.0.0.M26

wget "http://mirror.evowise.com/apache/tomcat/tomcat-9/v9.0.0.M26/bin/$TOMCAT_VERSION.tar.gz"
tar -xzf $TOMCAT_VERSION.tar.gz
mv $TOMCAT_VERSION /opt/tomcat
rm -rf $TOMCAT_VERSION.tar.gz
