#ps1
$Path = "C:\Users\Administrator"
$CsvFile = "$Path\Config.csv"

# Import du fichier config
$Param = Import-Csv -Path $CsvFile -Delimiter "," -Header "ServerName", "IPAddress", "SubnetMask", "Gateway", "DnsIpAddress", "DomainName", "DomainAdminUser", "DomainAdminPassword" -Encoding UTF8  | Select-Object -Skip 1

foreach ($Config in $Param) {

    #variable du fichier
    $ServerName = $Config.ServerName
    $IpAddress = $Config.IPAddress
    $SubnetMask = $Config.SubnetMask
    $Gateway = $Config.Gateway
    $DnsIp = $Config.DnsIpAddress
    $DomainName = $Config.DomainName
    $DomainAdmin = $Config.DomainAdminUser
    $DomainPassword = $Config.DomainAdminPassword

}

#Renommer le serveur
Rename-Computer -NewName $ServerName -Force

#Configuer les paramètres réseaux
$Interface = (Get-NetAdapter).ifIndex
New-NetIPAddress -InterfaceIndex $Interface -IPAddress $IpAddress -Prefix 24 -DefaultGateway $Gateway

#Configurer le DNS
Set-DnsClientServerAddress -InterfaceIndex $Interface -ServerAddresses $DnsIp

#Installer le rôle AD-DS
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

#ajout au domaine
Add-Computer -DomainName $DomainName -Credential $DomainAdmin

#Redémarrer le poste
Restart-Computer -Force



