##############################################
#                                            #
#  Script Pour création automatique des OU   #
#                                            #
##############################################

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
#$FilePath = [System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)
$cheminFichierCSV = "C:\Users\Administrator\ScriptAD\s09_Ekoloclast.csv"
$DomainDN = (Get-ADDomain).DistinguishedName

# Importer le fichier CSV
$data = Import-Csv -Path $cheminFichierCSV -Delimiter ";" -Header "Prenom", "Nom", "Societe", "Site", "Departement", "Service", "fonction", "Managerprenom", "Managernom", "PC", "Datedenaissance", "Telephonefixe", "Telephoneportable", "NomadismeTeletravail", "OUPrincipale", "FonctionModif"

# Fonction pour créer une unité organisationnelle (OU) avec suppression de la protection contre la suppression
function CreerOU {
    param (
        [Parameter(Mandatory = $true)][string]$NomOU,
        [Parameter(Mandatory = $true)][string]$OUParent
    )

    # Chemin complet de l'OU
    $cheminOU = "OU=$NomOU,$OUParent"

    # Vérifier si l'OU existe déjà
    if (-not (Get-ADOrganizationalUnit -Filter "Name -eq '$NomOU'" -SearchBase $OUParent)) {
        # Créer l'OU
        New-ADOrganizationalUnit -Name $NomOU -Path $OUParent
        Write-Host "OU '$NomOU' creee dans '$OUParent'" -ForegroundColor Green

        # Supprimer la protection contre la suppression pour l'OU
        Set-ADOrganizationalUnit -Identity $cheminOU -ProtectedFromAccidentalDeletion:$false
        Write-Host "Protection contre la suppression supprimee pour l'OU '$NomOU'"
    }
    else {
        #Write-Host "OU '$NomOU' existe deja dans '$OUParent'" -ForegroundColor Red
    }
}

# Parcourir chaque ligne du fichier CSV
foreach ($ligne in $data) {
    $departement = $ligne.Departement
    $service = $ligne.Service
    $fonctionModif = $ligne.fonctionModif
    $ouPrincipale = $ligne.OUPrincipale

    if ($ouPrincipale -eq "LabUtilisateurs") {

        # Vérifier si l'OU principale existe
        $ouPrincipaleExistante = Get-ADOrganizationalUnit -Filter "Name -eq '$ouPrincipale'"

        if ($ouPrincipaleExistante) {
            # Chemin de l'OU principale
            $cheminOUPrincipale = "OU=$ouPrincipale,$DomainDN"  # Remplacez par le bon chemin AD

            # Créer l'OU du département si spécifié
            if ($departement -ne "") {
                CreerOU -NomOU $departement -OUParent $cheminOUPrincipale
            }

            # Ne pas créer l'OU du service si la chaine est vide
            if ($service.Length -ge 3) {
                CreerOU -NomOU $service -OUParent "OU=$departement,$cheminOUPrincipale"
            }
            else { 
                $grpPath = "OU=$departement,$cheminOUPrincipale"

                # Vérifier si le groupe existe déjà
                if (-not (Get-ADGroup -Filter { Name -eq $fonctionModif })) {
                    try {
                        # Créer le groupe dans l'OU spécifiée
                        New-ADGroup -Name $fonctionModif -Path $grpPath -GroupScope Global -GroupCategory Security
                        $logMessage = "Le groupe $fonctionModif a été créé avec succes dans l'OU $grpPath"
                        $modificationsList += $logMessage
                        Log-Execution -scriptName "ScriptCreaOUetGRPauto.ps1" -modification $logMessage
                        Write-Host $logMessage -ForegroundColor Green
                    }
                    catch {
                        $errorMessage = "Erreur lors de la creation du groupe $fonctionModif dans l'OU $grpPath : $_" 
                        Log-Execution -scriptName "ScriptCreaOUetGRPauto.ps1" -modification $errorMessage
                        Write-Host $errorMessage -ForegroundColor Red
                    }
                }
                else {
                    #Write-Host "Le groupe $fonctionModif existe déjà." -ForegroundColor Yellow
                }
            
            }

            # Créer l'OU du service si spécifié
            # Creation simple des OU departements dans le labOrdinateurs
            CreerOU -NomOU $departement -OUParent "OU=LabOrdinateurs,$DomainDN"

            # Créer le groupe dans l'OU du service
            if ($fonctionModif -ne "") {
                $ouPath = "OU=$service,OU=$departement,$cheminOUPrincipale"

                # Vérifier si le groupe existe déjà
                if (-not (Get-ADGroup -Filter { Name -eq $fonctionModif })) {
                    try {
                        # Créer le groupe dans l'OU spécifiée
                        New-ADGroup -Name $fonctionModif -Path $ouPath -GroupScope Global -GroupCategory Security
                        $logMessage = "Le groupe $fonctionModif a été créé avec succes dans l'OU $ouPath"
                        $modificationsList += $logMessage
                        Log-Execution -scriptName "ScriptCreaOUetGRPauto.ps1" -modification $logMessage
                        Write-Host $logMessage -ForegroundColor Green
                    }
                    catch {
                        $errorMessage = "Erreur lors de la creation du groupe $fonctionModif dans l'OU $ouPath : $_"
                        Log-Execution -scriptName "ScriptCreaOUetGRPauto.ps1" -modification $errorMessage
                        Write-Host $errorMessage -ForegroundColor Red
                    }
                }
                else {
                    #Write-Host "Le groupe $fonctionModif existe déjà." -ForegroundColor Yellow
                }
            }
        }
        else {
            $errorMessage = "L'OU principale $ouPrincipale n'existe pas."
            Log-Execution -scriptName "ScriptCreaOUetGRPauto.ps1" -modification $errorMessage
            Write-Host $errorMessage
        }
        
    }

}
