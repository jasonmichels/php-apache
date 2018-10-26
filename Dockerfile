FROM php:7.1.18-apache

ENV DEBIAN_FRONTEND noninteractive

RUN mkdir -p /var/www/html/public

# Setup Apache and PHP
RUN 	apt-get -o 'Acquire::CompressionTypes::Order::="gz"' update && \
	apt-get install -y --no-install-recommends \
 	libmcrypt-dev \
	libbz2-dev \
	libjpeg-dev \
	libpng-dev && \
	rm -rf /var/lib/apt/lists/* && \
	pecl install xdebug && \
	docker-php-ext-configure gd --with-png-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
	docker-php-ext-install mcrypt bz2 gd mbstring exif zip pdo_mysql mysqli pcntl bcmath && \
	apt-get purge --auto-remove -y libmcrypt-dev libbz2-dev libpng12-dev && \
	apt-get install -y --no-install-recommends libbz2-1.0 'libpng*' && \
	a2enmod rewrite && \
	a2enmod expires

# Copy config files
COPY config/apache2.conf /etc/apache2/apache2.conf
COPY config/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY config/000-default.conf /etc/apache2/sites-enabled/000-default.conf
COPY config/php.ini /usr/local/etc/php/php.ini
