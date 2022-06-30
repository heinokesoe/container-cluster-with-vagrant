#!/bin/bash

for (( i=1; i<=MANAGER_NODE_COUNT; i++ )); do
    echo "10.10.10.1$i manager$i manager$i" >> /etc/hosts
done

for (( i=1; i<=WORKER_NODE_COUNT; i++ )); do
    echo "10.10.10.2$i worker$i worker$i" >> /etc/hosts
done

if [[ "$(cat /etc/hostname)" == "manager1" ]]; then
    docker swarm init --advertise-addr 10.10.10.11
    docker swarm join-token manager | grep token > /managerjoin.sh
    docker swarm join-token worker | grep token > /workerjoin.sh
else
    sshpass -p "vagrant" scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no vagrant@10.10.10.11:/managerjoin.sh /managerjoin.sh
    bash /managerjoin.sh
fi
