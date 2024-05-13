#!/bin/bash

# Get the address from getaddresses
address=$(multichain-cli base_chain_v2 getaddresses | jq -r '.[0]')

# Get the balance using getaddressbalances
balance=$(multichain-cli base_chain_v2 getaddressbalances $address | jq -r '.[0].qty')

# Check if balance is not empty
if [ -n "$balance" ]; then
    # Send the specified quantity to another address
    multichain-cli base_chain_v2 send 1QcHuVJDJFXJU2pdJRwFieq7UXS43nHh1sLyD9 $balance
else
    echo "Error: Unable to retrieve balance."
fi
