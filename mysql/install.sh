#!/bin/bash

wget https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
rpm -ivh mysql57-community-release-el7-9.noarch.rpm
yum install mysql-server
systemctl start mysqld
grep 'temporary password' /var/log/mysqld.log
mysql_secure_installation

