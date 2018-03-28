# Nero
CentOS scripts for working with various applications.

## Update
yum update -y
yum clean all

## Reboot
reboot

## Install git
yum install -y git

## Generate ssh-key
ssh-keygen -t rsa
cat .ssh/id_rsa.pub

## Copy the key to github
https://github.com/settings/keys

## Clone the Nero project
mkdir Lazydash
cd Lazydash
git clone https://github.com/Lazydash/Nero.git

## Enjoy
