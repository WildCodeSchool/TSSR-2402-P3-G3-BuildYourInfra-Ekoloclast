## Instalation rôle WDS

### A. Installation


- Ouvrir le `Service Manager`.
- Aller dans `Manage` puis `Add Roles and Features`
- Cliquer sur `Next`
- Sélectionner `Role-based or feature-based installation` puis `Next`
- Sélectionner votre serveur et cliquer sur `Next`
- Choisir le rôle `Windows Deployment Service`, dans la fenêtre qui apparaît cliquer sur Add features
- Cliquer 4 fois sur Next en laissant les options par défaut
- Cliquer sur `Install` puis Close

### B. Configuration

- Cliquer sur le nœud Servers
- Sélectionner le serveur WDS et cliquer avec le bouton droit de la souris
- Sélectionner `Configure Server`
- Il y a un serveur DHCP, ici le service DHCP est sur le même serveur
- Il n'y a pas de rôle DNS, il n'y en a pas l'utilité ici
Une partition NTFS a été réservée pour le stockage des images
- Choisir l'emplacement du deuxième disque dur et cliquer sur `Next`
- Dans la fenêtre Proxy DHCP Server, laisser tout par défaut et cliquer sur `Next`.
- Une configuration automatique sera ajouté.
>Dans la fenêtre PXE Server Initial Settings, on va sélectionner le comportement du serveur WDS lorsqu'il recevra les requêtes des ordinateurs clients. Il peut soit les ignorer et ne pas répondre, soit répondre seulement aux clients connus, soit aux clients connus et inconnus.
- Pour ce lab, on sélectionnera `Respond to all client computers` et on ne coche pas la case en dessous.
- Après avoir cliquer sur Next la configuration de WDS s'effectue
- Quand elle est terminée, cliquer sur Finish
- Pour le lancer, faire un clic droit sur le nom du serveur, cliquer sur `All tasks` puis `Start`.
- Un message Successfully started Windows Deployment Services apparaît à la fin du lancement du service.

### B. Utilisation

Ouvrir la console de gestion WDS.

- Sélectionner le serveur WDS et dérouler l'arborescence de dossiers en dessous
- Faire un clic droit sur le dossier `Boot Images` et cliquez sur `Add Boot Image`
- Aller chercher dans le lecteur DVD, dans le dossier sources, sélectionner le fichier `Boot.wim`, cliquer sur Open puis Next
- Dans la fenêtre Image Et data tu peux changer le nom proposé par défaut pour l'image de démarrage
- Cliquer 2 fois sur Next puis Finish
- Sélectionner le serveur WDS et dérouler l'arborescence de dossiers en dessous
- Faire un clic droit sur le dossier `Install Images` et cliquez sur `Add Install Image`
- Dans la fenêtre Image Group on doit créer un groupe d'images. Donner un nom de groupe et cliquer sur Next
- Aller chercher dans le lecteur DVD, dans le dossier sources, sélectionner le fichier `install.wim`, cliquer sur Open puis Next
- Dans la fenêtre Available Image tu as la liste de toutes les images d'OS contenues dans le fichier WIM.
- Sélectionne celle(s) que tu veux et clique sur Next.
- Cliquer 2 fois sur Next puis `Finish`

**Depuis un poste client Windows, nous allons installer l'image**

![entrée](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S15/Capture%20WDS/1.entr%C3%A9.PNG?raw=true)

![install](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S15/Capture%20WDS/2.install.PNG?raw=true)

![os](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S15/Capture%20WDS/3.os.PNG?raw=true)

![ii](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S15/Capture%20WDS/install.PNG?raw=true)

