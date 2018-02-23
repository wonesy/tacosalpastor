#!/bin/bash

# Check python version
py3version=$(python3 --version)
if [[ "$py3version" != *"3.6"* ]]; then
    sudo apt-get update
    sudo apt-get install python3.6
fi

# Virtual Env
wget https://bootstrap.pypa.io/get-pip.py
python3.6 get-pip.py
pip3.6 install virtualenv
rm -f get-pip.py

# Start virtualenv
virtualenv venv -p python3.6
source venv/bin/activate

# Django
pip install django
