#!/bin/bash

#add mysql repo
wget https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
rpm -ivh mysql57-community-release-el7-9.noarch.rpm

#install mysql
yum install mysql-server

#enable and start mysql
systemctl enable mysqld
systemctl start mysqld

#print temporary passowrd
grep 'temporary password' /var/log/mysqld.log

#configure mysql
mysql_secure_installation
