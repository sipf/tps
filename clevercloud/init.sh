#!/bin/bash
set -e

mkdir -p /home/bas/clamav

# encrypted with cmd :
# openssl enc -e -aes-256-cbc -in file -out file.enc -pass pass:$CONF_SECRET
openssl enc -d -aes-256-cbc -in "$APP_HOME/clevercloud/freshclam.conf.enc" -out "/home/bas/clamav/freshclam.conf" -pass pass:$CONF_SECRET
openssl enc -d -aes-256-cbc -in "$APP_HOME/clevercloud/clamd.conf.enc" -out "/home/bas/clamav/clamd.conf" -pass pass:$CONF_SECRET

/usr/bin/freshclam --config-file="/home/bas/clamav/freshclam.conf"
/usr/bin/clamd --config-file="/home/bas/clamav/clamd.conf"
