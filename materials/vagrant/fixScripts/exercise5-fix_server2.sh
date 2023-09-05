#!/bin/bash

sudo sed -i '$a\192.168.60.10	 server1 server1' /etc/hosts

# changing PasswordAuthentication value to 'yes'
sudo sed -i "s:PasswordAuthentication no:PasswordAuthentication yes :g" \
  /etc/ssh/sshd_config

# restart service so changes will take effect
sudo service sshd restart
echo "Updating System"
sudo apt-get update && sudo apt-get upgrade

echo "Installing sshpass"
sudo apt-get install sshpass -y
echo "Generating keys"
ssh-keygen -t rsa -N '' -f /home/vagrant/.ssh/id_rsa <<< y

echo "Changing owner"
chown vagrant:vagrant /home/vagrant/.ssh/id_rsa
chown vagrant:vagrant /home/vagrant/.ssh/id_rsa.pub

echo "Changing permisions"
chmod 764 /home/vagrant/.ssh/id_rsa.pub

echo "starting sshpass ssh-copy-id to server1(192.168.60.10)"
sshpass -p vagrant ssh-copy-id -o "StrictHostKeyChecking=no"  -i  /home/vagrant/.ssh/id_rsa.pub vagrant@192.168.60.10

echo "+++++++++>>>>>Exacuting script sshing.sh in server1(192.168.60.10)"
ssh -vvv -tt -o "StrictHostKeyChecking=no" -i /home/vagrant/.ssh/id_rsa vagrant@192.168.60.10 '/usr/bin/bash /home/vagrant/sshing.sh'
sudo sed -i '$a\    StrictHostKeyChecking no' /etc/ssh/ssh_config
