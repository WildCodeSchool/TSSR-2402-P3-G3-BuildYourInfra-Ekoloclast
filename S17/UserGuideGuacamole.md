### Se connecter a l'interface web Guacamol
```
http://<Adresse IP>:8080/guacamole/
```  
  
- Cette page doit s'afficher
  
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S17/Ressources%20Guacamole/Connexion-a-Apache-Guacamole.png)
  
- Pour se connecter il faut utiliser les identifiants par defaut :    
    - Utilisateur : guacadmin
    - Mot de passe : guacadmin
  
- Creer un nouveau compte d'administration et supprimer le compte par defaut, pour des raisons de securite
  
- Acceder aux parametres, il faut cliquer sur le nom d'utilisateur en haut à droite puis sur "Parametres".  
  
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S17/Ressources%20Guacamole/Apache-Guacamole-Interface-des-parametres.png)
  
- Ensuite, sur l'onglet "Utilisateurs" et sur "Nouvel utilisateur".
  
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S17/Ressources%20Guacamole/Locadmin%20compte.png)
  
### Ajouter une connexion RDP
  
- Dans cet exemple, je crée un groupe nommé "DomainControlers". Il sera positionné sous le lieu "ROOT" qui est la racine de l'arborescence. Le type de groupe "Organizationel" doit être sélectionné pour tous les groupes qui ont pour vocation à organiser les connexions.
  
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S17/Ressources%20Guacamole/Capture%20d%E2%80%99e%CC%81cran%202024-07-06%20a%CC%80%2016.13.27.png)
  
- Cliquer sur le bouton "Nouvelle connexion". On commence par nommer la connexion, choisir le groupe et le protocole. Ici, c'est sur le serveur "Bitwarden" que je souhaite me connecter, associé à l'adresse IP "192.168.0.4".
  
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S17/Ressources%20Guacamole/ekomstr1.png)
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S17/Ressources%20Guacamole/ekomstr2.png)
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S17/Ressources%20Guacamole/ekomstr3.png)
  
- La nouvelle connexion apparaît sous "DomainControlers". Pour tester cette connexion, il faut basculer sur "Accueil" en cliquant sur son identifiant en haut à droite.
  
-Cliquer sur le serveur ajouter
  
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S17/Ressources%20Guacamole/Apache-Guacamole-Connexion-en-cours.png)
  
- Vous voila connectez a la machine distante
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S17/Ressources%20Guacamole/fin.png)