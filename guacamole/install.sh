#Prerequisites:
#  - mysql
#  - tomcat
#  - 'Development Tools'
#  - EPEL repo
#  - rpm fusion

#vars
#default
GUACAMOLE_DB_USER_PASSWORD=`date +%s | sha256sum | base64 | head -c 20`_`shuf -i 1000-9999 -n 1`
MYSQL_ROOT_PASSWORD=password

#user
MYSQL_JCONNECTOR_URL="https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.46.tar.gz"
GUACAMOLE_SERVER_URL="http://apache.org/dyn/closer.cgi?action=download&filename=guacamole/0.9.14/source/guacamole-server-0.9.14.tar.gz"
GUACAMOLE_CLIENT_URL="http://apache.org/dyn/closer.cgi?action=download&filename=guacamole/0.9.14/binary/guacamole-0.9.14.war"
GUACAMOLE_AUTH_JDBC_URL="http://apache.org/dyn/closer.cgi?action=download&filename=guacamole/0.9.14/binary/guacamole-auth-jdbc-0.9.14.tar.gz"

function get_user_input {
  read -s -p "Enter MYSQL root password" MYSQL_ROOT_PASSWORD

}

function install_dependencies {
  #install ffmpeg ffmpeg-devel
  yum install -y ffmpeg ffmpeg-devel

  #required deps
  yum install -y cairo-devel libjpeg-turbo-devel libjpeg-devel libpng-devel uuid-devel

  #optional deps
  yum install -y freerdp-devel pango-devel libssh2-devel libtelnet-devel libvncserver-devel pulseaudio-libs-devel openssl-devel libvorbis-devel libwebp-devel

}

function install_guacd {
  echo "$GUACAMOLE_SERVER_URL"
  wget "$GUACAMOLE_SERVER_URL" -O guacamole-server.tar.gz
  mkdir guacamole-server
  tar -xzf guacamole-server.tar.gz -C guacamole-server --strip-components=1
  cd guacamole-server
  ./configure
  make
  make install
  guacd

  #cleanup
  cd ..
  rm -rf guacamole-server*

}

function install_guacamole_war {
  #this assumes a tomcat server installation located in /opt/tomcat
  wget "$GUACAMOLE_CLIENT_URL" -O guacamole.war
  mv guacamole.war /opt/tomcat/webapps/guacamole.war

}

function create_guacamole_home_folder {
  #GUACAMOLE_HOME
  mkdir ~/.guacamole
  mkdir ~/.guacamole/extensions
  mkdir ~/.guacamole/lib
}

function create_guacamole_db_and_user {
  touch create_guacamole_db_user.sql
  echo "DROP DATABASE guacamole_db;" > create_guacamole_db_user.sql
  echo "CREATE DATABASE guacamole_db;" > create_guacamole_db_user.sql
  echo "DROP USER 'guacamole_user'@'localhost';" >> create_guacamole_db_user.sql
  echo "CREATE USER 'guacamole_user'@'localhost' IDENTIFIED BY '$GUACAMOLE_DB_USER_PASSWORD';" >> create_guacamole_db_user.sql
  echo "GRANT SELECT,INSERT,UPDATE,DELETE ON guacamole_db.* TO 'guacamole_user'@'localhost';" >> create_guacamole_db_user.sql
  echo "FLUSH PRIVILEGES;" >> create_guacamole_db_user.sql
  mysql -u root -p$MYSQL_ROOT_PASSWORD < create_guacamole_db_user.sql
  rm -rf create_guacamole_db_user.sql
}

function download_guacamole_db_extensions_and_setup_guacamole_db {
  wget "$GUACAMOLE_AUTH_JDBC_URL" -O guacamole-auth-jdbc.tar.gz
  mkdir guacamole-auth-jdbc
  tar -xzf guacamole-auth-jdbc.tar.gz -C guacamole-auth-jdbc --strip-components=1
  cp guacamole-auth-jdbc/mysql/guacamole-auth-jdbc-mysql-*.jar ~/.guacamole/extensions/

  cd guacamole-auth-jdbc/mysql
  echo "Connecting to mysql using root"
  cat schema/*.sql | mysql -u root -p$MYSQL_ROOT_PASSWORD guacamole_db
  cd ../..
  rm -rf guacamole-auth-jdbc*
}

function download_guacamole_mysql_connector {
  wget "$MYSQL_JCONNECTOR_URL" -O mysql-connector-java.tar.gz
  mkdir mysql-connector-java
  tar -xzf mysql-connector-java.tar.gz -C mysql-connector-java --strip-components=1
  mv mysql-connector-java/mysql-connector-java-*-bin.jar ~/.guacamole/lib/
  rm -rf mysql-connector-java*
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
