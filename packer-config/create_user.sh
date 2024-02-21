#!/bin/bash
cd /opt || exit
sudo unzip webapp.zip -d webapp
sudo groupadd csye6225
sudo useradd -s /usr/sbin/nologin -g csye6225 -d /opt/webapp csye6225
cd /opt/webapp/ || exit
sudo npm install

sudo chown -R csye6225:csye6225 /opt/webapp
sudo chmod -R 750 /opt/webapp



 
 




