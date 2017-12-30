FROM php:7.1-apache
MAINTAINER Dan Pupius <dan@pupi.us>

RUN  apt-get update && apt-get install -y software-properties-common python-software-properties git

#RUN export add-apt-repository -y ppa:ondrej/php

#RUN apt-get update -y

# Install apache, PHP, and supplimentary programs. openssh-server, curl, and lynx-cur are for debugging the container.
#RUN apt-get update && apt-get -y upgrade && DEBIAN_FRONTEND=noninteractive apt-get -y install \
#    apache2 php7.1  libapache2-mod-php7.1 curl lynx-cur libpq-dev && docker-php-ext-install pdo pdo_pgsql

RUN apt-get update && apt-get -y upgrade && DEBIAN_FRONTEND=noninteractive  && apt-get install -y libpq-dev \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install pdo pdo_pgsql pgsql

#RUN apache2 libapache2-mod-php7.1 curl lynx-cur
# Enable apache mods.
#RUN a2enmod php7.1
RUN a2enmod rewrite

# Update the PHP.ini file, enable <? ?> tags and quieten logging.
#RUN sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php/7.1/apache2/php.ini
#RUN sed -i "s/error_reporting = .*$/error_reporting = E_ERROR | E_WARNING | E_PARSE/" /etc/php/7.1/apache2/php.ini

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

# Expose apache.
EXPOSE 8001

# Copy this repo into place.
COPY . /var/www/html

# Download and Install Composer
RUN curl -s http://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

#COPY composer.json composer.lock /var/www/html/

WORKDIR /var/www/html

RUN pwd

RUN composer install

# RUN rm /etc/apache2/sites-available/000-default.conf
# RUN rm /etc/apache2/sites-enabled/000-default.conf
# RUN rm /etc/apache2/apache2.conf

# Update the default apache site with the config we created.
ADD docker-supports/apache/apache2.conf  /etc/apache2/apache2.conf

# By default start up apache in the foreground, override with /bin/bash for interative.
#CMD /usr/sbin/apache2ctl -D FOREGROUND

RUN chown -R www-data:www-data /var/www/html/storage/

# Configure data volume
VOLUME /var/www/html/storage

RUN service apache2 start