FROM php:7.4-apache

RUN apt-get update
RUN apt-get install -y unzip less nano libzip-dev git zlib1g-dev libpng-dev

RUN docker-php-ext-install mysqli gd
COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer

COPY additional.conf /etc/apache2/sites-enabled/additional.conf

RUN mkdir /apps
COPY app.zip /apps/app.zip
COPY rc-setup.php /apps/rc-setup.php
COPY kaum-setup.php /apps/kaum-setup.php
COPY kaum.sql /apps/kaum.sql
COPY logo_kidactions4_512.png /apps/logo_kidactions4_512.png

RUN a2enmod rewrite proxy proxy_http headers

RUN curl --output /tmp/pma.zip -L https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.zip
RUN unzip -q /tmp/pma.zip -d /var/www/html/
RUN mv /var/www/html/phpMyAdmin* /var/www/html/pma
RUN mv /var/www/html/pma/config.sample.inc.php /var/www/html/pma/config.inc.php
RUN sed -i 's/localhost/mysql/g' /var/www/html/pma/config.inc.php
RUN rm /tmp/pma.zip

RUN curl --output /tmp/creender.zip https://dh.fbk.eu/software/creender.zip
RUN unzip -q /tmp/creender.zip -d /var/www/html/
RUN curl --output /tmp/kaum.zip https://dh.fbk.eu/software/kaum.zip
RUN unzip -q /tmp/kaum.zip -d /var/www/html/
RUN curl --output /tmp/hssh.zip https://dh.fbk.eu/software/hssh.zip
RUN unzip -q /tmp/hssh.zip -d /var/www/html/
RUN rm /tmp/creender.zip /tmp/kaum.zip /tmp/hssh.zip

RUN git clone https://github.com/dhfbk/kaum /tmp/kaum
RUN mv /tmp/kaum/api /var/www/html/
RUN rm -r /tmp/kaum
RUN cp /var/www/html/api/config.sample.php /var/www/html/api/config.php
RUN sed -i 's/DB_HOST = ""/DB_HOST = "mysql"/g' /var/www/html/api/config.php
RUN sed -i 's/DB_USERNAME = ""/DB_USERNAME = "root"/g' /var/www/html/api/config.php
RUN sed -i 's/DB_NAME = ""/DB_NAME = "kaum"/g' /var/www/html/api/config.php

RUN pecl install ds
RUN pecl install zip
COPY extensions.ini /usr/local/etc/php/conf.d/

RUN ( cd /var/www/html/api ; php /usr/local/bin/composer install )

# RUN mkdir /var/www/tasks
