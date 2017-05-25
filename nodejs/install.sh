#!/bin/bash
curl --silent --location https://rpm.nodesource.com/setup_6.x | bash -
yum -y install nodejs

#install node apps
npm install -g bower
