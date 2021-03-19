#!/bin/bash

#bash init.sh
#######################################
service mysql start
#######################################
mkdir /var/www/here && touch /var/www/here/index.php
echo "<?php phpinfo(); ?>" >> /var/www/here/index.php
#chown -R www-data /var/www/*
#chmod -R 755 /var/www/*
mkdir /etc/nginx/ssl
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/localhost.pem -keyout /etc/nginx/ssl/localhost.key -subj "/C=FR/ST=Brussels/L=Brussels/O=19 School/OU=kkalinic/CN/nginx_conf"
#######################################

mv ./here /etc/nginx/sites-available/here
ln -s /etc/nginx/sites-available/here /etc/nginx/sites-enabled/here
rm -rf /etc/nginx/sites-enabled/default 
#######################################
service nginx start
service php7.3-fpm start
#######################################
echo "CREATE DATABASE wordpress;"| mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;"| mysql -u root --skip-password
echo "FLUSH PRIVILEGES;"| mysql -u root --skip-password
echo "update mysql.user set plugin='' where user='root';"| mysql -u root --skip-password
#######################################
mkdir /var/www/here/phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz --strip-components 1 -C /var/www/here/phpmyadmin
cd && cp /config.inc.php /var/www/here/phpmyadmin/
#######################################

cd /var/www/here && wget https://wordpress.org/latest.tar.gz
cd /var/www/here && tar -xvzf latest.tar.gz && rm -rf latest.tar.gz
cd && cp /wp-config.php /var/www/here/wordpress/



service nginx restart
service mysql restart
service php7.3-fpm start
tail -f /dev/null