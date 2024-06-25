## Installation Windows Server RDS 

### A. Prérequis

Nom Server : EKO-RDS
Adresse IP : 192.168.0.7

Ajouter le serveur au domaine existant **ekoloclast.fr** et le promouvoir en tant que DC.

### B. Installtion du rôle RDS

Le rôle RDS va permettre de :

- Déployer des sessions distantes sur votre serveur en mettant à disposition un bureau pour chaque utilisateur
- Déployer des applications en mode Remote App pour permettre l'accès distant sans passer par un bureau distant
- Déployer des sessions distantes directement au travers d'un ordinateur virtuel attribué à chaque utilisateur (virtualisation de postes de travail)

Installation : 

- Manage -> Add Roles and Features -> Remote Desktop Services Installation

![addrole](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S14/Capture%20RDS/1.addrole.PNG?raw=true)

- Quick Start -> Session-based desktop deployment

![server](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S14/Capture%20RDS/2.server.PNG?raw=true)

- Cliquer sur le menu ``Remote Desktop Services``
- Collections -> Task -> Edit Deployement properties
- Dans RD Licensing cocher ``Per User``
- Dans QuickSessionCollection -> user groups -> ajouter le groupe ``GrpRdsAccess``

![deploiement](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S14/Capture%20RDS/3.deploiementok.PNG?raw=true)

### C. Déploiement RemotApp

Installer le logiciel LAPS (se référer au fichier https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S13/INSTALL%20LAPS.md)
- QuickSessionsCollection
- Remoteapp programs
- Task 
- Publish RemoteApp Programs
- Choisir

![remote](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S14/Capture%20RDS/4.remote.PNG?raw=true)

**Important**

Afin que les utilisateurs du support puisse lire les mots de passe des comptes administrateurs locaux :

```powershell
Set-AdmPwdReadPasswordPermission -Identity "OU=LabOrdinateurs,DC=ekoloclast,DC=fr" -AllowedPrincipals "ekoloclast\GrpRdsAccess"
```
