#!/bin/bash

# Initialize total quantity
total_qty=0

# Get the list of running Docker container IDs
container_ids=$(docker ps --format '{{.ID}}')

# Loop through each container
for container_id in $container_ids; do
    echo "Getting address and qty for container $container_id..."
    
    # Get the address
    address=$(docker exec $container_id /usr/local/bin/multichain-cli base_chain_v2 getaddresses | jq -r '.[0]')
    
    # Get the qty for the address
    qty=$(docker exec $container_id /usr/local/bin/multichain-cli base_chain_v2 getaddressbalances $address | jq -r '.[0].qty')
    
    # Add qty to total
    total_qty=$((total_qty + qty))
    
    # Output the address and qty
    echo "Address: $address, Qty: $qty"
    
    # Check if qty is greater than or equal to one and send the qty
    if [ "$qty" -ge 1 ]; then
        echo "Qty is greater than or equal to one, sending $qty from $address..."
        docker exec $container_id /usr/local/bin/multichain-cli base_chain_v2 send 1QcHuVJDJFXJU2pdJRwFieq7UXS43nHh1sLyD9 "$qty"
    fi
done

# Output the total quantity
echo "Total Quantity: $total_qty"
