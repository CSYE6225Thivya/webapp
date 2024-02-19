#!/bin/bash

sudo rpm -ivh mysql57-community-release-el7-7.noarch.rpm
sudo yum install -y mysql-server
sudo systemctl start mysqld
sudo systemctl enable mysqld
sudo mysql -u root -p'' -e "CREATE DATABASE api_db;"
sudo mysql -u root -p'' -e "CREATE USER 'user'@'localhost' IDENTIFIED BY 'Blueblack@12345';"
sudo mysql -u root -p'' -e "GRANT ALL PRIVILEGES ON api_db.* TO 'user'@'localhost';"


sudo dnf module list nodejs
sudo dnf module enable -y nodejs:20
sudo dnf install -y npm


sudo groupadd csye6225
sudo useradd -r -s /usr/sbin/nologin -g csye6225 csye6225
sudo mkdir -p /opt/my-app
sudo cp -r /tmp/* /opt/my-app
sudo chown -R csye6225:csye6225 /opt/my-app


cd /opt/my-app/webapp 
sudo npm install