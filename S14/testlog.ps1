# Importer le module Active Directory
Import-Module ActiveDirectory

# Importer les fonctions de journalisation depuis log_function.ps1
$logFunctionPath = "C:\User\Administrator\RessourcesSript\log_function.ps1"

# Chemin vers le fichier CSV
$csvPath = "C:\Users\Administrator\Tssr\s09_Ekoloclast.csv" # A modifier si besoin

# Lire le fichier CSV
$users = Import-Csv -Path $csvPath -Delimiter ";" -Header "Prenom", "Nom", "Societe", "Site", "Departement", "Service", "fonction", "Managerprenom", "Managernom", "PC", "Datedenaissance", "Telephonefixe", "Telephoneportable", "NomadismeTeletravail", "OUPrincipale", "FonctionModif" | Select-Object -Skip 1

# Liste pour accumuler les modifications
$modificationsList = @()

# Parcourir chaque utilisateur dans le CSV
foreach ($user in $users) {
    # Préparer les propriétés de l'utilisateur
    $baseSamAccountName = ($user.Prenom.Substring(0, 3) + "." + $user.Nom).ToLower()
    $samAccountName = $baseSamAccountName
    $prenom = $user.Prenom
    $Nom = $user.Nom
    $displayName = "$prenom $Nom"
    $Service = $user.Service

    # Vérifier si l'utilisateur existe déjà
    $existingUser = Get-ADUser -Filter { SamAccountName -eq $samAccountName }
    if ($existingUser) {
        # Ajouter l'utilisateur aux groupes départements spécifiés
        $groups = $user.Departement 
        foreach ($group in $groups) {
            try {
                Add-ADGroupMember -Identity $group -Members $samAccountName
                $logMessage = "Utilisateur $displayName ajouté au groupe $group."
                $modificationsList += $logMessage
                Write-Log -scriptName "script1.ps1" -message $logMessage
                Write-Host $logMessage -ForegroundColor Yellow
            } catch {
                $errorMessage = "Erreur lors de l'ajout de l'utilisateur $displayName au groupe $group : $_"
                Write-Log -scriptName "script1.ps1" -message $errorMessage
                Write-Host $errorMessage -ForegroundColor Red
            }
        }

        if ($Service.Length -ge 3) {
            # Ajouter l'utilisateur aux groupes services spécifiés
            $groups = $user.Service 
            foreach ($group in $groups) {
                try {
                    Add-ADGroupMember -Identity $group -Members $samAccountName
                    $logMessage = "Utilisateur $displayName ajouté au groupe $group."
                    $modificationsList += $logMessage
                    Write-Log -scriptName "script1.ps1" -message $logMessage
                    Write-Host $logMessage -ForegroundColor Yellow
                } catch {
                    $errorMessage = "Erreur lors de l'ajout de l'utilisateur $displayName au groupe $group : $_"
                    Write-Log -scriptName "script1.ps1" -message $errorMessage
                    Write-Host $errorMessage -ForegroundColor Red
                }
            }
        } else {
            $message = "L'utilisateur $displayName n'existe pas"
            Write-Log -scriptName "script1.ps1" -message $message
            Write-Host $message -ForegroundColor DarkRed
        }
    }
}

# Enregistrer l'exécution finale du script avec les détails des modifications
$modificationsSummary = $modificationsList -join "; "
Log-Execution -scriptName "script1.ps1" -modifications $modificationsSummary
