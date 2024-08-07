#!/bin/bash

# Initialize total quantity
total_qty=0

# Get the address
address=$(multichain-cli base_chain_v2 getaddresses | jq -r '.[0]')
    
# Get the qty for the address
qty=$(multichain-cli base_chain_v2 getaddressbalances $address | jq -r '.[0].qty')
    
# Add qty to total
total_qty=$((total_qty + qty))
    
# Output the address and qty
echo "Address: $address, Qty: $qty"

# Telegram bot credentials
telegram_bot_token=""
chat_id="-"
message="LVS Node has mined $total_qty Blocks so far this week"

# Send message via Telegram bot
curl -s -X POST "https://api.telegram.org/bot$telegram_bot_token/sendMessage" -d "chat_id=$chat_id" -d "text=$message"
