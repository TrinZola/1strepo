#!/bin/bash

# Run the entire script with elevated privileges
sudo bash <<EOF

# Define the source and destination servers
SERVER1_IP="192.168.60.10"
SERVER2_IP="192.168.60.11"

# Path to the authorized_keys file
authorized_keys_file="/home/vagrant/.ssh/authorized_keys"

# Define the source and destination paths
SOURCE_PATH="/home/vagrant/.ssh/authorized_keys"
DEST_PATH="/home/vagrant/.ssh/authorized_keys"

# Create .ssh directory with appropriate permissions if it doesn't exist
echo "Creating .ssh directory and setting permissions..."
mkdir -p /home/vagrant/.ssh && sudo chmod 700 ~/.ssh

# Set up SSH config to avoid authentication prompts
echo "Setting up SSH config to avoid authentication prompts..."
echo "Host $SERVER1_IP" >> /home/vagrant/.ssh/config
echo "    IdentityFile /home/vagrant/.ssh/id_ecdsa" >> /home/vagrant/.ssh/config
chmod 644 /home/vagrant/.ssh/config

# Generate an SSH key pair (ECDSA)
echo "Generating SSH key pair..."
ssh-keygen -t ecdsa -f /home/vagrant/.ssh/id_ecdsa -N ""

# Add the private key to the SSH agent
# echo "Adding private key to SSH agent..."
  ssh-add /home/vagrant/.ssh/id_ecdsa

cat /home/vagrant/.ssh/id_ecdsa.pub >> "$authorized_keys_file"

# Copy the public key content from server2 to server1
# echo "Copying public key content from server2 to server1..."
# scp -F "/home/vagrant/.ssh/config" /home/vagrant/.ssh/id_ecdsa.pub "vagrant@192.168.60.10:/home/vagrant/.ssh/authorized_keys2"

# echo "Public key content copied successfully!"
