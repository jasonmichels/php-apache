FROM php:5.6.9-apache

ENV DEBIAN_FRONTEND noninteractive

RUN mkdir -p /var/www/html/public

# Setup Apache and PHP
RUN 	apt-get -o 'Acquire::CompressionTypes::Order::="gz"' update && \
	apt-get install -y --no-install-recommends \
 	libmcrypt-dev \
	libbz2-dev \
	libjpeg-dev \
	libpng12-dev && \
	rm -rf /var/lib/apt/lists/* && \
	docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr && \
	docker-php-ext-install mcrypt bz2 gd mbstring zip pdo_mysql mysql mysqli pcntl bcmath && \
	apt-get purge --auto-remove -y libmcrypt-dev libbz2-dev libpng12-dev && \
	apt-get install -y --no-install-recommends libbz2-1.0 libpng12-0 && \
	a2enmod rewrite && \
	a2enmod expires

# Copy config files
COPY config/apache2.conf /etc/apache2/apache2.conf
COPY config/php.ini /usr/local/etc/php/php.ini
