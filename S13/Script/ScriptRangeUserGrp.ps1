# Importer le module Active Directory
Import-Module ActiveDirectory

# Chemin vers le fichier CSV
$csvPath = "C:\Users\Administrator\Tssr\s09_Ekoloclast.csv" # A modifier si besoin

# Lire le fichier CSV
$users = Import-Csv -Path $csvPath -Delimiter ";" -Header "Prenom", "Nom", "Societe", "Site", "Departement", "Service", "fonction", "Managerprenom", "Managernom", "PC", "Datedenaissance", "Telephonefixe", "Telephoneportable", "NomadismeTeletravail", "OUPrincipale", "FonctionModif" | Select-Object -Skip 1

# Parcourir chaque utilisateur dans le CSV
foreach ($user in $users) {
    # Préparer les propriétés de l'utilisateur
    $baseSamAccountName = ($user.Prenom.Substring(0, 3) + "." + $user.Nom).ToLower()
    $samAccountName = $baseSamAccountName
    $prenom = $user.Prenom
    $Nom = $user.Nom
    $displayName = "$prenom $Nom"
    $Service = $user.Service


    # Vérifier l'existence de l'utilisateur et ajuster si nécessaire
    # while (Get-ADUser -Filter { SamAccountName -eq $samAccountName }) {
    #    $samAccountName = "$baseSamAccountName$i"
    #    $i++
    #}
    
    # Vérifier si l'utilisateur existe déjà
    if (Get-ADUser -Filter { SamAccountName -eq $samAccountName }) {
        # Ajouter l'utilisateur aux groupes départements spécifiés
        $groups = $user.Departement
        foreach ($group in $groups) {
            try {
                Add-ADGroupMember -Identity $group -Members $samAccountName
                Write-host "Utilisateur $displayName ajoute au groupe $group." -ForegroundColor Yellow
            }
            catch {
                Write-host "Erreur lors de l'ajout de l'utilisateur $displayName au groupe $group : $_" -ForegroundColor red
            }
        }
        if ($service.Length -ge 3) {
            # Ajouter l'utilisateur aux groupes services spécifiés
            $groups = $user.Service
            foreach ($group in $groups) {
                try {
                    Add-ADGroupMember -Identity $group -Members $samAccountName
                    Write-host "Utilisateur $displayName ajoute au groupe $group." -ForegroundColor Yellow
                }
                catch {
                    Write-host "Erreur lors de l'ajout de l'utilisateur $displayName au groupe $group : $_" -ForegroundColor red
                }
            }
        }
        else {
            Write-Host "L'utilisateur $displayName n'existe pas" -ForegroundColor DarkRed
        }
    }
}