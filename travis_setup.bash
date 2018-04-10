#!/bin/bash

export MYSQL_DATABASE=alpastor
export MYSQL_USERNAME=alpastoradmin
export MYSQL_USER_PASSWORD=alpastorpass

sudo mysql -e 'CREATE DATABASE IF NOT EXISTS alpastor;'
sudo mysql -e "CREATE USER 'alpastoradmin'@'localhost' IDENTIFIED BY 'alpastorpass';"
sudo mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'alpastoradmin'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Migrations nonsense

find . -path "*/migrations/*.py" -not -name "__init__.py" -delete
find . -path "*/migrations/*.pyc"  -delete
find . -path "*/migrations/__pycache__"  -delete
