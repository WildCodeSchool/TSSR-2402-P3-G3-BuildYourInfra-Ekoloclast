# Importer le module Active Directory
#Import-Module ActiveDirectory

# Chemin vers le fichier CSV
$csvPath = "C:\Users\Administrator\ScriptAD\s09_Ekoloclast.csv"

# Lire le fichier CSV
$users = Import-Csv -Path $csvPath -Delimiter ";" -Header "Prenom", "Nom", "Societe", "Site", "Departement", "Service", "fonction", "Managerprenom", "Managernom", "PC", "Datedenaissance", "Telephonefixe", "Telephoneportable", "NomadismeTeletravail", "OUPrincipale", "FonctionModif"

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
    #while (Get-ADUser -Filter { SamAccountName -eq $samAccountName }) {
    #   
    #  $samAccountName = "$baseSamAccountName$i"
    # $i++
    #}

    $displayName = "$prenom $Nom"
    $userPrincipalName = "$samAccountName@$($user.Societe).fr"
    $password = "Azerty1*"  # Remplacer par une méthode plus sécurisée de gestion des mots de passe

    # Construire le chemin de l'OU
    $ouPath = "OU=$($user.Service),OU=$($user.Departement),$DomainDN"

    # Créer l'utilisateur
    try {

        New-ADUser `
            -SamAccountName $samAccountName `
            -UserPrincipalName "adrschultz@ekoloclast.local" `
            -Name "$prenom $Nom" `
            -GivenName $prenom `
            -Surname $Nom `
            -DisplayName "$prenom $Nom" `
            -Department $Departement `
            -Title $Service `
            -Office $Site `
            -Company $Societe `
            -Path "OU=$Service,OU=$Departement,OU=LabUtilisateurs,$DomainDN" `
            -AccountPassword (ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force) `
            -Enabled $true `
            -City $Site `
            -Manager (Get-ADUser -Filter { GivenName -eq $Managerprenom -and Surname -eq $Managernom }).DistinguishedName `
            -OfficePhone $Telephonefixe `
            -MobilePhone $Telephoneportable `
            -Description "non" `
            -EmailAddress $mail
        
        Write-Output "Utilisateur $displayName créé avec succès."
    }
    catch {
        Write-Error "Erreur lors de la création de l'utilisateur $displayName : $_"
    }

    # Ajouter l'utilisateur aux groupes spécifiés
    $groups = $user.FonctionModif -split "_"
    foreach ($group in $groups) {
        try {
            Add-ADGroupMember -Identity $group -Members $samAccountName
            Write-Output "Utilisateur $displayName ajouté au groupe $group."
        }
        catch {
            Write-Error "Erreur lors de l'ajout de l'utilisateur $displayName au groupe $group : $_"
        }
    }
}

Write-Output "Processus terminé."
