#!/bin/bash

## Build infrastructure ##
docker-compose up -d
sleep 10

## Create cluster ##
docker-compose exec master-node "/opt/setup_cluster.sh"

## Join nodes ##
docker-compose exec node-1 "/opt/join_node.sh"
docker-compose exec node-2 "/opt/join_node.sh"

## Create DB ##
docker-compose exec -e OSS_CLUSTER=$1 master-node "/opt/create_db.sh"