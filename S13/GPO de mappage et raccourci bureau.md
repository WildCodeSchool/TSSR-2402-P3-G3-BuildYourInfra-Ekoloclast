# GPO de mappage des dossiers partagés et création du raccourci bureau

## Configuration du mappage

- Sélectionner `Tools` puis `Group Policy Management`
- Clic droit sur `Group Policy Objects` puis `New`
- Sélectionner `User Configuration` --> `Preferences` --> `Windows Settings` --> `Drive Maps`
- Suivre les instructions comme ci-dessous :

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S13/capture%20GPO%20Mapage%20et%20Shortcut/New%20mapped%20drive.png)

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S13/capture%20GPO%20Mapage%20et%20Shortcut/general%20mapped.png)

- Dans `Location`, indiquer le chemin du dossier partagé
- Dans `Label`, choisir le nom qui sera affiché

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S13/capture%20GPO%20Mapage%20et%20Shortcut/common%20mapped.png)

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S13/capture%20GPO%20Mapage%20et%20Shortcut/clik%20targetting.png)

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S13/capture%20GPO%20Mapage%20et%20Shortcut/security%20group.png)

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S13/capture%20GPO%20Mapage%20et%20Shortcut/target%20choice.png)

- Répéter l'opération pour chaque service et chaque département

## Création du raccourci bureau

- Sélectionner `Tools` puis `Group Policy Management`
- Clic droit sur `Group Policy Objects` puis `New`
- Sélectionner `User Configuration` --> `Preferences` --> `Windows Settings` --> `Shortcuts`
- Suivre les instructions comme ci-dessous :

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S13/capture%20GPO%20Mapage%20et%20Shortcut/neu%20shrtcut.png)

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S13/capture%20GPO%20Mapage%20et%20Shortcut/general%20shrtcut.png)

- Dans `Target Path`, indiquer le chemin du dossier partagé

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S13/capture%20GPO%20Mapage%20et%20Shortcut/shrt%20clik%20targeting.png)

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S13/capture%20GPO%20Mapage%20et%20Shortcut/shrt%20security%20group.png)

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S13/capture%20GPO%20Mapage%20et%20Shortcut/target%20choice.png)
