#!/bin/bash

echo "Start"

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    echo "End"
    exit 0
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
client=$1

cd /etc/openvpn/easy-rsa/
source ./vars
./build-key $1

cd ./keys/
mkdir $DIR/$1
cp $1.crt $1.key ca.crt $DIR/$1/

cd $DIR
cp ./client.ovpn ./$1/client.ovpn
echo ca ca.crt$'\r' >> ./$1/client.ovpn
echo cert $1.crt$'\r' >> ./$1/client.ovpn
echo key $1.key$'\r' >> ./$1/client.ovpn

#restart openvpn
systemctl restart openvpn@server.service

echo "End"
