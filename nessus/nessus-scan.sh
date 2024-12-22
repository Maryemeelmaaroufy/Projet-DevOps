#!/bin/bash

# Lancer un scan Nessus (manuel)
docker exec nessus curl -k -X POST https://localhost:8834/scans \
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
  }'

echo "Scan Nessus lancé pour Akaunting"
