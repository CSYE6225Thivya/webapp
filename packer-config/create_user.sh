#!/bin/bash
sudo groupadd csye6225
sudo useradd -r -s /usr/sbin/nologin -g csye6225 csye6225
sudo mkdir -p /opt/my-app
sudo cp -r /tmp/* /opt/my-app
sudo chown -R csye6225:csye6225 /opt/my-app


cd /opt/my-app/webapp 
sudo npm install



