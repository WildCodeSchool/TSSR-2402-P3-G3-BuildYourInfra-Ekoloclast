## Installation 5 GPO standard

### 1. Déploiement logiciel 7-zip

Sur le serveur EKO-MSTR

- Télécharger le fichier .msi (64-bit Windows X64) sur https://www.7-zip.org/download.html

- Enregistrer le fichier ``7z2406-x64.msi`` dans le sossier partagé ``C:\Sources``

**Création de la GPO**

- Clic droit sur Group Policy Objects
- Nommé la GPO ``Computer-Dpl-7zip``
- Dans l'onglet Details → ``GPO Status : User configuration settings disabled``
- Computer Configuration → Policies  Software Settings → Software installation
- Dans la partie de droite clic avec le bouton droit de la souris et fait New → Package
- Choisir le fichier dans le dossier partagé  ``\\EKO-MSTR\Sources\7z2406-x64.msi``
- Lié cette GPO à l'OU LabOrdinateurs

### 2. Application fond d'écran de l'entreprise

**Création de la GPO**

- Clic droit sur Group Policy Objects
- Nommé la GPO ``User-Interface-Wallpaper``
- Dans l'onglet Details → ``GPO Status : Computer configuration settings disabled``
- User Configuration → Policies → Administrative Templates → Desktop → Desktop
- Desktop Wallpaper → Enabled 
- Choisir le fichier dans le dossier partagé  ``\\EKO-MSTR\Sources\wallpaper.jpg``
- Lié cette GPO à l'OU LabUtilisateurs

### 3. Installation et configuration Chrome

- Se rendre sur https://chromeenterprise.google/intl/fr_fr/browser/download/#windows-tab
- Choisir 
    - Canal : ``Stable``
    - Type de fichier : ``MSI``
    - Architecture : ``64 bits``
     - Télécharger

**Création de la GPO**

- Clic droit sur Group Policy Objects
- Nommé la GPO ``User-Dpl-Chrome``
- Dans l'onglet Details → ``GPO Status : Computer configuration settings disabled``

**Déploiement Chrome**
- User Configuration → Policies  Software Settings → Software installation
- Dans la partie de droite clic avec le bouton droit de la souris et fait New → Package
- Choisir le fichier dans le dossier partagé  ``\\EKO-MSTR\Sources\googlechrome.msi``
- Lié cette GPO à l'OU LabUtilisateurs 

**Configuration Chrome**

- Se rendre sur https://chromeenterprise.google/intl/fr_fr/browser/download/#windows-tab
 - Type de fichier : ``Paquet``
 - Télécharger

Copier les fichiers ADMX sur le serveur AD dans ``C:\PolicyDefinitions`` et copier les fichiers AML dans le dossier ``C:\PolicyDefinitions\en-US``

![policies](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S12/Ressources%20GPO%20Telemetrie/policies.PNG?raw=true)

On trouvera dans Administrative Template un nouveau dossier ``Google Chrome`` qui contient les Templates de Chrome.

- Administrative Templates → Google Chrome → Définir Google Chrome comme navigateur par défaut → ``Enabled``

- Administrative Templates → Google Chrome → Extensions → Configure extension installation bloclist → ``Enabled`` puis ajouter une ligne avec "*" pour toutes les extensions.

Lié la GPO à l'OU Utilisateurs.

**Vérifier sur un poste client que la GPO est bien appliquée.**

![extension](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S12/Ressources%20GPO%20Telemetrie/extension.PNG?raw=true)


