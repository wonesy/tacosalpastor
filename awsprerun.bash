#!/bin/bash

settings_file=./alpastor/alpastor/settings.py
allowed_hosts="ALLOWED_HOSTS = ['.elasticbeanstalk.com']"

sed -i -e "s/.*ALLOWED_HOSTS.*/${allowed_hosts}/" "$settings_file"
