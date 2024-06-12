Creation de capteurs WMI 
![image](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/assets/161337347/5718d417-3f7d-4007-a403-608af6a6467c)
![image](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/assets/161337347/acf04389-96e2-439f-8047-0705786fd4f3)
![image](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/assets/161337347/c51a5073-97e6-42f9-8458-72a43aa58fa1)
![image](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/assets/161337347/2a6d2722-9582-494b-b570-f3d0fb7c40b0)
![image](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/assets/161337347/45a2765c-afd4-4bf2-ad8a-d3e36d142246)
![image](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/assets/161337347/56a91df0-a3ec-4de7-97aa-75aefa9f9f5c)
![image](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/assets/161337347/a0ea6b28-4359-462d-8b1a-91387616cc52)


Pour configurer l'autorisation WMI
Sur le serveur distant, dans le menu Démarrer , cliquez sur Exécuter.

Dans la zone Ouvrir , tapez wmimgmt.mscet cliquez sur OK.

Dans le programme Windows Management Infrastructure , cliquez avec le bouton droit sur Contrôle WMI (local), puis cliquez sur Propriétés.

Dans la boîte de dialogue Propriétés de WMI Control (Local) , sous l’onglet Sécurité , développez Root, puis cliquez sur CIMV2.

Cliquez sur Sécurité pour ouvrir la boîte de dialogue Sécurité pour ROOT\CIMV2 .

Ajoutez un groupe ou un utilisateur à la zone Noms de groupes ou d’utilisateurs et sélectionnez-le.

Dans la zone Autorisations pour<groupe ou utilisateur>, sélectionnez la colonne Autoriser correspondant à l’autorisation Appel à distance autorisé, pour les utilisateurs dont vous souhaitez détecter à distance l’état de service.


![image](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/assets/161337347/70de9b53-e911-4928-97f1-7a4f90cdf8d4)

![image](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/assets/161337347/d63bd595-cc83-4b3f-99bb-b46b0dee62a0)
![image](https://github.com/WildCodeSchool/TSSR-2402-P3-G3-BuildYourInfra-Ekoloclast/assets/161337347/71589ae3-a002-4a37-933d-a967ac5f3b09)
