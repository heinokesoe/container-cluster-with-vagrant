#!/bin/bash

for (( i=1; i<=MANAGER_NODE_COUNT; i++ )); do
    echo "10.10.10.1$i manager$i manager$i" >> /etc/hosts
done

for (( i=1; i<=WORKER_NODE_COUNT; i++ )); do
    echo "10.10.10.2$i worker$i worker$i" >> /etc/hosts
done

sshpass -p "vagrant" scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no vagrant@10.10.10.11:/workerjoin.sh /workerjoin.sh
bash /workerjoin.sh
