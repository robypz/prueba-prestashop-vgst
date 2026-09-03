FROM prestashop/prestashop:8.2.8-apache

# Configuración personalizada de PHP optimizada para PrestaShop
RUN echo "memory_limit = 512M\n\
max_execution_time = 300\n\
max_input_vars = 5000\n\
upload_max_filesize = 64M\n\
post_max_size = 64M\n\
date.timezone = UTC\n\
opcache.enable = 1\n\
opcache.memory_consumption = 256\n\
opcache.max_accelerated_files = 20000\n\
opcache.validate_timestamps = 1" > /usr/local/etc/php/conf.d/prestashop-custom.ini

# Hook pre-instalación para garantizar permisos de escritura automáticos
RUN mkdir -p /tmp/pre-install-scripts && \
    echo '#!/bin/sh\n\
echo "* Ensuring write permissions on PrestaShop folders..."\n\
mkdir -p /var/www/html/var/cache /var/www/html/var/logs /var/www/html/app/config /var/www/html/img /var/www/html/mails /var/www/html/modules /var/www/html/themes /var/www/html/translations /var/www/html/upload /var/www/html/download /var/www/html/config\n\
chmod -R 777 /var/www/html/var /var/www/html/app/config /var/www/html/img /var/www/html/mails /var/www/html/modules /var/www/html/themes /var/www/html/translations /var/www/html/upload /var/www/html/download /var/www/html/config || true\n\
chown -R www-data:www-data /var/www/html/var /var/www/html/app/config /var/www/html/img /var/www/html/mails /var/www/html/modules /var/www/html/themes /var/www/html/translations /var/www/html/upload /var/www/html/download /var/www/html/config || true\n' \
    > /tmp/pre-install-scripts/01-permissions.sh && \
    chmod +x /tmp/pre-install-scripts/01-permissions.sh
