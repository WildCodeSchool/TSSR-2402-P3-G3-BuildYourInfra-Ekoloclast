## 1-routeurVyos-priseEnMain

VyOS login : vyos
Password : vyos

- Configuration basique :

```bash
config
set system host-name VyosRouteur
set system domain-name ekoloclast.fr
set service ssh
commit
save
```

- Affichage des interfaces réseaux :

```bash
show interfaces
```

## 2-routeurVyos-routageStatique

### Configurer les interfaces réseau

```bash
config
```

```bash
set interfaces ethernet eth0 address 192.168.0.253/24
set interfaces ethernet eth0 description "Reseau Wan – 192.168.0.253/24" 
```

```bash
set interfaces ethernet eth1 address 192.168.1.254/24
set interfaces ethernet eth1 description "Reseau Lan Communication – 192.168.1.254/24" 
```
```bash
commit
save
```

###  Configurer la passerelle par défaut
```bash
set protocols static route 0.0.0.0/0 next-hop 192.168.0.254
```
(Définit la passerelle par défaut pour tout le trafic non-local.)
```bash
commit
save
```


### Configurer le NAT
- Pour le réseau LAN COMMUNICATION
```bash
set nat source rule 10 description 'NAT from 192.168.1.0/24 to internet'
set nat source rule 10 outbound-interface eth0
set nat source rule 10 source address 192.168.1.0/24
set nat source rule 10 translation address masquerade
```
```bash
commit
save
exit
```
```bash
show nat source rule
```

### Configurer le relai DHCP
```bash
set service dhcp-relay listen-interface eth0
```
```bash
set service dhcp-relay upstream-interface eth1
```
```bash
set service dhcp-relay server 192.168.0.2
```
```bash
set service dhcp-relay relay-options relay-agents-packets discard
```

```bash
show service dhcp-relay
    listen-interface eth1
    upstrem-interface eth2
    server 192.168.0.2
    relay-options {
       relay-agents-packets discard
    }
```


### Plan réseau de Ekoloclast

|Plage IP | Pôles | Effectifs |
| ---- |  ---- | ------ | 
| 192.168.0.0/24 | DSI  &  Serveurs | 12 |
| 192.168.1.0/24 | Communication | 20 |
|192.168.2.0/24 | Direction Financière | 14 |
| 192.168.3.0/24 | Direction Générale | 8 |
| 192.168.4.0/24 | Direction Marketing | 22 |
| 192.168.5.0/24 | R&D | 17 |
| 192.168.6.0/24 | RH | 24 |
| 192.168.7.0/24 | Service Généraux | 12 |
| 192.168.8.0/24 | Service Juridique | 8 |
| 192.168.9.0/24 | Ventes et Développement Commercial | 46 |
