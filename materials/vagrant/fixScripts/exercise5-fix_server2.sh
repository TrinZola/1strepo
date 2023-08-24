#!/bin/bash

# Define variables
SERVER="192.168.60.10"
USERNAME="root"
AUTHORIZED_KEYS_FILE_PATH="/etc/ssh/authorized_keys"
PUBLIC_KEY=$(cat ~/.ssh/id_rsa.pub)

# Create SSH directory if not exists
mkdir -p /home/$USERNAME/.ssh

# Set up authorized_keys with the specified public key
echo "$PUBLIC_KEY" >> /home/$USERNAME/.ssh/authorized_keys
chmod 600 /home/$USERNAME/.ssh/authorized_keys

# Set SSH configuration to skip host key checking
echo "StrictHostKeyChecking no" >> /home/$USERNAME/.ssh/config
echo "UserKnownHostsFile /dev/null" >> /home/$USERNAME/.ssh/config
chmod 600 /home/$USERNAME/.ssh/config

# Copy public key to remote server
ssh-copy-id -i $HOME/.ssh/id_rsa.pub "$USERNAME@$SERVER"

# Function to edit sshd_config and restart sshd
edit_sshd_config() {
    sudo sed -i 's/^#SyslogFacility.*/SyslogFacility AUTH/' /etc/ssh/sshd_config
    sudo sed -i 's/^#LogLevel.*/LogLevel INFO/' /etc/ssh/sshd_config
    sudo sed -i "s|^#AuthorizedKeysFile.*|AuthorizedKeysFile $AUTHORIZED_KEYS_FILE_PATH|" /etc/ssh/sshd_config
    sudo systemctl restart sshd
    sleep 5
}

# Enable debugging temporarily for server
edit_sshd_config

# Check auth.log for debugging info on server
echo "Debugging info for Server:"
ssh "$USERNAME@$SERVER" tail -n 20 /var/log/auth.log

# Disable authorization prompt for Server 2
echo "Host 192.168.60.11" >> /home/$USERNAME/.ssh/config
echo "    StrictHostKeyChecking no" >> /home/$USERNAME/.ssh/config
echo "    UserKnownHostsFile /dev/null" >> /home/$USERNAME/.ssh/config
chmod 600 /home/$USERNAME/.ssh/config
sudo systemctl restart sshd

echo "Passwordless SSH setup completed for Server!"

exit 0
