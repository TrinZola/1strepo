#!/bin/bash

# Specify the IP address to configure Apache
ip_address="192.168.60.10"

# Configure Apache to bind to the specified IP address
sudo sed -i "s/Listen 80/Listen $ip_address:80/" /etc/apache2/ports.conf

# Create a virtual host configuration file for the specified IP address
sudo bash -c "cat << EOF > /etc/apache2/sites-available/$ip_address.conf
<VirtualHost $ip_address:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF"

# Enable the virtual host configuration
sudo a2ensite $ip_address.conf

# Disable the default virtual host
sudo a2dissite 000-default.conf

# Restart Apache to apply the changes
sudo service apache2 restart

# Check if the Apache server is running
apache_status=$(sudo service apache2 status)
if [[ $apache_status == *"active (running)"* ]]; then
    echo "Apache server is running."
    # Check if the Apache server is reachable
    curl_output=$(curl -sI http://$ip_address/)
    if [[ $curl_output == *"Server: Apache"* ]]; then
        echo "Hello world"
    else
        echo "Apache server is running, but not reachable."
    fi
else
    echo "Apache server is not running."
fi
