
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

# Demande les noms des utilisateurs à désactiver
$removename = Read-Host "Quels utilisateurs souhaitez-vous désactivez ? (séparés par des virgules) "

# Trie les noms d'utilisateurs en liste
$usernames = $removename -split ','

# Parcoure chaque utilisateur et le désactive
foreach ($username in $usernames) {

    # Desactive l'utilisateur et ajoute l'horodatage dans le champ descrption
    Set-ADUser -Identity $username -Enabled $false -Description "Désactivé le $(Get-Date -Format dd/MM/yyyy)"

    # Verifie la désactivation
    $desacverif = Get-ADUser -Identity $username -Properties Enabled
    
    if ($desacverif.Enabled -eq $false) {
        $logMessage = "L'utilisateur $username est désactivé."
        $modificationsList += $logMessage
        Log-Execution -scriptName "ScriptDesacUsers.ps1" -modification $logMessage
        Write-Host $logMessage
    } else {
        $errorMessage = "L'utilisateur $username est toujours actif."
        Log-Execution -scriptName "ScriptDesacUsers.ps1" -modification $errorMessage
        Write-Host $errorMessage
    }
}