#!/bin/bash

#bash init.sh
#######################################
service mysql start
#######################################
#mkdir /var/www/here && touch /var/www/here/info.php
#echo "<?php phpinfo(); ?>" >> /var/www/here/info.php

mkdir /etc/ssl
openssl req -x509 -nodes -days 365 -subj "/C=BE/ST=Brussels/L=Brussels/O=19School/OU=student/CN=here" -newkey rsa:2048 -keyout /etc/ssl/localhost.key -out /etc/ssl/localhost.crt
#######################################

#mv ./here /etc/nginx/sites-available/here
#ln -s /etc/nginx/sites-available/here /etc/nginx/sites-enabled/here
#rm -rf /etc/nginx/sites-enabled/default 

#######################################

echo "CREATE DATABASE wordpress;"| mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;"| mysql -u root --skip-password
echo "FLUSH PRIVILEGES;"| mysql -u root --skip-password
echo "update mysql.user set plugin='' where user='root';"| mysql -u root --skip-password

#######################################

#mkdir /var/www/here/phpmyadmin
#wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
#tar -xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz --strip-components 1 -C /var/www/here/phpmyadmin
#cd && cp /config.inc.php /var/www/here/phpmyadmin/

#######################################

#cd /var/www/here && wget https://wordpress.org/latest.tar.gz
#cd /var/www/here && tar -xvzf latest.tar.gz && rm -rf latest.tar.gz
#cd && cp /wp-config.php /var/www/here/wordpress/

service nginx start
service mysql restart
service php7.3-fpm start
#tail -f /dev/null
bash
