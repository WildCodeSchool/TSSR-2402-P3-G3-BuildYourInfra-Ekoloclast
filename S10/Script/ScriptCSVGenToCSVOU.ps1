##################################################################################
#                                                                                #
#  Script pour modifier un fichier CSV en CSV pour la creation d'OU automatique  #
#                                                                                #
##################################################################################



$fileSourceU = Import-CSV -Path "C:\Users\Nico\TSSR\Projet3\Script\s09_Ekoloclast_New.csv" -Delimiter "," | Select-Object Departement, Service, fonction | Select-Object -Property * -Unique
$fileSourceC = Import-CSV -Path "C:\Users\Nico\TSSR\Projet3\Script\s09_Ekoloclast_New.csv" -Delimiter "," | Select-Object Departement, Service, fonction | Select-Object -Property * -Unique

# Ajouter une nouvelle colonne avec des valeurs statiques
foreach ($ligne in $fileSourceU) {
    $ligne | Add-Member -MemberType NoteProperty -Name "OUPrincipale" -Value "LabUtilisateurs"
}

foreach ($ligne in $fileSourceC) {
    $ligne | Add-Member -MemberType NoteProperty -Name "OUPrincipale" -Value "LabOrdinateurs"
}

$fileSourceU | Export-CSV -Path "C:\Users\Nico\TSSR\Projet3\Script\s09_Ekoloclast_New1.csv" -Delimiter ";" -NoTypeInformation
$fileSourceC | Export-CSV -Path "C:\Users\Nico\TSSR\Projet3\Script\s09_Ekoloclast_New1.csv" -Delimiter ";" -NoTypeInformation -Append