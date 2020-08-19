#!/bin/bash

if [ $INDEX = "off" ]
then
sed -i s/"autoindex on"/"autoindex off"/g /etc/nginx/sites-available/default
fi
service nginx start
service php7.3-fpm start
service mysql start
trap : TERM INT
tail -f /dev/null & wait
