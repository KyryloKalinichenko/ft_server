server {
    listen 80;
    listen [::]:80;

    root /var/www/hereasite;
    index index.php index.html index.htm;

    server_name hereasite www.hereasite.com;

    location / {
        try_files $uri $uri/ =404;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php7.3-fpm.sock;
    }
}
