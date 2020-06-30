#!/bin/bash

service mysql start
/bin/echo -e "\nn\n\n\n\n\n" | mysql_secure_installation
