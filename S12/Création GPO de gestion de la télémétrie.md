# Création GPO de gestion de la télémétrie
  
## GPO de désactivation du service de télémétrie
  
- Cliquer sur ```Tools``` puis sur ```Group Policy Management```
- Clique droit sur ```Group Policy Object``` puis sur ```New```
- Nommer la GPO
- Clique droit sur cette GPO puis séléctionner ```Edit```
- Dans ```Computer Configuration```
- Aller dans Policies -> Administrative Templates -> Windows Components -> Data Collection and preview Builds
- Activer ```Allow Diagnostics Data``` et dans options séléctionner ```Diagnostics data off```
- Désactiver ```Configure Connected User Experience and Telemetry```
- Activer ```Do not show feedback notifications````
- Désactiver ```Toggle user control over insider builds```
  
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S12/Ressources%20GPO%20Telemetrie/Telemetry.png)
  
  
## GPO de désactivation de Cortana et restriction sur WDS
  
- Dans ```Computer Configuration```
- Aller dans Policies -> Administrative Templates -> Windows Components -> Search
- Désactiver ```Allow Cortana```
- Désactiver ```Allow Cortana above look screen```
- Désactiver ```Allow indexing of encrypted files```
- Activer ```Do not allow web search```
- Activer ```Don't search the web or display web results in Search```
- Activer ```Set what information in shared in Search``` et séléctionner l'option ```Anonymous info```
  
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S12/Ressources%20GPO%20Telemetrie/WDSCortana.png)
  
  
## GPO de Désactivation de l'usage de compte microsoft et de OneDrive pour le stockage des fichier
  
- Aller dans Policies -> Windows Settings -> Security Settings -> Local Policies -> Security Options
- Séléctionner ```Accounts: Block Microsoft accouts``` puis ```Users can't add or log with Microsoft accounts```
- Dans ```Computer Configuration```
- Aller dans Policies -> Administrative Templates -> Windows Components -> OneDrive
- Désactiver ```Prevent the usage of OneDrive for file storage```
  
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S12/Ressources%20GPO%20Telemetrie/onedrive.png)
  
  
## GPO pour désactiver la localisation pour les application windows
  
- Dans ```Computer Configuration```
- Aller dans Policies -> Administrative Templates -> Windows Components -> App Privacy
- Désactiver ```Let Windows apps acces location```
  
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S12/Ressources%20GPO%20Telemetrie/location.png)
  
  
## GPO pour désactiver la localisation de l'appareil
  
- Dans ```Computer Configuration```
- Aller dans Policies -> Administrative Templates -> Windows Components -> Find My Device
- Désactiver ```Turn On/Off Find My Device```
  
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S12/Ressources%20GPO%20Telemetrie/finddevice.png)
  
  
## GPO pour désactiver les capture d'ecran par les application windows
  
- Dans ```Computer Configuration```
- Aller dans Policies -> Administrative Templates -> Windows Components -> App Privacy
- Désactiver ```Let Windows apps take screenshots of various windows  or display```
  
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S12/Ressources%20GPO%20Telemetrie/screenshot.png)
  
  
## GPO pour désactiver l'acces à l'hitstorique des appels par les application Windows
  
- Dans ```Computer Configuration```
- Aller dans Policies -> Administrative Templates -> Windows Components -> App Privacy
- Désactiver ```Let Windows apps access call history```
  
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S12/Ressources%20GPO%20Telemetrie/call%20history.png)
  
  
## GPO pour désactiver l'acces au calendrier par les application Windows
  
- Dans ```Computer Configuration```
- Aller dans Policies -> Administrative Templates -> Windows Components -> App Privacy
- Désactiver ```Let Windows apps access calendar```
  
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S12/Ressources%20GPO%20Telemetrie/calendar.png)
  
  
## GPO pour désactiver le service d'experience utilisateur
  
- Dans ```Computer Configuration```
- Aller dans Policies -> Administrative Templates -> Control Panel -> Regional and Language Options
- Activer ```Restrict Language Pack ans Language Feature installation```
- Aller dans Policies -> Administrative Templates -> Control Panel -> Regional and Language Options -> Handwriting personalization
- Activer ```Turn off automatic learning```
- Aller dans Policies -> Administrative Templates -> System -> Internet Communication Management -> Internet Communication settings
- Activer ```Turn off Help and Support Center "Did you know?" content```
- Activer ```Turn of Windows Customer Experience Improvement Program```
- Activer ```Turn off Windows Error Reporting```
- Aller dans Policies -> Administrative Templates -> Windows Components -> Location and Sensors
- Désactiver ```Turn off location```
- Aller dans Policies -> Administrative Templates -> Windows Components -> Windows Error Reporting
- Désactiver ```Automatically send memory dumps for os-generated error reports```
- Activer ```Disable Windows Error Reporting```
- Activer ```Do not send additional data```
Dans ```User Configuration```
- Aller dans Policies -> Administrative Templates -> Windows Components -> Cloud Content
- Activer ```Do not use diagnostic data for tailored experiences```
  
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S12/Ressources%20GPO%20Telemetrie/user1.png)
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S12/Ressources%20GPO%20Telemetrie/user2.png)
  
