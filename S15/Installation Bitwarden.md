# Installation Bitwarden

**Prérequis**

Machine : VM DEBIAN-SSH (Debian 12)
IP : 192.168.0.7

### 1. Installation Docker à l'aide du apt référentiel

- Configurez aptle référentiel Docker.
```bash
#Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

#Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
Note
```
- Installez les packages Docker.
```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

- Vérifiez que l'installation a réussi en exécutant l' hello-world image :
```bash
sudo docker run hello-world
```
Cette commande télécharge une image de test et l'exécute dans un conteneur. Lorsque le conteneur s'exécute, il imprime un message de confirmation et se ferme.

Vous avez maintenant installé et démarré avec succès Docker Engine.

### 2. Créer un utilisateur local Bitwarden & répertoire

- Créez un utilisateur Bitwarden :

```bash
sudo adduser bitwarden
```
- Définir le mot de passe pour l'utilisateur Bitwarden (mot de passe fort) :

```bash
- sudo passwd bitwarden
```
Créez un groupe Docker (s'il n'existe pas déjà) :

```bash
- sudo groupadd docker
```
Ajoutez l'utilisateur Bitwarden au groupe docker :

```bash
- sudo usermod -aG docker bitwarden
```
Créez un répertoire Bitwarden :

```bash
- sudo mkdir /opt/bitwarden
```
Définissez les autorisations pour le répertoire /opt/bitwarden :

```bash
- sudo chmod -R 700 /opt/bitwarden
```
Définissez l'utilisateur de Bitwarden comme propriétaire du répertoire /opt/bitwarden :

```bash
- sudo chown -R bitwarden:bitwarden /opt/bitwarden
```

### 3. Installez Bitwarden


Bitwarden fournit un script shell pour une installation facile sur Linux et Windows (PowerShell). Suivez les étapes suivantes pour installer Bitwarden en utilisant le script shell :

- Téléchargez le script d'installation de Bitwarden (bitwarden.sh) sur votre machine :

```bash
curl -Lso bitwarden.sh "https://func.bitwarden.com/api/dl/?app=self-host&platform=linux" && chmod 700 bitwarden.sh
```
- Exécutez le script d'installation. Un répertoire ./bwdata sera créé par rapport à l'emplacement de bitwarden.sh.

```bash
./bitwarden.sh install
```