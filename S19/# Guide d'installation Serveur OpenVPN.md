# Guide d'installation Serveur OpenVPN

## Création des certificats

### Création du certificat d’autorité (CA)

1. Aller à **System > Certificates**, onglet **Authorities**
    
2. Cliquer sur **Add** pour créer un nouveau certificat
    
3. Entrer les paramètres suivants :
- Nom descriptif : `EkoGreen-Auth`
- Méthode : `Créer une autorité de certification interne`
- Nom commun : `EkoGreen-Auth`

4. Cliquer sur **Save**

### Création du certificat de certification serveur

1. Aller à **System > Certificates**, onglet **Certificates**
    
2. Cliquer sur **Add** pour créer un nouveau certificat
    
3. Entrer les paramètres suivants : 

- Méthode : `Créer un certificat interne`
- Nom descriptif : `EkoGreen-Serv`
- Autorité de certification : `EkoGreen-Auth`
- Nom commun : `EkoGreen-Serv`
- Type de certificat : `Server Certificate`

4. Cliquer sur **Save**

### Création du certificat de certification client

1. Aller à **System > Certificates**, onglet **Certificates**
    
2. Cliquer sur **Add** pour créer un nouveau certificat
    
3. Entrer les paramètres suivants : 

- Méthode : `Créer un certificat interne`
- Nom descriptif : `EkoGreen-Client`
- Autorité de certification : `EkoGreen-Auth`
- Nom commun : `EkoGreen-Client`
- Type de certificat : `User Certificate`

4. Cliquer sur **Save**

### Export des Certificats nécessaires pour le client

1. Dans **Authorities** , cliquer sur ![[Pasted image 20240717002603.png]] pour Exporter uniquement de CA de `EkoGreen-Auth`
2. Dans **Certificats** , cliquer sur ![[Pasted image 20240717002603.png]] et ![[Pasted image 20240717003133.png]]pour Exporter le certificat et la clé de `EkoGreen-Client`

## Configurer l'Instance Serveur OpenVPN

### Création du serveur


Après avoir crées les certificats, créer le serveur OpenVPN :

1. Aller à **VPN > OpenVPN**, onglet **Serveurs**
    
2. Cliquer sur **Add** pour créer un nouveau serveur
    
3. Remplir les champs comme suit, en laissant tout le reste par défaut :
    

   - Description : Texte pour décrire la connexion (par ex. `Server VPN EkoGreen`)

   - Mode Serveur : `Peer to Peer (SSL/TLS)

   - Mode Appareil : `tun`

   - Protocole : `UDP on IPv4 only`

   - Interface : `WAN`

   - Port du serveur : `1194`

   - Utiliser une clé TLS : Coché

   - Générer automatiquement une clé TLS : Coché

   - Autorité de certification du pair : `EkoGreen-Auth`
   
   - Certificat du serveur : `EkoGreen-Serv`

   - Réseau Tunnel IPv4 : `10.0.8.0/30`
   
   - Réseau(x) local/locaux IPv4 : `192.168.0.0/24` `172.16.2.0/24` (Tout les réseaux qui vont passer par ce VPN)
   
   - Réseau(x) distant(s) IPv4 : `172.16.2.0/24`
   
   - Création d'une passerelle : `IPv4 uniquement`


4. Cliquer sur **Save**

5. Une fois le serveur crée retourner sur le serveur en cliquant sur ![[Pasted image 20240717111713.png]] et copié en entier la clé `TLS` pour la joindre aux certificats a envoyé au client.

### Création de l'autorisation de client

Après avoir crée le serveur, il faut autoriser le(s) client(s) qui pourront se connecter.

1. Aller à **VPN > OpenVPN**, onglet **Client-Specific Overrides**
    
2. Cliquer sur **Add** pour créer un nouveau client
    
3. Remplir les champs comme suit, en laissant tout le reste par défaut :

- Description : `Client VPN Pharmgreen`

- Nom commun : `EkoGreen-Client`

- Réseau tunnel : `10.0.8.0/30`

- Réseau(x) distant(s) IPv4 : `172.16.2.0/24`

4. Cliquer sur **Save**

## Règles de Pare-feu

Une règle de type "Autoriser tout".

### Exemple de règle pour autoriser tout le trafic :

Exemple de règle pour autoriser tout le trafic :

1. Aller à **Firewall > Rules**, onglet **OpenVPN**
    
2. Cliquer sur **Add** pour créer une nouvelle règle en haut de la liste
    
3. Configurer les options comme suit :
    

   - Protocole : `any`

   - Source : `any`

   - Description : `Allow all on OpenVPN`

4. Cliquer sur **Save**
    
5. Cliquer sur **Apply Changes**
    

Votre configuration serveur OpenVPN est maintenant terminée.