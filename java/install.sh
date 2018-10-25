#!/bin/bash

#vars
JAVA_JDK_URL="http://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/jdk-8u191-linux-x64.rpm"

#main
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "$JAVA_JDK_URL" -O java_install.rpm
yum localinstall -y java_install.rpm
rm -rf java_install.rpm
