#!/bin/bash

# Copy the private key
cp id_rsa /home/vagrant/.ssh/id_rsa

# Read the public key
public_key=$(cat id_rsa.pub)

# Copy the public key and set permissions
echo "Copying ansible-vm public SSH Keys to the VM"
mkdir -p /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
echo "$public_key" >> /home/vagrant/.ssh/authorized_keys
chmod 600 /home/vagrant/.ssh/authorized_keys

# Configure SSH options
echo "Host 192.168.*.*" >> /home/vagrant/.ssh/config
echo "StrictHostKeyChecking no" >> /home/vagrant/.ssh/config
echo "UserKnownHostsFile /dev/null" >> /home/vagrant/.ssh/config
chmod 600 /home/vagrant/.ssh/config
