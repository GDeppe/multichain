### About
This is a docker compose template for setting up several multiminer nodes to mine Base. This works on Ubuntu, running on Windows or another OS has not been tested so milage may vary.

### Breakdown

```
services:
  multichain-node1:
    build: .
    ports:
      - "8000:2918"
      - "8001:2919"
    volumes:
      - ./chain1:/root/.multichain/base_chain_v2
    mem_limit: 1g
    cpus: 0.5
    restart: always

  multichain-node2:
    build: .
    ports:
      - "2920:2918"
      - "2921:2919"
    volumes:
      - ./chain2:/root/.multichain/base_chain_v2
    mem_limit: 1g
    cpus: 0.5
    restart: always
```

For each container be sure to change your ingress ports to prevent clashes in Docker. Ports 2918 and 2919 are the service ports exposed by the containers and should remain static.
Modify the CPU for your needs, I would recommend a setting of 0.5 if you aren't sure. Volumes are persistent and will be created in your working directory, this aids recovery after a reboot or container failure.

### Scripts
```
getaddresses.sh
```
Loops through the containers and obtains the address from each miner.
```
getamount.sh
```
Loops through the containers, collects the amount of Base mined and totals the amount at the end.
Make sure to make the scripts executable
```
chmod +x getaddresses.sh
```
### Starting containers
This uses docker compose which should be installed by default in recent version of Ubuntu. See the Docker website if you need to install Docker or Docker Compose
```
docker compose build
docker compose up -d
```
You can check running containers with
```
docker ps
```


