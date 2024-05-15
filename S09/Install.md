# 1. Configuration VM Windows-Server-2022-core-DHCP 

Il faut modifier le mot de passe du compte Administrator dès le début, choisir ``Azerty1*``

### a. Modidier le nom du Serveur puis redémarrer le serveur

Name : ``PARSRVDHCPDC01``

![changename](https://github.com/Seyia11/capture-DHCP/blob/main/Quete%20Dhcp%20windows%20server/changename.PNG?raw=true)

### b. Configuration Network settings

Dans le terminal ``Sconfig``
- Taper 8 pour Network settings
- Choisir la carte réseau
- Taper 1 pour Set network adapter address
- Taper S pour IP fixe
- Entrer l'adresse ip : 192.168.0.2
- Masque de sous réseau : 255.255.255.0
- Passerelle : 192.168.0.254

### c. Installation des fonctionnalités necessaires à la préparation de ce serveur en controleur de domaine.

Dans le terminal Powershell taper les commandes suivantes:

```powershell
Add-WindowsFeature -Name "RSAT-AD-Tools" -IncludeManagementTools -IncludeAllSubFeature
```
```powershell
Add-WindowsFeature -Name "AD-Domain-Services" -IncludeManagementTools -IncludeAllSubFeature
```
```powershell
Add-WindowsFeature -Name "DNS" -IncludeManagementTools -IncludeAllSubFeature
```
### d. Création du domaine AD

```powershell
$ForestConfiguration = @{
'-DatabasePath' = 'C:\Windows\NTDS';
'-DomainMode' = 'Default';
'-DomainName' = "ekoloclast.fr";
'-DomainNetbiosName' = "ekoloclast";
'-ForestMode' = 'Default';
'-InstallDns' = $true;
'-LogPath' = 'C:\Windows\NTDS';
'-NoRebootOnCompletion' = $false;
'-SysvolPath' = 'C:\Windows\SYSVOL';
'-Force' = $true;
'-CreateDnsDelegation' = $false }

Import-Module ADDSDeployment
Install-ADDSForest @ForestConfiguration
```

Indiquer deux fois le mot de passe Azerty1* pour la récupération
Le serveur redémarre

### e. Désactiver les parfeu 
```powershell
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
```
Ce serveur est désormais controleur du domaine ekoloclast.fr

Pour la suite, suivre la procédure **2. VM Windows-Server-2022-AD-DC**

# 2. VM Windows-Server-2022-AD-DC

**Prérequis:**

>1 carte réseau interne : intnet
Name : PARSRVADDC01
IP Fixe : 192.168.0.1
Masque ss réseau : 255.255.255.0
Passerelle : 192.168.0.254 (optionnel à ce stade du projet)
DNS : 192.168.0.2 (obligatoire)


**Compte Local** 
ID : ``Administrator``
MDP : ``Azerty*``

### a. Ajouter le rôle AD-DS sur le serveur

Dans le server manager :

- Manage
- Add roles and Feaures
- Selectionner ADDS
- Cliquer sur ``Promote this server to a Domain Controler``
- Cocher première option et inscrire le domaine ``ekoloclast.fr``
- Renseigner Credentials : ``ekoloclast\Administrator`` et mdp ``Azerty1*``

![adddomain](https://github.com/Seyia11/capture-DHCP/blob/main/Quete%20Dhcp%20windows%20server/adddomaine.PNG?raw=true)


- Taper deux fois le mdp ``Azerty1*``
- Next
- Install

Le serveur va redémarrer

### b. Ajouter le role DHCP sur le serveur core ``PARSRVDHCPDC01``

Depuis ce serveur nous allons installer le service DHCP sur le serveur Core.

Dans le Server Manager, aller dans Manage -> Add Servers, et ajouter le serveur ``PARSRVDHCPDC01``

Pour ajouter le role DHCP:

- Manage
- Add roles and Feaures
- Selectionner Server ARSRVDHCPDC01 192.168.0.2
- Selectionner DHCP -> Next
- Install
- Cliquer sur complete DHCP Configuration

![auto](https://github.com/Seyia11/capture-DHCP/blob/main/Quete%20Dhcp%20windows%20server/dhcpauto.PNG?raw=true)

**Configuration plage d'adresse réservée:**

- DHCP Manager
- Clic droit sur IPV4 -> New Scope
- Nommer le scope
- Start IP address : ``192.168.0.50``
- End IP address : ``192.168.0.250``
- Passerelle : ``192.168.0.254``

![dhcpfin](https://github.com/Seyia11/capture-DHCP/blob/main/Quete%20Dhcp%20windows%20server/dhcpfin.PNG?raw=true)

**Le DHCP est configuré pour cette première plage d'adresse, tester le bon fonctionnement avec un poste Client Windows10.**

