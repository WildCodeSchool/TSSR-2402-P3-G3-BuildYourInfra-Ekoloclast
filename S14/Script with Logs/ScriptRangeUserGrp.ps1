# Importer le module Active Directory
Import-Module ActiveDirectory

function Write-Log {
    param (
        [string]$scriptName,
        [string]$message,
        [string]$logDirectory = "C:\PowerShellLogs"
    )

    # Crée le répertoire de logs s'il n'existe pas
    if (-not (Test-Path $logDirectory)) {
        New-Item -ItemType Directory -Path $logDirectory
    }

    $logFile = Join-Path $logDirectory "$scriptName.log"

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "$timestamp - $message"
    Add-Content -Path $logFile -Value $logMessage
}

function Log-Execution {
    param (
        [string]$scriptName,
        [string]$modifications,
        [string]$logDirectory = "C:\PowerShellLogs"
    )
    
    Write-Log -scriptName $scriptName -message "Modifications: $modifications" -logDirectory $logDirectory

    # Enregistrement dans l'Observateur d'événements Windows
    $eventSource = "PowerShellScript"
    if (-not (Get-EventLog -LogName Application -Source $eventSource -ErrorAction SilentlyContinue)) {
        New-EventLog -LogName Application -Source $eventSource
    }

    Write-EventLog -LogName Application -Source $eventSource -EventId 1 -EntryType Information -Message "Script exécuté: $scriptName - Modifications: $modifications"
}

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
                Log-Execution -scriptName "ScriptRangeUserGrp.ps1" -modification $logMessage
                Write-Host $logMessage -ForegroundColor Yellow
            } catch {
                $errorMessage = "Erreur lors de l'ajout de l'utilisateur $displayName au groupe $group : $_"
                Log-Execution -scriptName "ScriptRangeUserGrp.ps1" -modification $errorMessage
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
                    Log-Execution -scriptName "ScriptRangeUserGrp.ps1" -modification $logMessage
                    Write-Host $logMessage -ForegroundColor Yellow
                } catch {
                    $errorMessage = "Erreur lors de l'ajout de l'utilisateur $displayName au groupe $group : $_"
                    Log-Execution -scriptName "ScriptRangeUserGrp.ps1" -modification $errorMessage
                    Write-Host $errorMessage -ForegroundColor Red
                }
            }
        } else {
            $message = "L'utilisateur $displayName n'existe pas"
            Write-Log -scriptName "ScriptRangeUserGrp.ps1" -message $message
            Write-Host $message -ForegroundColor DarkRed
        }
    }
}
