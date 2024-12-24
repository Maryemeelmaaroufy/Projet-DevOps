#!/bin/bash
if ! docker ps --filter "name=nessus" --format "{{.Names}}" | grep -q "^nessus$"; then
  echo "Erreur : Le conteneur Nessus n'est pas en cours d'exécution."
  exit 1
fi
NESSUS_IP=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' nessus)
if [ -z "$NESSUS_IP" ]; then
  echo "Erreur : Impossible de récupérer l'IP du conteneur Nessus."
  exit 1
fi
echo "Adresse IP du conteneur Nessus : $NESSUS_IP"
echo $NESSUS_IP > ./nessus/nessus_ip.txt
