# Mise en place de LAPS

### 1. Installation

- Sur le serveur DC EKO-MSTR télécharger le logiciel ``LAPS.x64.msi`` sur https://www.microsoft.com/en-us/download/details.aspx?id=46899

![logiciel](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S13/capture%20LAPS/logiciel.PNG?raw=true)

- Exécutez le fichier d'installation et suivez les instructions à l'écran.
- Sélectionnez l'option "Installer LAPS sur ce serveur uniquement".



![2.installation](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S13/capture%20LAPS/2.installation.PNG?raw=true)

- Fat client UI : outil graphique pour la gestion de LAPS
- PowerShell module : commandes PowerShell pour LAPS
- GPO Editor templates : modèle ADMX de LAPS



### 2. Configuration

A. Mettre à jour le schéma Active Directory

- Exécutez la commande suivante pour importer le module PowerShell de LAPS :
```powershell
Import-Module AdmPwd.PS
```
- Ensuite, exécuter la commande ci-dessous pour mettre à jour le schéma AD :
```powershell
Update-AdmPwdADSchema
```

![powershell](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S13/capture%20LAPS/powershell.PNG?raw=true)

B. Attribuer les droits d'écriture aux machines
```powershell
Set-AdmPwdComputerSelfPermission -OrgUnit "OU=LabOrdinateurs,DC=ekoloclast,DC=fr"
```
_On obtient un retour dans la console avec le statut "Delegated"_


"
C. Ajouter des autorisations de lire le mot de passe LAPS
```powershell
Set-AdmPwdReadPasswordPermission -Identity "OU=LabOrdinateurs,DC=ekoloclast,DC=fr" -AllowedPrincipals "GrpSecuriteMdp"
```

D. Ajouter des autorisations de réinitialisation le mot de passe LAPS
```powershell
Set-AdmPwdResetPasswordPermission -Identity "OU=LabOrdinateurs,DC=ekoloclast,DC=fr" -AllowedPrincipals "GrpSecuriteMdp"
```

![delegated](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S13/capture%20LAPS/delegated.PNG?raw=true)


# Configuration de la GPO LAPS

### 1. GPO configuration :
- Dans la console Group Policy Management
- Ajouter une nouvelle GPO -> ``Computer-Laps-Config``
- Clic droit Edit
- Computer configuration - Policies - Administrative templates - LAPS 
- Password Settings -> Enabled
    - Password length  : ``14``
    -  Password Age : ``7``
- Do not allow password expiration time longer than required by policy -> Enabled
- Enable local admin password management -> Enabled
- GPO status : User configuration settings disabled

Lié cette GPO à l'OU LabOrdinateurs

### 2. GPO déploiement :

Mettre le fichier ``LAPS.x64.msi`` dans le fichier partagé ``\\EKO-MSTR\Sources``

- Dans la console Group Policy Management
- Ajouter une nouvelle GPO -> ``Computer-Laps-Dlp``
- Clic droit Edit
- Computer configuration - Policies - Software Settings - Software Installation
- Clic droit New -> Package -> choisir ``\\EKO-MSTR\SourcesLAPS.x64.msi``
- GPO status : User configuration settings disabled

Lié cette GPO à l'OU LabOrdinateurs

Sur un poste client forcer la maj en lançant ``gpupdate /force`` dans l'invit de commande puis redémarrer la machine.

Sur le serveur EKO-MSTR, utiliser le logiciel LAPS UI et choisir un poste client, le mot de passe du compte Administrator local s'affichera.

![mdplocal](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S13/capture%20LAPS/mdplocal.PNG?raw=true)

