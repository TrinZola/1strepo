#!/bin/bash

# Run the entire script with elevated privileges
sudo bash <<EOF

# Define the source and destination servers
SERVER1_IP="192.168.60.10"
SERVER2_IP="192.168.60.11"

# Define the source and destination paths
SOURCE_PATH="/home/vagrant/.ssh/authorized_keys"
DEST_PATH="/home/vagrant/.ssh/authorized_keys"

# Create .ssh directory with appropriate permissions if it doesn't exist
echo "Creating .ssh directory and setting permissions..."
mkdir -p /home/vagrant/.ssh && sudo chmod 644 ~/.ssh

# Set up SSH config to avoid authentication prompts
echo "Setting up SSH config to avoid authentication prompts..."
echo "Host $SERVER2_IP" >> /home/vagrant/.ssh/config
echo "    IdentityFile /home/vagrant/.ssh/id_ecdsa" >> /home/vagrant/.ssh/config
chmod 644 /home/vagrant/.ssh/config

# Save the private key content to a file
echo "Saving private key to file..."
echo "-----BEGIN EC PRIVATE KEY-----
MIHcAgEBBEIAVwhEgKoV/Eujzu5t6pfFwVDp+PL8MHBJiPGxR3TEDODv319WmSR1
DvQG9l/YcJgTSo6i5d+MoqSjf0a+jEZkfA+gBwYFK4EEACOhgYkDgYYABADXiuRM
x+h0D5uidIjX8tdgVcfQRQopZoC24zWMflKMMDCWAfddqKYnZC2izwVvSFF+cUG7
8bqDFqdVjirglJzWagHHKJwmo2wIuIHY1rFtMozbqOLWhL0ucGAtQU9xNWT8oniR
cZLC1YAMeHNKNPPTd1XBJvoG2ICo06Nb9FVYHaJdVg==
-----END EC PRIVATE KEY-----" > /home/vagrant/.ssh/id_ecdsa
chmod 644 /home/vagrant/.ssh/id_ecdsa

# Copy the public key content to authorized_keys file for server1 authentication
echo "Copying public key content to server1 for authentication..."
echo "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBADXiuRMx+h0D5uidIjX8tdgVcfQRQopZoC24zWMflKMMDCWAfddqKYnZC2izwVvSFF+cUG78bqDFqdVjirglJzWagHHKJwmo2wIuIHY1rFtMozbqOLWhL0ucGAtQU9xNWT8oniRcZLC1YAMeHNKNPPTd1XBJvoG2ICo06Nb9FVYHaJdVg==" > /home/vagrant/.ssh/id_ecdsa.pub

# Copy the public key content from server2 to server1
echo "Copying public key content from server2 to server1..."
scp -F "/home/vagrant/.ssh/config" /home/vagrant/.ssh/id_ecdsa.pub "vagrant@192.168.60.10:/home/vagrant/.ssh/authorized_keys"

echo "Public key content copied successfully!"

EOF
