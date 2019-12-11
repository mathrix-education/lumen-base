FROM php:7.4-fpm-alpine

LABEL Maintainer="Mathieu Bour <mathieu@mathrix.fr>" \
      Description="Base for PHP projects with nginx and PHP 7.4"

# Install the required php gmp extension for ellipitic curves
RUN apk add --no-cache gmp gmp-dev gettext \
  && docker-php-ext-install gmp

# Install nginx
RUN apk add --no-cache nginx

COPY ./entrypoint.sh /entrypoint.sh

# Cleanup
RUN rm -rf /usr/src \
  /etc/nginx/conf.d/default.conf

ENTRYPOINT ["/entrypoint.sh"]
