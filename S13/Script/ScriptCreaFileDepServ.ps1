# Chemin vers votre fichier CSV
$csvPath = "C:\Users\Administrator\Tssr\s09_Ekoloclast.csv"

# Lire le fichier CSV
$data = Import-Csv -Path $csvPath -Delimiter ";"

# Extraire les valeurs uniques des colonnes "Departement" et "Service"
$departements = $data | Select-Object -ExpandProperty Departement | Sort-Object -Unique
$services = $data | Select-Object -ExpandProperty Service | Sort-Object -Unique

# Créer les dossiers pour chaque département
foreach ($departement in $departements) {
    # Ignorer les valeurs vides
    if (-not [string]::IsNullOrEmpty($departement)) {
        $folderPath = "C:\Users\Administrator\Tssr\departements\$departement"
        if (-not (Test-Path -Path $folderPath)) {
            New-Item -Path $folderPath -ItemType Directory
        }
    }
}

# Créer les dossiers pour chaque service
foreach ($service in $services) {
    # Ignorer les valeurs vides
    if (-not [string]::IsNullOrEmpty($service)) {
        $folderPath = "C:\Users\Administrator\Tssr\services\$service"
        if (-not (Test-Path -Path $folderPath)) {
            New-Item -Path $folderPath -ItemType Directory
        }
    }
}
