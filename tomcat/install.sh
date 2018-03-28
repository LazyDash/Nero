#!/bin/bash

#Prerequisites:
#  - java (for running the tomcat container)
#  - havedge (for improving tomcat's startup time and entropy)

#vars
TOMCAT_URL=http://mirrors.dotsrc.org/apache/tomcat/tomcat-9/v9.0.6/bin/apache-tomcat-9.0.6.tar.gz

#main
wget "$TOMCAT_URL" -O tomcat.tar.gz
mkdir tomcat
tar -xzf tomcat.tar.gz -C tomcat  --strip-components=1
mv -fv tomcat /opt
rm -rf tomcat*
