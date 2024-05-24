

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
                   

                Write-host "Ordinateur $computerName créé dans $targetOU avec succès." -ForegroundColor Green
            }
            catch {
                Write-host "Erreur lors de la création de l'ordinateur $computerName : $_" -ForegroundColor Red
            }
        }
    }
}


