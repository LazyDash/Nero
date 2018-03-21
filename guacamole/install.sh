#Prerequisites:
#  - mysql
#  - tomcat
#  - 'Development Tools'
#  - EPEL repo

#vars
#default
GUACAMOLE_VERSION=0.9.14
MYSQL_JCONNECTOR=5.1.43
GUACAMOLE_DB_USER_PASSWORD=`date +%s | sha256sum | base64 | head -c 20`

#user
MYSQL_ROOT_PASSWORD=password

function get_user_input {
  read -s -p "Enter MYSQL root password" MYSQL_ROOT_PASSWORD

}

function install_dependencies {
  #install ffmpeg ffmpeg-devel
  rpm --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro
  rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
  yum install -y ffmpeg ffmpeg-devel

  #required deps
  yum install -y cairo-devel libjpeg-turbo-devel libjpeg-devel libpng-devel uuid-devel

  #optional deps
  yum install -y freerdp-devel pango-devel libssh2-devel libtelnet-devel libvncserver-devel pulseaudio-libs-devel openssl-devel libvorbis-devel libwebp-devel

}

function install_guacd {
  wget "http://apache.org/dyn/closer.cgi?action=download&filename=guacamole/$GUACAMOLE_VERSION/source/guacamole-server-$GUACAMOLE_VERSION.tar.gz" -O guacamole-server-$GUACAMOLE_VERSION.tar.gz
  tar -xzf guacamole-server-$GUACAMOLE_VERSION.tar.gz
  rm -rf guacamole-server-$GUACAMOLE_VERSION.tar.gz
  cd guacamole-server-$GUACAMOLE_VERSION
  ./configure
  make
  make install
  guacd

  #cleanup
  cd ..
  rm -rf guacamole-server-$GUACAMOLE_VERSION

}

function install_guacamole_war {
  #this assumes a tomcat server installation located in /opt/tomcat
  wget "http://apache.org/dyn/closer.cgi?action=download&filename=guacamole/$GUACAMOLE_VERSION/binary/guacamole-$GUACAMOLE_VERSION.war" -O guacamole-$GUACAMOLE_VERSION.war
  mv guacamole-$GUACAMOLE_VERSION.war /opt/tomcat/webapps/guacamole.war

}

function create_guacamole_home_folder {
  #GUACAMOLE_HOME
  mkdir ~/.guacamole
  mkdir ~/.guacamole/extensions
  mkdir ~/.guacamole/lib

}

function create_guacamole_db_and_user {
  touch create_guacamole_db_user.sql
  echo "CREATE DATABASE guacamole_db;" > create_guacamole_db_user.sql
  echo "CREATE USER 'guacamole_user'@'localhost' IDENTIFIED BY '$GUACAMOLE_DB_USER_PASSWORD';" >> create_guacamole_db_user.sql
  echo "GRANT SELECT,INSERT,UPDATE,DELETE ON guacamole_db.* TO 'guacamole_user'@'localhost';" >> create_guacamole_db_user.sql
  echo "FLUSH PRIVILEGES;" >> create_guacamole_db_user.sql
  mysql -u root -p$MYSQL_ROOT_PASSWORD < create_guacamole_db_user.sql
  rm -rf create_guacamole_db_user.sql

}

function download_guacamole_db_extensions_and_setup_guacamole_db {
  wget "http://apache.org/dyn/closer.cgi?action=download&filename=guacamole/$GUACAMOLE_VERSION/binary/guacamole-auth-jdbc-$GUACAMOLE_VERSION.tar.gz" -O guacamole-auth-jdbc-$GUACAMOLE_VERSION.tar.gz
  tar -xzf guacamole-auth-jdbc-$GUACAMOLE_VERSION.tar.gz
  rm -rf guacamole-auth-jdbc-$GUACAMOLE_VERSION.tar.gz
  cp guacamole-auth-jdbc-$GUACAMOLE_VERSION/mysql/guacamole-auth-jdbc-mysql-$GUACAMOLE_VERSION.jar ~/.guacamole/extensions/

  cd guacamole-auth-jdbc-$GUACAMOLE_VERSION/mysql
  echo "Connecting to mysql using root"
  cat schema/*.sql | mysql -u root -p$MYSQL_ROOT_PASSWORD guacamole_db
  cd ../..
  rm -rf guacamole-auth-jdbc-$GUACAMOLE_VERSION

}

function download_guacamole_mysql_connector {
  wget "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-MYSQL_JCONNECTOR.tar.gz"
  tar -xzf mysql-connector-java-MYSQL_JCONNECTOR.tar.gz
  rm -rf mysql-connector-java-MYSQL_JCONNECTOR.tar.gz
  mv mysql-connector-java-MYSQL_JCONNECTOR/mysql-connector-java-MYSQL_JCONNECTOR-bin.jar ~/.guacamole/lib/
  rm -rf mysql-connector-java-MYSQL_JCONNECTOR

}

function setup_guacamole_properties {
  touch guacamole.properties

  echo "# Hostname and port of guacamole proxy
guacd-hostname: localhost
guacd-port:     4822

# MySQL properties
mysql-hostname: localhost
mysql-port: 3306
mysql-database: guacamole_db
mysql-username: guacamole_user
mysql-password: $GUACAMOLE_DB_USER_PASSWORD" > guacamole.properties

  mv guacamole.properties ~/.guacamole

}

#main
get_user_input
install_dependencies
install_guacd
install_guacamole_war
create_guacamole_home_folder
create_guacamole_db_and_user
download_guacamole_db_extensions_and_setup_guacamole_db
download_guacamole_mysql_connector
setup_guacamole_properties
