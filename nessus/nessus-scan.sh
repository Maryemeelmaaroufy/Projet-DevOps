#!/bin/bash
if [ ! -f nessus_ip.txt ]; then
  echo "Erreur : Le fichier nessus_ip.txt contenant l'IP de Nessus est introuvable."
  exit 1
fi
NESSUS_IP=$(cat nessus_ip.txt)
if [ -z "$NESSUS_IP" ]; then
  echo "Erreur : IP de Nessus non valide."
  exit 1
fi
echo "IP de Nessus récupérée : $NESSUS_IP"
SCAN_OUTPUT=$(curl -k -X POST https://$NESSUS_IP:8834/scans \
  -H "Content-Type: application/json" \
  -d '{
    "uuid": "basic",
    "settings": {
      "name": "Akaunting Scan",
      "enabled": true,
      "text_targets": "akaunting",
      "launch": "ON_DEMAND",
      "scanner_id": "1",
      "policy_id": "1"
    }
  }')
REPORT_DIR="./reports"
mkdir -p $REPORT_DIR
REPORT_FILE="$REPORT_DIR/nessus_report.json"
echo "$SCAN_OUTPUT" > $REPORT_FILE
echo "Rapport de vulnérabilité sauvegardé dans $REPORT_FILE"
