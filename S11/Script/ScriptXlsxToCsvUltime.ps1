################################################################################################
#                                                                                              #
#  Script pour modifier un fichier XLSX en CSV sans accent, ni caractere speciaux, ni espace   #
#  Il permet également d'obtenir le CSV pour l'ajout automatique des OU, groupes et Users      #
#                                                                                              #
################################################################################################

# Chemin d'accès du fichier XLSX d'entrée et du fichier CSV de sortie
# A MODIFIER SI BESOIN 
$fichierXLSX = "C:\Users\Nico\TSSR\Projet3\Script\s09_Ekoloclast.xlsx"
$fichierCSV = "C:\Users\Nico\TSSR\Projet3\Script\s09_Ekoloclast.csv"

# Charger le contenu du fichier XLSX
$data = Import-Excel -Path $fichierXLSX

# Exporter les données dans un fichier CSV avec encodage UTF-8 avec BOM
$data | Export-Csv -Path $fichierCSV -Encoding UTF8 -NoTypeInformation

# Définition de la fonction Remove-StringSpecialCharacters
function Remove-StringSpecialCharacters {
   param ([string]$String)

   Begin {}

   Process {

      $String = [Text.Encoding]::ASCII.GetString([Text.Encoding]::GetEncoding("Cyrillic").GetBytes($String))

      $String = $String -replace '-', '' `
         -replace ' ', '' `
         -replace '/', '' `
         -replace '\*', '' `
         -replace "'", "" 
   }

   End {
      return $String
   }
}

# Lire le contenu du fichier d'entrée
$contenu = Get-Content -path $fichierCSV

# Appliquer la fonction Remove-StringSpecialCharacters à chaque ligne
$contenuTraite = foreach ($ligne in $contenu) {
   Remove-StringSpecialCharacters -String $ligne
}

# Écrire les lignes traitées dans un nouveau fichier
$contenuTraite | Out-File -FilePath $fichierCSV -Encoding utf8

$fileSource = Import-Csv  $fichierCSV

# Ajouter une nouvelle colonne avec des valeurs statiques

foreach ($ligne in $fileSource) {
   # Extraire le nom de la fonction
   $fonction = $ligne.fonction

   # Vérifier si la colonne "Service" a au moins 3 caractères
   if ($ligne.Service.Length -ge 3) {
      # Récupérer les trois premières lettres de la colonne "Service"
      $service = $ligne.Service.Substring(0, 3) + "_"
   }
   else {
      # Si la longueur est inférieure à 3, utiliser la chaîne entière
      $service = $ligne.Service
   }
   # Construire le terme final
   $termeFinal = "$service$fonction"

   $ligne | Add-Member -MemberType NoteProperty -Name "OUPrincipale" -Value "LabUtilisateurs"
   $ligne | Add-Member -MemberType NoteProperty -Name "FonctionModif" -Value "$termeFinal"
}



$fileSource | Export-CSV -Path $fichierCSV -Delimiter ";" -NoTypeInformation





