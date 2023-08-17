# Configure Apache to bind to the specified IP address
sudo sed -i 's/Listen 80/Listen 192.168.60.10:80/' /etc/apache2/ports.conf

# Create a virtual host configuration file for the specified IP address
sudo bash -c "cat << EOF > /etc/apache2/sites-available/192.168.60.10.conf
<VirtualHost 192.168.60.10:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF"

# Enable the virtual host configuration
sudo a2ensite 192.168.60.10.conf

# Disable the default virtual host
sudo a2dissite 000-default.conf#!/bin/bash
#add fix to exercise3 here
