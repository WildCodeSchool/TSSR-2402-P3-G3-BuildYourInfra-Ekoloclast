### Installer prerequis pour Apache et Guacamole
  
- Installer un ensemble de paquets indispensables au bon fonctionnement d'Apache Guacamole.  
- Commencer par `sudo apt update`  
- Puis `sudo apt-get install build-essential libcairo2-dev libjpeg62-turbo-dev libpng-dev libtool-bin uuid-dev libossp-uuid-dev libavcodec-dev libavformat-dev libavutil-dev libswscale-dev freerdp2-dev libpango1.0-dev libssh2-1-dev libtelnet-dev libvncserver-dev libwebsockets-dev libpulse-dev libssl-dev libvorbis-dev libwebp-dev`
- Attendre la fin de l'installation
  
### Complier et installer Apache Guacamole "Server"
  
- Se positionner dans le répertoire "/tmp" et télécharger l'archive tar.gz  
`cd/tmp`     
`wget https://downloads.apache.org/guacamole/1.5.5/source/guacamole-server-1.5.5.tar.gz`
  
- Une fois le téléchargement terminé, on décompresse l'archive tar.gz puis on se positionne dans le répertoire obtenue.  
`tar -xzf guacamole-server-1.5.5.tar.gz`  
`cd guacamole-server-1.5.5/`
  
- Preparer la Compilation  
`sudo ./configure --with-init-dir=/etc/init.d` 
- Verifier la sortie de la commande
  
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S17/Ressources%20Guacamole/Compilation-configure.png)
  
  
  
- Compiler le code source de guacamole-server  
`sudo make`
- Installer le composant Guacamole Server  
`sudo make instal``
  
- Mettre a jour les liens entre guacamole-server et les librairies  
`sudo ldconfig`
  
- Demarrer le service "guacd" correspondant à Guacamole et activer son demarrage automatique  
`sudo systemctl daemon-reload`  
`sudo systemctl start guacd`  
`sudo systemctl enable guacd`  
  
- Verifier le statu Apache Guacamole Server  
`sudo systemctl status guacd`  
  
- Cree l'arborescence pour la configuration d'Apache Guacamole.  
`sudo mkdir -p /etc/guacamole/{extensions,lib}`
  
  
### Installer Guacamole Client (Web App)  
  
- Pour utiliser guacamole via l'interface web il faut utilser tomcat9, mais sur les systemes debian12 seul tomcat10 est disponnible pour palier a cela il faut ajouter le depot debian11

- Il faut d'abord jouter le depot suivant à votre source.list:  
`sudo nano /etc/apt/sources.list.d/bullseye.list`   
`deb http://deb.debian.org/debian/ bullseye main `
  
- Installer Tomcat9  
`sudo apt-get install tomcat9 tomcat9-admin tomcat9-common tomcat9-user` 
  
- Telecharger la derniere version de la Web App d'Apache Guacamole depuis le depot officiel (même endroit que pour la partie serveur). On se positionne dans "/tmp" et télécharger la Web App  
`cd /tmp`  
`wget https://downloads.apache.org/guacamole/1.5.5/binary/guacamole-1.5.5.war`  
  
- Supprimer le depot debian 11 pour eviter les conflits lors des maj de paquets  
`sudo rm -r /etc/apt/sources.list.d/bullseye.list`  

- Se deplacer dans la librairie de Web App de Tomcat9  
`sudo mv guacamole-1.5.5.war /var/lib/tomcat9/webapps/guacamole.war`
  
- Puis relancer les services Tomcat9 et Guacamole  
`sudo systemctl restart tomcat9 guacd`
  
### Base de donees MariaDB
  
- Installer le paquet MariaDB Server  
`sudo apt-get install mariadb-server`
  
- executer le script ci-dessous pour sécuriser un minimum notre instance  
`sudo mysql_secure_installation`
  
- Se connecter en tant que root à notre instance MariaDB  
`mysql -u root -p`
  
- Les commandes ci-dessous permettent de créer la base de donnees "guacadb", avec l'utilisateur "guaca_nachos" associé au mot de passe "P@ssword!"  
`CREATE DATABASE guacadb;`  
`CREATE USER   'guaca_nachos'@'localhost' IDENTIFIED BY 'P@ssword!';`   
`GRANT SELECT,INSERT,UPDATE,DELETE ON guacadb.* TO 'guaca_nachos'@'localhost';`     
`FLUSH PRIVILEGES;`   
`EXIT;`
  
- Depuis le depot officiel,telecharger cette extension.  
`cd /tmp`  
`wget https://downloads.apache.org/guacamole/1.5.5/binary/guacamole-auth-jdbc-1.5.5.tar.gz`  
  
- Decompresser l'archive tar.gz  
`tar -xzf guacamole-auth-jdbc-1.5.5.tar.gz`  
  
- Deplacer le fichier ".jar" de l'extension dans le répertoire "/etc/guacamole/extensions/"  
`sudo mv guacamole-auth-jdbc-1.5.5/mysql/guacamole-auth-jdbc-mysql-1.5.5.jar /etc/guacamole/extensions/`  
  
- Le connecteur MySQL doit être téléchargé depuis le site de MySQL  
`cd /tmp`  
`wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-j-9.0.0.tar.gz`
  
- Decompresse l'archive tar.gz  
`tar -xzf mysql-connector-j-9.0.0.tar.gz`
  
- Copier le fichier .jar du connecteur vers le repertoire "lib" de Apache guacamole  
`sudo cp mysql-connector-j-9.0.0/mysql-connector-j-9.0.0.jar /etc/guacamole/lib/`  
  
- Importer la structure de la base de donnees Apache Guacamole dans notre base de données "guacadb"  
`cd guacamole-auth-jdbc-1.5.2/mysql/schema/`  
`cat *.sql | mysql -u root -p guacadb` 
  
- Creer et editer le fichier "guacamole.properties" pour declarer la connexion à MariaDB  
`sudo nano /etc/guacamole/guacamole.properties`  
- Inserer les lignes ci-dessous  
```
# MySQL  
mysql-hostname: 127.0.0.1  
mysql-port: 3306  
mysql-database: guacadb  
mysql-username: guaca_nachos  
mysql-password: P@ssword!
```
  
- Editer le fichier "guacd.conf" pour déclarer le serveur Guacamole  
`sudo nano /etc/guacamole/guacd.conf`  
  
- Inserer les lignes ci-dessous  
```
[server] 
bind_host = 0.0.0.0
bind_port = 4822
```
  
- Redemarrer les trois services lies à Apache Guacamole  
`sudo systemctl restart tomcat9 guacd mariadb`  

