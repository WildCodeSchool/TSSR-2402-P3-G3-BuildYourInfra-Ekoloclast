## Installation RAID1 sur Windows Server core

1. Lancer Diskpart

```cmd
diskpart
```
2. Lister les disques
```cmd
listdisk
```
3. Selectionner le disque 0 et le convertir en dynamic
```cmd
select disk 0
convert dynamic
```
4. Idem pour le nouveau disque ajouté
```cmd
select disk 1
convert dynamic
```
5. Lister les volumes
```cmd
list volume
```
6. Selectionner le disque C et ajouter le deuxième disque

```cmd
select volume V
add disk=1
```

7. Vérification

```cmd
list disk
list volume
```

![raidcore]()


