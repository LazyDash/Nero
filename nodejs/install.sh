#!/bin/bash
#requires epel-release

#install nodejs and npm
yum install -y nodejs
yum install -y npm

#install packages
npm install -g bower
