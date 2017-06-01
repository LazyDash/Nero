 #!/bin/bash

#setup repo
yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum makecache fast

#get docker
yum install -y docker-ce
systemctl start docker

#enable docker
systemctl enable docker

#test
docker run hello-world
