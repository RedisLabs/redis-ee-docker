#!/bin/bash

docker compose down --rmi all --volumes --remove-orphans

# Récupère tous les ports locaux (ceux avant le ':') dans le fichier
ports=$(grep -E '^[[:space:]]+- "[0-9]+:[0-9]+"' docker-compose.yml | sed -E 's/.*"([0-9]+):[0-9]+".*/\1/')

# Liste des ports déjà utilisés
used_ports=()

# Vérifie chaque port
for port in $ports; do
  if lsof -iTCP:"$port" -sTCP:LISTEN -Pn > /dev/null; then
    used_ports+=("$port")
  fi
done

# Affiche uniquement si au moins un est utilisé
if [ ${#used_ports[@]} -gt 0 ]; then
  echo "The following ports are already in use. Stop the program that use them."
  for port in "${used_ports[@]}"; do
    echo "  - $port"
  done
  exit 1
fi


if [[ -n "${DOCKER_ACCESS_TOKEN}" ]]; then
  echo $DOCKER_ACCESS_TOKEN | docker login --username=$DOCKER_USERNAME --password-stdin
fi



docker compose pull

## Build infrastructure ##
docker compose up -d --force-recreate --renew-anon-volumes

## Create cluster ##
docker compose exec -T master-node "/opt/setup_cluster.sh"

## Join nodes ##
docker compose exec -T node-1 "/opt/join_node.sh"
docker compose exec -T node-2 "/opt/join_node.sh"

## Create DB ##
docker compose exec -T master-node "/opt/create_db.sh"