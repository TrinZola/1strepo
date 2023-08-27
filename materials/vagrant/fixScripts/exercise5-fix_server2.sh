#!/bin/bash

# Run the entire script with elevated privileges
sudo bash <<EOF

# Define the source and destination servers
SERVER1_IP="192.168.60.10"
SERVER2_IP="192.168.60.11"

# Define the source and destination paths
SOURCE_PATH="/home/vagrant/.ssh/authorized_keys"
DEST_PATH="~/"

# Create .ssh directory with appropriate permissions if it doesn't exist
echo "Creating .ssh directory and setting permissions..."
mkdir -p /home/vagrant/.ssh && sudo chmod 700 ~/.ssh

# Generate an SSH key pair (ECDSA)
echo "Generating SSH key pair..."
ssh-keygen -t ecdsa -f /home/vagrant/.ssh/id_ecdsa -N ""

# Add the private key to the SSH agent
echo "Adding private key to SSH agent..."
ssh-add /home/vagrant/.ssh/id_ecdsa

# Copy the public key to server1 for authentication
echo "Copying public key to server1 for authentication..."
ssh-copy-id -i /home/vagrant/.ssh/id_ecdsa.pub "vagrant@${SERVER1_IP}"

# Debug: Display the public key for troubleshooting
echo "Contents of public key:"
cat /home/vagrant/.ssh/id_ecdsa.pub

# Copy the file from server2 to server1
echo "Copying file from server2 to server1..."
scp "${SERVER2_IP}:${SOURCE_PATH}" "${SERVER1_IP}:${DEST_PATH}"

echo "File copied successfully!"
