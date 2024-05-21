# Installation GPO Sécurité

## 1. Blocage l'accès au panneau de configuration

Créer le groupe ``GrpUsersWindowsRestrictions`` dans l'OU LabSecurité.

![grpcontrolpanel](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S11/captureGPO/GRPcontrolpanel.PNG?raw=true)

Accèder à l'interface de gestion des GPO : 

- Cliquer sur ``Tools`` puis ``Group Policy Management``
- Dans le dossier Group Policy Objects clic droit puis New
- Nommer la GPO **"User-Security-ControlPanel-Deny"**
- Dans l'onglet Scope partie Security Filtering supprimer ``Authenticated Users`` et ajouter les groupes ``GrpUsersWindowsRestrictions`` et ``Domain Computers``


![scope](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S11/captureGPO/Scope.PNG?raw=true)

- Cette GPO s'appliquera sur les utilisateurs, dans l'onglet détail choisir  ``GPO Statuts : Computer configuration settings disabled``
- Clic droit sur la GPO puis ``Edit``
- User Configuration → Policies → Administrative Templates → Control Panel
- Double clic sur ``Prohibit access to Control Panel and PC settings``
- Selectionner ``Enabled`` et OK

![enabled](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S11/captureGPO/enabled.PNG?raw=true)

- Lier cette GPO à l'OU LabUtilisateurs : clic droit puis "Link an Existing GPO"

**La GPO est bien liée à l'OU LabUtilisateurs.**

![link](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S11/captureGPO/link.PNG?raw=true)


## 2. Politique de mot de passe

Créer le groupe ``GrpComputersPasswordPolicy`` dans l'OU LabSecurité.

- Cliquer sur ``Tools`` puis ``Group Policy Management``
- Dans le dossier Group Policy Objects clic droit puis New
- Nommer la GPO "Computeur-Password-Policy"
- Dans l'onglet Scope partie Security Filtering supprimer ``Authenticated Users`` et ajouter les groupes ``GrpComputersPasswordPolicy`` et ``Domain Computers``
- Cette GPO s'appliquera sur les ordinateurs, dans l'onglet détail choisir  ``GPO Statuts : User configuration settings disabled``
- Clic droit sur la GPO puis ``Edit``
- **Computeur Configuration → Policies → Windows Settings → Security Settings → Account Policy → Password Policy**

   > - **Enforce password history** → 12 _(L'utilisateur doit définir 12 mots de passe différents pour pouvoir en réutiliser un)_
   > - **Maximum password age** → 60 days _(Le mdp doit être changé au bout de 60 jours)_
   > - **Minimum password age** → 30 days _(La durée minimale du mdp est de 30 jours)_
   > - `**Minimum password length** → 8 characters _(8 digit minimum)_
   > - **Password must meet complexity requirements** → Enabled _(Le mdp doit comprendre au moins une lettre majuscule, une lettre minuscule, un chiffre ert un caractère spécial)_

![password](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S11/captureGPO/password.PNG?raw=true)

- Lier cette GPO à l'OU LabOrdinateurs : clic droit puis "Link an Existing GPO"


## 3. Verrouillage de compte (suite à 5 mots de passe erronés)

Créer le groupe ``GrpComputersLock` dans l'OU LabSecurité.

- Cliquer sur ``Tools`` puis ``Group Policy Management``
- Dans le dossier Group Policy Objects clic droit puis New
- Nommer la GPO "Computeur-Lock-Account"
- Dans l'onglet Scope partie Security Filtering supprimer ``Authenticated Users`` et ajouter les groupes ``GrpComputersLock`` et ``Domain Computers``
- Cette GPO s'appliquera sur les ordinateurs, dans l'onglet détail choisir  ``GPO Statuts : User configuration settings disabled``
- Clic droit sur la GPO puis ``Edit``
- **Computeur Configuration → Policies → Windows Settings → Security Settings → Account Policy → Account Lockout Policy**

   > - **Account lockout duration** → 45 minutes _(Après 5 tentatives e mdp, le compte sera vérouiller pendant 45 minutes)_
   > - **Account lockout threshold** → 5 invalid logon attempts _(Le compte se vérouille après 5 tentatives incorrectes)_
   > - `**Reset Lockout counter after** → 15 minutes _(Le compteur du mot de passe érroné revient à 0 au bout de 15 minutes)_


- Lier cette GPO à l'OU LabOrdinateurs : clic droit puis "Link an Existing GPO"

## 4. Blocage accès à la base de registre

Créer le groupe ``GrpUsersRegistryRestrictions` dans l'OU LabSecurité.

Accèder à l'interface de gestion des GPO : 

- Cliquer sur ``Tools`` puis ``Group Policy Management``
- Dans le dossier Group Policy Objects clic droit puis New
- Nommer la GPO **"User-Registry-Deny"**
- Dans l'onglet Scope partie Security Filtering supprimer ``Authenticated Users`` et ajouter les groupes ``GrpUsersRegistryRestrictions`` et ``Domain Computers``
- Cette GPO s'appliquera sur les utilisateurs, dans l'onglet détail choisir  ``GPO Statuts : Computer configuration settings disabled``
- Clic droit sur la GPO puis ``Edit``
- User Configuration → Policies → Administrative Templates → System
- Double clic sur ``Prevent access to registry editing tools``
- Selectionner ``Enabled`` et OK


- Lier cette GPO à l'OU LabUtilisateurs : clic droit puis "Link an Existing GPO"

**La GPO est bien liée à l'OU LabUtilisateurs.**

## 5. Restriction d'installation de logiciel pour les utilisateurs non-administrateurs

Créer le groupe ``GrpComputerSoftwareRestrictions` dans l'OU LabSecurité.

- Cliquer sur ``Tools`` puis ``Group Policy Management``
- Dans le dossier Group Policy Objects clic droit puis New
- Nommer la GPO **"Computeur-SoftwareRsestriction-Disallowed"**
- Dans l'onglet Scope partie Security Filtering supprimer ``Authenticated Users`` et ajouter les groupes ``GrpComputerSoftwareRestrictions`` et ``Domain Computers``
- Cette GPO s'appliquera sur les ordinateurs, dans l'onglet détail choisir  ``GPO Statuts : User configuration settings disabled``
- Clic droit sur la GPO puis ``Edit``
- **Computeur Configuration → Policies → Windows Settings → Security Settings → Clic droit sur Software Restriction Policy → New Software Rstriction Policies**

    - Security Level
    - Urnestricted → ``Set as Default``

![unrestricted](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S11/captureGPO/unrestricted.PNG?raw=true)

- Lier cette GPO à l'OU LabOrdinateurs : clic droit puis "Link an Existing GPO"
