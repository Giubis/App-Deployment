#!/bin/bash

# Version 4

echo "/// Starting app deployment ///"

# Delay to ensure system is ready
echo "/// Waiting fifteen seconds ///"
sleep 15

# Enter the user directory
cd/home/ubuntu

# Enter the app directory
cd nodejs20-se-test-app-2025/app

# Stop any previous PM2 processes
echo "/// Stopping any previous PM2 processes ///"
pm2 kill

# Install Node dependencies
echo "/// Installing Node dependencies ///"
npm install

# Start the app with PM2
echo "/// Starting app with PM2 ///"
pm2 start app.js --watch

echo "/// Deployment complete! ///"