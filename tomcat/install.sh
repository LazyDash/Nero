#!/bin/bash

#Prerequisites:
#  - java (for running the tomcat container)
#  - havedge (for improving tomcat's startup time and entropy)

#vars
TOMCAT_URL=http://mirrors.m247.ro/apache/tomcat/tomcat-9/v9.0.12/bin/apache-tomcat-9.0.12.tar.gz

#main
wget "$TOMCAT_URL" -O tomcat.tar.gz
mkdir tomcat
tar -xzf tomcat.tar.gz -C tomcat  --strip-components=1
mv -fv tomcat /opt
rm -rf tomcat*
