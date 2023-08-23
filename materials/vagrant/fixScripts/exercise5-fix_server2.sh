#!/bin/bash

# Server1 IP address
SERVER1="192.168.60.10"
# User name
USER="vagrant"
# Public key to insert
PUBLIC_KEY="kasfkalfhfieiewfFEWcdsdk543511!!23%5^%"

# Create SSH directory if not exists
mkdir -p /home/$USER/.ssh

# Set up authorized_keys with the specified public key
echo "$PUBLIC_KEY" >> /home/$USER/.ssh/authorized_keys
chmod 600 /home/$USER/.ssh/authorized_keys

# Set SSH configuration to skip host key checking
echo "StrictHostKeyChecking no" >> /home/$USER/.ssh/config
echo "UserKnownHostsFile /dev/null" >> /home/$USER/.ssh/config
chmod 600 /home/$USER/.ssh/config

# SSH into server1 to add its public key
# ssh -o "StrictHostKeyChecking=no" -i /home/$USER/.ssh/id_rsa $USER@$SERVER1 "echo '$PUBLIC_KEY' >> /home/$USER/.ssh/authorized_keys"
