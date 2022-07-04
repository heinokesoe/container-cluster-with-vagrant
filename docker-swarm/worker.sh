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

sshpass -p "vagrant" scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no vagrant@10.10.10.11:/workerjoin.sh /workerjoin.sh
sh /workerjoin.sh
