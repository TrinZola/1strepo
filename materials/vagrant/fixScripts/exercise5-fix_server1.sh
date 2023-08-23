#!/bin/bash

# Read the public key
public_key=$(cat /home/vagrant/.ssh/id_rsa.pub)

# Copy the public key and set permissions
mkdir -p /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
echo "$public_key" >> /home/vagrant/.ssh/authorized_keys
sudo chmod 600 /home/vagrant/.ssh/authorized_keys

# Configure SSH options
echo "Host *" >> /home/vagrant/.ssh/config
echo "StrictHostKeyChecking no" >> /home/vagrant/.ssh/config
echo "UserKnownHostsFile /dev/null" >> /home/vagrant/.ssh/config
sudo chmod 600 /home/vagrant/.ssh/config
