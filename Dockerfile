FROM php:7.4-fpm-alpine

LABEL Maintainer="Mathieu Bour <mathieu@mathrix.fr>" \
      Description="Base for PHP projects with nginx and PHP 7.4"

ENV PORT=8080

USER root

# Install additional packages:
# - nginx to serve the PHP application
# - gmp for the php-gmp extension required to use ellipitic curves
# - gettext to use the envsubst command
RUN apk add --no-cache nginx gmp gmp-dev gettext fcgi \
    && docker-php-ext-install -j$(nproc) gmp opcache \

    # Download PHP-FPM healthcheck
    && wget -O /usr/local/bin/php-fpm-healthcheck \
    "https://raw.githubusercontent.com/renatomefi/php-fpm-healthcheck/master/php-fpm-healthcheck" \
    && chmod +x /usr/local/bin/php-fpm-healthcheck \

    # Cleanup: remove PHP source file
    && rm -rf /usr/src /var/www /var/cache/apk/*

# Copy configuration files
COPY ./confs/nginx.conf /etc/nginx/nginx.conf
COPY ./confs/nginx-gzip.conf /etc/nginx/conf.d/gzip.conf
COPY ./confs/nginx-vhost.conf /etc/nginx/conf.d/default.conf
COPY ./confs/php.ini /usr/local/etc/php/php.ini
COPY ./confs/php-fpm.conf /usr/local/etc/php-fpm.conf
COPY ./confs/php-fpm-pool.conf /usr/local/etc/php-fpm.d/www.conf


# Copy entrypoint and ensure that it is runnable
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Setup a default phpinfo page as index
RUN mkdir -p /var/www/public \
    && echo "<?php phpinfo(); ?>" > /var/www/public/index.php

# Make sure files/folders needed by the processes are accessible when they run under the nobody user
RUN chown -R nobody.nobody /run && \
    chown -R nobody.nobody /etc/nginx && \
    chown -R nobody.nobody /var/lib/nginx && \
    chown -R nobody.nobody /var/log/nginx && \
    chown -R nobody.nobody /var/tmp/nginx && \
    chown -R nobody.nobody /var/www

# Declare healthcheck
HEALTHCHECK CMD /usr/local/bin/php-fpm-healthcheck || exit 1

USER nobody

WORKDIR /var/www

ENTRYPOINT ["/entrypoint.sh"]
