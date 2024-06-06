# Mise en place de la sauvegarde du volume de partage de fichiers

## Prérequis

- Disque dur supplémentaire non formaté pour la sauvegarde du volume

## Installer le rôle de Serveur Backup

- Sélectionner `Manage` --> `Add Roles and features`
- Sélectionner les paramètres de votre serveur, puis cocher la case `Windows Server Backup`

![Ajouter les rôles et fonctionnalités](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S13/BackupInstall%20Capture/role%20serveur.png)

- Sélectionner `Next` puis `Finish`

## Créer la partition qui accueillera la sauvegarde

- Sélectionner `Tools` --> `Computer Management`
- Sélectionner `Disk Management`

![Gestion des disques](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S13/BackupInstall%20Capture/partition.png)

- Clic droit sur le nouveau disque puis sélectionner `Initialize`
- Clic droit sur le nouveau disque puis sur nouvelle partition, laisser les paramètres par défaut jusqu'au choix de la lettre
- Choisir un nom de label puis terminer

## Créer la planification de sauvegarde

- Sur le Server Manager, sélectionner `Tools` --> `Windows Server Backup`
- Sélectionner `Backup Schedule Wizard`
- Sélectionner `Custom`
- Sélectionner `Add Items` puis sélectionner le lecteur à sauvegarder
- Paramétrer les options selon votre choix
- Sélectionner `Back up to a volume`
- Sélectionner `Add Items` puis sélectionner le lecteur où seront sauvegardées les données
- Sélectionner `Keep the volume destination` puis terminer

![Planification de sauvegarde](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S13/BackupInstall%20Capture/backup%20confir.png)
