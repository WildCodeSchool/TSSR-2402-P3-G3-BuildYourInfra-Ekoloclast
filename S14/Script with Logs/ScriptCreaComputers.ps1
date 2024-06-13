######################################################
#                                                    #
#  Script Pour création automatique des ordinateurs  #
#                                                    #
######################################################

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

# Chemin vers le fichier CSV
$csvPath = "C:\Users\Administrator\ScriptAD\s09_Ekoloclast.csv"

# Lire le fichier CSV
$computers = Import-Csv -Path $csvPath -Delimiter ";"

# mise en variable du domaine
$DomainDN = (Get-ADDomain).DistinguishedName

# Parcourir chaque ordinateur dans le CSV
foreach ($computer in $computers) {
    $computerName = $computer.PC
    $departement = $computer.Departement
    $ouPrincipale = $computer.OUPrincipale

    # Construire le chemin de l'OU cible
    $targetOU = "OU=$departement,OU=LabOrdinateurs,$DomainDN"

    # Verifie que le pc est bien renseigner dans le csv
    if ($computerName.Length -ge 3) {

        # Vérifier si l'ordinateur existe dans Active Directory
        $adComputer = Get-ADComputer -Filter { Name -eq $computerName }

    

        # Vérifier si l'ordinateur n'existe pas
        if (-not ($adComputer)) {

            try {
                # Créer l'ordinateur dans l'OU cible
                New-ADComputer `
                    -Name $computerName `
                    -SamAccountName $computerName `
                    -Path $targetOU `
                    -DNSHostName ekoloclast.fr `
                    -PassThru
                $logMessage = "Ordinateur $computeurName créé dans $targetOU"
                $modificationsList += $logMessage
                Log-Execution -scriptName "ScriptCreaComputers.ps1" -modification $logMessage
                Write-host $logMessage -ForegroundColor Green
            }
            catch {
                $errorMessage = "Erreur lors de la création de l'ordinateur $computerName : $_"
                Log-Execution -scriptName "ScriptCreaComputers.ps1" -modification $errorMessage
                Write-host $errorMessage -ForegroundColor Red
            }
        }
    }
}


