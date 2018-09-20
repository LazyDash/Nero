# Nero
CentOS scripts for working with various applications.

## Setup
1. Update:  
yum update -y  
yum clean all

2. Reboot:  
reboot

3. Install git:  
yum install -y git

4. Generate new ssh-key:  
ssh-keygen -t rsa  
cat .ssh/id_rsa.pub

5. Copy the key to github:  
ssh://github.com/settings/keys

6. Clone the Nero project:  
mkdir Lazydash  
cd Lazydash  
git clone https://github.com/Lazydash/Nero.git

## Enjoy
Have fun with the scripts
