mkdir -p /var/lib/phpmyadmin/tmp
chown -R www-data:www-data /var/lib/phpmyadmin
service mysql start
mysql -u root
mysql < /var/www/html/phpmyadmin/sql/create_tables.sql
mysql < pma_user_conf.sql
mysql < normal_user_conf.sql
