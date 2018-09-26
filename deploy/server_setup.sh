#!/usr/bin/env bash

set -e

PROJECT_GIT_URL='https://github.com/abhisheksoam/project_api.git'

PROJECT_BASE_PATH='/usr/local/apps'
VIRTUALENV_BASE_PATH='/usr/local/virtualenvs'

# Set Ubuntu Language
locale-gen en_GB.UTF-8

# Install Python, SQLite and pip
echo "Installing dependencies..."
apt-get update
apt-get install -y python3-dev python3-venv sqlite python-pip supervisor nginx git

mkdir -p $PROJECT_BASE_PATH
git clone $PROJECT_GIT_URL $PROJECT_BASE_PATH/api

mkdir -p $VIRTUALENV_BASE_PATH
python3 -m venv $VIRTUALENV_BASE_PATH/api_env

$VIRTUALENV_BASE_PATH/api_env/bin/pip install -r $PROJECT_BASE_PATH/api/req.txt

# Run migrations
cd $PROJECT_BASE_PATH/api/src

# Setup Supervisor to run our uwsgi process.
cp $PROJECT_BASE_PATH/api/deploy/supervisor_api.conf /etc/supervisor/conf.d/api.conf
supervisorctl reread
supervisorctl update
supervisorctl restart api

# Setup nginx to make our application accessible.
cp $PROJECT_BASE_PATH/api/deploy/api_nginx.conf /etc/nginx/sites-available/api_nginx.conf
rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/api_nginx.conf /etc/nginx/sites-enabled/api_nginx.conf
systemctl restart nginx.service

echo "DONE! :)"