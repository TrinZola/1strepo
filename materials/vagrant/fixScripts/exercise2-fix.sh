HOSTS_FILE="/etc/hosts"
ENTRY_TO_REMOVE="127.0.0.1 www.ascii-art.de"

# Check if the entry exists in the hosts file
if grep -q "$ENTRY_TO_REMOVE" "$HOSTS_FILE"; then
    sudo sed -i "/$ENTRY_TO_REMOVE/d" "$HOSTS_FILE"
    echo "Entry removed from $HOSTS_FILE"
    
    # Flush DNS cache
    if command -v systemctl &>/dev/null; then
        sudo systemctl restart systemd-resolved
    else
        sudo service networking restart
    fi
    
    echo "DNS cache flushed."
else
    echo "Entry not found in $HOSTS_FILE"
fi
