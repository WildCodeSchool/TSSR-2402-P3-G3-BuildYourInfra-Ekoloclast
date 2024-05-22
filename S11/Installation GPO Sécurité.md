# Installation GPO Sécurité

## 1. Blocage accès au panneau de configuration



Accèder à l'interface de gestion des GPO : 

- Cliquer sur ``Tools`` puis ``Group Policy Management``
- Dans le dossier Group Policy Objects clic droit puis New
- Nommer la GPO **"User-Security-ControlPanel-Deny"**
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


- Cliquer sur ``Tools`` puis ``Group Policy Management``
- Dans le dossier Group Policy Objects clic droit puis New
- Nommer la GPO "Computeur-Password-Policy"
- Cette GPO s'appliquera sur les ordinateurs, dans l'onglet détail choisir  ``GPO Statuts : User configuration settings disabled``
- Clic droit sur la GPO puis ``Edit``
- **Computeur Configuration → Policies → Windows Settings → Security Settings → Account Policy → Password Policy**

| Action | Paramètre | Statut |
| ------ | ------- | ------ |
| L'utilisateur doit définir 12 mots de passe différents pour pouvoir en réutiliser un | Enforce password history| Cocher : ``Define this policy setting`` → 12  |
| Le mdp doit être changé au bout de 60 jours | Maximum password age| Cocher : ``Define this policy setting`` → 60 |
| La durée minimale du mdp est de 30 jours | Minimum password age | Cocher : ``Define this policy setting`` → 30 |
| Le mdp doit contenir 8 charactères au minimum | Minimum password length | Cocher : ``Define this policy setting`` → 8 |
| Le mdp doit comprendre au moins une lettre majuscule, une lettre minuscule, un chiffre ert un caractère spécial | Password must meet complexity requirements| Cocher : ``Define this policy setting`` → Enabled|
| Désactiver le stockage des mots de passe | Store passwords using reversible encryption | Disabled |

![password](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S11/captureGPO/password.PNG?raw=true)

- Lier cette GPO à l'OU LabOrdinateurs : clic droit puis "Link an Existing GPO"


## 3. Verrouillage de compte (suite à 5 mots de passe erronés)


- Cliquer sur ``Tools`` puis ``Group Policy Management``
- Dans le dossier Group Policy Objects clic droit puis New
- Nommer la GPO "Computeur-Lock-Account"
- Cette GPO s'appliquera sur les ordinateurs, dans l'onglet détail choisir  ``GPO Statuts : User configuration settings disabled``
- Clic droit sur la GPO puis ``Edit``
- **Computeur Configuration → Policies → Windows Settings → Security Settings → Account Policy → Account Lockout Policy**

| Action | Paramètre | Statut |
| ------ | ------- | ------ |
| Après 5 tentatives de mdp, le compte sera vérouiller pendant 45 minutes | Account lockout duration| Cocher : ``Define this policy setting`` → 45 minutes  |
| Le compte se vérouille après 5 tentatives incorrectes | Account lockout threshold| Cocher : ``Define this policy setting`` → 5 invalid logon |
| Le compteur du mot de passe érroné revient à 0 au bout de 15 minutes | Reset Lockout counter after | Cocher : ``Define this policy setting`` → 15 minutes |

- Lier cette GPO à l'OU LabOrdinateurs : clic droit puis "Link an Existing GPO"

## 4. Blocage accès à la base de registre


Accèder à l'interface de gestion des GPO : 

- Cliquer sur ``Tools`` puis ``Group Policy Management``
- Dans le dossier Group Policy Objects clic droit puis New
- Nommer la GPO **"User-Registry-Deny"**
- Cette GPO s'appliquera sur les utilisateurs, dans l'onglet détail choisir  ``GPO Statuts : Computer configuration settings disabled``
- Clic droit sur la GPO puis ``Edit``
- User Configuration → Policies → Administrative Templates → System
- Double clic sur ``Prevent access to registry editing tools``
- Selectionner ``Enabled`` et OK


- Lier cette GPO à l'OU LabUtilisateurs : clic droit puis "Link an Existing GPO"


## 5. Restriction d'installation de logiciel pour les utilisateurs non-administrateurs
git

- Cliquer sur ``Tools`` puis ``Group Policy Management``
- Dans le dossier Group Policy Objects clic droit puis New
- Nommer la GPO **"Computeur-SoftwareRsestriction-Disallowed"**
- Cette GPO s'appliquera sur les ordinateurs, dans l'onglet détail choisir  ``GPO Statuts : User configuration settings disabled``
- Clic droit sur la GPO puis ``Edit``
- **Computeur Configuration → Policies → Windows Settings → Security Settings → Clic droit sur Software Restriction Policy → New Software Rstriction Policies**

    - Security Level
    - Urnestricted → ``Set as Default``

![unrestricted](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S11/captureGPO/unrestricted.PNG?raw=true)

- Lier cette GPO à l'OU LabOrdinateurs : clic droit puis "Link an Existing GPO"

## 6. Gestion de Windows update

- Cliquer sur ``Tools`` puis ``Group Policy Management``
- Dans le dossier Group Policy Objects clic droit puis New
- Nommer la GPO **"Computeur-WindowsUpdate-Configuration"**
- Cette GPO s'appliquera sur les ordinateurs, dans l'onglet détail choisir  ``GPO Statuts : User configuration settings disabled``
- Clic droit sur la GPO puis ``Edit``
- **Computeur Configuration → Policies → Administrative Templates → Windows Components → Windows Update**

| Action | Paramètre | Statut |
| ------ | ------- | ------ |
| Téléchargement automatique et notification d'installation | Configure Automatic Updates| Enabled → 3 - Auto download and notify for install|
|Configure un délai avant qu'un redémarrage automatique ne soit effectué après l'installation des mises à jour. Cela donne aux utilisateurs le temps de sauvegarder leur travail| Delay Restart for scheduled installations | Enabled → Restart (minutes) = 30 |
| Afficher un rappel de redémarrage pour les mises à jour installées| Display options for update notifications | Enabled|
| Empêche le redémarrage automatique si des utilisateurs sont connectés, même si une mise à jour nécessite un redémarrage. | No auto-restart with logged on users for scheduled automatic updates installations | Enabled |
| Configure les rappels de redémarrage pour les mises à jour qui doivent être installées avant une date limite| Configure auto-restart reminder notifications for updates | Enabled |

- Lier cette GPO à l'OU LabOrdinateurs : clic droit puis "Link an Existing GPO"

## 7. Gestion écran de veille avec mot de passe en sortie

Accèder à l'interface de gestion des GPO : 

- Cliquer sur ``Tools`` puis ``Group Policy Management``
- Dans le dossier Group Policy Objects clic droit puis New
- Nommer la GPO **"User-ScreenSaver-Enable"**
- Cette GPO s'appliquera sur les utilisateurs, dans l'onglet détail choisir  ``GPO Statuts : Computer configuration settings disabled``
- Clic droit sur la GPO puis ``Edit``
- User Configuration → Policies → Administrative Templates → Control Panel → Personalization
   
| Action | Paramètre | Statut |
| ------ | ------- | ------ |
| L'écran de veille sera activé selon les paramètres définis dans les autres options (comme le délai d'inactivité) | Enable screen saver| Enabled |
|Les utilisateurs devront entrer leur mot de passe pour reprendre leur session après que l'écran de veille s'est activé| Password protect the screen saver | Enabled  |
| L'écran de veille s'active automatiquement après le nombre de secondes spécifié d'inactivité de l'utilisateur | Screen saver timeout | Enabled → Seconds : 600 |

- Lier cette GPO à l'OU LabUtilisateurs : clic droit puis "Link an Existing GPO"

## 8. Désactiver le compte invité

Accèder à l'interface de gestion des GPO : 

- Cliquer sur ``Tools`` puis ``Group Policy Management``
- Dans le dossier Group Policy Objects clic droit puis New
- Nommer la GPO **"Computeur-GuestAcount-Disable"**
- Cette GPO s'appliquera sur les ordinateurs, dans l'onglet détail choisir  ``GPO Statuts : User configuration settings disabled``
- Clic droit sur la GPO puis ``Edit``
- **Computer Configuration -> Windows Settings -> Security Settings -> Local Policies -> Security Options**

   - Accounts: Guest account status -> Define this policy setting : ``Disabled``

- Lier cette GPO à l'OU LabOrdinateurs : clic droit puis "Link an Existing GPO"

## 9. Bloquez l’énumération anonyme des SID

>Les Security Identifiers (SID) sont des numéros uniques associés à chaque utilisateur et groupe dans Active Directory. L’énumération anonyme des SID peut être utilisée par des attaquants pour collecter des informations sur vos utilisateurs et groupes. En bloquant cette fonctionnalité via les GPO, vous maintenez les intrus aveugles, renforçant ainsi la confidentialité des informations dans votre annuaire Active Directory.

Accèder à l'interface de gestion des GPO : 

- Cliquer sur ``Tools`` puis ``Group Policy Management``
- Dans le dossier Group Policy Objects clic droit puis New
- Nommer la GPO **"Computeur-GuestAcount-Disable"**
- Cette GPO s'appliquera sur les ordinateurs, dans l'onglet détail choisir  ``GPO Statuts : User configuration settings disabled``
- Clic droit sur la GPO puis ``Edit``
- **Computer Configuration -> Windows Settings -> Security Settings -> Local Policies -> Security Options**

   - Network access: Do not allow anonymous enumeration of SAM accounts and shares -> Define this policy setting : ``Disabled``

- Lier cette GPO à l'OU LabOrdinateurs : clic droit puis "Link an Existing GPO"

## 10. Bloquez l’accès à l'invit de commande

Accèder à l'interface de gestion des GPO : 

- Cliquer sur ``Tools`` puis ``Group Policy Management``
- Dans le dossier Group Policy Objects clic droit puis New
- Nommer la GPO **"User-AccessCMD-Block"**
- Cette GPO s'appliquera sur les utilisateurs, dans l'onglet détail choisir  ``GPO Statuts : Computer configuration settings disabled``
- Clic droit sur la GPO puis ``Edit``
- User Configuration -> Administrative Templates -> System 

   - Prevent access to the command prompt -> ``Enabled``
   - Disable the commande prompt script processing also? -> ``Yes``

- Lier cette GPO à l'OU LabUtilisateurs : clic droit puis "Link an Existing GPO"