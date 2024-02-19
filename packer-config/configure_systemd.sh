#!/bin/bash

# Copy the service file to the appropriate directory
sudo cp webapp.service /etc/systemd/system/

# Reload systemd to apply the changes
sudo systemctl daemon-reload

# Enable the service to start automatically
sudo systemctl enable webapp.service
