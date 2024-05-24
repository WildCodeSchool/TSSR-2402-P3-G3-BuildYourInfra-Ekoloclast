#ps1
$Path = "C:\Users\Administrator"
$CsvFile = "$Path\Config.csv"

# Import du fichier config
$Users = Import-Csv -Path $CsvFile -Delimiter "," -Header "ServerName", "IPAddress", "SubnetMask", "Gateway", "DnsIpAddress", "DomainName", "DomainAdminUser", "DomainAdminPassword" -Encoding UTF8  | Select-Object -Skip 1

foreach ($User in $Users) {

    #variable du fichier
    $ServerName = $Config.ServeurName
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

#objet credential
$DomainCredential = New-Object System.Management.Automation.PSCredential($DomainAdmin, $DomainPassword)

#ajout au omaine
Add-Computer -DomainName $DomainName -Credential $DomainCredential


    



