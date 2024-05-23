# Chemin du fichier de configuration CSV
$configFilePath = "C:\Users\Administrator\config.csv"

# Charger les paramètres depuis le fichier de configuration CSV
$config = @{}
Import-Csv $configFilePath | ForEach-Object { $config[$_.Parameter] = $_.Value }

# Variables du fichier de configuration
$serverName = $config["ServerName"]
$ipAddress = $config["IpAddress"]
$SubnetMask = $config["SubnetMask"]
$Gateway = $config["Gateway"]
$DnsIpAddress = $config["DnsIpAddress"]
$DomainName = $config["DomainName"]
$DomainAdmin = $config["DomainAdminUser"]
$DomainAdminPassword = $config["DomainAdminPassword"]

# Changer le nom du serveur
Rename-Computer -NewName $serverName -Force -Restart

# Configurer une adresse IP statique
$interface = Get-NetAdapter | Where-Object { $_.Status -eq "Up" }
New-NetIPAddress -InterfaceAlias $interface.Alias -IPAddress $ipAddress -PrefixLength 24 -DefaultGateway $gateway
# Configurer le DNS
Set-DnsClientServerAddress -InterfaceAlias $interface.Alias -ServerAddresses $dnsIpAddress
# Redémarrer le serveur pour appliquer les changements de configuration réseau
Restart-Computer -Force

# Installation du rôle AD DS
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
# Si pas dans le domaine -> ajouter le serveur au domaine
Add-Computer -DomainName $domainName -Credential (New-Object System.Management.Automation.PSCredential ($domainAdmin, (ConvertTo-SecureString -AsPlainText $domainAdminPassword -Force)))
# Redémarrer le serveur après l'ajout au domaine
Restart-Computer -Force

