####################################################################
#  Nom du Projet : System for Unified Master Operating aka SUMO
#  Script en PowerShell pour Windows
#  Description :
#    Script permettant l'automatisation de la gestion de postes 
#    et d'utilisateurs client.
#  Auteurs :
#   - Ahmed Ben Rebai <benrebaiahmed@gmail.com>
#   - Nicolas Claverie <claverie.nicolas.lapo@gmail.com>
#   - Pierre Girard <pierre.girard2788@gmail.com>
#   - Alexandre Peyronie <alexpeyro@gmail.com>
#   - Luca Pouilly <luca.pouilly@hotmail.com>
####################################################################


#######################################
# Affiche le menu principal.
# Auteur : Nico
#   
#######################################

function Menu {
    while ($true) {
        Write-Host "    ----------------------------------------------------------
    Bonjour, bienvenue dans Sumo, comment puis-je vous aider ?
    ----------------------------------------------------------
    "
        $message = "Début script Sumo"
        Write-Log
        Write-Host "1. Je veux cibler l'utilisateur."
        Write-Host "2. Je veux cibler l'ordinateur."
        Write-Host "Q. Je veux sortir du script.
        "
        $choiceM = Read-Host "Entrez le numero souhaite"
        # Redirection des choix 
        switch ($choiceM) {
            '1' {
                #Choix Utilisateur
                $message = "Choix 1 Utilisateur"
                Write-Log
                write-host " "
                User_Menu
            }
            '2' {
                #Choix ordinateur
                Write-Host " "
                $message = "Choix 2 Ordinateur"
                Write-Log
                Computer_Menu
            }
            'q' {
                #Clear-Host
                Write-Host "Sumo vous remercie d'avoir fait appel a ses services."
                $message = "Sortie du script Sumo"
                Write-Log
                Exit
            }
            default {
                $message = "Choix $choiceM invalide"
                Write-Log
                Write-Host "Ce choix n'est pas disponible, merci de saisir 1, 2 ou R.
                "
            }
        }
    }
}

#######################################
# Affiche le sous-menu utilisateurs.
# Auteur : Nico
# 
#######################################

function User_Menu {
    while ($true) {
        Write-Host "    --------------------------------------------------
    Menu utilisateur, que souhaitez-vous faire ?
    --------------------------------------------------
            "
        Write-Host "1. Je veux des information."
        Write-Host "2. Je veux effectuer une action."
        Write-Host "R. Je veux retourner au menu precedent.
        "
        $choiceUM = Read-Host "Entrez le numero souhaite: "
        # Redirection des choix 
        switch ($choiceUM) {
            '1' {
                #Choix information
                $message = "Choix $choiceUM information utilisateur"
                Write-Log
                Write-Host " "
                User_Menu_info
            }
            '2' {
                #Choix Action
                $message = "Choix $choiceUM action utilisateur"
                Write-Log
                Write-Host " "
                User_Menu_Action
            }
            'r' {
                Write-Host "Back to the futur."
                $message = "Retour menu précédent"
                Write-Log
                return
            }
            default {
                $message = "Choix $choiceUM invalide"
                Write-Log
                Write-Host "Ce choix n'est pas disponible, merci de saisir 1, 2 ou R.
                "
            }
        }
    }
}

#####################################################
# Affiche le sous-menu d'info sur les utilisateurs.
# Auteur : Nico
# 
#####################################################

function User_Menu_info {
    while ($true) {
        Write-Host "    --------------------------------------------------------------
    Menu informartion de l'utilisateur, que souhaitez-vous faire ?
    --------------------------------------------------------------
    "
        Write-Host "1. Date de derniere connexion"
        Write-Host "2. Date de la derniere modification du mot de passe"
        Write-Host "3. Liste des sessions ouvertes par l'utilisateur"
        Write-Host "4. A quelle groupe appartient l'utilisateur"
        Write-Host "5. Liste des commandes utiliser par l'utilisateur"
        Write-Host "6. Droit et permissions de l'utilisateur sur un dossier"
        Write-Host "7. Droit et permissions de l'utilisateur sur un fichier"
        Write-Host "8. Recherche des evenements dans le fichier log_evt.log pour un utilisateur"
        Write-Host "R. Retour au menu precedent
        "
        $choiceUMI = Read-Host "Entrez le numero souhaite"
        # Redirection des choix 
        switch ($choiceUMI) {
            '1' {
                #Fonction Date de dernière connexion
                $message = "Choix 1 Date de derniere connexion"
                Write-Log
                Lastconnexion
            }
            '2' {
                #Fonction Date de la dernière modification du mot de passe
                $message = "Choix 2 Date de la dernière modification du mot de passe"
                Write-Log
                last_change_password
            }
            '3' {
                #Fonction Liste des sessions ouvertes par l'utilisateur
                $message = "Choix 3 Liste des sessions ouvertes par l'utilisateur"
                Write-Log
                sesionactive
            }
            '4' {
                #Fonction A quelle groupe appartient l'utilisateur
                $message = "Choix 4 A quelle groupe appartient l'utilisateur"
                Write-Log
                user_group
            }
            '5' {
                #Fonction Liste des commandes utiliser par l'utilisateur
                $message = "Choix 5 Liste des commandes utiliser par l'utilisateur"
                Write-Log
                Write-Host "IMPOSSIBLE SANS PSReadLine"
            }
            '6' {
                #Fonction Droit et permissions de l'utilisateur sur un dossier
                $message = "Choix 6 Droit et permissions de l'utilisateur sur un dossier"
                Write-Log
                Droitsdossier
            }
            '7' {
                #Fonction Droit et permissions de l'utilisateur sur un fichier
                $message = "Choix 7 Droit et permissions de l'utilisateur sur un fichier"
                Write-Log
                Filedroit
            }
            '8' {
                #Fonction Recherche des événements dans le fichier log_evt.log pour un utilisateur
                $message = "Choix 8 Recherche des événements dans le fichier log_evt.log pour un utilisateur"
                Write-Log
                userEvtLog
            }
            'r' {
                #Retour au menu précédent
                $message = "Retour menu précédent"
                Write-Log
                Write-Host "Back to the futur."
                return 
            }
            Default {
                $message = "Choix $choiceUMI invalide"
                Write-Log
                Write-Host "Ce choix n'est pas disponible, merci de saisir un chiffre entre 1 et 8 ou R.
                " 
            }
        }
    }   
}

#####################################################
# Fonction Date de dernière connexion
# Auteur : Luca/Nico
# 
#####################################################

function Lastconnexion {

    
    # Demande le nom de l'utilisateur à rechercher
    $lastuser = Read-Host "Nom utilisateur"
    
    # Recherche la derniere connexion de l'utilisateur
    Write-Output "Date de la derniere connexion de l'utilisateur $lastuser" >> $info_log
    $lastLogin = Invoke-Command -ScriptBlock { param ($lastuser) Get-WinEvent -FilterHashtable @{ LogName ='Security'; ID = 4624 } -MaxEvents 1000 |  Where-Object { $_.Properties[5].Value -eq "$lastuser" } | Sort-Object TimeCreated -Descending | Select-Object -First 1} -argumentlist $lastuser -Session $session | Tee-Object $info_log -Append
    $message "Date de la derniere connexion de l'utilisateur $lastuser"
    Write-Log
        
    if ($lastLogin) {
    # Affiche la dernière date de connexion
    Write-output "Dernière connexion de l'utilisateur $lastuser : $($lastLogin.TimeCreated)"
    } else {
    Write-output "Aucune connexion trouvé pour l'utilisateur $lastuser."
    }

}

#####################################################
# Fonction Date de la dernière modification du mot de passe 
# Auteur : Pierre
# 
#####################################################

function last_change_password() {
    $user = Read-Host "De quelle utilisateur voulez vous savoir a quelle date a eus lieux le dernier changement de mot passe"
    if(Invoke-Command -scriptBlock { param($user) Get-LocalUser -Name $user 2> $null } -ArgumentList $user -Session $session)  
    {   
        Write-Output "Date de derniere modification du mot de passe de l'utilisateur $user" >> $info_log
        Invoke-Command -scriptBlock { param($user) (Get-LocalUser -Name $user).PasswordLastSet } -ArgumentList $user -Session $session | Tee-Object $info_log -Append
        $message = "affichage de la derniere fois que $nomUtilisateur a changer de mot de passe"
        Write-Log $message
    }
    else
    {
        write-host "L'utilisateur n'existe pas"
        $message = "affichage de la derniere fois que $nomUtilisateur a changer de mot de passe ECHEC car l'utilisateur n'existe pas"
        Write-Log $message
    }
    
}

#####################################################
# Fonction Liste des sessions ouvertes par l'utilisateur
# Auteur : Luca
# 
#####################################################

function sesionactive {

    Write-Output "Liste des session actives" >> $info_log
    Invoke-Command { query session } -Session $session | Tee-Object $info_log -Append
    $message = "Affichage des sessions active"
    Write-Log
    
}


#####################################################
# Fonction A quelle groupe appartient l'utilisateur
# Auteur : Pierre
# 
#####################################################

function user_group()
{
    $username_user = Read-Host "quelle utilisateur voulez vous cibler? "
    if (Invoke-Command -ScriptBlock { param($username) Get-LocalUser -Name $username 2> $null } -ArgumentList $username_user -Session $session)  
    {
        Write-Output "Liste des groupes auxquels appartient l'utilisateur $username_user" >> $info_log
        Invoke-Command -ScriptBlock { param($username) (net user $username)[22,23] } -ArgumentList $username_user -Session $session | Tee-Object $info_log -Append
        $message = "affichage a quelle groupe appaartient l'utilisateur"
        Write-Log $mesage 
        
    }
    else
    {
        write-host "L'utilisateur n'existe pas"
        $message = "impossible de savoir a quelle groupe appartient l'utilisateur"
        Write-Log $mesage
    }
}


#####################################################
# Fonction Liste des commandes utiliser par l'utilisateur
# Auteur : Nico
#  !!! Impossible a utiliser les commandes ne s'enregistre pas dans la machine !!!
#####################################################

#Invoke-Command -ScriptBlock { Get-History } -Session $session

#####################################################
# Fonction Droit et permissions de l'utilisateur sur un dossier
# Auteur : Luca
# 
#####################################################

function Droitsdossier {

    $message = "Affichage des droits du dossier $droitdoss pour l'utilisateur $droituser"
    Write-Log
    $droituser = Read-Host "de quel utilisateur verifier les doits sur un dossier "
    $droitdoss = Read-Host "de quel dossier verifier les droits d'un utilisateur chemin complet "

    Write-Output "Droits de l'utilisateur $droituser sur le dossier $droitdoss " >> $info_log
    
    Invoke-Command -ScriptBlock { param ($droitdoss,$droituser) Get-Acl -Path $droitdoss | Select-Object -ExpandProperty Access | Where-Object { $_.IdentityReference -match "$droituser" } } -argumentlist $droitdoss,$droituser -Session $session | Tee-Object $info_log -Append

}

#####################################################
# Fonction Droit et permissions de l'utilisateur sur un fichier
# Auteur : Luca
# 
#####################################################

function Filedroit {

    $message = "Vérification des droits du fichier $droitfile pour l'utilisateur $fileuser"
    Write-Log
    $fileuser = Read-Host "de quel utilisateur verifier les doits sur un fichier "
    $droitfile = Read-Host "de quel fichier verifier les droits d'un utilisateur chemin complet "
    
    Write-Output "Droits de l'utilisateur $fileuser sur le dossier $droitfile " >> $info_log

    Invoke-Command -ScriptBlock { param ($droitfile,$fileuser) Get-Acl -Path $droitfile | Select-Object -ExpandProperty Access | Where-Object { $_.IdentityReference -match "$fileuser" } } -argumentlist $droitfile,$fileuser -Session $session | Tee-Object $info_log -Append
}


#####################################################
# Fonction Recherche des événements dans le fichier log_evt.log pour un utilisateur
# Auteur : Nico
# 
#####################################################

function userEvtLog {
    $userevtlogg = Read-Host "Quel utilisateur pour la consultation"
    $message = "Consultation du fichier log_evt.log pour l'utilisateur $userevtlogg"
    Write-Log
    Write-Output "Consultation du fichier log_evt.log pour l'utilisateur $userevtlogg" >> $info_log
    Get-Content C:\Windows\System32\LogFiles\log_evt.log | Select-String $userevtlogg | Tee-Object $info_log -Append
    $message = "Fin consultation du fichier log_evt.log pour l'utilisateur"
    Write-Log
}

#####################################################
# Affiche le sous-menu d'action sur les utilisateurs.
# Auteur : Nico
# 
#####################################################

function User_Menu_Action {
    while ($true) {
        Write-Host "    --------------------------------------------------------------
    Menu action de l'utilisateur, que souhaitez-vous faire ?
    --------------------------------------------------------------
    "
        Write-Host "1. Creation d'un compte local"
        Write-Host "2. Changer le mot de passe d'un compte"
        Write-Host "3. Suppression d'un compte utilisateur"
        Write-Host "4. Desactivation d'un compte utilisateur local"
        Write-Host "5. Ajout a un groupe d'administration"
        Write-Host "6. Ajout a un groupe local"
        Write-Host "7. Sortie d'un groupe local"
        Write-Host "R. Retour au menu precedent
        "
        $choiceUMA = Read-Host "Entrez le numero souhaite"
        # Redirection des choix 
        switch ($choiceUMA) {
            '1' {
                #Fonction Création d'un compte local
                $message = "Choix 1 Création d'un compte local"
                Write-Log
                add_user
            }
            '2' {
                #Fonction Changer le mot de passe d'un compte
                $message = "Choix 2 Changer le mot de passe d'un compte"
                Write-Log
                ChangePassword
            }
            '3' {
                #Fonction Suppression d'un compte utilisateur
                $message = "Choix 3 Suppression d'un compte utilisateur"
                Write-Log
                DeleteUser
            }
            '4' {
                #Fonction Désactivation d'un compte utilisateur local
                $message = "Choix 4 Désactivation d'un compte utilisateur local"
                Write-Log
                DisableUser
            }
            '5' {
                #Fonction Ajout a un groupe d'administration
                $message = "Choix 5 Ajout a un groupe d'administration"
                Write-Log
                AddAdminGroup
            }
            '6' {
                #Fonction Ajout a un groupe local
                $message = "Choix 6 Ajout a un groupe local"
                Write-Log
                AddLocalGroup
            }
            '7' {
                #Fonction Sortie d'un groupe local
                $message = "Choix 7 Sortie d'un groupe local"
                Write-Log
                RemoveLocalGroup
            }
            'r' {
                #Retour au menu précédent
                $message = "Retour menu précédent"
                Write-Log
                Write-Host "Back to the futur."
                return 
            }
            Default {
                $message = "Choix Choix $choiceUMA invalide"
                Write-Log
                Write-Host "Ce choix n'est pas disponible, merci de saisir un chiffre entre 1 et 7 ou R.
                " 
            }
        }     
    }

}

#####################################################
# Fonction Création d'un compte local
# Auteur : Pierre
# 
#####################################################

function add_user {
    $username_user = Read-Host "Quel utilisateur voulez-vous ajouter?"
    if (Invoke-Command -ScriptBlock {param($username) Get-LocalUser -Name $username 2> $null} -ArgumentList $username_user -Session $session) {
        Write-Host "L'utilisateur existe déjà."
        $message = "l'utilisateur $username_user ne peut pas etre creer car il exite deja"
        Write-Log $mesage
    }
    else {
        $password_user = Read-Host -AsSecureString "Choisissez un mot de passe pour le compte"
        Invoke-Command -ScriptBlock {param($username, $password) New-LocalUser -Name $username -Password $password 2> $null} -ArgumentList $username_user, $password_user -Session $session
        if (Invoke-Command -ScriptBlock {param($username) Get-LocalUser -Name $username} -ArgumentList $username_user -Session $session) {
            Write-Host "L'utilisateur a bien été créé."
            $message = "l'Utilisateur $username_user a été creer"
            Write-Log $mesage
        }
    }
}

#####################################################
# Fonction Changer le mot de passe d'un compte
# Auteur : Alexandre
# 
#####################################################

function ChangePassword () {
    $nomUtilisateur = Read-Host "Nommez l'utilisateur"
    $nouveauMotDePasse = Read-Host "Veuillez entrer le nouveaux mot de passe" -AsSecureString
    $confirm = Read-Host "Voulez vous vraiment changer le mot de passe de $nomUtilisateur ? Taper [o] pour confirmer"
    if ($confirm -eq "o") {
        Invoke-Command -ScriptBlock { param($nomUtilisateur, $nouveauMotDePasse) Set-LocalUser -Name $nomUtilisateur -Password $nouveauMotDePasse } -ArgumentList $nomUtilisateur, $nouveauMotDePasse -Session $session
        Write-Host "Le mot de passe de $nomUtilisateur à bien été modifié" -ForegroundColor Green
        }
        else{
        Write-Host " Erreur " -ForegroundColor Red 
    }
    $message = "Le mot de passe de $nomUtilisateur à bien été modifié"
    Write-Log $message
}

#####################################################
# Fonction Suppression d'un compte utilisateur
# Auteur : Alexandre
# 
#####################################################

function DeleteUser () {

    $nomUtilisateur = Read-Host "Nommez l'utilisateur"
    $confirm = Read-Host "Voulez vous vraiment supprimer $nomUtilisateur ? Taper [o] pour oui "
    if ($confirm -eq "o") {
        Then 
        Invoke-Command -ScriptBlock { param( $nomUtilisateur) Remove-LocalUser -Name $nomUtilisateur } -ArgumentList $nomUtilisateur -Session $session
        Write-Host "$nomUtilisateur a bien été supprimé" -ForegroundColor Green
        }
        Else { 
        Write-Host " Erreur " -ForegroundColor Red 
    }
    $message = "$nomUtilisateur a bien été supprimer"
    Write-Log $message
}

#####################################################
# Fonction Désactivation d'un compte utilisateur local
# Auteur : Alexandre
# 
#####################################################

Function DisableUser () {
    $nomUtilisateur = Read-Host "Nommez l'utilisateur"
    $confirm = Read-Host "Voulez vous vraiment désactiver $nomUtilisateur ? Taper [o] pour confirmer"
    if ($confirm -eq "o") {
        then
        Invoke-Command -ScriptBlock { param($nameUser) Disable-User -Name $nameUser } -ArgumentList $nomUtilisateur -Session $session 
        Write-Host "$nomUtilisateur à bie nété désactivé" -ForegroundColor Green
        }
        else {
        Write-Host " Erreur " -ForegroundColor Red 
    }
    $message = "$nomUtilisateur a bien été désactivé"
    Write-Log $message
}

#####################################################
# Fonction Ajout a un groupe d'administration
# Auteur : Alexandre
# 
#####################################################

Function AddAdminGroup () {
    $nomUtilisateur = Read-Host "Nommez l'utilisateur"
    $confirm = Read-Host "Voulez vous vraiment ajouter $nomUtilisateur au groupe d'administration? Taper [o] pour confirmer."
    if ($confirm -eq "o") {
        then
        Invoke-Command -ScriptBlock { param($userName) Add-LocalGroupMember -Group Administrateurs -Member $userName } -ArgumentList $nomUtilisateur -Session $session
        Write-Host "$nomUtilisateur à bien été ajouter au groupe administrateur" -ForegroundColor Green
        }
        else {
        Write-Host " Erreur " -ForegroundColor Red 
    }
    $message = "$nomUtilisateur a bien été ajouter au groupe administrateur"
    Write-Log $message
}

#####################################################
# Fonction Ajout a un groupe local
# Auteur : Alexandre
# 
#####################################################

Function AddLocalGroup () {
    $nomUtilisateur = Read-Host "Nommez l'utilisateur"
    $localGroup = Read-Host "Nommer dans quel groupe voulez vous ajouter $nomUtilisateur"
    $confirm = Read-Host "Voulez vous vraiment ajouter $nomUtilisateur a $localGroup ? Taper [o] pour confirmer."
    if ($confirm -eq "o") {
        Invoke-Command -ScriptBlock { param($localGroup, $nomUtilisateur) Add-LocalGroupMember -Group $localGroup -Member $nomUtilisateur } -ArgumentList $localGroup, $nomUtilisateur -Session $session
        Write-Host "$nomUtilisateur à bien été ajouté au groupe $localGroup " -ForegroundColor Green
        }
        else {
        Write-Host "Erreur" -ForegroundColor Red 
    }
    $message = "$nomUtilisateur a bien été ajouter au groupe $localGroup"
    Write-Log $message
}

#####################################################
# Fonction Sortie d'un groupe local
# Auteur : Alexandre
# 
#####################################################

Function RemoveLocalGroup () {
    $nomUtilisateur = Read-Host "Nommez l'utilisateur"
    $nomGroup = Read-Host "De quel groupe voulez vous supprimer $nomUtilisateur ? "
    $confirm = Read-Host "Voulez vous vraiment supprimer $nomUtilisateur du groupe nomGroup ? Taper [o] pour confirmer."
    if ($confirm -eq "o") {
        then
        Invoke-Command -ScriptBlock { param($nomGroup, $nomUtilisateur) Remove-LocalGroupMember -Group $nomGroup -Member $nomUtilisateur } -ArgumentList $nomGroup, $nomUtilisateur -Session $session
        Write-Host "$nomUtilisateur à bie nété enlever du groupe $nomGroup" -ForegroundColor Green
        }
        else {
        Write-Host "Erreur" -ForegroundColor Red 
    }
    $message = "$nomUtilisateur a bien été enlever du groupe $nomGroup"
    Write-Log $message
}

#######################################
# Affiche le sous-menu ordinateur.
# Auteur : Nico
# 
#######################################

function Computer_Menu {
    while ($true) {
        Write-Host "    --------------------------------------------------
    Menu ordinateur, que souhaitez-vous faire ?
    --------------------------------------------------
    "
        Write-Host "1. Je veux des information."
        Write-Host "2. Je veux effectuer une action."
        Write-Host "R. Je veux retourner au menu precedent.
        "
        $choiceCM = Read-Host "Entrez le numero souhaite"
        # Redirection des choix 
        switch ($choiceCM) {
            '1' {
                #Choix information
                $message = "Choix 1 information ordinateur"
                Write-Log
                Write-Host " "
                Computer_Menu_Info
            }
            '2' {
                #Choix Action
                $message = "Choix 2 action ordinateur"
                Write-Log
                Write-Host " "
                Computer_Menu_Action
            }
            'r' {
                #Retour au menu précédent
                $message = "Retour menu précédent"
                Write-Log
                Write-Host "Back to the futur."
                return
            }
            default {
                $message = "Choix $choiceCM invalide"
                Write-Log
                Write-Host "Ce choix n'est pas disponible, merci de saisir 1, 2 ou R.
                "
            }
        }
    }
}

#####################################################
# Affiche le sous-menu d'info sur les ordinateurs.
# Auteur : Nico
# 
#####################################################

function Computer_Menu_Info {
    
    Write-Host "    --------------------------------------------------------------
    Menu action de l'utilisateur, que souhaitez-vous faire ?
    --------------------------------------------------------------
    "
    Write-Host "1. Version de l'OS"
    Write-Host "2. Nombre de disque"
    Write-Host "3. Partition(nombres,nom,FS,taille)"
    Write-Host "4. Espace disque restant sur par partitions"
    Write-Host "5. Nom et espace disque d'un dossier(nom de dossier demande)"
    Write-Host "6. Liste des lecteurs monte (disque,CD,etc...)"
    Write-Host "7. Liste des applications/paquets installees"
    Write-Host "8. Liste des services en cours d'execution"
    Write-Host "9. Liste des utilisateurs locaux"
    Write-Host "10. Memoire RAM total"
    Write-Host "11. Utilisation de la RAM"
    Write-Host "12. Recherche des événements dans le fichier log_evt.log pour la machine"
    Write-Host "R. Retour au menu precedent
    "

    $choiceCMI = Read-Host "Entrez le numero souhaite"
    # Redirection des choix 
    switch ($choiceCMI) {
        '1' {
            #Fonction Version de l'OS
            $message = "Choix 1 Version de l'OS"
            Write-Log
            os_version
        }
        '2' {
            #Fonction Nombre de disque
            $message = "Choix 2 Nombre de disque"
            Write-Log
            nbDisk
        }
        '3' {
            #Fonction Partition(nombres,nom,FS,taille)
            $message = "Choix 3 Partition(nombres,nom,FS,taille)"
            Write-Log
            partGet
        }
        '4' {
            #Fonction Espace disque restant sur par partitions
            $message = "Choix 4 Espace disque restant sur par partitions"
            Write-Log
            spaceDisk
        }
        '5' {
            #Fonction Nom et espace disque d'un dossier(nom de dossier demande)
            $message = "Choix 5 Nom et espace disque d'un dossier"
            Write-Log
            dossSize_use
        }
        '6' {
            #Fonction Liste des lecteurs monte (disque,CD,etc...)
            $message = "Choix 6 Liste des lecteurs monte"
            Write-Log
            lecteur_list
        }
        '7' {
            #Fonction Liste des applications/paquets installees
            $message = "Choix 7 Liste des applications/paquets installees"
            Write-Log
            list_install
        }
        '8' {
            #Fonction Liste des services en cours d'execution
            $message = "Choix 8 Liste des services en cours d'execution"
            Write-Log
            service_run
        }
        '9' {
            #Fonction Liste des utilisateurs locaux
            $message = "Choix 9 Liste des utilisateurs locaux"
            Write-Log
            list_user_local
        }
        '10' {
            #Fonction Memoire RAM total
            $message = "Choix 10 Memoire RAM total"
            Write-Log
            ram_total
        }
        '11' {
            #Fonction Utilisation de la RAM
            $message = "Choix 11 Utilisation de la RAM"
            Write-Log
            ram_use
        }
        '12' {
            #Fonction Recherche des événements dans le fichier log_evt.log pour la machine
            $message = "Choix 12 Recherche des événements dans le fichier log_evt.log pour la machine"
            Write-Log
            compEvtLog
        }
        'R' {
            #Fonction Retour au menu precedent
            $message = "Retour menu précédent"
            Write-Log
            Write-Host "Back to the futur."
            return
        }
        Default { 
            $message = "Choix $choiceCMI invalide"
            Write-Log
            Write-Host "Ce choix n'est pas disponible, merci de saisir un chiffre entre 1 et 12 ou R.
            "
        }
    }
}

#####################################################
# Fonction Version de l'OS
# Auteur : Pierre
# 
#####################################################

function os_version()
{
    Write-Output "Version le l'OS" >> $info_log
    Invoke-Command -ScriptBlock { Get-WmiObject Win32_OperatingSystem | Format-Table Version } -Session $session | Tee-Object $info_log -Append
    $message = "affichage de la version de l'OS"
    Write-Log $mesage
}

#####################################################
# Fonction Nombre de disque
# Auteur : Nico
# 
#####################################################

function nbDisk {
    $message = "Affichage nombre de disques"
    Write-Log
    Write-Output "Nombre de disques" >> $info_log
    Invoke-Command -ScriptBlock { Get-Disk | Select-Object disknumber } -Session $session | Tee-Object $info_log -Append
    $message = "Fin affichage nombre de disques"
    Write-Log
}

#####################################################
# Fonction Partition(nombres,nom,FS,taille)
# Auteur : Nico
# 
#####################################################

function partGet {
    $message = "Affichage des informations de partition"
    Write-Log
    Write-Output "Informations de partition des disques">> $info_log
    Get-Partition | Select-Object -Property PartitionNumber, DriveLetter, @{Name = "SizeGB"; Expression = { [math]::Round($_.Size / 1GB, 2) } }, FileSystem, DiskNumber | Tee-Object $info_log -Append
    $message = "Fin affichage des informations de partition"
    Write-Log
}

#####################################################
# Fonction Espace disque restant sur par partitions
# Auteur : Nico
# 
#####################################################

function spaceDisk {
    $message = "Affichage de l'espace disque restant"
    Write-Log
    Write-Output "Informations espace disques restant" >> $info_log
    Invoke-Command -ScriptBlock { Get-WmiObject -Class Win32_LogicalDisk | 
        Select-Object -Property DeviceID, VolumeName, @{
            label      = 'FreeSpace'
            expression = { ($_.FreeSpace / 1GB).ToString('F2') }
        } } -Session $session | Tee-Object $info_log -Append
    $message = "Fin d'affichage nombre de disques"
    Write-Log
}

#####################################################
# Fonction Nom et espace disque d'un dossier(nom de dossier demandé)
# Auteur : Luca
# 
#####################################################

function dossSize_use {

    $message = "Affichege de la taille du dossier $doss_name"
    Write-Log
    # Demander à l'utilisateur le chemin du dossier
    $doss_name = Read-Host "Entrez le chemin complet du dossier"
    
        # Vérifier si le dossier existe
        if (Test-Path $doss_name) {
        # Calculer la taille totale du dossier
        Write-Output "Taille du dossier $doss_name" >> $info_log
        Invoke-Command -ScriptBlock { param ($doss_name) Get-ChildItem $doss_name -Recurse | Measure-Object -Property Length -Sum } -argumentlist $doss_name -Session $session
        $dossSizeMB = [math]::Round($dossSize / 1MB, 2) | Tee-Object $info_log -Append# Convertir en Megabytes et arrondir à deux décimales
        Write-Output "Taille du dossier $doss_name " >> $info_log

        # Afficher les résultat
        Write-Host "Espace utilisé: $dossSizeMB MB"
        } 
        else {
            # Message si le chemin n'est pas valide
            Write-Host "Le chemin spécifié n'est pas valide ou n'existe pas."
        }
    }
    

#####################################################
# Fonction Liste des lecteurs monté (disque,CD,etc...)
# Auteur : Luca
# 
#####################################################

function lecteur_list {

    $message = "Affichage des lecteurs monté"
    Write-Log
    Write-Output "Liste des lecteurs monter " >> $info_log
    Invoke-Command -ScriptBlock { [System.IO.DriveInfo]::GetDrives() | Select-Object Name,DriveType | Format-Table -AutoSize } -Session $session | Tee-Object $info_log -Append

}

#####################################################
# Fonction Liste des applications/paquets installées
# Auteur : Pierre
# 
#####################################################

function list_install()
{
    Write-Output "Liste des Applications instalé" >> $info_log
    Invoke-Command -ScriptBlock { Get-AppxPackage | Select Name } | Tee-Object $info_log -Append
    $message = "affichage des paquets installé"
    Write-Log $mesage
}

#####################################################
# Fonction Liste des services en cours d'execution
# Auteur : Pierre
# 
#####################################################

function service_run()
{
    Write-Output "Liste des services en cours d'execution" >> $info_log
    Invoke-Command -ScriptBlock { Get-Service | Where-Object {$_.Status -eq "running"} | Select-Object Name } | Tee-Object $info_log -Append
    $message = "affichage de services en cours d'execution"
    Write-Log $mesage
}

#####################################################
# Fonction Liste des utilisateurs locaux
# Auteur : Pierre
# 
#####################################################

function list_user_local()
{
    Write-Output "Liste des utilisateurs locaux" >> $info_log
    Invoke-Command -ScriptBlock { Get-LocalUser | Select-Object Name } -Session $session | Tee-Object $info_log -Append
    $message = "affichage de la liste des utilisateurs local"
    Write-Log $mesage
}

#####################################################
# Fonction Memoire RAM total
# Auteur :  Pierre
# 
#####################################################

function ram_total()
{
    Write-Output "Affichage de la RAM total" >> $info_log
    Invoke-Command -ScriptBlock { Get-WmiObject Win32_PhysicalMemory | Format-Table capacity } -Session $session | Tee-Object $info_log -Append

    $message = "affichage de la ram total"
    Write-Log $mesage
}

#####################################################
# Fonction Utilisation de la RAM
# Auteur : Luca
# 
#####################################################

function ram_use {

    $message = "Affichage de la RAM utiliser "
    Write-Log
    Write-Output "Vérification le l'utilisation de la RAM en cours" >> $info_log
    Invoke-Command -ScriptBlock { Get-ComputerInfo | Select-Object @{Name = "RAM utilisé en GB"; Expression = { ("{0:F2}" -f ($_.OsFreePhysicalMemory / 1MB)) } } } -Session $session | Tee-Object $info_log -Append
    
}


#####################################################
# Fonction Recherche des événements dans le fichier log_evt.log pour la machine
# Auteur : Nico
# 
#####################################################

function compEvtLog {
    $compevtlogg = Read-Host "Ip de l'ordinateur pour la consultation"
    $message = "Consultation du fichier log_evt.log pour l'ordinateur $compevtlogg"
    Write-Log
    Write-Output "Consultation du fichier log_evt.log pour l'ordinateur $compevtlogg" >> $info_log
    Get-Content C:\Windows\System32\LogFiles\log_evt.log | Select-String $compevtlogg | Tee-Object $info_log -Append
    $message = "Fin consultation du fichier log_evt.log pour l'ordinateur"
    Write-Log
}

#####################################################
# Affiche le sous-menu d'action sur les ordinateurs.
# Auteur : Nico
# 
#####################################################

function Computer_Menu_Action {
    while ($true) {
        #Affichage du menu Action Ordinateur
        Write-Host "    -------------------------------------------------------
        Menu action de l'ordinateur, que souhaitez-vous faire ?
        -------------------------------------------------------
        "
        Write-Host "1. Arret"
        Write-Host "2. Redemarrage"
        Write-Host "3. Verrouillage"
        Write-Host "4. Mise a jour du systeme"
        Write-Host "5. Creation de repertoire"
        Write-Host "6. Modification de repertoire"
        Write-Host "7. Suppression d'un repertoire"
        Write-Host "8. Prise de main a distance"
        Write-Host "9. Activation du pare-feu"
        Write-Host "10. Désactivation du pare-feu"
        Write-Host "11. Installation de logiciel"
        Write-Host "12. Désinstallation de logiciel"
        Write-Host "13. Execution de script sur la machine distante"
        Write-Host "R. Retour au menu précédent
        "

        $choiceCMA = Read-Host "Entrez le numero souhaite"
        # Redirection des choix 
        switch ($choiceCMA) {
            '1' {
                #Fonction Arret
                $message = "Choix 1 Arret"
                Write-Log
                Arreter-Client
            }
            '2' {
                #Fonction Redemarrage
                $message = "Choix 2 Redemarrage"
                Write-Log
                Restart-Computer
            }
            '3' {
                #Fonction Verrouillage
                $message = "Choix 3 Verrouillage"
                Write-Log
                
            }
            '4' {
                #Fonction Mise a jour du systeme
                $message = "Choix 4 Mise a jour du systeme"
                Write-Log
                Write-Host "NE FONCTIONNE PAS SANS ACTIVE DIRECTORY"
            }
            '5' {
                #Fonction Creation de repertoire
                $message = "Choix 5 Creation de repertoire"
                Write-Log
                addDir
            }
            '6' {
                #Fonction Modification de repertoire
                $message = "Choix 6 Modification de repertoire"
                Write-Log
                Modifier-NomRepertoireDistant
            }
            '7' {
                #Fonction Suppression d'un repertoire
                $message = "Choix 7 Suppression d'un repertoire"
                Write-Log
                remDir
            }
            '8' {
                #Fonction Prise de main a distance
                $message = "Choix 8 Prise de main a distance"
                Write-Log
                priseCLI
            }
            '9' {
                #Fonction Activation du pare-feu
                $message = "Choix 9 Activation du pare-feu"
                Write-Log
                fwActive
            }
            '10' {
                #Fonction Désactivation du pare-feu
                $message = "Choix 10 Désactivation du pare-feu"
                Write-Log
                fwDisactive
            }
            '11' {
                #Fonction Installation de logiciel
                $message = "Choix 11 Installation de logiciel"
                Write-Log
                InstallSoftWare
            }
            '12' {
                #Fonction Désinstallation de logiciel
                $message = "Choix 12 Désinstallation de logiciel"
                Write-Log
                UninstallSoftWare
            }
            '13' {
                #Fonction Execution de script sur la machine distante
                $message = "Choix 13 Execution de script sur la machine distante"
                Write-Log
                Write-Host "TODO faire la fonction Execution de script sur la machine distante"
            }
            'R' {
                #Fonction Retour au menu precedent
                $message = "Choix Retour menu précédent"
                Write-Log
                Write-Host "Back to the futur."
                return
            }
            Default { 
                $message = "Choix $choiceCMA invalide "
                Write-Log
                Write-Host "Ce choix n'est pas disponible, merci de saisir un chiffre entre 1 et 13 ou R.
                "
            }
        }
    }
}

#####################################################
# Fonction Arrêt
# Auteur : Nico/Ahmed
# 
#####################################################

function Arreter-Client {
    $message = "Arret de la machine"
    Write-Log
    Invoke-Command -ScriptBlock { shutdown /s /f /t 0 } -Session $session
}

#####################################################
# Fonction Redémarrage
# Auteur : Luca/Ahmed
# 
#####################################################

function Restart-Computer {

    $message = "Redemarrage machine"
    Write-log
    Invoke-Command -ScriptBlock { Restart-Computer -Force } -Session $session 
}

#####################################################
# Fonction Verrouillage
# Auteur : Nico/Ahmed
# 
#####################################################

function Verrouiller-Client {
    $message = "Verrouillage session distante"
    Write-Log
    Invoke-Command -ScriptBlock { logoff console } -Session $session
}

#####################################################
# Fonction Mise a jour du système
# Auteur :  Nico
#  !!! NE FONCTIONNE PAS !!!
#####################################################

#Invoke-Command -ScriptBlock { Install-WindowsUpdate } -Session $session

#####################################################
# Fonction Creation de repertoire
# Auteur : Nico
# 
#####################################################

function addDir {
    $addDirr = Read-Host "Nom du Dossier a créer"
    $message = "Début de la création du dossier $addDirr"
    Write-Log
    Invoke-Command -ScriptBlock { param($dirName) New-Item -ItemType Directory $dirName } -ArgumentList $addDirr -Session $session
    $message = "Fin création de dossier"
    Write-Log
}

#####################################################
# Fonction Modification de repertoire
# Auteur : Nico/Ahmed
# 
#####################################################

function Modifier-NomRepertoireDistant {

    $namedir = Read-Host "Nom et chemin complet du dossier a modifier"
    $newnamedir = Read-Host "Chemin complet et nouveau nom du dossier a modifier"
    $message = "Modification du dossier $namedir avec le nouveau nom $newnamedir"
    Write-Log
    # Vérifiez si le dossier existe
    if (Invoke-Command -ScriptBlock { param ($namedir)Test-Path $namedir -PathType Container } -ArgumentList $namedir -Session $session) {
        Invoke-Command -ScriptBlock { param ($namedir, $newnamedir) Rename-Item -Path $namedir -NewName $newnamedir } -ArgumentList $namedir, $newnamedir -Session $session
        if (Invoke-Command -ScriptBlock { param ($newnamedir)Test-Path $newnamedir -PathType Container } -ArgumentList $newnamedir -Session $session) {
            Write-Output "Changement de nom de dossier OK !"
            $message = "Changement de nom de dossier OK !"
            Write-Log
        }
        else { 
            Write-Output "Echec de changement de nom" 
            $message = "Echec de changement de nom"
            Write-Log
        }
    }
    else {
        Write-Output "Le dossier $namedir n'existe pas"
        $message = "Le dossier $namedir n'existe pas"
        Write-Log
    }
    $message = "Fin modification du nom de dossier"
    Write-Log
}


#####################################################
# Fonction Suppression d'un repertoire
# Auteur : Nico
# 
#####################################################

function remDir {
    $remDirr = Read-Host "Nom du Dossier a supprimer"
    $message = "Début de la suppression du dossier $remDirr"
    Write-Log
    Invoke-Command -ScriptBlock { param($dirrRem) Remove-Item $dirrRem } -ArgumentList $remDirr -Session $session
    $message = "Fin de la suppression du dossier"
    Write-Log
}

#####################################################
# Fonction Prise de main a distance
# Auteur : Nico
# !!! FAIT SORTIR DU SCRIPT !!!
#####################################################

function priseCLI {
    $message = "Début prise en main a distance en CLI"
    Write-Log 
    $pricli = Read-Host "!!! Prendre la main a distance vous fera quitter le script, voulez-vous continuer ? o/n"
    if ($pricli -eq "o") {
        Enter-PSSession $session
        $message = "Fin de prise en main a distance OK, sortie du script"
        Write-Log
        exit
    }
    else {
        Write-Host "Prise en main annulé"
        $message = "Prise en main annulé"
        Write-Log
    }
}

#####################################################
# Fonction Activation du pare-feu
# Auteur : Nico
# 
#####################################################

function fwActive {
    $message = "Activation du Pare-feu de la machine distante"
    Write-Log
    Invoke-Command -ScriptBlock { Set-NetFirewallProfile -profile * -Enabled True } -Session $session

}


#####################################################
# Fonction Désactivation du par-feu
# Auteur : Nico
# 
#####################################################

function fwDisactive {
    $message = "Désactivation du Pare-feu de la machine distante"
    Write-Log
    Invoke-Command -ScriptBlock { Set-NetFirewallProfile -profile * -Enabled False } -Session $session
}

#####################################################
# Fonction Installation de logiciel
# Auteur : Nico
# 
#####################################################

function InstallSoftWare {
    Write-Host "Le logiciel a installer doit etre dans le catalogue PSGallery"
    $waresoft = Read-Host "Logiciel a installer"
    $message = "Début installation du logiciel $waresoft"
    Write-Log
    Invoke-Command -ScriptBlock { param($sofwar)Install-Package -name $sofwar -force } -ArgumentList $waresoft -Session $session
    $message = "Fin installation de logiciel"
    Write-Log
}

#####################################################
# Fonction Désinstallation de logiciel
# Auteur : Nico
#
#####################################################

function UninstallSoftWare {
    Write-Host "Le logiciel a désinstaller doit etre dans le catalogue PSGallery"
    $waresoft = Read-Host "Logiciel a désinstaller"
    $message = "Début désinstallation du logiciel $waresoft"
    Write-Log
    Invoke-Command -ScriptBlock { param($sofwar)Uninstall-Package -name $sofwar -force } -ArgumentList $waresoft -Session $session
    $message = "Fin désinstallation de logiciel"
    Write-Log
}

#####################################################
# Fonction Execution de script sur la machine distante
# Auteur : 
# 
#####################################################




Write-Host "                                __ "
Write-Host "                            ,;.'--'. "
Write-Host '                             /"/=,=( '
Write-Host "                             \(  __/ "
Write-Host "                          ___/    (____ "
Write-Host "                        .'     -  -    '. "
Write-Host "                       /         v       \ "
Write-Host "                    __/    ,     |    \   '-/'_ "
Write-Host '                   {z, ,__/__,__/\__,_ )__(   z} '
Write-Host "                    \>'   (            \_  --c/ "
Write-Host "                      _.- \_      ,   / \_ "
Write-Host "                      (       .______.'    '. "
Write-Host "                       \   ,   \    ( __     ) "
Write-Host "                        \   )-'-\__/-'  |   / "
Write-Host "                         |  |          /  .' "
Write-Host "                        /  ,)         (   \_ "
Write-Host "                       oooO'           '--Ooo  "
Write-Host " "
Write-Host "                     ___ _   _ _ __ ___   ___  "
Write-Host "                    / __| | | |  _   _ \ / _ \ "
Write-Host "                    \__ \ |_| | | | | | | (_)|"
Write-Host "                    |___/\__,_|_| |_| |_|\___/ "


Write-Host "-----------------------------------------------------------------------
Bonjour, bienvenue dans Sumo, merci d'entrer les identifiants à cibler.
-----------------------------------------------------------------------"


#Variable pour choisir l'ordinateur 
$choix_users = Read-Host "Utilisateur a joindre"
$choix_ordinateur = Read-Host "Ordinateur a joindre"
$session = New-PSSession -ComputerName $choix_ordinateur -Credential $choix_users

# Fonction pour la sauvegarde des actions fait avec le script
function Write-Log {
    Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log -Value "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - $env:USERNAME - $choix_users - $choix_ordinateur - $message"
}

#Variables pour le Fichier Log des demandes d'information
$Dates = Get-Date -Format "yyyyMMdd"
$info_log = "$HOME\Documents\info_$choix_users`_$dates.txt"


Menu











