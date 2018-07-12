#!/bin/bash
secrets=../secrets.env

function read_secrets()
{
    if [[ ! -f "$secrets" ]]; then
        echo "Please download from GoogleDrive/AlPastor/Documentation/secrets.env"
        exit 1
	  fi

    mysql_root_pw=$(cat "$secrets" | grep -i "mysql_root_password" | cut -d= -f2)
    mysql_username=$(cat "$secrets" | grep -i "mysql_username" | cut -d= -f2)
    mysql_user_pw=$(cat "$secrets" | grep -i "mysql_user_password" | cut -d= -f2)
    mysql_db=$(cat "$secrets" | grep -i "mysql_database" | cut -d= -f2)
}


#find */migrations -type f \( -iname "*.py" ! -iname "__init__.py" \) -exec rm -f {} \;

read_secrets

mysql -u${mysql_username} -p${mysql_user_pw} -e  "DROP DATABASE alpastor;"
mysql -u${mysql_username} -p${mysql_user_pw} -e  "CREATE DATABASE alpastor CHARACTER SET utf8;"

./manage.py makemigrations
./manage.py migrate
./manage.py createsu
./manage.py populatefakedb 
