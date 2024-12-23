#!/bin/bash
docker exec nessus curl -k -X POST https://localhost:8834/scans \
  -H "Content-Type: application/json" \
  -H "X-Cookie: token=$NESSUS_TOKEN" \
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
  }'
echo "Scan Nessus lancé pour Akaunting"
sleep 30
SCAN_ID=$(docker exec nessus curl -k -X GET "https://localhost:8834/scans" -H "X-Cookie: token=$NESSUS_TOKEN" | jq '.scans[0].id')
docker exec nessus curl -k -X GET "https://localhost:8834/scans/${SCAN_ID}/export" -H "X-Cookie: token=$NESSUS_TOKEN" -o /tmp/nessus_report.json
docker cp nessus:/tmp/nessus_report.json ./reports/nessus_report.json
echo "Rapport de vulnérabilité téléchargé et copié dans ./reports/nessus_report.json"
