#
# Cachet Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM debian:latest

MAINTAINER hihouhou < hihouhou@hihouhou.com >

ENV LATEST_TAG v2.3.3

# Update & install packages for installing consul
RUN apt-get update && \
    apt-get install -y git apache2 curl php5 php5-gd postgresql-client php5-pgsql

#Install and configure consul
RUN git clone https://github.com/cachethq/Cachet.git && \
    cd Cachet && \
    git tag -l && \
    git checkout $LATEST_TAG

#Add configuration file
ADD .env /Cachet/

#install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    cd Cachet && \
    composer install --no-dev -o && \
    php artisan app:install

#Configure Apache
RUN a2enmod rewrite
ADD toto.conf /etc/apache2/sites-enabled/000-default.conf

CMD ["apache2ctl", "-D", "FOREGROUND"]


RUN ls -la /Cachet && \
    cat /Cachet/.env.example
