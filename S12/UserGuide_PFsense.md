
## Parametrage du FireWall PFsense

### Connection au parefeu 

Pour se connecter au parfeu en mode graphique il faut entrer l'adresse `LAN` dans le navigateur d'un ordinateur du réseau.

### Creation d'alias

Pour faciliter la création de regles il y a la création d'alias, qui permet de rassembler des elements commun.  
Aller dans le menu `Pare-feu` puis dans `Alias`  

![image](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/assets/161337347/9f52619f-2240-49ae-ba73-6545fbfca44b)


Pour la partie qui nous interesse pour le moment est de rassembler les Ports necessaire pour les mêmes service Mail, Web, Netbios

Dans l'exemple dessous, il y a un Alias pour la navigation WEB qui se nomme **Service_Web** et qui contient les ports HTTP `80` HTTPS `443` et DNS `53`

![image](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/assets/161337347/0a364e78-118c-43fa-9001-69e9066e3d78)


### Mise en place de regle


Pour les regles, il faut aller dans le menu `Pare-feu` puis `Regles` et `LAN` 

Dans un premier temps, il ne faut pas toucher a la premiere regle nommé `regle anti-blocage` car l'accées au Pare-feu serait impossible

On peux désactiver les regles nommé `Default allow LAN IPv6 to any rule` et `Default allow LAN to any rule` car ça ouvre tout les ports pour toute les IP v4 et v6

![image](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/assets/161337347/9102abc4-1585-45c3-84b4-f37d1571caf0)

Les regles de pare-feu se lisent du bas vers le haut, donc dans une bonne pratique on applique le principe du `Deny All` qui consiste a tout bloquer, et a ouvrir les ports necessaire

![image](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/assets/161337347/37e58cfb-6a63-4e9b-abd6-cc3c7b96990a)

Pour la mise en place de regles, on prend l'exemple du **Service_Web**

Dans le premier "Action" on met `Autoriser` 

On laisse décocher la case `Désactiver cette règle`

Dans "Interface" on laisse `LAN`

Pour la "Famille d'adresse" on garde `IPv4` car on ne fait pas encore d'IPv6

Concernant le "Protocole" on choisi `TCP/UDP` a cause du Port DNS `53` qui est en TCP/UDP alors que les ports HTTP(80) et HTTPS(443) ne sont qu'en TCP
 
![image](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/assets/161337347/17a44450-9d46-4c04-adf3-d45402df3cd1)

Pour la "Source" on choisi `LAN Subnets` 
Pour la "Destination" on regle sur `Tous` ou `Any` et on viens ajouter notre Alias `Service_Web` qui contient tous les ports necessaire au fonctionnement de la navigation
  
![image](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/assets/161337347/176d4887-166f-4cd9-b025-e16e7dda03e5)

Puis il reste a faire `Enregistrer` en bas de page, et `Appliquer les modifications` une fois revenu sur le résumé des regles.


## Annexe

Site qui m'a permi de trouver les reglages de base pour la configuration

https://docs.netgate.com/pfsense/en/latest/recipes/example-basic-configuration.html
