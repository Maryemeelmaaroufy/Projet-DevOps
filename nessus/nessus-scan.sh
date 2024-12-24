#!/bin/bash
if [ ! -f ./nessus/nessus_ip.txt ]; then
  echo "Erreur : Le fichier nessus_ip.txt n'existe pas. Veuillez exécuter get_nessus_ip.sh d'abord."
  exit 1
fi
NESSUS_IP=$(cat ./nessus/nessus_ip.txt)
if [ -z "$NESSUS_IP" ]; then
  echo "Erreur : Impossible de lire l'IP du conteneur Nessus."
  exit 1
fi
echo "Scan Nessus lancé pour Akaunting"
docker exec nessus nessuscli scan --target "$NESSUS_IP" --output /tmp/nessus_scan.json
docker cp nessus:/tmp/nessus_scan.json ./reports/nessus_report.json
if [ -f ./reports/nessus_report.json ]; then
  echo "Rapport de vulnérabilité téléchargé et copié dans ./reports/nessus_report.json"
else
  echo "Erreur : Le rapport de vulnérabilité n'a pas pu être copié."
  exit 1
fi
