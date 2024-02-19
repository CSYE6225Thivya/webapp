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
