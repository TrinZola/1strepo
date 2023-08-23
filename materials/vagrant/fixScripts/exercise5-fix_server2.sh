#!/bin/bash

# Server1 IP address
SERVER1="192.168.60.10"
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

# Set SSH configuration to skip host key checking
echo "StrictHostKeyChecking no" > /home/$USER/.ssh/config

# Copy the public key to Server1 for passwordless SSH
sshpass -p "" ssh-copy-id -i "$SSH_KEY.pub" "$USER@$SERVER1"
