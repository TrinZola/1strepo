#!/bin/bash

# Update with the appropriate values
SSH_USER="vagrant"
SERVER1_IP="192.168.60.10"
SERVER2_IP="192.168.60.11"

# Store the public key in a variable
PUBLIC_KEY="-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCD+is0cnPCSaA2QsC6U20Ds3Dm
9lvxYO5WoPo1TtFfKhl+H2P7z3/zdTHSqBRndficz2jpQWccxlHDHQUr04wpO4Hh
7uH+ndahGvz0ELWNbLINm7+iyezH2Zs3FlCH7Sedg2mmhjGbt0kP5USoJEbgRHwX
OeVlPiw6WlWRbaBHZQIDAQAB
-----END PUBLIC KEY-----"

# Create a function to install the public key
install_public_key() {
    local SERVER_IP="$1"
    ssh "$SSH_USER@$SERVER_IP" "mkdir -p ~/.ssh && chmod 700 ~/.ssh && \
        echo '$PUBLIC_KEY' >> ~/.ssh/authorized_keys && \
        chmod 600 ~/.ssh/authorized_keys"
    echo "SSH key has been installed on $SSH_USER@$SERVER_IP."
}

# Install the public key on both servers
install_public_key "$SERVER1_IP"
install_public_key "$SERVER2_IP"
