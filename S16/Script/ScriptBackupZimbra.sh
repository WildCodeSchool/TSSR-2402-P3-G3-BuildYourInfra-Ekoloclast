#!/bin/bash

printf "Rapport de sauvegarde Zimbra du " > backup_mail
date "+%D %T" >> backup_mail
echo "-------------------------------------------------" >> backup_mail

tar -PScf /opt/zimbra/backup_manual_files/data.mdb.tar /opt/zimbra/data/ldap/mdb/db/data.mdb >> backup_mail 2>&1
rsync -e ssh -az --stats --exclude 'data/ldap/mdb/db/data.mdb' /opt/zimbra/ wilder@192.168.0.30:/home/wilder/backup-zimbra/ --delete >> backup_mail 2>&1

cat backup_mail | mail -s "Rapport de sauvegarde : $(date +%D)" localadmin@ekoloclast.fr