#!/bin/bash

export MYSQL_DATABASE=alpastor
export MYSQL_USERNAME=alpastoradmin
export MYSQL_USER_PASSWORD=alpastorpass

rc=$(sudo mysql -e 'CREATE DATABASE IF NOT EXISTS alpastor;')
if [[ ${rc} != 0 ]]; then
    echo "Create database failed"
fi

rc=$(sudo mysql -e "CREATE USER 'alpastoradmin'@'localhost' IDENTIFIED BY 'alpastorpass';")
if [[ ${rc} != 0 ]]; then
    echo "Create user failed"
fi

rc=$(sudo mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'alpastoradmin'@'localhost';")
if [[ ${rc} != 0 ]]; then
    echo "Granting privileges failed"
fi

rc=$(sudo mysql -e "FLUSH PRIVILEGES;")
if [[ ${rc} != 0 ]]; then
    echo "Flushing privileges failed"
fi


# Migrations nonsense

find . -path "*/migrations/*.py" -not -name "__init__.py" -delete
find . -path "*/migrations/*.pyc"  -delete
find . -path "*/migrations/__pycache__"  -delete
