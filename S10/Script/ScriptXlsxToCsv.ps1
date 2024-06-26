################################################################################################
#                                                                                              #
#  Script pour modifier un fichier XLSX en CSV sans accent, ni caractere speciaux, ni espace   #
#                                                                                              #
################################################################################################

# Chemin d'accès du fichier XLSX d'entrée et du fichier CSV de sortie
$fichierXLSX = "chemin d'acces au fichier XLSX"
$fichierCSV = "chemin d'acces au fichier CSV a creer"

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
$contenu = Get-Content $fichierCSV

# Appliquer la fonction Remove-StringSpecialCharacters à chaque ligne
$contenuTraite = foreach ($ligne in $contenu) {
   Remove-StringSpecialCharacters -String $ligne
}

# Écrire les lignes traitées dans un nouveau fichier
$contenuTraite | Out-File -FilePath $fichierCSV -Encoding utf8