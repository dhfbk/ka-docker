FROM php:7.4-apache

RUN docker-php-ext-install mysqli

COPY additional.conf /etc/apache2/sites-enabled/additional.conf

RUN mkdir /apps
COPY app.zip /apps/app.zip
COPY rc-setup.php /apps/rc-setup.php

RUN a2enmod rewrite proxy proxy_http headers

RUN apt-get update
RUN apt-get install -y unzip less nano

RUN curl --output /tmp/pma.zip https://files.phpmyadmin.net/phpMyAdmin/5.1.3/phpMyAdmin-5.1.3-all-languages.zip
RUN unzip -q /tmp/pma.zip -d /var/www/
RUN mv /var/www/phpMyAdmin* /var/www/pma
RUN mv /var/www/pma/config.sample.inc.php /var/www/pma/config.inc.php
RUN sed -i 's/localhost/mysql/g' /var/www/pma/config.inc.php

RUN pecl install ds
COPY extensions.ini /usr/local/etc/php/conf.d/
