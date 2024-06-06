# Bloquer la connexion pour les utilisateurs
Nous allons passer par une GPO pour interdire l'ouverture d'une session locale :

1. Créer un groupe de sécurité comportant tous les utilisateurs.
2. Créer une GPO à l'aide de la console "Gestion de stratégie de groupe" (donnez-lui le nom que vous souhaitez).
3. Modifier la GPO en suivant ce chemin :
- Configuration ordinateur > Stratégies > Paramètres Windows > Paramètres de sécurité > Attribution des droits utilisateur > Interdire l'ouverture d'une session locale.
  ![](https://raw.githubusercontent.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/main/S13/Lock/Chemin.png)
4. Ouvrir ce paramètre, cocher la case appropriée et renseigner le groupe de sécurité créé au préalable.
  ![](https://raw.githubusercontent.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/main/S13/Lock/COCHE.png)
5. Lier la GPO à l'OU (Unité d'Organisation) contenant les utilisateurs concernés.
  ![](https://raw.githubusercontent.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/main/S13/Lock/Link.png)
À présent, les utilisateurs du groupe de sécurité ne pourront plus se connecter localement.

# Connexion autorisée
Nous voulons quand même que les utilisateurs puissent se connecter. Pour cela, nous allons définir des plages horaires pendant lesquelles les utilisateurs pourront se connecter (par exemple, de 7h à 20h). Pour ce faire, nous utiliserons un [script](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S13/Plagehoraire.ps1) qui sera fourni dans le dossier script de ce sprint. 
```
$users = Get-ADUser -filter * | Select-object SamAccountName -Skip 1

foreach ($user in $users) {
    $username = $user.SamAccountName  
    net user $username /times:M-Sa,7:00-20:00
}```
