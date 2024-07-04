# Installation du serveur freePBX 
- Mise en place d'une machine sous distribution linux Red Hat dans notre cas et lancer avec l'iso FreePbx
- Selectionner la ```version Recommandée```
  ![](https://raw.githubusercontent.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/main/S17/Freepbx/1.png)
- Puis sélectionner ```Graphical Installation - Output to VGA```
- Enfin choisir ```FreePBX Standard```
- Une autre fenêtre s'affichera. Dans celle-là, on devra configurer le mot de passe root le temps que l'installation se termine. Pour ce faire, il faut cliquer sur ```ROOT PASSWORD```. !!! ATTENTION LE CLAVIER EST EN QWERTY !!!
  ![](https://raw.githubusercontent.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/main/S17/Freepbx/2.png)
- Une fois l'installation terminée, éteindre et redémarrer le serveur sans l'ISO.
- Se connecter en root: Si tu veux rester en Qwerty tu peux te connecter directemnt a l'interface a partir de l'adresse ip. Sinon tu peux te mettre en Azerty avec
  ```
  localectl set-locale LANG=fr_FR.utf8
  localectl set-keymap fr
  localectl set-x11-keymap fr 
  ```
# Configuration de FreePBX 
- Par l'interface web, connecte-toi en root sur la VM avec le mot de passe associé (à mettre 2 fois). Indique également une addresse mail pour les notifications et clique sur ```Setup System```
- Dans la fenêtre, clique sur ```FreePBX Administration``` et reconnecte-toi en root.
- ```Skip``` l'activation du server et toutes les offres commerciales.
- ```Abort``` la fenêtre d'activation du firewall.
- ```Not Now```pour l'essaie du SIP Station
- Une fois sur le tableau de bord faire un ```Apply config``` pour valider tout ce qu'on viens de faire.
Maintenant nous allons activer le serveur.
- Va dans le menu ```Administrateur``` puis ```System Admin```
- Clique sur ```Activation``` puis Activate ,Dans la fenêtre qui s'affiche, clique sur Activate.
- Ensuite il faut rentrer une adresse mail ainsi qu'un mots de passe et patienter.
  
  Une fenêtre va s'afficher. Il faut la remplir avec les informations demandées.
- Pour ```Which best describes you``` mettre ```I use your products and services with my Business(s) and do not want to resell it```
- Pour ```Do you agree to receive product and marketing emails from Sangoma ?``` coche ```No```
- Clique sur ```Create```
  ![](https://raw.githubusercontent.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/main/S17/Freepbx/4.png)
- Dans la fenêtre d'activation, clique sur ```Activate``` et attends que l'activation se fasse et skip toutes les pubs.
- On se retrouve dirigier vers une fenêtre de mise a mjour de module. Clique sur ```Update Now``` et attendre la fin de mise des modules et faire ```Apply config```
- EN CAS D'ERREUR ALLER SUR LE SERVEUR ET REALISER LA DEMARCHE SUIVANTE:
```
fwconsole ma install userman
fwconsole ma enable userman
fwconsole ma install voicemail
fwconsole ma enable voicemail
fwconsole ma install sysadmin
fwconsole ma enable sysadmin
```
- Ensuite exécute la commande ```yum update``` faire y et Redémarre le serveur.
# Terminer les mises a jour des modules  
Connecte-toi en root via la console web, et vas dans le Dashboard pour voir s'il te manque des modules.
Vas dans le menu ```Admin``` puis ```Modules Admin```, et dans l'onglet ```Module Update```.

Dans la fenêtre qui s'affiche, dans la colonne ```Status```, sélectionne ceux qui sont en ```Disabled; Pending Upgrade...``` et qui ont une licence GPL.
Sélectionne alors le bouton ```Upgrade to ....``` 
![](https://raw.githubusercontent.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/main/S17/Freepbx/5.png) 
Quand tu as géré tous les modules, clique sur ```Process```
Dans la fenêtre qui apparaît, clique sur ```Confirm```. 
![](https://raw.githubusercontent.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/main/S17/Freepbx/6.png)
Recommencer jusqu'a ce que tout sois a jour.
