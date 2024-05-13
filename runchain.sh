#!/bin/bash -x
echo "Setup /root/.multichain/multichain.conf"
mkdir -p /root/.multichain/
cat << EOF > /root/.multichain/multichain.conf
rpcallowip=$RPC_ALLOW_IP
rpcport=$RPC_PORT
EOF

echo "Start the chain"
multichaind -txindex -printtoconsole -shrinkdebugfilesize $CHAINNAME@$MASTER_NODE:$NETWORK_PORT

# Wait for 30 seconds (adjust the time as needed)
sleep 30

# Run the multichain-cli command and output to the terminal
/bin/bash -c "multichain-cli base_chain_v2 getaddresses"
