wget "http://mirror.evowise.com/apache/tomcat/tomcat-9/v9.0.0.M26/bin/apache-tomcat-9.0.0.M26.tar.gz"
tar -xzf apache-tomcat-9.0.0.M26.tar.gz
mkdir /opt/servers
mv apache-tomcat-9.0.0.M26 /opt/servers/tomcat
rm -rf apache-tomcat-9.0.0.M26.tar.gz
