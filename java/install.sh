#!/bin/bash

#vars
JAVA_JDK_URL="http://download.oracle.com/otn-pub/java/jdk/8u162-b12/0da788060d494f5095bf8624735fa2f1/jdk-8u162-linux-i586.rpm"

#main
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "$JAVA_JDK_URL" -O java_install.rpm
yum localinstall -y java_install.rpm
rm -rf java_install.rpm
