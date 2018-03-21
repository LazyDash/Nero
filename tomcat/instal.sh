#!/bin/bash

#Prerequisites:
#  - havedge

TOMCAT_VERSION=apache-tomcat-9.0.6

wget "http://www-us.apache.org/dist/tomcat/tomcat-9/v9.0.6/bin/$TOMCAT_VERSION.tar.gz"
tar -xzf $TOMCAT_VERSION.tar.gz
mv $TOMCAT_VERSION /opt/tomcat
rm -rf $TOMCAT_VERSION.tar.gz
