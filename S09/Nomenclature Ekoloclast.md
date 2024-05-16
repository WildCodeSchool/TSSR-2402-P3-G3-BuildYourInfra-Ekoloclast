# Nomenclature Ekoloclast

## 1.Serveur ADDS Windows 2022 

**Domaine : ekoloclast.fr**
_idem messagerie existante_

Serveur ADDS/DNS/DHCP
Name : EKO-MSTR
IP fixe : 192.168.0.2

Serveur ADDS Core
Name : EKO-CORE
IP : 192.168.0.3


## 2. OU Utilisateurs

- **DPTDsi**
  - (OU) Service
    - (OU) SERDatascientist
  - (OU) DeveloppemeLogiciel
    - (OU) DEVDeveloppeur
    - (OU) DEVIntegrateur
  - (OU) SUPPORT
    - (OU) SUPHotliner
  - (OU) Dsi



- **DPTCommunication**
  - (OU) Publicite
    - (OU) PUBChargedecommunication
    - (OU) PUBDesignergraphique
    - (OU) PUBIngenieurson
    - (OU) PUBphotographe
    - (OU) PUBPublicitaire
    - (OU) PUBRealisateur
    - (OU) PUBResponsablepublicite
    - (OU) PUBWebmaster
  - (OU) RelationPuliqueEtPresse
     - (OU) RELChargedecommunication
     - (OU) RELChargedepresse
     - (OU) RELChargeendroitdelacommunication
     - (OU) RELResponsablerelationmedia
  - (OU) Directioncommunication

- **DPTDirectionFinanciere**
  - (OU) ControleDeGestion
    - (OU) CDGControledegestion
  - (OU) Finance
    - (OU) FINAnalystefinancier
    - (OU) FINDaf
  - (OU) ServiceComptabilite
    - (OU) SCOComptable

- **DPTDirectiongenerale**
  - (OU) Assistantdedirection
  - (OU) Secrétaire
  - (OU) CEO
  - (OU) Directeuradjoint


- **DPTDirectionmarketing**
  - (OU)  Marketing Digital
    - (OU) MDIAnalysteweb
    - (OU) MDI
    - (OU) MDI
    - (OU) MDI
  - (OU) MarketingOperationnel
    - (OU) MOP
    - (OU) MOP
    - (OU) MOP
    - (OU) MOP
    - (OU) MOP
  - (OU) MarketingProduit
    - (OU) MPR
    - (OU) MPR
    - (OU) MPR
  - (OU) MarketingStrategique
    - (OU) MST
    - (OU) MST
    - (OU) MST

- **DPTRD**
  - (OU) InnovationEtStrategie
    - (OU) IESchercheur
    - (OU) IESResponsablerecherche
  - (OU) Laboratoire
    - (OU) LABlaorantin
    - (OU) LABresponsableLaborantin

- **DPTRH**
  - (OU)  DirectionRH
    - (OU) DRHdirecteur
    - (OU) DRHdirecteuradjoint
  - (OU) Formation
    - (OU) FORformateur
  - (OU) Gestiondesperformances
    - (OU) GDPagentRH
  - (OU) Recrutement
    - (OU) RECagentRH
  - (OU) SanteEtSecuriteTravail
    - (OU) SSTanimateursecurite
    - (OU) SSTauditeur
    - (OU) SSTtechnicienHSE

- **DPTServiceGeneraux**
  - (OU) GestionImmobiliere
    - (OU) GIMgestionnaireimmobilier
  - (OU) Logistique
    - (OU) LOGagentlogistique
    - (OU) LOGresponsablelogistique

- - **DPTServiceGeneraux**
  - (OU) Contrat
    - (OU) CNTjuriste
    - (OU) CNTresponsablejuridique
  - (OU) Contancieux
    - (OU) CTXjuriste

- **DPTVDcommercial**
  - (OU)  ADV
    - (OU) ADVgestionnaire
    - (OU) ADVresponsable
  - (OU) B2B
    - (OU) B2Bcommercial
    - (OU) B2Bresponsable
  - (OU) B2C
    - (OU) B2Ccommercial
    - (OU) B2Cresponsable
  - (OU) Developpementinternational
    - (OU) DEVcommercial
    - (OU) DEVdirectioncommercial
  - (OU) GrandComptes
    - (OU) GRCcommercial
    - (OU) GRCresponsableachat
  - (OU) Servicesachats
    - (OU) SACacheteur
    - (OU) SACresponsableachat
  - (OU) ServiClient
    - (OU) SCLacheteur
    - (OU) SCLresponsableachat

## 3. OU GroupesDeSécurité (a définir ultérieurement)

OU SecutityUtilisateurs 
OU SecutityOrdinateurs

## 4. Ordinateurs

- Serveurs DC :
Localisation + SRV + fonction + n°

exemple : **PARSRVDC1**

- Serveurs : 

**PARSRVDATA01, PARSRVWEB01, PARSRVDNS01, PARSRVDHCP01...**

- Poste Clients :
Uniquement PC portables
Existant nom type = PXXXX (4 chiffres)

## 5. Utilisateurs

Convention nomage

exemple : Alice Perrin 

Id : "3 premières lettres du prénom" + "." + "nom"

**ID : ali.perrin**

(Si doublon, incrémentation 1 chiffre à la suite)


## 6. GPO (en attente traitement)

- Convention de nommage
	- Cible/fonction (user, sec, config, ...)
	- Portée (global, domain, marketing, ...)
	- Version/date de révision
	- id
	- but/destination
