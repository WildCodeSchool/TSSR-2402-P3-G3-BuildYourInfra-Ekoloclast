# Déroulé du Démo Day

## Résumé :

Deux employés dialogue via mail au sujet d'un site de jeux en ligne `www.poki.com`.
Un troisième larron edit un ticket `GLPI` pour prévenir la DSI de bloquer le site en Question.
Le technicien DSI prend connaissance du ticket et commence a investiguer.

## P0232 (Ordinateur client)

#### Ouverture Thunderbird 

Mail reçu/envoyé :

Reçu
```
Salut Mec
Je viens de tomber sur un site de jeu vachement sympa www.poki.com 
Il y a plein de mini jeux, c'est très pratique on peu y jouer sur nos ordis, et c'est bien mieux que les tableurs excel ;)
```

Envoyé
```
Merci
Je regarde ça a ma pause
```

Reçu
```
Boaf tu peux regarder ça maintenant, en vrai le projet est trop chiant
```

Envoyé
```
C'est clair
```

#### Ouverture Chrome 

Le client clique sur le lien dans le mail (très mauvaise pratique a cause du phishing) et commence a jouer.

## P0600 (ordinateur Poukave)

#### Ouverture GLPI

La poukave ouvre un ticket `GLPI` pour dénoncer son collègue

Titre 
```
Ma collègue abuse avec son PC 
```

Description 
```
Bonjour, 
je vois que mon collègue passe son temps sur un site de jeux au lieu de travailler, merci de faire le nécessaire afin de bloquer ce site et l'obliger a travailler.
```

Réponse du technicien DSI

```
Bonjour,
Qui est votre collègue et sur quel poste elle est ?
Nous allons faire le nécessaire
```

Poukave

```
Ma collègue est Alice Perrin et son poste est le P0232 
```

## Supervision Ubuntu

#### Trouver l'ip du P0232

Ouvrir un terminal et faire `ping P0232` pour que le DNS resolve l'IP

#### Lancer WireShark 

Dans le même terminal, taper `sudo wireshark`

Ouvrir la configuration de `SSH remote capture` :
1) Server
- Remote SSH server address : `192.168.0.253`
- Remote SSH server port : `22`

2) Authentication
- Remote SSH server username : `vyos`
- Remote SSH server password : `vyos`

3) Sauvegarder

4) Lancer un scan et lancer `www.poki.com` sur le `P0232`

5) Appliquer les filtres
- Appliquer le filtre `ip.addr == 192.168.1.22`
- Voir qu'il y a beaucoup de choses
- Appliquer le filtre pour le DNS `dns && ip.addr == 192.168.1.22`

6) Trouver la lignes (ou les lignes `poki.com`)

#### Trouver les IP de `www.poki.com`

Ouvrir un terminal et taper `nslookup www.poki.com`
Ça doit afficher les IPs `104.18.144.9` et `104.18.143.9`

#### Bloquer les IPs dans le FireWall

Ouvrir le navigateur et se rendre sur la page de `pfsense` (utilisation de Bitwarden ??)

1) Pare-feu -> Alias
- Montrer l'alias `Blocked_sites` avec les deux adresses trouvé précédemment 

2) Pare-feu -> Règles -> Lan
- Montrer la règle `Blocage de sites` et l'activer.

#### Clôturer le ticket

Ouvrir le navigateur sur l'onglet `GLPI` et clôturer le ticket

Technicien  
```
Le site www.poki.com est bloqué sur le pare-feu, plus aucune personne de l'entreprise ne peux y acceder.
Bonne journée.
```

#### P0232

Ouvrir le navigateur et se rendre compte avec stupeur et désarroi que le bref et futile instant de bonheur dans cette journée si maussade, est maintenant et a jamais inaccessible. Il faut a présent se rendre a l'evidence et retourner péniblement a la tache sans saveur confier par cet être malfaisant et sournois nommé despote par moi-même et Mr le directeur par ses méprisables adorateurs.