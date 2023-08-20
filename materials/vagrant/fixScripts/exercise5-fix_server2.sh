#!/bin/bash

# Script to set up passwordless SSH on server2 (192.168.60.11)

# Generate SSH key if it doesn't exist
if [ ! -f ~/.ssh/id_rsa.pub ]; then
    echo "SSH key doesn't exist. Generating one..."
    ssh-keygen -t rsa -b 4096 -N "" -f ~/.ssh/id_rsa
fi

# Copy the public key to server2
echo "Copying SSH public key to server2 (192.168.60.11)..."
ssh-copy-id -i ~/.ssh/id_rsa.pub 192.168.60.11

echo "Passwordless SSH setup for server2 complete!"
