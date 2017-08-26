#Prerequisites:
#  - mysql
#  - tomcat
#  - 'Development Tools'
#  - EPEL repo

#install ffmpeg ffmpeg-devel
rpm --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro
rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
yum install -y ffmpeg ffmpeg-devel

#required deps
yum install -y cairo-devel libjpeg-turbo-devel libjpeg-devel libpng-devel uuid-devel

#optional deps
yum install -y freerdp-devel pango-devel libssh2-devel libtelnet-devel libvncserver-devel pulseaudio-libs-devel openssl-devel libvorbis-devel libwebp-devel

wget "http://apache.org/dyn/closer.cgi?action=download&filename=incubator/guacamole/0.9.13-incubating/source/guacamole-server-0.9.13-incubating.tar.gz" -O guacamole-server-0.9.13-incubating.tar.gz
tar -xzf guacamole-server-0.9.13-incubating.tar.gz
cd guacamole-server-0.9.13-incubating
./configure
make
make install
guacd

cd ..
rm -rf guacamole-server-0.9.13-incubating

#this assumes a tomcat server installation located in /opt/tomcat
wget "http://apache.org/dyn/closer.cgi?action=download&filename=incubator/guacamole/0.9.13-incubating/binary/guacamole-0.9.13-incubating.war" -O guacamole-0.9.13-incubating.war
mv guacamole-0.9.13-incubating.war /opt/tomcat/webapps/guacamole.war

#GUACAMOLE_HOME
mkdir ~/.guacamole
mkdir ~/.guacamole/extensions
mkdir ~/.guacamole/lib

#databse
mysql -u root -p
CREATE DATABASE guacamole_db;
CREATE USER 'guacamole_user'@'localhost' IDENTIFIED BY 'powerGuacamole_2017';
GRANT SELECT,INSERT,UPDATE,DELETE ON guacamole_db.* TO 'guacamole_user'@'localhost';
FLUSH PRIVILEGES;
quit

wget "http://apache.org/dyn/closer.cgi?action=download&filename=incubator/guacamole/0.9.13-incubating/binary/guacamole-auth-jdbc-0.9.13-incubating.tar.gz" -O guacamole-auth-jdbc-0.9.13-incubating.tar.gz
tar -xzf guacamole-auth-jdbc-0.9.13-incubating.tar.gz
rm -rf guacamole-auth-jdbc-0.9.13-incubating.tar.gz
cp guacamole-auth-jdbc-0.9.13-incubating/mysql/guacamole-auth-jdbc-mysql-0.9.13-incubating.jar ~./.guacamole/extensions/

cd guacamole-auth-jdbc-0.9.13-incubating/mysql
cat schema/*.sql | mysql -u root -p guacamole_db
cd
rm -rf guacamole-auth-jdbc-0.9.13-incubating

wget "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.43.tar.gz"
tar -xzf mysql-connector-java-5.1.43.tar.gz
rm -rf mysql-connector-java-5.1.43.tar.gz
mv mysql-connector-java-5.1.43/mysql-connector-java-5.1.43-bin.jar ~./.guacamole/lib/
rm -rf mysql-connector-java-5.1.43

#copy guacamole.properties in .guacamole
cp ./guacamole.properties ~./.guacamole
