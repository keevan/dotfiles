#!/bin/sh

# Install PHP (fpm to not install apache)
sudo apt update
sudo apt install -y php-fpm

# Install Composer

EXPECTED_CHECKSUM="$(wget -q -O - https://composer.github.io/installer.sig)"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]
then
    >&2 echo 'ERROR: Invalid installer checksum'
    rm composer-setup.php
    exit 1
fi

php composer-setup.php --quiet
RESULT=$?
rm composer-setup.php

mv composer.phar ~/bin/composer
source ~/.exports

# Requires php-curl and the extension enabled
echo "Remember to enable the php-curl extension and install it if not already"

echo "Then run the following:"
echo "composer global require hirak/prestissimo"

exit $RESULT
