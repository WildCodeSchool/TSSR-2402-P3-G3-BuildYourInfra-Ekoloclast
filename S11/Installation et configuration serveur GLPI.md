# INSTALLATION ET CONFIGURATION SERVEUR GLPI
    
*Configuration serveur*
    
- Debian 12.0
- Carte réseaux en pont 
- Adresse IP Static en 192.168.0.5/24
    

## 1.Installer le socle LAMP
    
- La première étape consiste à installer les paquets LAMP (Linux Apache2 MariaDB PHP).
    
```apt-get install apache2 php mariadb-server```
    
    
- Ensuite, installer toutes les extensions nécessaires au bon fonctionnement de GLPI.
    
```apt-get install php-xml php-common php-json php-mysql php-mbstring php-curl php-gd php-intl php-zip php-bz2 php-imap php-apcu```
    
    
- Pour associer GLPI avec l'Active Directory, il faut installer l'extension LDAP de PHP.
    
```apt-get install php-ldap```
    
    
    
## 2.Préparer la base de donné pour GLPI
    
- Il faut préparer MariaDB pour qu'il puisse héberger la base de données de GLPI.
    
Pour commencer il faut effectuer.
    
```mysql_secure_installation```
    
- Ici plusieurs option s'affiche pour une bonne configuration suivre l'exemple de l'image ci-dessous :
    
ce qui doit donner :
    
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S11/Ressources%20Install%20et%20configuration%20GLPI/Securiser-MariaDB-pour-GLPI.png)
    
- Ensuite on se connecte à notre instance MariaDB.
    
```mysql -u root -p```
   
- Saisire le mot de passe précédement definie.
    
- Il faut maintenant exécuter les requêtes SQL ci-dessous pour créé la base de donné ici "glpi_23", ansi que l'utilisateur "glpi_adm".
    
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S11/Ressources%20Install%20et%20configuration%20GLPI/base_de_donner.png)
    
- Ce qui doit donner :
    
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S11/Ressources%20Install%20et%20configuration%20GLPI/Creer-base-de-donnees-GLPI.png)
    
    
## 3.Télécharger GLPI et préparer son installation
    
- Il faut maintenant télécharger l'archiver ".tgz" qui contient les sources d'installation de GLPI.
    
- Se rendre dans le dossier /tmp
    
```cd /tmp```
    
- Puis faire
```wget https://github.com/glpi-project/glpi/releases/download/10.0.15/glpi-10.0.15.tgz```
    
- Il faut ensuite decomprésser l'archive .tgz dans le dossier /var/www .
    
```tar -xzvf glpi-10.0.15.tgz -C /var/www/```
    
- Définir l'utilisateur "www-data" correspondant à Appache2, en tant que propriétaire des fichiers GLPI
    
```chown www-data /var/www/glpi/ -R```
    
- Il faut créer pluisieurs dossiers et sortir des données de la racine Web (/var/www/glpi) de manière à les stocker dans les nouveaux dossiers que nous allons créer.
    
- Créer le répertoire "/etc/glpi" qui va recevoir les fichiers de configuration de GLPI.
    
```mkdir /etc/glpi```
```chown www-data /etc/glpi/```
    
- déplacer le répertoire "config" de GLPI vers ce nouveau dossier.
    
```mv /var/www/glpi/config /etc/glpi```
    
- répéter la même opération avec:
    
```mkdir /var/lib/glpi```
```chown www-data /var/lib/glpi/```
    
- Déplacer le dossier "files".
    
```mv /var/www/glpi/files /var/lib/glpi```
    
- terminer par créé le répertoire destiné à stocker les journaux de GLPI.
    
```mkdir /var/log/glpi```
```chown www-data /var/log/glpi```
    
- Configurer GLPI pour qu'il sache où aller chercher les données.
    
- créer ce premier fichier.
    
```nano /var/www/glpi/inc/downstream.php```
    
- Ajouter le contenue ci dessous:
- <?php
define('GLPI_CONFIG_DIR', '/etc/glpi/');
if (file_exists(GLPI_CONFIG_DIR . '/local_define.php')) {
    require_once GLPI_CONFIG_DIR . '/local_define.php';
}
    
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S11/Ressources%20Install%20et%20configuration%20GLPI/Capture%20d%E2%80%99e%CC%81cran%202024-05-23%20a%CC%80%2013.36.26.png)
    
- Ensuite, créé ce second fichier
    
```nano /etc/glpi/local_define.php```
    
- Ajouter le contenue ci dessous :
- <?php
define('GLPI_VAR_DIR', '/var/lib/glpi/files');
define('GLPI_LOG_DIR', '/var/log/glpi');
    
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S11/Ressources%20Install%20et%20configuration%20GLPI/Fichier_php2.png)
    
    
## 4.Préparer la configuration Apache2
    
- Il faut créer un nouveau fichier de configuration qui va permettre de configurer le VirtualHost dédié à GLPI.
    
```nano /etc/apache2/sites-available/support.ekoloclast.fr.conf```
    
- Ajouter :
- <VirtualHost *:80>
    ServerName support.ekoloclast.fr

    DocumentRoot /var/www/glpi/public

    # If you want to place GLPI in a subfolder of your site (e.g. your virtual host is serving multiple applications),
    # you can use an Alias directive. If you do this, the DocumentRoot directive MUST NOT target the GLPI directory itself.
    # Alias "/glpi" "/var/www/glpi/public"

    <Directory /var/www/glpi/public>
        Require all granted

        RewriteEngine On

        # Redirect all requests to GLPI router, unless file exists.
        RewriteCond %{REQUEST_FILENAME} !-f
        RewriteRule ^(.*)$ index.php [QSA,L]
    </Directory>
</VirtualHost>
    
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S11/Ressources%20Install%20et%20configuration%20GLPI/Edition_fichier_virtualhost.png)
    
- Activer ce nouveau site dans Apache2.
    
```a2ensite support.ekoloclast.fr.conf```
    
- Désactiver le site par défault.
    
```a2dissite 000-default.conf```
    
- Activer le module "rewrite".
    
```a2enmod rewrite```
    
- Redémarrer le servive Apache2.
    
```systemctl restart apache2```
    
    
## 5.Utilisation de PHP8.2-FPM avec Apache2
    
- Installer PHP8.2-FPM.
    
```apt-get install php8.2-fpm```
    
- Activer deux modules dans Apache et la configuration de PHP-FPM.
    
```a2enmod proxy_fcgi setenvif```
```a2enconf php8.2-fpm```
```systemctl reload apache2```
    
- Configurer PHP-FPM pour Apache2.
    
```/etc/php/8.2/fpm/php.ini```
    
- Dans ce fichier, rechercher l'option "session.cookie_httponly" et indiquer la valeur "on" :
    
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S11/Ressources%20Install%20et%20configuration%20GLPI/Cookie.png)
    
- Redémarrer le servive PHP-FPM.
    
```systemctl restart php8.2-fpm.service```
    
- Modifier notre VirtualHost pour préciser à Apache2 que PHP-FPM doit être utilisé pour les fichiers PHP :
    
```/etc/apache2/sites-available/support.ekoloclast.fr.conf```
    
- Ce qui doit donner :
    
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S11/Ressources%20Install%20et%20configuration%20GLPI/Apache2-et-PHP-FPM-Exemple.png)
    
- Relancer Apache2
    
```systemctl restart apache2```
    
    
## 6.Installation de GLPI
    
- Pour effectuer l'installation de GLPI, il faut utiliser un navigateur Web afin d'accéder à l'adresse du GLPI l'adresse déclarée dans le fichier de configuration Apache2 (ServerName) :
    
- GLPI vérifie la configuration de notre serveur pour déterminer si tous les prérequis sont respectés :
    
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S11/Ressources%20Install%20et%20configuration%20GLPI/Installation-de-GLPI-Etape-3.png)
    
- Renseigner les informations pour acceder à la base de données :
    
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S11/Ressources%20Install%20et%20configuration%20GLPI/Installation-de-GLPI-Etape-4.png)
    
- Choisir la base de données "db23_glpi" :
    
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S11/Ressources%20Install%20et%20configuration%20GLPI/Installation-de-GLPI-Etape-5.png)
    
- Continuer jusqu'a à cette page et se connecter avec le compte "glpi" et le mot de passe "glpi" :
    
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S11/Ressources%20Install%20et%20configuration%20GLPI/Installation-de-GLPI-Etape-9.png)
    
- Pour Changer le mot de passe par default cliquer sur les nom de compte dans l'encadre orange.
    
- Supprimer le fichier "install.php".
    
```rm /var/www/glpi/install/install.php```
