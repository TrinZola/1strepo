#!/bin/bash

# Server information
server2_name="server2"
server2_ip="192.168.60.11"

# Add server2 entry to /etc/hosts
if ! grep -q "$server2_name" /etc/hosts; then
    echo "$server2_ip $server2_name" | sudo tee -a /etc/hosts > /dev/null
    echo "Added entry for $server2_name"
else
    echo "Entry for $server2_name already exists"
fi
