# Dockerfile for Ubuntu 18.04 nginx

# Pull base image.
FROM ubuntu:18.04

# Maintainer
MAINTAINER John McCracken <john.mccracken@qanw.co.uk>

# Set user and groups
#RUN groupadd -r dockuser && useradd -r -g dockuser dockuser

# Install Packages
RUN DEBIAN_FRONTEND=noninteractive apt update -y && DEBIAN_FRONTEND=noninteractive apt install -y vim nginx nodejs npm supervisor php-fpm php7.2-mbstring && apt clean

RUN service php7.2-fpm start

#Permissions! this bad boy took ages to figure out
RUN usermod -u 1000 www-data

COPY ./conf/nginx.conf /etc/nginx/sites-enabled/default
COPY ./webroot /var/www/html

EXPOSE 443 80

#Supervisor
COPY ./conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]

