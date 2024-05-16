##############################################
#                                            #
#  Script Pour création automatique des OU   #
#                                            #
##############################################


# Chemin vers le fichier CSV
$FilePath = [System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)
$cheminFichierCSV = "$FilePath\s09_Ekoloclast_New.csv"
$DomainDN = (Get-ADDomain).DistinguishedName

# Importer le fichier CSV
$data = Import-Csv -Path $cheminFichierCSV -Delimiter ";" -Header "Departement", "Service", "fonction", "OUPrincipale"

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
        Write-Host "OU '$NomOU' existe deja dans '$OUParent'" -ForegroundColor Red
    }
}

# Parcourir chaque ligne du fichier CSV
foreach ($ligne in $data) {
    $departement = $ligne.Departement
    $service = $ligne.Service
    $fonction = $ligne.fonction
    $ouPrincipale = $ligne.OUPrincipale

    # Vérifier si l'OU principale existe
    $ouPrincipaleExistante = Get-ADOrganizationalUnit -Filter "Name -eq '$ouPrincipale'"

    if ($ouPrincipaleExistante) {
        # Chemin de l'OU principale
        $cheminOUPrincipale = "OU=$ouPrincipale,$DomainDN"  # Remplacez par le bon chemin AD

        # Créer l'OU du département si spécifié
        if ($departement -ne "") {
            CreerOU -NomOU $departement -OUParent $cheminOUPrincipale
        }

        # Créer l'OU du service si spécifié
        if ($service -ne "") {
            CreerOU -NomOU $service -OUParent "OU=$departement,$cheminOUPrincipale"
        }

        # Créer l'OU de la fonction si spécifié
        if ($fonction -ne "") {
            CreerOU -NomOU $fonction -OUParent "OU=$service,OU=$departement,$cheminOUPrincipale"
        }
    }
    else {
        Write-Host "L'OU principale '$ouPrincipale' n'existe pas."
    }
}
