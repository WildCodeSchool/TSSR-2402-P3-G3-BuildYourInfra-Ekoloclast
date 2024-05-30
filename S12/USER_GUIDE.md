## Stratégie de mot de passe 

Cette stratégie s'appliquera à tous les utilisateurs du domaine ekoloclast.fr. 

1. Dans l'OU LabSecurité : 
- Créer un groupe nommé ``GrpSecuriteMdp``
- Group scope : ``Global``
- Group type : ``Security``

2. Nous devons ajouter tous les utilisateurs de l'OU LabUtilisateurs à ce groupe créé.
Pour réaliser cette action il faut executer le script ci dessous dans Powershell :

```powershell
#PS1
#Impoter module AD
Import-Module ActiveDirectory

#Emplacement utilisateurs
$Ou = "OU=LabUtilisateurs,DC=ekoloclast,DC=fr"

#groupe sécurité mdp
$GroupSec = "GrpSecuriteMdp"

#Recupérer les utilisateurs
$Users = Get-ADUser -Filter * -SearchBase $Ou

#Ajouterles utilisateurs au groupe
foreach ($User in $Users) {
    Add-ADGroupMember -Identity $GroupSec -Members $User
}

Write-Host "Tous les utilisateurs de l'OU Labutilisateurs ont été ajoutés au groupe $Groupsec"
```


2. Depuis le Server manager

- Cliquer sur Tools -> Active Directory Administrative Center
- Sur la partie gauche, dérouler ``ekoloclast`` -> ``System`` -> ``Password Settings Container``
- Renseigner les champs
- Dans Directly Applies To -> ajouter le groupe ``GrpSecuriteMdp``

![stat](https://github.com/Seyia11/capture-DHCP/blob/main/Quete%20Dhcp%20windows%20server/strat.PNG?raw=true)



La stratégie de mot de passe est opérationnelle.