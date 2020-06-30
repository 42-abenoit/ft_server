#!/bin/bash

service nginx start
#service nginx reload
service php7.3-fpm start
service mysql start
trap : TERM INT
tail -f /dev/null & wait
