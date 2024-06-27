# Rapport incident survenu le 24/06/24

## Sommaire

- Evaluation
- Identification et projection
- Réparation
- Conclusion et perspectives


## A. Evaluation

Suite à un problème électrique certains éléments de l'infrastructure ne fonctionnent plus.
Le MCO (Maintient en Condition Opérationnelle) n'est plus valide.
La priorité est de réaliser un état complet du parc afin de définir quels équipements sont touchés.

![etat1](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S16/Sources/etat1.PNG?raw=true)
_Etat du parc le 24/06/24_

## B. Identification et projection



| Priroité | Degré d'urgence | Action | Estimation date de résolution |
|   :---------: |  :-------: | :---------: | :---------: |
| 1 |   <font color='red'>Critique</font>    |  Rétablir le réseau interne et externe, routeur VyOS en priorité + Passerelle PFsense | 24/06/24 |
| 2 |   Sévère    |  Remise en état du DC principal EKO-MSTR et EKO-CORE (Raid + réplication) | 25/06/24 |
| 3 |   Majeur    |  Suite au rétablissement du réseau en P1, contrôle des services tiers (Messagerie, redmine, bitwarden) | 26/06/24 |
| 4 |   Mineur    |  Serveur GLPI + serveur DC3 à réinstaller | 26/06/24 |

## C. Réparation

- **Priorité 1**

|   Serveur |  Etat | Actions réalisées| Prévention ajoutée |
|   :---------: |  :-------: | :---------: | :---------: |
| Pfsence |  Dégradé | Réassignement des cartes réseaux | Sauvegarde de la configuration (Diagnostics- Sauvegarde & Restauration) |
| VyOS |  <font color='red'>HS</font> | Remplacement du routeur et configuration (cf [Install VyOS](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S12/INSTALL%20VyOS.md)) | Sauvegarde de la configuration (connection en SSH depuis poste de supervision pour copier la conf) |

_Réalisé le 24/06/24_

- **Priorité 2**

|   Serveur |  Etat | Actions réalisées| Paramètre ajouté |
|   :---------: |  :-------: | :---------: | :---------: |
| EKO-MSTR |  Dégradé | Réparation du RAID1 | Rôles FSMO |
| EKO-CORE |  <font color='red'>HS</font> | Remontage du serveur,ajout rôle DC, réplication OK | Rôles FSMO  |

_Réalisé le 25/06/24_

- **Priorité 3**

Contrôle réalisé sur les services messagerie, Redmine et Bitwarden.
Les services sont opérationnels et n'ont pas été affectés par l'incident.
_Réalisé le 26/06/24_

- **Priorité 4**

|   Serveur |  Etat | Actions réalisées| Paramètre ajouté |
|   :---------: |  :-------: | :---------: | :---------: |
| EKO-RDS-WDS |  <font color='red'>HS</font> | Remontage du serveur,rôles reconfigurés | Rôles WSUS  |

_Réalisé le 26/06/24_

Iniatelement l'application GLPI était hébergée sur une VM debian, suite à l'incident la VM st complétment HS. Afin d'alléger notre infrastructure nous avons décidé d'installer GLPI dans un conteneur dédié.

|   Serveur |  Etat | Actions réalisées| Paramètre ajouté |
|   :---------: |  :-------: | :---------: | :---------: |
| GLPI |  <font color='red'>HS</font> | Mise en place dans un conteneur | Intégration des adresses email des utilisateurs dans LDAP  |

_Réalisé le 26/06/24_


## D. Conclusion et perspectives


![etat2](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S16/Sources/etat2.PNG?raw=true)

>Nous avons en premieu lieu rétabli le réseau pour que les collaborateurs puissent travailler dès le Lundi avec l'accès à internet.
Dans un second temps il a fallu rétablir les services pour retrouver le maintien en condition opérationnelle.
Notre documentation écrite tout au long du projet nous a était très utile et nous avons ajouter des informations sur les procédures d'installation VyOS et GLPI.

**A titre préventif :** 

- Investissement dans de meilleurs onduleurs pour palier aux coupures de longue durée.
- Séparation du réseau électrique.

**Evolution envisagée:** 

- Prévoir un routeur de secours qui puisse être rapidement déployé en cas de panne du routeur principal.


