#!/bin/bash

mkdir -p /var/log/tacosalpastor-logs
chmod g+s /var/log/tacosalpastor-logs
touch /var/log/tacosalpastor-logs/tacos.log
chown wsgi:wsgi -R /var/log/tacosalpastor-logs

settings_file=./alpastor/alpastor/settings.py
allowed_hosts="ALLOWED_HOSTS = ['.elasticbeanstalk.com']"

sed -i -e "s/.*ALLOWED_HOSTS.*/${allowed_hosts}/" "$settings_file"
