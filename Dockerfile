FROM ubuntu:18.04

RUN apt-get update &&\
    apt-get -y dist-upgrade &&\
    apt-get install -y curl gnupg apt-transport-https nginx-extras &&\
    echo 'deb https://deb.torproject.org/torproject.org bionic main' >> /etc/apt/sources.list &&\
    curl https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --import &&\
    gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add - &&\
    apt-get update &&\
    apt-get install -y tor deb.torproject.org-keyring &&\
    sed -i 's@#HiddenServiceDir /var/lib/tor/hidden_service/@HiddenServiceDir /var/lib/tor/hidden_service/@' /etc/tor/torrc &&\
    sed -i 's@#HiddenServicePort 80 127.0.0.1:80@HiddenServicePort 80 127.0.0.1:80@' /etc/tor/torrc &&\
    rm -vf /etc/nginx/nginx.conf &&\
    rm -vf /etc/nginx/sites-{available,enabled}/default &&\
    ln -sf /dev/stdout /var/log/nginx/access.log &&\
    ln -sf /dev/stderr /var/log/nginx/error.log &&\
    mkdir -p /var/www/hiddenservice

VOLUME /var/www/hiddenservice

COPY nginx/nginx.conf /etc/nginx/
COPY nginx/hiddenservice.conf /etc/nginx/sites-available/hiddenservice.conf
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT /entrypoint.sh
