###########################


# Importer le module Active Directory
Import-Module ActiveDirectory

# Variable 
$DomainDN = (Get-ADDomain).DistinguishedName

# Source et destination des OU
$sourceOU = "CN=Computers,$DomainDN"
$tempOU = "OU=Tampon,OU=labOrdinateurs,$DomainDN"


# Get all computers in the source OU
$computers = Get-ADComputer -SearchBase $sourceOU -Filter *

# Move each computer to the temporary OU
foreach ($computer in $computers) {
    $computerDistinguishedName = $computer.DistinguishedName
    try {
        # Move the computer to the temporary OU
        Move-ADObject -Identity $computerDistinguishedName -TargetPath $tempOU
        Write-Output "Succes du déplacement de $($computer.Name) dans $tempOU"
    } catch {
        Write-host "Echec du déplacement de $($computer.Name). Error: $_"
    }
}
