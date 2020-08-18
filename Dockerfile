FROM debian:buster

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y wget

RUN apt-get install -y nginx

RUN service nginx start

RUN apt install -y mariadb-server mariadb-client
COPY srcs/mysql_install.sh mysql_install.sh
RUN chmod 711 mysql_install.sh
RUN ./mysql_install.sh

RUN apt install -y php-fpm php-mysql
 
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.5/phpMyAdmin-4.9.5-english.tar.gz
RUN mkdir /var/www/html/phpmyadmin
RUN tar -xzf /phpMyAdmin-4.9.5-english.tar.gz --strip-component=1 -C /var/www/html/phpmyadmin
RUN rm /phpMyAdmin-4.9.5-english.tar.gz
COPY srcs/config.inc.php /var/www/html/phpmyadmin/congig.inc.php
COPY srcs/admin_setup.sh admin_setup.sh
COPY srcs/pma_user_conf.sql pma_user_conf.sql
COPY srcs/normal_user_conf.sql normal_user_conf.sql
RUN chmod 711 admin_setup.sh
RUN ./admin_setup.sh

COPY srcs/wordpress_user_conf.sql wordpress_user_conf.sql
COPY srcs/wordpress_setup.sh wordpress_setup.sh
COPY srcs/wordpress /var/www/html/wordpress
COPY srcs/wordpress.sql wordpress.sql
RUN chmod 711 wordpress_setup.sh
RUN ./wordpress_setup.sh

COPY srcs/cert /etc/nginx/ssl

RUN rm /etc/nginx/sites-available/default
COPY srcs/host_setup /etc/nginx/sites-available/default
COPY srcs/system_init.sh system_init.sh
RUN chmod 711 system_init.sh
CMD ./system_init.sh
RUN rm /var/www/html/index.nginx-debian.html

RUN rm admin_setup.sh mysql_install.sh wordpress_setup.sh
RUN rm normal_user_conf.sql pma_user_conf.sql wordpress_user_conf.sql wordpress.sql

EXPOSE 80
EXPOSE 443
