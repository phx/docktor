#!/bin/bash

/etc/init.d/tor start &&\
onion="$(cat "/var/lib/tor/hidden_service/hostname")"
cd /etc/nginx/sites-enabled &&\
ln -s ../sites-available/hiddenservice.conf &&\
sed -i "s/YOUR_HIDDEN_SERVICE_HERE.onion;/$onion;/" hiddenservice.conf &&\
nginx -t &&\
echo -e "\n***** $onion *****\n" &&\
echo "$onion" > /var/www/hiddenservice/hostname &&\
nginx -g 'daemon off;'
