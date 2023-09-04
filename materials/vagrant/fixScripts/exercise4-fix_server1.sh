#!/bin/bash
#add fix to exercise4-server1 here

#adding rule to hosts file
sudo sed -i '$a\192.168.60.11	   server2 server2' /etc/hosts


# changing PasswordAuthentication value to 'yes'
sudo sed -i "s:PasswordAuthentication no:PasswordAuthentication yes :g"   \
  /etc/ssh/sshd_config



# restart service so changes will take effect
sudo service sshd restart
