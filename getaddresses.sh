#!/bin/bash

# Get the list of running Docker container IDs
container_ids=$(docker ps --format '{{.ID}}')

# Loop through each container
for container_id in $container_ids; do
    # Execute multichain-cli command in the container
    addresses=$(docker exec $container_id /usr/local/bin/multichain-cli base_chain_v2 getaddresses 2>/dev/null)
    
    # Extract the address from the output
    address=$(echo "$addresses" | jq -r '.[0]')
    
    # Output the address
    echo "Address for container $container_id: $address"
done
