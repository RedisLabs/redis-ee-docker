#!/bin/bash

if [[ -n "${DOCKER_ACCESS_TOKEN}" ]]; then
  echo $DOCKER_ACCESS_TOKEN | docker login --username=$DOCKER_USERNAME --password-stdin
fi

## Build infrastructure ##
docker-compose up -d

## Create cluster ##
docker-compose exec -T master-node "/opt/setup_cluster.sh"

## Join nodes ##
docker-compose exec -T node-1 "/opt/join_node.sh"
docker-compose exec -T node-2 "/opt/join_node.sh"

## Create DB ##
docker-compose exec -T master-node "/opt/create_db.sh"
