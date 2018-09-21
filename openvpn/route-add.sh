#!/bin/bash

if [ $# -ne 3 ]
  then
    echo "ERROR: Incorect number of arguments where supplied."
	echo ""
	echo "Usage: add-route <common name> <network ip> <network mask>"
	echo "    - common name: the common name of the ccd client."
  echo "    - network ip: the network ip of the ccd client."
  echo "    - network mask: the network mask of the network ip for the ccd client."
    exit 0
fi

common_name=$1
network_ip=$2
network_mask=$3

touch /etc/openvpn/ccd/$common_name
echo "iroute $network_ip $network_mask" > /etc/openvpn/ccd/$common_name

echo "route $network_ip $network_mask" >> /etc/openvpn/server.conf
echo "push \"route $network_ip $network_mask\"" >> /etc/openvpn/server.conf

systemctl restart openvpn@server.service
