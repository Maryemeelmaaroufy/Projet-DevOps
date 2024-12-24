!/bin/bash
Récupérer l'adresse IP du container Nessus
NESSUS_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' nessus)
if [ -z "$NESSUS_IP" ]; then
  echo "Erreur : Impossible de récupérer l'IP du container Nessus."
  exit 1
fi
echo "$NESSUS_IP" > nessus_ip.txt
