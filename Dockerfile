FROM debian:jessie

RUN apt-get update && apt-get install -y ca-certificates curl apache2-bin apache2.2-common libapache2-mod-php5

ADD project.conf /etc/apache2/sites-available/

RUN a2enmod proxy_fcgi
RUN a2dismod mpm_event
RUN a2enmod mpm_prefork

RUN ln -s /etc/apache2/sites-available/project.conf /etc/apache2/sites-enabled/project.conf
RUN rm /etc/apache2/sites-enabled/*default*

RUN usermod -u 1000 www-data

EXPOSE 80
EXPOSE 443

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]