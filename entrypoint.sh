#!/bin/ash
# Replace PORT variable in configurations using envsubst
cp -r /etc/nginx/conf.d /etc/nginx/conf.d.templates

for template in /etc/nginx/conf.d.templates/*; do
  conf=$(basename "$template")
  # shellcheck disable=SC2016
  envsubst '$PORT' < "$template" > "/etc/nginx/conf.d/$conf"
done

rm -rf /etc/nginx/conf.d.templates

# Start php-fpm and nginx
/usr/bin/supervisord
