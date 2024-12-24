#!/bin/bash
TARGET_IP=$1
NESSUS_IP=$(cat nessus_ip.txt)
if [ -z "$TARGET_IP" ] || [ -z "$NESSUS_IP" ]; then
  echo "Erreur : L'adresse cible ou l'adresse IP de Nessus n'est pas définie."
  exit 1
fi
echo "Scan Nessus lancé pour la cible : $TARGET_IP via Nessus à $NESSUS_IP"
docker exec nessus nessuscli scan --target $TARGET_IP --name "Scan Akaunting" --output ./reports/nessus_report.json
if [ -f "./reports/nessus_report.json" ]; then
  echo "Rapport de vulnérabilité téléchargé et copié dans ./reports/nessus_report.json"
else
  echo "Erreur : Le rapport Nessus n'a pas été généré."
  exit 1
fi
