FROM php:8.5-fpm-alpine3.24

WORKDIR /var/www/html

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
    && apk update \
    && apk add --no-cache \
        libpng libpng-dev \
        libwebp libwebp-dev \
        libjpeg libjpeg-turbo-dev \
        freetype freetype-dev \
        php85-dev \
        libzip libzip-dev \
        alpine-sdk \
        php85-pecl-imagick \
        imagemagick-dev \
        ghostscript \
        postfix \
    && docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install -j$(nproc) mysqli zip gd pdo_mysql \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && sed -i '/<\/policymap>/i<policy domain="coder" rights="write" pattern="PDF" \/>' /etc/ImageMagick-7/policy.xml \
    && apk del --no-cache \
        libpng-dev \
        libwebp-dev \
        libjpeg-turbo-dev \
        freetype-dev \
        php85-dev \
        libzip-dev \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/apk/*

COPY ./php/conf.d/* /usr/local/etc/php/conf.d/
RUN deluser www-data; addgroup -g 82 www-data; adduser -u 1000 -D -S -G www-data www-data

CMD ["php-fpm"]
