```
CREATE DATABASE db23_glpi;
GRANT ALL PRIVILEGES ON db23_glpi.* TO glpi_adm@localhost IDENTIFIED BY "Azerty1*";
FLUSH PRIVILEGES;
EXIT

<?php
define('GLPI_CONFIG_DIR', '/etc/glpi/');  
if (file_exists(GLPI_CONFIG_DIR . '/local_define.php')) { 
  require_once GLPI_CONFIG_DIR . '/local_define.php'; 
  }

<?php
define('GLPI_VAR_DIR', '/var/lib/glpi/files'); 
define('GLPI_LOG_DIR', '/var/log/glpi');


<VirtualHost *:80> 
ServerName support.ekoloclast.fr 
DocumentRoot /var/www/glpi/public 
<Directory /var/www/glpi/public> 
Require all granted 
RewriteEngine On 
RewriteCond %{REQUEST_FILENAME} !-f 
RewriteRule ^(.*)$ index.php [QSA,L] 
</Directory> 
</VirtualHost>```
