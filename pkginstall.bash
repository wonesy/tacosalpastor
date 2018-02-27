#!/bin/bash

secrets=secrets.txt
mysql_root_pw=
mysql_username=
mysql_user_pw=
mysql_db=

function install_python3() {
    py3version=$(python3 --version)
    if [[ "$py3version" != *"3.6"* ]]; then
        sudo apt-get update
        sudo apt-get install python3.6
    fi
}

function install_venv() {
    wget https://bootstrap.pypa.io/get-pip.py
    python3.6 get-pip.py
    pip3.6 install virtualenv
    rm -f get-pip.py
}

function start_venv() {
	if [[ ! -d "venv" ]]; then
		virtualenv venv -p python3.6
	fi

	if [[ -z "$VIRTUAL_ENV" ]]; then
		source venv/bin/activate
	fi
}

function install_django() {
    pip install django
}

function secure_install_mysql() {
	#
	# If you're getting errors with this, just run /usr/bin/mysql_secure_installation
	#

    mysql -e "UPDATE mysql.user SET Password=PASSWORD(\'"$mysql_root_pw"\') WHERE User='root';"
	mysql -e "DELETE FROM mysql.user WHERE User='';"
	mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
	mysql -e "DROP DATABASE IF EXISTS test;"
	mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
	mysql -e "FLUSH PRIVILEGES;"
}

function create_mysql_admin() {
	
	sudo mysql -uroot -p${mysql_root_pw} -e  "CREATE DATABASE ${mysql_db};"
	sudo mysql -uroot -p${mysql_root_pw} -e  "CREATE USER ${mysql_username}@localhost IDENTIFIED BY '${mysql_user_pw}';"
	sudo mysql -uroot -p${mysql_root_pw} -e  "GRANT ALL PRIVILEGES ON ${mysql_db}.* TO '${mysql_username}'@'localhost';"
	sudo mysql -uroot -p${mysql_root_pw} -e  "FLUSH PRIVILEGES;"
}

function install_mysql() {
    is_installed=$(dpkg --get-selections | grep mysql | grep installed)
    if [[ -z "$is_installed" ]]; then
        sudo apt-get install mysql-server
        #secure_install_mysql
    fi
}

read_secrets() {
	if [[ ! -f "$secrets" ]]; then
		echo "Please download from GoogleDrive/AlPastor/Documentation/secrets.txt"
		exit 1
	fi

	mysql_root_pw=$(cat "$secrets" | grep "mysql_root_password" | cut -d: -f2)
	mysql_username=$(cat "$secrets" | grep "mysql_username" | cut -d: -f2)
	mysql_user_pw=$(cat "$secrets" | grep "mysql_user_password" | cut -d: -f2)
	mysql_db=$(cat "$secrets" | grep "mysql_database" | cut -d: -f2)
}


read_secrets
install_python3
install_venv
start_venv
install_django
install_mysql
create_mysql_admin
