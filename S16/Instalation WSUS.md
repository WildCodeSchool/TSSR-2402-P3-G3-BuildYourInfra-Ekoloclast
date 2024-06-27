
### Prerequis
  
- il est conseille d'utiliser un volume dedie qui acceuillera les donnes WSUS
  
## Installation du Service WSUS
  
- Ouvrer le serveur manager puis se rendre sur`Add Roles and Features`
- Cocher `Windows Update Services`, selectionner `Next`
- Sur `Roles Service` cocher `WID Connectivity` et `WSUS Service`
- Entrer le chemin du volume dedie au donnes WSUS
- Selectionner `Next`puis `Install`
- En haut a droite de l'ecran selectionner l'onglet `Notifications` --> `Launch Post-Installation task`
  
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S16/Ressources-WSUS/Notification%20acces.png)
  
- Cette notification doit apparaitre
  
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S16/Ressources-WSUS/valid%20notification.png)
  
  
## Configuration 

- Dans le `Windows Shearch desktop` taper "WSUS" puis double cliques sur l'application
- Selectionner `Next` 
- Decocher l'option ci-dessous 
  
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S16/Ressources-WSUS/Decocher%20yes.png)
  
- Garder l'option `Synchronize from Microsoft Update` puis `Next`
- Cliquer sur `Start Connecting`
- Choisir les langues voulues 
  
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S16/Ressources-WSUS/language%20.png)
  
- Choisir les produits voulues
- Selectionner la classification 
  
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S16/Ressources-WSUS/classification.png)
  
- Determiner si les mise a jour seront automatique ou manuel
- Terminer l'installation
  
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S16/Ressources-WSUS/finished.png)
  
  
## GPO pour lier les PC et Serveurs à WSUS
  
### GPO pour les parametres communs
  
Cette GPO est lier à la racine du domaine

- Dans le serveur manager cliquer sur `tools` puis `Group Policy Management`
- Clique droit puis `New`, Nommer la GPO
- Clique droit puis `Edit` sur cette nouvelle GPO
- Se rendre sur 'Computer configuration' --> `Policies` --> `Administrative templates` --> `Windows Components` --> 'Windows Update`
- Selectionner `Configure Automatic Updates` puis `Enabled`
- Suivre la configuration ci-dessous :
  
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S16/Ressources-WSUS/Common%20setting.jpeg)
  
- Selectionner `Do not connect to any Windows update Internet locations` puis `Enabled` 
- Selectionner 'Specify intranet Microsoft upadate service location`
- Suivre la configuration ci-dessous :
  
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S16/Ressources-WSUS/Common%20settings%202.png)
  
### GPO pour chaques OU du LabOrdinateurs

Cette GPO sera lier à L'OU "Communication" dans le LabOrdinateurs, il est necessaire de faire une GPO pour chaque OU presente dans le LabOrdinateurs

- Se rendre sur `Computer configuration` --> `Policies` --> `Administrative templates` --> `Windows Components` --> 'Windows Update`
- Selectionner `Enable client-side targeting` puis `Enabled`
- Selectionner `Turn off auto-restart for updates during active hours`, indiquer les heurs d'activite de la societe 
  
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S16/Ressources-WSUS/Comuni.png)
  
### GPO pour les serveurs 

Cette GPO ser lier à l'OU "Dommain Controller` ainsi que l'OU ou sont placer les serveurs

- Se rendre sur `Computer configuration` --> `Policies` --> `Administrative templates` --> `Windows Components` --> 'Windows Update`
- Selectionner `Enable client-side targeting` puis `Enabled`
- Selectionner `Turn off auto-restart for updates during active hours`, indiquer les heures d'activite des serveurs, il est important de prevoir une plage plus large que la periode d'activiter definie pour les ordinateurs
  
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S16/Ressources-WSUS/Servers.png)
  
