
# Purple Knight - Identification des vulnérabilités

![1](https://github.com/Seyia11/capture-DHCP/blob/main/1.PNG?raw=true)


## 1. Changements de Permissions sur l'Objet AdminSDHolder

![1bis](https://github.com/Seyia11/capture-DHCP/blob/main/1bis.PNG?raw=true)

## 2. Mot de passe des comptes admin faible

![2](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S18/Capture%20PK/2.PNG?raw=true)

## 3. Le spooler d'impression est activé sur les DC

![3](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S18/Capture%20PK/3.PNG?raw=true)

Pour remédier à cette faille :

- Dans la barre de recherche taper `services.msc`
- Rechercher le service ``Print Spooler``
- Clic droit ``Properties`` puis ``Startup Type`` sélectionner ``Disabled``

**Désactiver le service Print Spooler sur les contrôleurs de domaine est une mesure de sécurité recommandée si ce service n'est pas nécessaire.**

## 4. Absence de signature LDAP

![4](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S18/Capture%20PK/4.PNG?raw=true)

En suivant les étapes ci-dessous, vous pourrez configurer vos contrôleurs de domaine et vos clients pour utiliser et exiger la signature LDAP, améliorant ainsi la sécurité de votre environnement Active Directory contre les attaques de type "man-in-the-middle".

#### A. GPO computers

- ``gpmc.msc``
- New GPO : ``Computer-LDAP-signing``
- Edit 
- Computer Configuration -> Windows Settings -> Security Settings -> Local Policies -> Security Options
- ``Network security: LDAP client signing requirements``
- Choisir ``Require signing``
- ``Apply puis OK``
- Lié cette GPO à l'OU LabOrdinateurs (s'applique à tous les postes clients)

#### B. GPO Domain Controllers

- ``gpmc.msc``
- New GPO : ``DC-LDAP-signing``
- Edit 
- Computer Configuration -> Windows Settings -> Security Settings -> Local Policies -> Security Options
- ``Domain controller: LDAP server signing requirements``
- Choisir ``Require signing``
- ``Apply puis OK``
- Lié cette GPO à l'OU Domain Controllers (s'applique à tous les DC)


## 5. Chiffrement RC4 et DES supportés

![5](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S18/Capture%20PK/5.PNG?raw=true)


Les DC supportent encore le chiffrement RC4 et DES. Ces algorithmes de chiffrement sont obsolètes et vulnérables à diverses attaques cryptographiques, notamment les attaques de type "man-in-the-middle" (MiTM) et les attaques de déchiffrement. Les vulnérabilités associées à RC4 et DES, telles que CVE-2013-2566 et CVE-2015-2808, permettent aux attaquants de compromettre les communications sécurisées.

**Créer une GPO pour autoriser uniquement les chiffrments AES128 et AES256**

GPO Domain Controllers

- ``gpmc.msc``
- New GPO : ``DC-RC4-DES-Encryption-Disable``
- Edit 
- Computer Configuration -> Windows Settings -> Security Settings -> Local Policies -> Security Options
- ``Network security: Configure encryption types allowed for Kerberos``
- cochez uniquement les options ``AES-128`` et ``AES-256``
- ``Apply puis OK``
- Lié cette GPO à l'OU Domain Controllers (s'applique à tous les DC)
