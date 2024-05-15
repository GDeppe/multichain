#!/bin/bash -x

# Create the MultiChain configuration directory if it doesn't exist
if [ ! -d /root/.multichain/ ]; then
    mkdir -p /root/.multichain/
fi

# Create the multichain.conf file only if it doesn't exist
if [ ! -f /root/.multichain/multichain.conf ]; then
    echo "Setup /root/.multichain/multichain.conf"
    cat << EOF > /root/.multichain/multichain.conf
rpcallowip=$RPC_ALLOW_IP
rpcport=$RPC_PORT
EOF
else
    echo "/root/.multichain/multichain.conf already exists. Skipping creation."
fi

echo "Start the chain"
multichaind -txindex -printtoconsole -shrinkdebugfilesize $CHAINNAME@$MASTER_NODE:$NETWORK_PORT

# Wait for 30 seconds (adjust the time as needed)
sleep 30

# Run the multichain-cli command and output to the terminal
/bin/bash -c "multichain-cli $CHAINNAME getaddresses"
