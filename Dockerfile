FROM debian:buster

RUN apt-get update -y && apt-get upgrade -y && apt-get install nginx -y && apt-get -y install mariadb-server && apt-get -y install wget
RUN apt-get -y install php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring

EXPOSE 80
EXPOSE 443
COPY srcs /

RUN service mysql start

RUN chown -R www-data /var/www/*
RUN chmod -R 755 /var/www/*

RUN mkdir /var/www/here && touch /var/www/here/info.php
RUN echo "<?php phpinfo(); ?>" >> /var/www/here/info.php

RUN mv ./here /etc/nginx/sites-available/here
RUN ln -s /etc/nginx/sites-available/here /etc/nginx/sites-enabled/here
RUN rm -rf /etc/nginx/sites-enabled/default 

RUN mkdir /var/www/here/phpmyadmin
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
RUN tar -xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz --strip-components 1 -C /var/www/here/phpmyadmin
RUN cd && cp /config.inc.php /var/www/here/phpmyadmin/



RUN cd /var/www/here && wget https://wordpress.org/latest.tar.gz
RUN cd /var/www/here && tar -xvzf latest.tar.gz && rm -rf latest.tar.gz
RUN cd && cp /wp-config.php /var/www/here/wordpress/

ENTRYPOINT [ "/bin/bash", "-C", "run.sh"]
#RUN bash