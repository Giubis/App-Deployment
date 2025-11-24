#!/bin/bash

# Version 3

# Redirect all output to log
exec > >(sudo tee /var/log/user-data.log) 2>&1

echo "/// Starting app deployment ///"

# Update system
echo "///Updating packages ///"
sudo apt update -y && sudo apt upgrade -y

# Install dependencies
echo "/// Installing git, curl, NGINX ///"
sudo apt install git curl nginx -y

# Configure Nginx as reverse proxy
echo "/// Configuring Nginx ///"
sudo sed -i 's|try_files \$uri \$uri/ =404;|proxy_pass http://localhost:3000/;|g' /etc/nginx/sites-available/default

# Enable and restart Nginx
echo "/// Restarting NGINX ///"
sudo systemctl enable nginx
sudo systemctl restart nginx

# Install Node.js
echo "/// Installing Node.js ///"
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# Clone or update the app repo
echo "/// Cloning or updating app repo ///"

if [ ! -d "nodejs20-se-test-app-2025" ]; then
  git clone https://github.com/Giubis/nodejs20-se-test-app-2025.git
else
  cd nodejs20-se-test-app-2025 && git pull
fi

cd nodejs20-se-test-app-2025/app

# Install Node dependencies
echo "/// Installing Node dependencies ///"
npm install

# Install PM2
echo "/// Installing PM2 ///"
sudo npm install -g pm2@latest

# Stop any previous PM2 processes
echo "/// Stopping any previous PM2 processes ///"
pm2 kill

# Delay to ensure system is ready
echo "/// Waiting ten seconds ///"
sleep 10

# Start the app with PM2
echo "/// Starting app with PM2 ///"
sudo -pm2 start app.js --watch

echo "/// Deployment complete! ///"