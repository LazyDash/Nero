How to use lazydash scripts to install openvpn and create client keys
1. open the vars file and update the configuration
vi ./vars

2. run the install script:
./install.sh

3. run the create client key script with the name of the client
./build-key.sh client-name
