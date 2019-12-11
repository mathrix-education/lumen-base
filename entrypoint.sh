#!/bin/ash
# Replace PORT variable using envsubst
PORT=$(printenv PORT)
PORT=${PORT:-"8080"}
export PORT="${PORT}"

cp -r /etc/nginx/conf.d /etc/nginx/conf.d.templates

for t in /etc/nginx/conf.d.templates/*
do
  envsubst '$PORT' < ${t} > "/etc/nginx/conf.d/"$(basename $t)
done

rm -rf /etc/nginx/conf.d.templates


# Start php-fpm and nginx
php-fpm && nginx -g 'daemon off;'
