# How to use the openvpn scrips

## Basic
1. Edit the server.conf and client.conf from the conf folder.  
2. Run ./install-server.sh  
3. Add clients with ./add-client.sh <common_name>  

## Advanced
1. Revoke a clients certificate with ./revoke-client.sh <common_name>  
2. Add a route to be included in the vpn for a client's local network with ./add-route <common_name> <network_ip> <network_mask>  
3. Remove a previously added route with ./remove-route <common_name> <network_ip> <network_mask>  

## Details
1. By default the client to client communication is enabled. If this is not desired the configuration from server.conf should be changed.  
2. The add-client.sh will create a copy of all the files needed on the client machine in the ./clients/<common_name> folder.  


### Todo
1. Add script to toggle the client to client communication.  
2. Change naming and grouping of the scripts.  
3. Look into sed in order to toggle the settings by commenting the required line.  
