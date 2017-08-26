#!/bin/bash

MYSQL_VERSION=mysql57-community-release-el7-9.noarch

#add mysql repo
wget https://dev.mysql.com/get/$MYSQL_VERSION.rpm
rpm -ivh $MYSQL_VERSION.rpm
rm -rf $MYSQL_VERSION.rpm

#install mysql
yum install -y mysql-server

#enable and start mysql
systemctl enable mysqld
systemctl start mysqld

#print temporary passowrd
grep 'temporary password' /var/log/mysqld.log

#configure mysql
mysql_secure_installation
