FROM php:7.4-apache

RUN docker-php-ext-install mysqli

COPY additional.conf /etc/apache2/sites-enabled/additional.conf

RUN mkdir /apps
COPY app.zip /apps/app.zip
COPY rc-setup.php /apps/rc-setup.php
COPY logo_kidactions4_512.png /apps/logo_kidactions4_512.png

RUN a2enmod rewrite proxy proxy_http headers

RUN apt-get update
RUN apt-get install -y unzip less nano libzip-dev

RUN curl --output /tmp/pma.zip https://files.phpmyadmin.net/phpMyAdmin/5.1.3/phpMyAdmin-5.1.3-all-languages.zip
RUN unzip -q /tmp/pma.zip -d /var/www/
RUN mv /var/www/phpMyAdmin* /var/www/pma
RUN mv /var/www/pma/config.sample.inc.php /var/www/pma/config.inc.php
RUN sed -i 's/localhost/mysql/g' /var/www/pma/config.inc.php

RUN pecl install ds
RUN pecl install zip
COPY extensions.ini /usr/local/etc/php/conf.d/
