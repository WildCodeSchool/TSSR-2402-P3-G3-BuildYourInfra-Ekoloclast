# TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast

- Présentation du projet & Objectifs finaux
- Introduction : Mise en contexte
- Membres du groupe de projet & Rôles par sprint


## Présentation du projet

En qualité de nouveaux membres de la DSI au sein de la société Ekoloclast, notre projet consistera à créer et gérer une infrastructure réseau répondant à ses besoins.

## Introduction : Mise en contexte

Fondée il y a moins de deux ans, Ekoloclast est une start-up innovante située à Paris dans le 8 ème arrondissement.

Elle ambitionne de révolutionner l’approche écologique avec l’introduction de nouveaux produits et services bénéficiant à la fois à l'environnement et aux individus.
Récemment l’entreprise a réussi une levée de fonds significative, ce qui la positionne pour une expansion prometteuse.

Dans le contexte actuel, Ekoloclast est composée de 183 collaborateurs répartis en dix départements. Cependant une future fusion/acquisition est prévue dans les prochain mois.

Chaque collaborateur est équipé d'un ordinateur portable en WORKGOUP sous le plan d'addressage 192.168.10.0/24 (accès internet par FAI). Il n'y a actuellement aucune gestion de sauvegarde de données, nous identifions aussi l'abscence de politique de sécurité au sein du groupe.

## Membres du groupe de projet & Rôles par sprint

| Sprint  |  Team   | Nicolas | Luca | Patrick | Grégory |
|   :---------: |  :-------: | :---------: |  :-------: | :-------: |  :-------:  |
| 09 |  Analyse des besoins techniques - Choix Nomenclature et Plan IP| **PO** - Schema réseau | **SM** - Arborescence AD | Script fichier csv | Prépa VM et AD |
| 10 |  Configuration AD DS | Sript de création arborecense AD | Création et configuration Serveur Core Master - Edition du fichier README| **PO** - Script pour fichier CSV - Création poste client | **SM** - Création et configuration du Serveur maître en GUI - Edition du fichier Install.MD
| 11 |   /   | Finalisation Script de création des OU/groupes et Ajout des utilisateurs | **PO** Installation et configuration Serveur GLPI - Documentation serveur GLPI | Installation et configuration serveur GLPI - Script automatisation de configuration serveur GLPI | **SM** Création des GPO - Documentation des GPO
| 12 |   /   | **PO** - Configuration du pare-feu Pfsense - mise en place de règle | **SM** - Création et documentation des GPO de gestion de télémétrie | Finition GLPI + Doc - Support sur les autres tâches |  Installation et configuration du routeur VYOS - Documentation |
| 13 |  Mappage des lecteurs   | Mise en place des dossiers partagés | Mise en place sauvegarde de volume| **SM** - Mise en place restriction d'utilisation des machines (plage horaire) | **PO** Mise en place de LAPS |
| 14 |  / | **SM** - Mise en place de PRTG pour la supervision, Déplacement machines dans l’AD | Mise en place des logs et mise à jour des scripts | **PO** - Gestion AD : Modification, Ajout | Mise en place du raid & création du serveur RDS |
| 15 |  / | **PO** - Mise en place de Zimbra pour la messagerie | Mise en place du logiciel Bitwarden | **SM** - Mise en place de Redmine pour le suivi du projet | Mise en place du logiciel Bitwarden + WDS |


## Difficultés rencontrées & Solutions trouvées

|  Sprint  |  Problèmes  |  Solution  |
| :-------:| :----------:| :---------:|
|    09    |      /      |     /      |
|    10    | Problème pour retiré les accents du fichier CSV | Solution trouvé sur le site IT-connect |           
|    11    | Problèmes de versions GLPI apres supression de l'ancienne version | Recommencer l'installation du début |
|    12    | Problème avec le DHCP superscope | En attendant la résolution, les adresses IP des postes clients sont renseignés manuellement |
|    13    | Accès à Proxmox non optimal  - Problème dans l'installation  de bareOS | Une partie des objectifs ont été réalisés sur Virtualbox - Aucune pour l'instant|


## Serveurs :

| Nom  | Fonction | Adresse IP |
| ----- | ------ | -------|
| EKO-MSTR | Serveur ADDS/DNS/DHCP | 192.168.0.2 |
| EKO-CORE | Serveur DC | 192.168.0.3 |
| DEBIAN-SSH-BITWARDEN| Serveur SSH |192.168.0.4 |
| DEBIAN-GLPI | Serveur GLPI | 192.168.0.5 |
| PRTG | Serveur Supervision | 192.168.0.6 |
| EKO-RDS-WDS | Serveur RDS/WDS | 192.168.0.7 |
| EKO-ZIMBRA | Serveur Messagerie | 192.168.0.8 |
| EKO-VyOSRouteur | Routeur | 192.168.0.253 |
| pfsense | Firewall | 198.168.0.254 |


