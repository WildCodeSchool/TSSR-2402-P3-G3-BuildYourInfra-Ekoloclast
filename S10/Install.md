## Installation server Windows AD-DS/DNS/DHCP

Prérequis :

>- Nom du serveur : EKO-MSTR
>- Adresse IP : 192.168.0.2
>- Masque de sous réseau : 255.255.255.0
>- Passerelle : 192.168.0.253

### 1. Installer le rôle ADDS

1. Dans le Gestionnaire de serveur, cliquer sur l’étape « Add roles and features » .
2. Cocher le rôle "Active Directory Domain Services".
3. Laisser les choix par défaut et cliquer sur Next jusqu'à "Install".
4. A la fin de l'installation cliquer sur "Promote this server to a domain controller".
5. Add a new forest -> name : **ekoloclast.fr**
Laisser cocher DNS et en server 2016 puis choisir un mdp pour DSRM (récupération des services d'annuaires) puis Next
6. NetBios : WILDERS
7. Valider l’emplacement de la base de données AD DS -> laisser les choix par défaut puis cliquer sur "Install"
8. Le serveur rédémarre, la connexion doit maintenant se faire sur le domaine.


### 2. Installer le serveur DHCP
Dans le Server Manager suivre les étapes ci dessous :

- Clic sur Manage
- -> Next
- Add Roles and Features
- Role-based or feature-based installation -> Next
- Le serveur local est déja selectionné -> Next
- Dans la liste des rôles, cochez "Serveur DHCP" et au sein de la fenêtre qui s'affiche vérifiez que l'option "Include management Tools" soit cochée. Elle permet d'ajouter la console de gestion DHCP sur le serveur. Cliquez sur "Add Features" -> Next
- Laisser cocher les fonctionnalité -> Next
- L'assistant nous rappelle qu'il faut avoir une adresse IP statique sur le serveur DHCP avant de procéder à l'installation de ce rôle. C'est bien le cas, cliquez sur -> Next
- Dernière étape de l'assistant, cliquez sur "Install". Il ne sera pas nécessaire de redémarrer le serveur à la fin de l'installation.

### 3. Autoriser le serveur DHCP dans l'active Directory

>Cette étape consiste à effectuer deux actions auprès de l'Active Directory :
>Créer deux groupes de sécurité dans l'AD pour permettre la délégation quant à la gestion du serveur DHCP
>Déclarer notre serveur DHCP au sein de l'AD

- cliquer sur le logo "avertissement" puis sur **Complete DHCP configuration**
- cliquer sur commit et close

![active diractory](https://github.com/Seyia11/capture-DHCP/blob/main/Quete%20Dhcp%20windows%20server/ajout%20active%20directory.PNG?raw=true)

### 4. Configurer le serveur DHCP : Déclarer une plage d'adresse IP

Dans le serveur manager (barre à gauche), cliquer sur DHCP puis clic droit sur le serveur sélectionné (ligne en bleu), choisir "DHCP manager" pour ouvrir la console

![console](https://github.com/Seyia11/capture-DHCP/blob/main/Quete%20Dhcp%20windows%20server/concole.PNG?raw=true)

- Clic sur SRVWIN01
- clic droit sur IPV4 puis clic sur New Scope
- -> Next
- Taper le nom : "SRV-DHCP"
- Start IP address : 192.168.0.20
- End IP address : 172.20.0.253
- Subnet mask : 255.255.255.0
- Ne rien remplir dans la partie Add Exclusions (pas besoin) -> Next
- Laisse la durrée du bail à 8 jours par défaut -> Next
- choisir "Yes, I want to configure these options now" -> Next

- Paramétrage Gateway : taper 172.20.0.254
- Nom de domaine : laisser vide -> Next
- Wins Servers : laisser vide -> Next
- cliquer sur "Yes, I want to activate scope now" et Finish

## Installation server Windows AD-DS CORE

### 1. Modifier le nom du serveur

Dans le terminal ``Sconfig``

Name: ``EKO-MSTR-CORE``

![changename](https://github.com/Seyia11/capture-DHCP/blob/main/Quete%20Dhcp%20windows%20server/changename.PNG?raw=true)

### 2. Configuration Network settings

Dans le terminal ``Sconfig``
- Taper 8 pour Network settings
- Choisir la carte réseau
- Taper 1 pour Set network adapter address
- Taper S pour IP fixe
- Entrer l'adresse ip : 192.168.0.3
- Masque de sous réseau : 255.255.255.0
- Passerelle : 192.168.0.254
- DNS : 192.168.0.2

### 3. Configuration AD et ajout au domaine

Dans le terminal Powershell taper les commandes suivantes:

```powershell
Install-WindowsFeature RSAT-AD-PowerShell
```
```powershell
Add-Computer -DomainName "ekoloclast.fr" -Credential (Get-Credential)
```
_(le serveur va redémarrer pour entrer dans le domaine cité)_

Pour finir taper la commande suivante :

```powershell
Install-WindowsFeature AD-Domain-Services
```

### 4. Finalisation configuration

Revenir sur le serveur principal ``EKO-MSTR`` (graphique)

Depuis le serveur manager :

- Ouvrir en haut à droite le menu Manage
- Cliquer sur Add Server
- Chercher le serveur à ajouter à l’AD
- Suivre les instructions à l’ecran

![core](https://github.com/Seyia11/capture-DHCP/blob/main/Quete%20Dhcp%20windows%20server/core.PNG?raw=true)
