#!/bin/bash

# Server2 IP address
SERVER2="192.168.60.11"
# User name
USER="vagrant"
# SSH key location
SSH_KEY="/home/$USER/.ssh/id_rsa"

# Create SSH directory if not exists
mkdir -p /home/$USER/.ssh

# Generate SSH key if not exists
if [ ! -f "$SSH_KEY" ]; then
    ssh-keygen -t rsa -N "" -f $SSH_KEY
fi

# Add Server2's public key to known_hosts
ssh-keyscan -H "$SERVER2" >> /home/$USER/.ssh/known_hosts

# Copy the public key to Server2 for passwordless SSH
ssh-copy-id -i "$SSH_KEY.pub" "$USER@$SERVER2"
