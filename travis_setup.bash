#!/bin/bash

export MYSQL_DATABASE=alpastor
export MYSQL_USERNAME=alpastoradmin
export MYSQL_USER_PASSWORD=alpastorpass

mysql -u root -e 'CREATE DATABASE IF NOT EXISTS alpastor;'
mysql -u root -e "CREATE USER 'alpastoradmin'@'localhost' IDENTIFIED BY 'alpastorpass';"
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'alpastoradmin'@'localhost';"
mysql -u root -e "FLUSH PRIVILEGES;"

# Migrations nonsense

find . -path "*/migrations/*.py" -not -name "__init__.py" -delete
find . -path "*/migrations/*.pyc"  -delete
find . -path "*/migrations/__pycache__"  -delete
