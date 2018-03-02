#!/bin/bash

pkgman='unkown'
admincmd='unknown'
secrets="secrets.env"

function is_installed()
{
    case $OSTYPE in
        linux*)
            dpkg-query -s $1 > /dev/null
            return $?
            ;;
        darwin*)
            brew ls --versions $1 > /dev/null
            return $?
            ;;
        *)
            return 1
            ;;
    esac
}

#
# This function will check the operating system and assign the correct
# package manager to install system-wide packages
#

function identify_package_manager()
{
    case $OSTYPE in
        linux*)
            pkgman="apt-get"
            admincmd="sudo"
            ;;
        darwin*)
            pkgman="brew"
            admincmd=""
            ;;
        *)
            echo "Could not identify operating system"
            exit 1
            ;;
    esac
}

#
# We need to ensure we have python3.6 and dev packages installed
#
function install_python3()
{
    py3version=$(python3 --version)
    if [[ "$py3version" != *"3.6"* ]]; then
        echo "Installing python3.6..."
        update_cmd="$admincmd $pkgman update"
        install_cmd="$admincmd $pkgman install python3"

        if [[ "$OSTYPE" == "linux"* ]]; then
            install_cmd="${install_cmd}.6 python3-dev"
        fi

        eval "$update_cmd"
        eval "$install_cmd"
    fi
}

function install_django()
{
    wget https://bootstrap.pypa.io/get-pip.py > /dev/null
    python3.6 get-pip.py > /dev/null
    pip3.6 install virtualenv
    rm -f get-pip.py

    source venv/bin/activate

    pip install django 
}

function create_mysql_admin() {
	
	sudo mysql -uroot -p${mysql_root_pw} -e  "CREATE DATABASE ${mysql_db};"
	sudo mysql -uroot -p${mysql_root_pw} -e  "CREATE USER ${mysql_username}@localhost IDENTIFIED BY '${mysql_user_pw}';"
	sudo mysql -uroot -p${mysql_root_pw} -e  "GRANT ALL PRIVILEGES ON ${mysql_db}.* TO '${mysql_username}'@'localhost';"
	sudo mysql -uroot -p${mysql_root_pw} -e  "FLUSH PRIVILEGES;"
}

function install_mysql()
{
    is_installed=$(dpkg --get-selections | grep mysql | grep installed)
    if [[ -z "$is_installed" ]]; then
        export DEBIAN_FRONTEND="noninteractive"
        sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password ${mysql_root_pw}"
        sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password ${mysql_root_pw}"
        sudo apt-get update > /dev/null
        sudo apt-get install -y  mysql-server libmysqlclient-dev > /dev/null

        create_mysql_admin
        unset DEBIAN_FRONTEND
    fi
}

function read_secrets() {
	if [[ ! -f "$secrets" ]]; then
		echo "Please download from GoogleDrive/AlPastor/Documentation/secrets.env"
		exit 1
	fi

	mysql_root_pw=$(cat "$secrets" | grep -i "mysql_root_password" | cut -d= -f2)
	mysql_username=$(cat "$secrets" | grep -i "mysql_username" | cut -d= -f2)
	mysql_user_pw=$(cat "$secrets" | grep -i "mysql_user_password" | cut -d= -f2)
	mysql_db=$(cat "$secrets" | grep -i "mysql_database" | cut -d= -f2)
}


#
#  Main
#
identify_package_manager
read_secrets
install_python3
install_django
install_mysql
