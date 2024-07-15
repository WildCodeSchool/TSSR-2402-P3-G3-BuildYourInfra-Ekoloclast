
# Tableau de synthèse des matériels

| Nom | Type | OS | IP | Fonction | Disques dur | RAM |
| --- | --- | --- | --- | --- | ---| ----|
| EKO-MSTR | VM | Windows Server 2022 | 192.168.0.2/24 | Contrôleur de domaine n°1 - ADDS - DNS - DHCP -  Partage de fichier - Role FSMO : Schema Master,Domain Naming Master  | ide0 : 100GO (libre 72.6GO/72.6%) - ide1 : 20GO (libre 19GO / 95%) - ide3 : 20GO (libre 14.3GO / 71.5%) | 5.07GO sur 8GO (Utilisation 63.36%) | 
| EKO-CORE | VM | Windows Server 2022 | 192.168.0.3/24 | Contrôleur de domaine n°2 - ADDS - DNS - Role FSMO : PDC Emulator, RID Master | ide0 : 32GO (libre 24GO / 75%) | 1.14Go sur 2Go (Utilisation 56.98%)
| DEBIAN-SSH | VM | Debian 12 | 192.168.0.4/24 | Serveur SSH - BITWARDEN | ide0 : 32GO (libre 17GO / 51%)| 904.63 Mo sur 2Go (Utilisation 44.39%) |
| EKO-PRTG | VM | Windows Server 2022| 	192.168.0.6/24 | Serveur Supervision, surveillance réseau | ide : 100GO (libre 81.7GO / 81.7%) | 6.82Go sur 8.00 Go (Utilisation 85.28%)|
| EKO-RDS-WDS | VM  | Windows Server 2022  | 192.168.0.7/24 | Remote Desktop Services,Windows Deployment Services, WSUS | ide0 : 37GO (libre 3.66GO 9.9%) - ide1 : 30GO (libre 24.8 / 82.6%) - ide3 : 20GO (libre 19GO /95%) | 3.99Go sur 6Go (utilsation 66.51%)|
| EKO-FREEPBX | VM | RedHat | 192.168.0.10/24 | Serveur téléphonie | scsi0 : 32GO (libre 25.7GO / 76%)| 1.45Go sur 2Go (Utilisation 72.66%) |
| EKO-GCM | VM | Debian 12 | 192.168.0.12/24 | Serveur bastion d'administration Guacamole  | scsi0 : 32GO (libre 27.9GO / 85%)| 850.91Mo sur 2Go (Utilisation 41.55%) |
| EKO-VyOS | VM | VyOS| 192.168.0.253/24 | Routeur | scsi0 : 4GO (libre 2.3GO / 64%)| 397.666Mo sur 1Go (Utilisation 38.9%)|
| PFSENSE| VM | FreeBSD | LAN : 192.168.0.254/24, WAN : 10.0.0.2/24 | FireWall | scsi : 6GO (libre 3.2GO / 63%) | 666.23MO sur 2GO (Utilisation 32.53%) | 
| GLPI | CT | Debian 12 | 192.168.0.5/24 | Gestion des services informatiques,gestion des incidents | Disque racine 8GO (libre 5.9GO / 79%)  | 247.27Mo sur 1Go (Utilisation 24.15%)|
| MAIL | CT | Debian 12 | 192.168.0.8/24 | Messagerie Zimbra | Disque racine 15GO (libre 5.5GO / 39%) | 2.68Go sur 5.09 (Utilisation 52.60%)|
| REDMINE | CT | Debian 12| 192.168.0.9/24 | Gestion de projet | Disque racine 8GO (libre 4.3GO / 57%)| 392Mo sur 1GO (Utilisation 38%) |
| WWW | CT | Debian 12 | 192.168.0.11/24 | Conteneur web | Disque racine 20GO (libre 17GO / 85%)| 174Mo sur 2Go (Utilisation 8%) |
| G3-SUPERVISION | VM | Ubuntu 24.04 | 192.168.0.30/24 | Poste supervision admin | scsi0 32GO (libre 15GO / 47%) | 3.34Go sur 6Go (Utilisation 56%) |
| G3-KALI | VM | Kali-Linux | 192.168.0.20/24 | Suite METASPLOIT pour effectuer des tests d'attaques| scsi0 25GO (libre 4.5GO / 19%) | (3.15 Gio sur 4.00 Gio (Utilisation 78%|
| P0232 | VM | Windows10 | 192.168.1.22/24 | Poste client de l'utilisateur : Alice Perrin | ide0 : 100GO (libre 61.7GO / 61.32% ) | 2.97Go sur 4Go (Utilisation 74.30%)|
| P0600 | VM | Windows10 | 192.168.1.20/24 | Poste client de l'utilisateur : Adrien Schultz | ide0 : 100GO (libre 56.4GO / 56.06%) | 3.05Go sur 4.00 Gio (Utilisation 76.2%)|