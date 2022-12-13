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
RUN unzip -q /tmp/pma.zip -d /var/www/html/
RUN mv /var/www/html/phpMyAdmin* /var/www/html/pma
RUN mv /var/www/html/pma/config.sample.inc.php /var/www/html/pma/config.inc.php
RUN sed -i 's/localhost/mysql/g' /var/www/html/pma/config.inc.php

RUN curl --output /tmp/creender.zip https://dh.fbk.eu/software/creender.zip
RUN unzip -q /tmp/creender.zip -d /var/www/html/
RUN curl --output /tmp/kaum.zip https://dh.fbk.eu/software/kaum.zip
RUN unzip -q /tmp/kaum.zip -d /var/www/html/
RUN curl --output /tmp/hssh.zip https://dh.fbk.eu/software/hssh.zip
RUN unzip -q /tmp/hssh.zip -d /var/www/html/

RUN pecl install ds
RUN pecl install zip
COPY extensions.ini /usr/local/etc/php/conf.d/

# RUN mkdir /var/www/tasks
