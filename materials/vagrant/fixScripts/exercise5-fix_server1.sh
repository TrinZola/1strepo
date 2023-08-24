#!/bin/bash

# Define the source and destination servers
SERVER1_IP="192.168.60.10"
SERVER2_IP="192.168.60.11"

# Define the source and destination paths
SOURCE_PATH="/home/vagrant/.ssh/authorized_keys"
DEST_PATH="~/"

# Generate an SSH key pair (ECDSA)
echo "Generating SSH key pair..."
ssh-keygen -t ecdsa -f ~/.ssh/id_ecdsa -N ""

# Add the private key to the SSH agent
echo "Adding private key to SSH agent..."
ssh-add ~/.ssh/id_ecdsa

# Copy the public key to server1 for authentication
echo "Copying public key to server1 for authentication..."
ssh-copy-id -i ~/.ssh/id_ecdsa.pub "vagrant@${SERVER1_IP}"

# Debug: Display the public key for troubleshooting
echo "Contents of public key:"
cat ~/.ssh/id_ecdsa.pub

# Copy the file from server1 to server2
echo "Copying file from server1 to server2..."
scp "${SERVER1_IP}:${SOURCE_PATH}" "${SERVER2_IP}:${DEST_PATH}"

echo "File copied successfully!"
