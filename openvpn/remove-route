#!/bin/bash

if [ $# -ne 3 ]
  then
    echo "ERROR: Incorect number of arguments where supplied."
	echo ""
	echo "Usage: remove-route <common name> <network ip> <network mask>"
	echo "    - common name: the common name of the ccd client"
  echo "    - network ip: the network ip of the ccd client."
  echo "    - network mask: the network mask of the network ip for the ccd client."
    exit 0
fi

common_name=$1
network_ip=$2
network_mask=$3

#remove the common name file from the ccd folder
rm -rf /etc/openvpn/ccd/$1

#remove the lines in server.conf in order to make the route unavailable
sed -i "/route $network_ip $network_mask/d" /etc/openvpn/server.conf
sed -i "/push \"route $network_ip $network_mask\"/d" /etc/openvpn/server.conf

systemctl restart openvpn@server.service
