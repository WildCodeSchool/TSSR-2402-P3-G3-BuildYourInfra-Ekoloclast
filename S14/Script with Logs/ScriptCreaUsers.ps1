
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

    Write-Log -scriptName $scriptName -message "Script exécuté: $scriptName" -logDirectory $logDirectory
    Write-Log -scriptName $scriptName -message "Modifications: $modifications" -logDirectory $logDirectory

    # Enregistrement dans l'Observateur d'événements Windows
    $eventSource = "PowerShellScript"
    if (-not (Get-EventLog -LogName Application -Source $eventSource -ErrorAction SilentlyContinue)) {
        New-EventLog -LogName Application -Source $eventSource
    }

    Write-EventLog -LogName Application -Source $eventSource -EventId 1 -EntryType Information -Message "Script exécuté: $scriptName - Modifications: $modifications"
}

# Importer le module Active Directory
#Import-Module ActiveDirectory

# Chemin vers le fichier CSV
$csvPath = "C:\Users\Administrator\ScriptAD\s09_Ekoloclast.csv" # A modifier si besoin

# Lire le fichier CSV
$users = Import-Csv -Path $csvPath -Delimiter ";" -Header "Prenom", "Nom", "Societe", "Site", "Departement", "Service", "fonction", "Managerprenom", "Managernom", "PC", "Datedenaissance", "Telephonefixe", "Telephoneportable", "NomadismeTeletravail", "OUPrincipale", "FonctionModif" | Select-Object -Skip 1

# mise en variable du domaine
$DomainDN = (Get-ADDomain).DistinguishedName

# Parcourir chaque utilisateur dans le CSV
foreach ($user in $users) {
    # Préparer les propriétés de l'utilisateur
    $baseSamAccountName = ($user.Prenom.Substring(0, 3) + "." + $user.Nom).ToLower()
    $samAccountName = $baseSamAccountName
    $i = 1
    $prenom = $user.Prenom
    $Nom = $user.Nom
    $Societe = $user.Societe
    $Site = $user.Site
    $Departement = $user.Departement
    $Service = $user.Service
    $fonction = $user.fonction
    $Managerprenom = $user.Managerprenom
    $Managernom = $user.Managernom
    $PC = $user.PC
    $Datedenaissance = $user.Datedenaissance
    $Telephonefixe = $user.Telephonefixe
    $Telephoneportable = $user.Telephoneportable
    $NomadismeTeletravail = $user.NomadismeTeletravail
    $OUPrincipale = $user.OUPrincipale
    $FonctionModif = $user.FonctionModif
    #$mail = $user.mail # A modifier si besoin 

    
    # Vérifier l'existence de l'utilisateur et ajuster si nécessaire
    while (Get-ADUser -Filter { SamAccountName -eq $samAccountName }) {
        $samAccountName = "$baseSamAccountName$i"
        $i++
    }

    $displayName = "$prenom $Nom"
    $userPrincipalName = "$samAccountName@Ekoloclast.fr" # A modifier si besoin
    $password = "Azerty1*"  # Remplacer par une méthode plus sécurisée de gestion des mots de passe

    # Construire le chemin de l'OU
    $ouPath = "OU=$Service,OU=$Departement,OU=LabUtilisateurs,$DomainDN"


    # Vérifier si l'utilisateur existe déjà
    if (-not (Get-ADUser -Filter { SamAccountName -eq $SamAccountName })) {

        # Créer l'utilisateur
        if ($service.Length -ge 3) {
            try {

                New-ADUser `
                    -SamAccountName $samAccountName `
                    -UserPrincipalName $userPrincipalName `
                    -Name "$prenom $Nom" `
                    -GivenName $prenom `
                    -Surname $Nom `
                    -DisplayName "$prenom $Nom" `
                    -Department $Departement `
                    -Title $Service `
                    -Office $Site `
                    -Company $Societe `
                    -Path "OU=$Service,OU=$Departement,OU=LabUtilisateurs,$DomainDN" `
                    -AccountPassword (ConvertTo-SecureString "Azerty1*" -AsPlainText -Force) `
                    -Enabled $true `
                    -City $Site `
                    -OfficePhone $Telephonefixe `
                    -MobilePhone $Telephoneportable `
                    -Description "non" `
                    -EmailAddress $mail 
                $logMessage = "Utilisateur $displayName cree avec succes."
                $modificationsList =+ $logMessage
                Log-Execution -scriptName "ScriptCreaUsers.ps1" -modification $logMessage
                Write-host $logMessage -ForegroundColor green
            }
            catch {
                $errorMessage = "Erreur lors de la creation de l'utilisateur $displayName : $_"
                Log-Execution -scriptName "ScriptCreaUsers.ps1" -modification $errorMessage
                Write-host $errorMessage -ForegroundColor red
            }
        }
        else {
            try {

                New-ADUser `
                    -SamAccountName $samAccountName `
                    -UserPrincipalName $userPrincipalName `
                    -Name "$prenom $Nom" `
                    -GivenName $prenom `
                    -Surname $Nom `
                    -DisplayName "$prenom $Nom" `
                    -Department $Departement `
                    -Title $Service `
                    -Office $Site `
                    -Company $Societe `
                    -Path "OU=$Departement,OU=LabUtilisateurs,$DomainDN" `
                    -AccountPassword (ConvertTo-SecureString "Azerty1*" -AsPlainText -Force) `
                    -Enabled $true `
                    -City $Site `
                    -OfficePhone $Telephonefixe `
                    -MobilePhone $Telephoneportable `
                    -Description "non" `
                    -EmailAddress $mail 

                $logMessage = "Utilisateur $displayName cree avec succes."
                $modificationsList =+ $logMessage
                Log-Execution -scriptName "ScriptCreaUsers.ps1" -modification $logMessage
                Write-host $logMessage -ForegroundColor green
            }
            catch {
                $errorMessage = "Erreur lors de la creation de l'utilisateur $displayName : $_"
                Log-Execution -scriptName "ScriptCreaUsers.ps1" -modification $errorMessage
                Write-host $errorMessage -ForegroundColor red
            }
        }
    }

    # Vérifier si l'utilisateur existe déjà
    if (Get-ADUser -Filter { SamAccountName -eq $samAccountName }) {
        # Ajouter l'utilisateur aux groupes spécifiés
        $groups = $user.FonctionModif
        foreach ($group in $groups) {
            try {
                Add-ADGroupMember -Identity $group -Members $samAccountName
                $logMessage = "Utilisateur $displayName ajoute au groupe $group."
                $modificationsList =+ $logMessage
                Log-Execution -scriptName "ScriptCreaUsers.ps1" -modification $logMessage
                Write-host $logMessage -ForegroundColor Yellow
            }
            catch {
                $errorMessage = "Erreur lors de l'ajout de l'utilisateur $displayName au groupe $group : $_"
                Log-Execution -scriptName "ScriptCreaUsers.ps1" -modification $logMessage
                Write-host $errorMessage -ForegroundColor red
            }
        }
    }
}

# Write-Output "Processus terminé."
