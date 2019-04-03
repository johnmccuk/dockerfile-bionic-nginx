# Dockerfile for Ubuntu 18.04 nginx

# Pull base image.
FROM ubuntu:18.04

# Maintainer
MAINTAINER John McCracken <john.mccracken@qanw.co.uk>

# Install Packages
RUN DEBIAN_FRONTEND=noninteractive apt update -y && DEBIAN_FRONTEND=noninteractive apt install -y vim nginx nodejs npm \
    supervisor php7.2-fpm php7.2-mbstring php7.2-zip php-memcached libssh2-1 libssl1.0.0 php-curl php-ssh2 php7.2-mysql php-dom php-dom composer rsyslog zip unzip && apt clean && service php7.2-fpm start && usermod -u 1000 www-data

COPY ./conf/nginx.conf /etc/nginx/sites-enabled/default
COPY ./conf/php-custom.ini /etc/php/7.2/fpm/conf.d/99-custom.ini
COPY ./conf/php-fpm-pool.conf /etc/php/7.2/fpm/pool.d/www.conf
COPY ./webroot /var/www/html

EXPOSE 443 80

#Supervisor
COPY ./conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]

