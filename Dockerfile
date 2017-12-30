FROM php:7.1-apache
MAINTAINER Dan Pupius <dan@pupi.us>

EXPOSE 8001

# Copy this repo into place.
COPY . /var/www/html

RUN service apache2 start
