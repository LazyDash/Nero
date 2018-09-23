# How to use the openvpn scrips

## Basic
1. Edit the server.conf and client.conf from the conf folder.  
2. Run install.sh  
3. Add clients with client-add.sh <common_name>  

## Advanced
1. Revoke a clients certificate with client-revoke.sh <common_name>  
2. Add a route to be included in the vpn for a client's local network with route-add.sh <common_name> <network_ip> <network_mask>  
3. Remove a previously added route with route-remove.sh <common_name> <network_ip> <network_mask>  

## Details
1. By default the client to client communication is enabled. If this is not desired the configuration from server.conf should be changed.  
2. The client-add.sh will create a copy of all the files needed on the client machine in the ./clients/<common_name> folder.  
