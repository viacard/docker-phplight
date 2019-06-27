# docker-phplight

A small web server with PHP support built with Alpine and lighttpd.

The current version are using Alpine 3.10.0, lighthttpd 1.4.54 and PHP 7.3.6 

## Serving

The html- and php-files are being served from `/var/www`. Directory listing is disabled and the automatic index files are `index.php`, `index.html` and `index.htm`.

## Using
To use this image create a new Dockerfile like this:
```
FROM viacard/phplight
RUN echo '<?php phpinfo();' > /var/www/index.php
```
And then build, run and test it:
```
docker build -t testpl .
docker run -d --rm -p 8080:8080 testpl 
links http://localhost:8080
```

## Repo

All files can be found at https://github.com/viacard/docker-phplight

## Dockerfile
```
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
```

## Release history

- v1.0 June 27 2019 - Initial release
