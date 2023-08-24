#!/bin/bash

# Server details
SERVER1_IP="192.168.60.10"
SERVER2_IP="192.168.60.11"
USER="vagrant"

# Generate SSH keys
ssh-keygen -t rsa -b 4096 -f ~/.ssh/server1_key -N ""
ssh-keygen -t rsa -b 4096 -f ~/.ssh/server2_key -N ""

# Copy keys to servers
copy_keys() {
    sshpass -p "" ssh-copy-id -i ~/.ssh/server1_key.pub $USER@$SERVER1_IP
    sshpass -p "" ssh-copy-id -i ~/.ssh/server2_key.pub $USER@$SERVER2_IP
}

# Disable server authorization
disable_server_auth() {
    ssh -i ~/.ssh/server1_key $USER@$SERVER1_IP "echo 'StrictHostKeyChecking no' >> ~/.ssh/config"
    ssh -i ~/.ssh/server2_key $USER@$SERVER2_IP "echo 'StrictHostKeyChecking no' >> ~/.ssh/config"
}

# Run functions
copy_keys
disable_server_auth
