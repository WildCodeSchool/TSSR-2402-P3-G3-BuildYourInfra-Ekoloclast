
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

# Import-Module Active Directory module
Import-Module ActiveDirectory

# Define the path to the CSV file
$csvPath = "C:\Users\Administrator\Tssr\s09_Ekoloclast.csv"  # A modifier si besoin

$DomainDN = (Get-ADDomain).DistinguishedName


# Import the CSV file
$users = Import-Csv -Path $csvPath -Delimiter ";"

# Iterate over each user in the CSV
foreach ($user in $users) {
    $department = $user.Departement
    $service = $user.Service

    # Define the distinguished names (DN) for the OU and Sub-OU
    $ouDN = "OU=$department,OU=LabUtilisateurs,$DomainDN"
    $subOuDN = "OU=$service,OU=$department,OU=LabUtilisateurs,$DomainDN"

    # Define the group names
    $groupDepartment = "$department"
    $groupService = "$service"

    # Check if the department group exists, if not create it
    if (-not (Get-ADGroup -Filter "Name -eq '$groupDepartment'")) {
        New-ADGroup -Name $groupDepartment -Path $ouDN -GroupScope Global -GroupCategory Security
        $logMessage = "Le groupe $groupDepartment a été créé avec succes dans l'OU $ouDN"
        $modificationsList += $logMessage
        Log-Execution -scriptName "ScriptCreaGRPdepserv.ps1" -modification $logMessage
        Write-Host $logMessage -ForegroundColor Green
    }
    if ($service.Length -ge 3) {
        # Check if the service group exists, if not create it
        if ($service -and -not (Get-ADGroup -Filter "Name -eq '$groupService'")) {
            New-ADGroup -Name $groupService -Path $subOuDN -GroupScope Global -GroupCategory Security
            $logMessage = "Le groupe $groupService a été créé avec succes dans l'OU $subOuDN"
            $modificationsList += $logMessage
            Log-Execution -scriptName "ScriptCreaGRPdepserv.ps1" -modification $logMessage
            Write-Host $logMessage -ForegroundColor Green
        }
    }
}
