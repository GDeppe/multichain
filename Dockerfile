# Use an official Ubuntu runtime as a parent image
FROM ubuntu:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Update apt and install dependencies
RUN apt-get update && \
    apt-get install -y wget jq && \
    rm -rf /var/lib/apt/lists/*

# Download and install MultiChain
RUN wget https://www.multichain.com/download/multichain-2.3.3.tar.gz && \
    tar -xvzf multichain-2.3.3.tar.gz && \
    cd multichain-2.3.3 && \
    mv multichaind multichain-cli multichain-util /usr/local/bin && \
    cd .. && \
    rm -rf multichain-2.3.3.tar.gz multichain-2.3.3

#Env Vars
ENV CHAINNAME="base_chain_v2"
ENV NETWORK_PORT="2919"
ENV RPC_PORT="2918"
ENV RPC_ALLOW_IP="0.0.0.0/0"
ENV MASTER_NODE="147.182.214.238"

# Expose MultiChain ports
EXPOSE 2918 2919

# Define the command to run when the container starts
#CMD ["multichaind", "base_chain_v2@147.182.214.238:2919", "-daemon"]
#CMD ["/bin/bash"]
ADD ./runchain.sh /root/runchain.sh
RUN chmod a+x /root/runchain.sh
ADD ./send.sh /root/send.sh
RUN chmod a+x /root/send.sh
ADD sendcron /etc/cron.d/sendcron
RUN chmod 0644 /etc/cron.d/sendcron

CMD ["/bin/bash", "/root/runchain.sh"]
