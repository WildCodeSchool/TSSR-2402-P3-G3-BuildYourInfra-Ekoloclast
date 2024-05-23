#!/bin/bash

# Variables de configuration
DB_NAME="dbscript_glpi"
DB_USER="toto"
DB_PASS="toto1*"
GLPI_VERSION="10.0.5"
GLPI_URL="https://github.com/glpi-project/glpi/releases/download/${GLPI_VERSION}/glpi-${GLPI_VERSION}.tgz"
SITE="support.ekoloclast.fr"

# Mettre à jour le système
apt-get update && apt-get upgrade -y

# Installer les dépendances nécessaires
apt-get install -y apache2 mariadb-server php 
apt-get php-xml php-common php-json php-mysql php-mbstring php-curl php-gd php-intl php-zip php-bz2 php-imap php-apcu
apt-get install php-ldap

# Configurer la base de données
mysql -u root -p "CREATE DATABASE ${DB_NAME};"
mysql -u root -p "CREATE USER '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';"
mysql -u root -p "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';"
mysql -u root -p "FLUSH PRIVILEGES;"
mysql -u root -p "EXIT"

# Télécharger GLPI et préparer son installation
cd /tmp
wget https://github.com/glpi-project/glpi/releases/download/10.0.10/glpi-10.0.10.tgz
tar -xzvf glpi-10.0.10.tgz -C /var/www/
chown www-data /var/www/glpi/ -R
mkdir /etc/glpi
chown www-data /etc/glpi/
mv /var/www/glpi/config /etc/glpi
mkdir /var/lib/glpi
chown www-data /var/lib/glpi/
mv /var/www/glpi/files /var/lib/glpi
mkdir /var/log/glpi
chown www-data /var/log/glpi

# Créer le fichier de configuration de la base de données pour GLPI
echo "<?php
define('GLPI_VAR_DIR', '/var/lib/glpi/files');
define('GLPI_LOG_DIR', '/var/log/glpi');"  > /etc/glpi/local_define.php
echo "<?php
define('GLPI_CONFIG_DIR', '/etc/glpi/');
if (file_exists(GLPI_CONFIG_DIR . '/local_define.php')) {
    require_once GLPI_CONFIG_DIR . '/local_define.php';
}" > /var/www/glpi/inc/downstream.php

# Utilisation de PHP8.2-FPM avec Apache2
apt-get install php8.2-fpm
a2enmod proxy_fcgi setenvif
a2enconf php8.2-fpm
systemctl reload apache2
sed -i 's/\(session.cookie_httponly\).*'/\session.cookie_httponly = on/' /etc/php/8.2/fpm/php.ini'
systemctl restart php8.2-fpm.service
# Préparer la configuration Apache2
echo "<VirtualHost *:80>
    ServerName $SITE

    DocumentRoot /var/www/glpi/public

    <Directory /var/www/glpi/public>
        Require all granted

        RewriteEngine On

        RewriteCond %{REQUEST_FILENAME} !-f
        RewriteRule ^(.*)$ index.php [QSA,L]

    </Directory>

    <FilesMatch \.php$>
    SetHandler " proxy:unix:/run/php/php8.2-fpm.sock|fcgi://localhost/ "
    </FilesMatch>

</VirtualHost>" > /etc/apache2/sites-available/$SITE.conf

systemctl restart apache2



