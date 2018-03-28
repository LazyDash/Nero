#!/bin/bash

#vars
JAVA_JDK_URL=http://download.oracle.com/otn-pub/java/jdk/10+46/76eac37278c24557a3c4199677f19b62/jdk-10_linux-x64_bin.rpm

#main
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "$JAVA_JDK_URL" -O java_install.rpm
yum localinstall -y java_install.rpm
rm -rf java_install.rpm
