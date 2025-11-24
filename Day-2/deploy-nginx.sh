#!/bin/bash

# Update packages
sudo apt update -y

# Upgrade packages
sudo apt upgrade -y

# Install NGINX
sudo apt install nginx -y

# Restart NGINX
sudo systemctl restart nginx

# Enable NGINX
sudo systemctl enable nginx