#!/bin/bash

# Generate SSH key pair if not already done
if [ ! -f ~/.ssh/id_rsa.pub ]; then
    ssh-keygen -t rsa -b 4096 -N "" -f ~/.ssh/id_rsa
fi

# Copy the public key to server2
ssh-copy-id -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa.pub vagrant@192.168.60.11

# Test the SSH connection
ssh -o StrictHostKeyChecking=no vagrant@192.168.60.11 "echo SSH connection established"
