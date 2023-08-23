#!/bin/bash

# Define the network interface and destination
INTERFACE="enp0s8"
DESTINATION="www.textfiles.com"

# Check if the route entry exists
EXISTING_ROUTE=$(ip route show | grep "$DESTINATION")

if [ -n "$EXISTING_ROUTE" ]; then
    echo "Removing route for $DESTINATION from $INTERFACE..."
    sudo ip route del "$DESTINATION" dev "$INTERFACE"
    echo "Route removed successfully."
else
    echo "Route for $DESTINATION on $INTERFACE not found."
fi
