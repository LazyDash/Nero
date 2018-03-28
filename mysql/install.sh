#!/bin/bash

#vars
MYSQL_RPM_URL=https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm

#add mysql repo
wget "$MYSQL_RPM_URL" -O mysql.rpm
rpm -ivh mysql.rpm
rm -rf mysql.rpm

#install mysql
yum install -y mysql-server

#enable and start mysql
systemctl enable mysqld
systemctl start mysqld

#print temporary passowrd
grep 'temporary password' /var/log/mysqld.log

#configure mysql
mysql_secure_installation
