#Prerequisites:
#  - mysql
#  - tomcat
#  - 'Development Tools'
#  - EPEL repo

#vars
GUACAMOLE_VERSION=0.9.13-incubating

#main
install_dependencies
install_guacd
install_guacamole_war
create_guacamole_home_folder
create_guacamole_db_and_user
copy_guacamole_db_extensions_and_setup_guacamole_db
copy_guacamole_mysql_connector
copy_guacamole_properties


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
  wget "http://apache.org/dyn/closer.cgi?action=download&filename=incubator/guacamole/$GUACAMOLE_VERSION/source/guacamole-server-$GUACAMOLE_VERSION.tar.gz" -O guacamole-server-$GUACAMOLE_VERSION.tar.gz
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
  wget "http://apache.org/dyn/closer.cgi?action=download&filename=incubator/guacamole/$GUACAMOLE_VERSION/binary/guacamole-$GUACAMOLE_VERSION.war" -O guacamole-$GUACAMOLE_VERSION.war
  mv guacamole-$GUACAMOLE_VERSION.war /opt/tomcat/webapps/guacamole.war

}

function create_guacamole_home_folder {
  #GUACAMOLE_HOME
  mkdir ~/.guacamole
  mkdir ~/.guacamole/extensions
  mkdir ~/.guacamole/lib

}

function create_guacamole_db_and_user {
  echo "Connecting to mysql using root"
  mysql -u root -p < create_guacamole_db_user.sql

}

function copy_guacamole_db_extensions_and_setup_guacamole_db {
  wget "http://apache.org/dyn/closer.cgi?action=download&filename=incubator/guacamole/$GUACAMOLE_VERSION/binary/guacamole-auth-jdbc-$GUACAMOLE_VERSION.tar.gz" -O guacamole-auth-jdbc-$GUACAMOLE_VERSION.tar.gz
  tar -xzf guacamole-auth-jdbc-$GUACAMOLE_VERSION.tar.gz
  rm -rf guacamole-auth-jdbc-$GUACAMOLE_VERSION.tar.gz
  cp guacamole-auth-jdbc-$GUACAMOLE_VERSION/mysql/guacamole-auth-jdbc-mysql-$GUACAMOLE_VERSION.jar ~/.guacamole/extensions/

  cd guacamole-auth-jdbc-$GUACAMOLE_VERSION/mysql
  echo "Connecting to mysql using root"
  cat schema/*.sql | mysql -u root -p guacamole_db
  cd ../..
  rm -rf guacamole-auth-jdbc-$GUACAMOLE_VERSION

}

function copy_guacamole_mysql_connector {
  wget "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.43.tar.gz"
  tar -xzf mysql-connector-java-5.1.43.tar.gz
  rm -rf mysql-connector-java-5.1.43.tar.gz
  mv mysql-connector-java-5.1.43/mysql-connector-java-5.1.43-bin.jar ~/.guacamole/lib/
  rm -rf mysql-connector-java-5.1.43

}

function copy_guacamole_properties {
  #copy guacamole.properties in .guacamole
  cp guacamole.properties ~/.guacamole

}
