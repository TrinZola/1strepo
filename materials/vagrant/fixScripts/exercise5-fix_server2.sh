#!/bin/bash

# Run the entire script with elevated privileges
sudo bash <<EOF

# Check if the script is being run with root privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root." 
   exit 1
fi

# Path to the SSH daemon configuration file
sshd_config_file="/etc/ssh/sshd_config"

# Path to the authorized_keys file
authorized_keys_file="/home/vagrant/.ssh/authorized_keys"

# Function to configure SSH client to avoid host key checking
configure_ssh_client() {
    echo -e "Host *\n\tStrictHostKeyChecking no\n\tUserKnownHostsFile=/dev/null" >> "$ssh_config_file"
}

# Function to enable public key authentication
enable_public_key_authentication() {
    sed -i 's/^#*\s*\(PasswordAuthentication\)\s\+.*$/\1 no/' "$sshd_config_file"
    sed -i 's/^#*\s*\(PubkeyAuthentication\)\s\+.*$/\1 yes/' "$sshd_config_file"
    sed -i 's/^#*\s*\(AuthorizedKeysFile\)\s\+.*$/\1 %h\/.ssh\/authorized_keys/' "$sshd_config_file"
}

# Restart SSH service
restart_ssh_service() {
    systemctl restart ssh
}

# Define the source and destination servers
SERVER1_IP="192.168.60.10"
SERVER2_IP="192.168.60.11"

# Define the source and destination paths
SOURCE_PATH="/home/vagrant/.ssh/authorized_keys"
DEST_PATH="/home/vagrant/.ssh/authorized_keys"

# Create .ssh directory with appropriate permissions if it doesn't exist
echo "Creating .ssh directory and setting permissions..."
mkdir -p /home/vagrant/.ssh && sudo chmod 700 ~/.ssh

# Set up SSH config to avoid authentication prompts
echo "Setting up SSH config to avoid authentication prompts..."
echo "Host $SERVER2_IP" >> /home/vagrant/.ssh/config
echo "    IdentityFile /home/vagrant/.ssh/id_ecdsa" >> /home/vagrant/.ssh/config
chmod 644 /home/vagrant/.ssh/config
# Generate an SSH key pair (ECDSA)
echo "Generating SSH key pair..."
ssh-keygen -t ecdsa -f ~/.ssh/id_ecdsa -N ""

# Add the private key to the SSH agent
echo "Adding private key to SSH agent..."
ssh-add ~/.ssh/id_ecdsa

cat /home/vagrant/.ssh/id_ecdsa.pub >> "$authorized_keys_file"
ssh-copy-id -i /home/vagrant/.ssh/id_ecdsa.pub "vagrant@${SERVER1_IP}"

# Copy the public key content from server2 to server1
echo "Copying public key content from server2 to server1..."
scp -F "/home/vagrant/.ssh/config" /home/vagrant/.ssh/id_ecdsa.pub "vagrant@192.168.60.10:/home/vagrant/.ssh/authorized_keys"

echo "Public key content copied successfully!"

EOF
