#!/bin/bash
#add fix to exercise3 here
#replace string in '/etc/apache2/sites-available/000-default.conf '
sudo sed -i 's/Require all denied/Require all granted/'    \
  /etc/apache2/sites-available/000-default.conf

# To take effect
sudo service apache2 restart
