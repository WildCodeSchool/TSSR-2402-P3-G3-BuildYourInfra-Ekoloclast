####################################################################
#  Nom du Projet : 
#  Script en PowerShell pour Windows
#  Description :
#    
#  Auteurs :
#  
####################################################################


#######################################
# Affiche le menu principal.
# Auteur : 
#   
#######################################

function Menu {
    while ($true) {
        Write-Host "Script aide AD"
        Write-Host "1. Gestion des OU"
        Write-Host "2. Gestion des utilisateurs"
        Write-Host "3. Gestion des ordinateurs"
        Write-Host "4. Gestion des groupes"
        Write-Host "Q. Sortir du script.
        "
        $choiceM = Read-Host "Entrez le numero souhaite"
        # Redirection des choix 
        switch ($choiceM) {
            '1' {
                #Gestion des OU
                write-host " "
                GestOU
            }
            '2' {
                #Gestion des utilisateurs
                Write-Host " "
                GestUsers
            }
            '1' {
                #Gestion des ordinateurs
                write-host " "
                GestComputer
            }
            '1' {
                #Gestion des groupes
                write-host " "
                GestGroup
            }
            'q' {
                #Clear-Host
                Write-Host "A plus dans le bus !"
                Exit
            }
            default {
                $message = "Choix $choiceM invalide"

                Write-Host "Le choix $choiceM n'est pas disponible, merci de saisir 1, 2 ou R.
                "
            }
        }
    }
}


#####################################################
# Affiche le sous-menu Gestion des OU.
# Auteur : Nico
# 
#####################################################

function GestOU {
    while ($true) {
        #Affichage du menu Gestion des OU
        Write-Host "Gestion des OU"
        Write-Host "1. Creation OU manuelle"
        Write-Host "2. Creation de plusieurs OU à partir d'une liste"
        Write-Host "3. Modification champs description d'une liste d'OU"
        Write-Host "4. Suppression d'OU"
        Write-Host "R. Retour au menu précédent
        "

        $choiceGOU = Read-Host "Entrez le numero souhaite"
        # Redirection des choix 
        switch ($choiceGOU) {
            '1' {
                #Fonction Création OU manuelle
                createOUman
            }
            '2' {
                #Fonction Création de plusieurs OU à partir d'une liste
                createOUauto
            }
            '3' {
                #Fonction Modification champs description d'une liste d'OU
                
            }
            '4' {
                #Fonction Suppression d'OU
                Write-Host "NE FONCTIONNE PAS SANS ACTIVE DIRECTORY"
            }
            'R' {
                #Fonction Retour au menu precedent
                Write-Host "Back to the futur."
                return
            }
            Default { 

                Write-Host "Le choix $choiceGOU n'est pas disponible, merci de saisir un chiffre entre 1 et 4 ou R.
                "
            }
        }
    }
}

####################################################################################
#                                                                                  #
#   Création OU manuellement (avec suppression protection contre la suppression)   #
#                                                                                  #
####################################################################################

function createOUman {
    ### Parametre(s) à modifier

    $OU = Read-Host "Nom d'OU a creer"
    Write-Host "Dans quel OU principal ?"
    Write-Host "1. LabUtilisateurs"
    Write-Host "2. LabOrdinateurs"
    Write-Host "3. LabSecurite"
    $choiceOUPrincipale = Read-Host "Entrez le numero souhaite"
    switch ($choiceOUPrincipale) {
        '1' { $OUPrincipale = "OU LabUtilisateurs" }
        '2' { $OUPrincipale = "OU LabOrdinateurs" }
        '3' { $OUPrincipale = "OU LabSecurite" }
    }

    ### Initialisation

    $DomainDN = (Get-ADDomain).DistinguishedName

    ### Main

    function CreateOU {
        param ([Parameter(Mandatory = $True, Position = 0)][String]$OU,
            [Parameter(Mandatory = $True, Position = 1)][ValidateSet("OU LabOrdinateurs", "OU LabUtilisateurs", "OU LabSecurite")][String]$SearchBase)
    
        Switch ($SearchBase) {
            "OU LabOrdinateurs" { $DNSearchBase = "OU=LabOrdinateurs,$DomainDN" }
            "OU LabUtilisateurs" { $DNSearchBase = "OU=LabUtilisateurs,$DomainDN" }
            "OU LabSecurite" { $DNSearchBase = "OU=LabSecurite,$DomainDN" }
            default { $DNSearchBase = "OU=LabUtilisateurs,$DomainDN" }
        }

        If ((Get-ADOrganizationalUnit -Filter { Name -like $ou } -SearchBase $DNSearchBase) -eq $Null) {
            New-ADOrganizationalUnit -Name $OU -Path $DNSearchBase
            $OUObj = Get-ADOrganizationalUnit "ou=$OU,$DNSearchBase"
            $OUObj | Set-ADOrganizationalUnit -ProtectedFromAccidentalDeletion:$False
            Write-Host "Création de l'OU $($OUObj.DistinguishedName)" -ForegroundColor Green
        }
        Else {
            Write-Host "L'OU `"ou=$OU,$DNSearchBase`" existe déjà" -ForegroundColor Red
        }
    }

    If (-not(Get-Module -Name activedirectory)) {
        Import-Module activedirectory
    }

    CreateOU -OU $OU -SearchBase $OUPrincipale

}

####################################################################################################
#                                                                                                  #
#   Création OU automatiquement avec fichier (avec suppression protection contre la suppression)   #
#                                                                                                  #
####################################################################################################


function createOUauto {
    ### Parametre(s) à modifier
    Write-host "Le fichier doit etre dans le dossier du script"
    $fileName = Read-host "Nom complet du fichier avec les OU a creer"
    $FilePath = [System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)
    $File = "$FilePath\$fileName"

    ### Initialisation

    $DomainDN = (Get-ADDomain).DistinguishedName

    ### Main

    function CreateOU {
        param ([Parameter(Mandatory = $True, Position = 0)][String]$OU,
            [Parameter(Mandatory = $True, Position = 1)][ValidateSet("OU LabOrdinateurs", "OU LabUtilisateurs", "OU LabSecurite")][String]$SearchBase)
    
        Switch ($SearchBase) {
            "OU LabOrdinateurs" { $DNSearchBase = "OU=LabOrdinateurs,$DomainDN" }
            "OU LabUtilisateurs" { $DNSearchBase = "OU=LabUtilisateurs,$DomainDN" }
            "OU LabSecurite" { $DNSearchBase = "OU=LabSecurite,$DomainDN" }
            default { $DNSearchBase = "OU=LabUtilisateurs,$DomainDN" }
        }

        If ((Get-ADOrganizationalUnit -Filter { Name -like $ou } -SearchBase $DNSearchBase) -eq $Null) {
            New-ADOrganizationalUnit -Name $OU -Path $DNSearchBase
            $OUObj = Get-ADOrganizationalUnit "ou=$OU,$DNSearchBase"
            $OUObj | Set-ADOrganizationalUnit -ProtectedFromAccidentalDeletion:$False
            Write-Host "Création de l'OU $($OUObj.DistinguishedName)" -ForegroundColor Green
        }
        Else {
            Write-Host "L'OU `"ou=$OU,$DNSearchBase`" existe déjà" -ForegroundColor Red
        }
    }

    If (-not(Get-Module -Name activedirectory)) {
        Import-Module activedirectory
    }

    $OUs = Import-Csv -Path $File -Delimiter ";" -Header "OUServices", "OUPrincipales"

    Foreach ($OU in $OUs) {
        CreateOU -OU $OU.OUServices -SearchBase $OU.OUPrincipales
    }

}

#####################################################
# Affiche le sous-menu Gestion des utilisateurs.
# Auteur : Nico
# 
#####################################################

function GestUsers {
    while ($true) {
        #Affichage du menu Gestion des utilisateurs
        Write-Host "Gestion des utilisateurs"
        Write-Host "1. Creation d'utilisateurs"
        Write-Host "2. Creation de plusieurs utilisateurs à partir d'une liste"
        Write-Host "3. Recherche de doublon d'utilisateur"
        Write-Host "4. Suppression d'utilisateurs"
        Write-Host "R. Retour au menu précédent
        "

        $choiceGU = Read-Host "Entrez le numero souhaite"
        # Redirection des choix 
        switch ($choiceGU) {
            '1' {
                #Fonction Création d'utilisateurs
                Arreter-Client
            }
            '2' {
                #Fonction Création de plusieurs utilisateurs à partir d'une liste
                Restart-Computer
            }
            '3' {
                #Fonction Recherche de doublon d'utilisateur
                
            }
            '4' {
                #Fonction Suppression d'utilisateurs
                Write-Host "rien"
            }
            'R' {
                #Fonction Retour au menu precedent
                Write-Host "Back to the futur."
                return
            }
            Default { 

                Write-Host "Le choix $choiceGU n'est pas disponible, merci de saisir un chiffre entre 1 et 4 ou R.
                "
            }
        }
    }
}


#####################################################
# Affiche le sous-menu Gestion des ordinateurs.
# Auteur : Nico
# 
#####################################################

function GestComputer {
    while ($true) {
        #Affichage du menu Gestion des ordinateurs
        Write-Host "Gestion des ordinateurs"
        Write-Host "1. Création d'ordinateurs"
        Write-Host "2. Création de plusieurs ordinateurs à partir d'une liste"
        Write-Host "3. Recherche de doublon d'ordinateurs"
        Write-Host "4. Suppression d'ordinateurs"
        Write-Host "R. Retour au menu précédent
        "

        $choiceGC = Read-Host "Entrez le numero souhaite"
        # Redirection des choix 
        switch ($choiceGC) {
            '1' {
                #Fonction Création d'ordinateurs
                Arreter-Client
            }
            '2' {
                #Fonction Création de plusieurs ordinateurs à partir d'une liste
                Restart-Computer
            }
            '3' {
                #Fonction Recherche de doublon d'ordinateurs
                
            }
            '4' {
                #Fonction Suppression d'ordinateurs
                Write-Host "NE FONCTIONNE PAS SANS ACTIVE DIRECTORY"
            }
            'R' {
                #Fonction Retour au menu precedent
                Write-Host "Back to the futur."
                return
            }
            Default { 

                Write-Host "Le choix $choiceGC n'est pas disponible, merci de saisir un chiffre entre 1 et 4 ou R.
                "
            }
        }
    }
}


#####################################################
# Affiche le sous-menu Gestion des groupes.
# Auteur : Nico
# 
#####################################################

function GestGroup {
    while ($true) {
        #Affichage du menu Gestion des groupes
        Write-Host "Gestion des groupes"
        Write-Host "1. Création de groupes à partir d'une liste"
        Write-Host "2. Remplissage de groupe à partir des OU"
        Write-Host "R. Retour au menu précédent
        "

        $choiceGC = Read-Host "Entrez le numero souhaite"
        # Redirection des choix 
        switch ($choiceGC) {
            '1' {
                #Fonction Création de groupes à partir d'une liste
                Arreter-Client
            }
            '2' {
                #Fonction Remplissage de groupe à partir des OU
                Restart-Computer
            }
            '3' {
                #Fonction Recherche de doublon d'ordinateurs
                
            }
            '4' {
                #Fonction Suppression d'ordinateurs
                Write-Host "NE FONCTIONNE PAS SANS ACTIVE DIRECTORY"
            }
            'R' {
                #Fonction Retour au menu precedent
                Write-Host "Back to the futur."
                return
            }
            Default { 

                Write-Host "Le choix $choiceGC n'est pas disponible, merci de saisir un chiffre entre 1 et 4 ou R.
                "
            }
        }
    }
}

Menu