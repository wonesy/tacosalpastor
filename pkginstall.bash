#!/bin/bash

#
# Check python version, make sure 3.6 is installed
#
py3version=$(python3 --version)
if [[ "$py3version" != *"3.6"* ]]; then
    sudo apt-get update
    sudo apt-get install python3.6
fi

#
# Install virtualenv
#
wget https://bootstrap.pypa.io/get-pip.py
python3.6 get-pip.py
pip3.6 install virtualenv
rm -f get-pip.py

#
# Start virtualenv
#
virtualenv venv -p python3.6
source venv/bin/activate

#
# Django
#
pip install django

#
# Verify
#
echo "\n\n** Verifying Environment **\n\n"

if [[ -z "$VIRTUAL_ENV" ]]; then
    echo "[ERROR] venv not activated"
else
    echo "...venv activated"
fi

djangoversion=$(django-admin --version)
if [[ "$djangoversion" != "2"* ]]; then
    echo "[ERROR] django is not the correct version"
else
    echo "...django version 2 is installed"
fi
