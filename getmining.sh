#!/bin/bash

# Get the list of running Docker container IDs
container_ids=$(docker ps --format '{{.ID}}')

# Loop through each container
for container_id in $container_ids; do
    # Execute multichain-cli command in the container
    docker exec $container_id /usr/local/bin/multichain-cli base_chain_v2 getmininginfo
done
