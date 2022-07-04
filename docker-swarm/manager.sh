#!/bin/sh

m=1
while [ "$m" -le $MANAGER_NODE_COUNT ]
do
    echo "10.10.10.1$m manager$m manager$m" >> /etc/hosts
    m=$((m + 1))
done

w=1
while [ "$w" -le $WORKER_NODE_COUNT ]
do
    echo "10.10.10.2$w worker$w worker$w" >> /etc/hosts
    w=$((w + 1))
done

if [ "$(cat /etc/hostname)" = "manager1" ]; then
    docker swarm init --advertise-addr 10.10.10.11
    docker swarm join-token manager | grep token > /managerjoin.sh
    docker swarm join-token worker | grep token > /workerjoin.sh
else
    sshpass -p "vagrant" scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no vagrant@10.10.10.11:/managerjoin.sh /managerjoin.sh
    sh /managerjoin.sh
fi
