#!/bin/bash

php artisan app:install
chown -R www-data: *
#sed -i -e "s/Listen 80/Listen 8081/g" /etc/apache2/ports.conf
rm -rf /etc/apache2/sites-enabled/*
a2enmod rewrite
a2ensite cachet
apache2ctl -D FOREGROUND
