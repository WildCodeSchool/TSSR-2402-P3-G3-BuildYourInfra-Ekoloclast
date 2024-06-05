# Chemin racine où les dossiers sont situés
$rootPath = "C:\Users\Administrator\Tssr"

# Lire les noms des dossiers (correspondant aux groupes AD)
$departementFolders = Get-ChildItem -Path "$rootPath\departements" | Where-Object { $_.PSIsContainer }
$serviceFolders = Get-ChildItem -Path "$rootPath\services" | Where-Object { $_.PSIsContainer }

#Nom du domaine
$DomainDN = (Get-ADDomain).Name

# Fonction pour créer un partage et définir les permissions
function Share-Folder {
    param (
        [string]$folderPath,
        [string]$groupName
    )

    # Nom du partage
    #$shareName = Split-Path -Leaf $folderPath

    # Créer le partage / nom de domaine a changer
    New-SmbShare -Name $groupName -Path $folderPath -FullAccess "$DomainDN\$groupName"

    # Définir les permissions NTFS
    $acl = Get-Acl -Path $folderPath
    $ar = New-Object System.Security.AccessControl.FileSystemAccessRule("$DomainDN\$groupName", "FullControl", "ContainerInherit, ObjectInherit", "None", "Allow")
    $acl.SetAccessRule($ar)
    Set-Acl -Path $folderPath -AclObject $acl
}

# Créer les partages et configurer les permissions pour les dossiers de département
foreach ($folder in $departementFolders) {
    $groupName = $folder.Name
    $folderPath = $folder.FullName
    Share-Folder -folderPath $folderPath -groupName $groupName
}

# Créer les partages et configurer les permissions pour les dossiers de service
foreach ($folder in $serviceFolders) {
    $groupName = $folder.Name
    $folderPath = $folder.FullName
    Share-Folder -folderPath $folderPath -groupName $groupName
}
