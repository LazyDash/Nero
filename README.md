# Nero
CentOS scripts for working with various applications.

1. Update
yum update -y
yum clean all

2. Reboot
reboot

2. Install git.
yum install -y git

3. Generate ssh-key
ssh-keygen -t rsa
cat .ssh/id_rsa.pub

4. copy the key to github
https://github.com/settings/keys

5. clone the Nero project
mkdir Lazydash
cd Lazydash
git clone https://github.com/Lazydash/Nero.git

Enjoy
