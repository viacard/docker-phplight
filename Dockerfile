FROM alpine:3.10
LABEL maintainer "mats@viacard.com"

RUN apk add --no-cache  lighttpd \
			php7-common \
			php7-iconv \
			php7-json \
			php7-gd \
			php7-curl \
			php7-xml \
			php7-mysqli \
			php7-imap \
			php7-cgi \
			fcgi \
			php7-pdo \
			php7-pdo_mysql \
			php7-xmlrpc \
			php7-posix \
			php7-mcrypt \
			php7-gettext \
			php7-ldap \
			php7-ctype \
			php7-dom

COPY *.conf /etc/lighttpd/

RUN mkdir /var/run/lighttpd; \
    touch /var/run/lighttpd/php-fastcgi.socket; \
    chown -R lighttpd:lighttpd /var/run/lighttpd; \
    rm -rf /var/www/localhost

EXPOSE 8080

CMD ["/usr/sbin/lighttpd","-D", "-f", "/etc/lighttpd/lighttpd.conf"]
