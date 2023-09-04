#!/bin/bash

# Server information
server1_name="server1"
server1_ip="192.168.60.10"

# Add server1 entry to /etc/hosts
if ! grep -q "$server1_name" /etc/hosts; then
    echo "$server1_ip $server1_name" | sudo tee -a /etc/hosts > /dev/null
    echo "Added entry for $server1_name"
else
    echo "Entry for $server1_name already exists"
fi
