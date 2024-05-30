# Ajout des utilisateurs et des groupes sur Glpi 
1. Se connecter au serveur glpi en admin.
2. Aller dans configuration puis authentification et cliquer sur le + comme sur l'image ci joint

![](https://raw.githubusercontent.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/main/S12/GLPI/etape1.png) 

3. cela va nous ramener a une page ou ont devras rajouter des informations.
- Nom: Nom du pc.nom du domaine
- serveur mettre l'ip du servers AD
- la base DN c'est l'arborescense ou nous allons retrouver les utilisateurs et les groupe vous pouvez juste mettre le domaine
A la fin vous devez avoir un resultat similaire.

![](https://raw.githubusercontent.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/main/S12/GLPI/etape2.png)

Faire une sauvegarde et tester si la connexion a reussi, si elle a echouer verifier les informations. 

4. La configuration faite nous pouvez aller dans la parti administration et respectivement Utilisateur ou groupe pour les rajouter.

![](https://raw.githubusercontent.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/main/S12/GLPI/etape3.png)

5. Une fois sur le menu voulu cliquer sur liaison annuaire LDAP ---> importation de nouveaux utilisateurs cliquer sur mode expert ---> verifier la base DN ---> selectionner les utilisateurs groupes voulu ---> action puis importer et valider

![](https://raw.githubusercontent.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/main/S12/GLPI/etape4.png)

