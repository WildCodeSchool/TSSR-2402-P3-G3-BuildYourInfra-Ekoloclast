# INSTALLATION ET CONFIGURATION SERVEUR GLPI
    
*Configuration serveur*
    
- Debian 12.0
- Carte réseaux en pont 
- Adresse IP Static en 192.168.0.5/24
    

## 1.Installer le socle LAMP
    
La première étape consiste à installer les paquets LAMP (Linux Apache2 MariaDB PHP).
    
<span style="color: red;">apt-get install apache2 php mariadb-server</span>
    
    
Ensuite, installer toutes les extensions nécessaires au bon fonctionnement de GLPI.
    
<span style="color: red;">sudo apt-get install php-xml php-common php-json php-mysql php-mbstring php-curl php-gd php-intl php-zip php-bz2 php-imap php-apcu</span>
    
    
Pour associer GLPI avec l'Active Directory, il faut installer l'extension LDAP de PHP.
    
<span style="color: red;">sudo apt-get install php-ldap</span>
    
    
    
## 2.Préparer la base de donné pour GLPI
    
Il faut préparer MariaDB pour qu'il puisse héberger la base de données de GLPI.
    
Pour commencer il faut effectuer.
    
<span style="color: red;">mysql_secure_installation</span>
    
Ici plusieurs option s'affiche pour une bonne configuration suivre l'exemple de l'image ci-dessous :
    
ce qui doit donner :
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/Ressources%20Install%20et%20configuration%20GLPI/Securiser-MariaDB-pour-GLPI.png)
    
Ensuite on se connecte à notre instance MariaDB.
    
<span style="color: red;">mysql -u root -p</span>
Saisire le mot de passe précédement definie.
    
Il faut maintenant exécuter les requêtes SQL ci-dessous pour créé la base de donné ici "glpi_23", ansi que l'utilisateur "glpi_adm".
    
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/Ressources%20Install%20et%20configuration%20GLPI/base_de_donner.png)
    
Ce qui doit donner :
    
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/Ressources%20Install%20et%20configuration%20GLPI/Creer-base-de-donnees-GLPI.png)
    
    
## 3.Télécharger GLPI et préparer son installation
    
Il faut maintenant télécharger l'archiver ".tgz" qui contient les sources d'installation de GLPI.
    
Se rendre dans le dossier /tmp
    
<span style="color: red;">cd /tmp</span>
    
Puis faire
<span style="color: red;">wget https://github.com/glpi-project/glpi/releases/download/10.0.15/glpi-10.0.15.tgz
</span>
    
Il faut ensuite decomprésser l'archive .tgz dans le dossier /var/www .
    
<span style="color: red;">tar -xzvf glpi-10.0.10.tgz -C /var/www/</span>
    
Définir l'utilisateur "www-data" correspondant à Appache2, en tant que propriétaire des fichiers GLPI
    
<span style="color: red;">chown www-data /var/www/glpi/ -R</span>
    
Il faut créer pluisieurs dossiers et sortir des données de la racine Web (/var/www/glpi) de manière à les stocker dans les nouveaux dossiers que nous allons créer.
    
Créer le répertoire "/etc/glpi" qui va recevoir les fichiers de configuration de GLPI.
    
<span style="color: red;">mkdir /etc/glpi</span>
<span style="color: red;">chown www-data /etc/glpi/</span>
    
déplacer le répertoire "config" de GLPI vers ce nouveau dossier.
    
<span style="color: red;">mv /var/www/glpi/config /etc/glpi</span>
    
répéter la même opération avec:
    
<span style="color: red;">mkdir /var/lib/glpi</span>
<span style="color: red;">chown www-data /var/lib/glpi/</span>
    
Déplacer le dossier "files".
    
<span style="color: red;">mv /var/www/glpi/files /var/lib/glpi</span>
    
terminer par créé le répertoire destiné à stocker les journaux de GLPI.
    
<span style="color: red;">mkdir /var/log/glpi</span>
<span style="color: red;">chown www-data /var/log/glpi</span>
    
Configurer GLPI pour qu'il sache où aller chercher les données.
    
créer ce premier fichier.
    
<span style="color: red;">nano /var/www/glpi/inc/downstream.php</span>
    
Ajouter le contenue ci dessous:
    
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/Ressources%20Install%20et%20configuration%20GLPI/Capture%20d%E2%80%99e%CC%81cran%202024-05-23%20a%CC%80%2013.36.26.png)
    
Ensuite, créé ce second fichier
    
<span style="color: red;">nano /etc/glpi/local_define.php</span>
    
Ajouter le contenue ci dessous :
    
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/Ressources%20Install%20et%20configuration%20GLPI/Fichier_php2.png)
    
    
## 4.Préparer la configuration Apache2
    
Il faut créer un nouveau fichier de configuration qui va permettre de configurer le VirtualHost dédié à GLPI.
    
<span style="color: red;">nano /etc/apache2/sites-available/support.ekoloclast.fr.conf</span>
    
Ajouter :
    
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/Ressources%20Install%20et%20configuration%20GLPI/Edition_fichier_virtualhost.png)
    
Activer ce nouveau site dans Apache2.
    
<span style="color: red;">a2ensite support.ekoloclast.fr.conf</span>
    
Désactiver le site par défault.
    
<span style="color: red;">a2dissite 000-default.conf</span>
    
Activer le module "rewrite".
    
<span style="color: red;">a2enmod rewrite</span>
    
Redémarrer le servive Apache2.
    
<span style="color: red;">systemctl restart apache2</span>
    
    
## 5.Utilisation de PHP8.2-FPM avec Apache2
    
Installer PHP8.2-FPM.
    
<span style="color: red;">apt-get install php8.2-fpm</span>
    
Activer deux modules dans Apache et la configuration de PHP-FPM.
    
<span style="color: red;">a2enmod proxy_fcgi setenvif</span>
<span style="color: red;">a2enconf php8.2-fpm</span>
<span style="color: red;">systemctl reload apache2</span>
    
configurer PHP-FPM pour Apache2.
    
<span style="color: red;">/etc/php/8.2/fpm/php.ini</span>
    
Dans ce fichier, rechercher l'option "session.cookie_httponly" et indiquer la valeur "on" :
    
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/Ressources%20Install%20et%20configuration%20GLPI/Cookie.png)
    
Redémarrer le servive PHP-FPM.
    
<span style="color: red;">systemctl restart php8.2-fpm.service</span>
    
Modifier notre VirtualHost pour préciser à Apache2 que PHP-FPM doit être utilisé pour les fichiers PHP :
    
<span style="color: red;">nano /etc/apache2/sites-available/support.ekoloclast.fr.conf</span>
    
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/Ressources%20Install%20et%20configuration%20GLPI/PHP_localhost.png)
    
Ce qui doit donner :
    
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/Ressources%20Install%20et%20configuration%20GLPI/Apache2-et-PHP-FPM-Exemple.png)
    
Relancer Apache2
    
<span style="color: red;">systemctl restart apache2</span>
    
    
## 6.Installation de GLPI
    
Pour effectuer l'installation de GLPI, il faut utiliser un navigateur Web afin d'accéder à l'adresse du GLPI l'adresse déclarée dans le fichier de configuration Apache2 (ServerName) :
    
GLPI vérifie la configuration de notre serveur pour déterminer si tous les prérequis sont respectés :
    
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/Ressources%20Install%20et%20configuration%20GLPI/Installation-de-GLPI-Etape-4.png)
    
Renseigner les informations pour acceder à la base de données :
    
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/Ressources%20Install%20et%20configuration%20GLPI/Installation-de-GLPI-Etape-4.png)
    
Choisir la base de données "db23_glpi" :
    
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/Ressources%20Install%20et%20configuration%20GLPI/Installation-de-GLPI-Etape-5.png)
    
Continuer j'usque à cette page et se connecter avec le compte "glpi" et le mot de passe "glpi" :
    
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/Ressources%20Install%20et%20configuration%20GLPI/Installation-de-GLPI-Etape-9.png)
    
Pour Changer le mot de passe par default en cliquant sur l'encadre orange.
    
Supprimer le fichier "install.php".
    
<span style="color: red;">rm /var/www/glpi/install/install.php</span>
