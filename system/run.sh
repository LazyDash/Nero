#!/bin/bash

#run otho
cd /root/Lazydash/Otho/target
nohup java -jar otho-1.0-SNAPSHOT.jar &

#run augustus
cd /root/Lazydash/Augustus
nohup node main.js &
