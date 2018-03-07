#!/bin/bash

pkgman='unknown'
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

            release=$(lsb_release -a | grep -i release)
            if [[ "$release" == *"16.04"* ]]; then
                sudo add-apt-repository ppa:deadsnakes/ppa
                sudo apt-get update
            fi
            install_cmd="${install_cmd}.6 python3.6-dev"
        fi

        eval "$update_cmd"
        eval "$install_cmd"
    fi
}

function install_django()
{
    wget https://bootstrap.pypa.io/get-pip.py
    python3.6 get-pip.py
    sudo -H pip3.6 install virtualenv
    rm -f get-pip.py

    virtualenv -p python3.6 venv
    sudo chown -R ${USER}:${USER} venv

    source venv/bin/activate

    pip install django
    pip install mysqlclient
}

function create_mysql_admin()
{	
    $admincmd mysql -uroot -p${mysql_root_pw} -e  "CREATE DATABASE ${mysql_db};"
    $admincmd mysql -uroot -p${mysql_root_pw} -e  "CREATE USER ${mysql_username}@localhost IDENTIFIED BY '${mysql_user_pw}';"
    $admincmd mysql -uroot -p${mysql_root_pw} -e  "GRANT ALL PRIVILEGES ON ${mysql_db}.* TO '${mysql_username}'@'localhost';"
    $admincmd mysql -uroot -p${mysql_root_pw} -e  "FLUSH PRIVILEGES;"
}

function install_mysql()
{
    if [[ $pkgman == "apt-get" ]]; then
        is_installed=$(dpkg --get-selections | grep mysql | grep installed)
        if [[ -z "$is_installed" ]]; then
            export DEBIAN_FRONTEND="noninteractive"
            sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password ${mysql_root_pw}"
            sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password ${mysql_root_pw}"
            sudo apt-get update > /dev/null
            sudo apt-get install -y  mysql-server libmysqlclient-dev > /dev/null
            create_mysql_admin
            unset DEBIAN_FRONTEND
        else
            echo MySQL already installed.
        fi
    elif [[ $pkgman == "brew" ]]; then
        is_installed=$(type -a mysql)
        if [[ -z "$is_installed" ]]; then
            $pkgman install mysql
            mysql.server start
            sleep 7
            create_mysql_admin
        else
            echo MySQL already installed.
            echo $is_installed
        fi
    else
        echo Please install MySQL manually.
    fi
}

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

#
# Main
#
functions_list=(identify_package_manager read_secrets install_python3 install_django install_mysql)

echo -e "'y' to execute function or any other key to skip.\n"
#
# Allows you to skip individual functions
#
for i in ${functions_list[@]}; do
    read -p "Install $i? " answer
    if [[ $answer == "y" ]]; then
        echo -e "\n##################################################"
        echo "Installing $i..."
        echo -e "##################################################\n"
        $i
    else
        echo -e "\n##################################################"
        echo "Skipping $i..."
        echo -e "##################################################\n"
    fi
done
