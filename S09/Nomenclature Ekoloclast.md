# Nomenclature Ekoloclast

## 1.Serveur ADDS Windows 2022 

**Domaine : ekoloclast.fr**
_idem messagerie existante_

Name : PARSRVDC01
IP fixe : 192.168.0.1


## 2. OU Utilisateurs

- **DPTDsi**
  - (UO) Service
    - (GRP) SERDatascientist
  - (UO) DeveloppemeLogiciel
    - (GRP) DEVDeveloppeur
    - (GRP) DEVIntegrateur
  - (UO) SUPPORT
    - (GRP) SUPHotliner
  - (UO) Dsi



- **DPTCommunication**
  - (UO) Publicite
    - (GRP) PUBChargedecommunication
    - (GRP) PUBDesignergraphique
    - (GRP) PUBIngenieurson
    - (GRP) PUBphotographe
    - (GRP) PUBPublicitaire
    - (GRP) PUBRealisateur
    - (GRP) PUBResponsablepublicite
    - (GRP) PUBWebmaster
  - (UO) RelationPuliqueEtPresse
     - (GRP) RELChargedecommunication
     - (GRP) RELChargedepresse
     - (GRP) RELChargeendroitdelacommunication
     - (GRP) RELResponsablerelationmedia
  - (UO) Directioncommunication

- **DPTDirectionFinanciere**
  - (UO) ControleDeGestion
    - (GRP) CDGControledegestion
  - (UO) Finance
    - (GRP) FINAnalystefinancier
    - (GRP) FINDaf
  - (UO) ServiceComptabilite
    - (GRP) SCOComptable

- **DPTDirectiongenerale**
  - (GRP) Assistantdedirection
  - (GRP) Secrétaire
  - (GRP) CEO
  - (GRP) Directeuradjoint


- **DPTDirectionmarketing**
  - (UO)  Marketing Digital
    - (GRP) MDIAnalysteweb
    - (GRP) MDI
    - (GRP) MDI
    - (GRP) MDI
  - (UO) MarketingOperationnel
    - (GRP) MOP
    - (GRP) MOP
    - (GRP) MOP
    - (GRP) MOP
    - (GRP) MOP
  - (UO) MarketingProduit
    - (GRP) MPR
    - (GRP) MPR
    - (GRP) MPR
  - (UO) MarketingStrategique
    - (GRP) MST
    - (GRP) MST
    - (GRP) MST

- **DPTRD**
  - (UO) InnovationEtStrategie
    - (GRP) IESchercheur
    - (GRP) IESResponsablerecherche
  - (UO) Laboratoire
    - (GRP) LABlaorantin
    - (GRP) LABresponsableLaborantin

- **DPTRH**
  - (UO)  DirectionRH
    - (GRP) DRHdirecteur
    - (GRP) DRHdirecteuradjoint
  - (UO) Formation
    - (GRP) FORformateur
  - (UO) Gestiondesperformances
    - (GRP) GDPagentRH
  - (UO) Recrutement
    - (GRP) RECagentRH
  - (UO) SanteEtSecuriteTravail
    - (GRP) SSTanimateursecurite
    - (GRP) SSTauditeur
    - (GRP) SSTtechnicienHSE

- **DPTServiceGeneraux**
  - (UO) GestionImmobiliere
    - (GRP) GIMgestionnaireimmobilier
  - (UO) Logistique
    - (GRP) LOGagentlogistique
    - (GRP) LOGresponsablelogistique

- - **DPTServiceGeneraux**
  - (UO) Contrat
    - (GRP) CNTjuriste
    - (GRP) CNTresponsablejuridique
  - (UO) Contancieux
    - (GRP) CTXjuriste

- **DPTVDcommercial**
  - (UO)  ADV
    - (GRP) ADVgestionnaire
    - (GRP) ADVresponsable
  - (UO) B2B
    - (GRP) B2Bcommercial
    - (GRP) B2Bresponsable
  - (UO) B2C
    - (GRP) B2Ccommercial
    - (GRP) B2Cresponsable
  - (UO) Developpementinternational
    - (GRP) DEVcommercial
    - (GRP) DEVdirectioncommercial
  - (UO) GrandComptes
    - (GRP) GRCcommercial
    - (GRP) GRCresponsableachat
  - (UO) Servicesachats
    - (GRP) SACacheteur
    - (GRP) SACresponsableachat
  - (UO) ServiClient
    - (GRP) SCLacheteur
    - (GRP) SCLresponsableachat

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
