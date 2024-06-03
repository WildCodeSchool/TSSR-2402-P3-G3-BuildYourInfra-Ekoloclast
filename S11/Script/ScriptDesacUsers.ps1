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
        Write-Host "L'utilisateur $username est désactivé."
    } else {
        Write-Host "L'utilisateur $username est actif."
    }
}