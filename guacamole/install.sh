#!/bin/bash
#create guacd
docker run --name some-guacd -d guacamole/guacd

#create mysql
docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=powerMysql_2017 -e MYSQL_DATABASE=guacamole_db -e MYSQL_USER=guacamole_user -e MYSQL_PASSWORD=guacamole_pass -d mysql/mysql-server:latest

#get mysql scripts and run them
docker run --rm guacamole/guacamole /opt/guacamole/bin/initdb.sh --mysql > initdb.sql
docker exec -i some-mysql mysql -u guacamole_user -pguacamole_pass guacamole_db <./initdb.sql

#create guacamole
docker run --name some-guacamole --link some-guacd:guacd --link some-mysql:mysql -e MYSQL_DATABASE=guacamole_db -e MYSQL_USER=guacamole_user -e MYSQL_PASSWORD=guacamole_pass -d -p 127.0.0.1:8083:8080 guacamole/guacamole
