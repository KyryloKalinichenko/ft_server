FROM debian:buster

RUN apt-get update -y && apt-get upgrade -y && apt-get install nginx -y && apt-get -y install mariadb-server && apt-get -y install wget
RUN apt-get -y install php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring

COPY srcs /

RUN service mysql start

RUN chown -R www-data /var/www/*
RUN chmod -R 755 /var/www/*



#RUN mv ./here /etc/nginx/sites-available/here
#RUN ln -s /etc/nginx/sites-available/here /etc/nginx/sites-enabled/here
#RUN rm -rf /etc/nginx/sites-enabled/default 

ENTRYPOINT [ "/bin/bash", "-C", "run.sh"]
