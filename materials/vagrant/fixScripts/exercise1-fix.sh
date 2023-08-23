#!/bin/bash

# Check if the script is being run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

# DNS address to add
dns_address="8.8.8.8"

# Backup the original resolved.conf file
cp /etc/systemd/resolved.conf /etc/systemd/resolved.conf.bak

# Check if the address is already present
if ! grep -q "^DNS=$dns_address" /etc/systemd/resolved.conf; then
    echo "DNS=$dns_address" >> /etc/systemd/resolved.conf
    echo "Added DNS address: $dns_address"
else
    echo "DNS address $dns_address is already present."
fi
# Clear IP Tables
sudo iptables -F

# Restart systemd-resolved service
sudo systemctl restart systemd-resolved

echo "DNS address $dns_address added to resolved.conf. systemd-resolved service restarted."
