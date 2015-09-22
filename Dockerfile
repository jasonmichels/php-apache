FROM php:5.6.9-apache

ENV DEBIAN_FRONTEND noninteractive

RUN mkdir -p /var/www/html/public

# Setup Apache and PHP
RUN 	apt-get -o 'Acquire::CompressionTypes::Order::="gz"' update && \
	apt-get install -y --no-install-recommends \
 	libmcrypt-dev \
	libbz2-dev \
	libpng12-dev && \
	docker-php-ext-install mcrypt bz2 gd mbstring zip pdo_mysql mysql mysqli pcntl bcmath && \
	apt-get purge --auto-remove -y libmcrypt-dev libbz2-dev libpng12-dev && \
	apt-get install -y --no-install-recommends libmcrypt4 libbz2-1.0 libpng12-0 libmagickwand-6.q16-dev && \
	ln -s /usr/lib/x86_64-linux-gnu/ImageMagick-6.8.9/bin-Q16/MagickWand-config /usr/bin && \
	pecl install imagick && \
	echo "extension=imagick.so" > /usr/local/etc/php/conf.d/ext-imagick.ini && \
	a2enmod rewrite && \
	a2enmod expires

# Copy config files
COPY config/apache2.conf /etc/apache2/apache2.conf
COPY config/php.ini /usr/local/etc/php/php.ini
