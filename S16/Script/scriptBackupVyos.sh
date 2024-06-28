#!/bin/bash
# Sauvegarder la configuation VyOS

# Variables
VYOS_USER="vyos"
VYOS_IP="192.168.0.253"
LOCAL_BACKUP_DIR="/home/wilder/backup-vyos"
BACKUP_FILE="config-$(date +%F-%H-%M-%S).boot"

# Commandes
ssh $VYOS_USER@$VYOS_IP "save /config/config.boot"
scp $VYOS_USER@$VYOS_IP:/config/config.boot $LOCAL_BACKUP_DIR/$BACKUP_FILE

# Message
echo "La configuration VyOS a été sauvegardée dans $LOCAL_BACKUP_DIR/$BACKUP_FILE"
