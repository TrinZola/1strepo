#!/bin/bash
#add fix to exercise5-server1 here
sudo apt-get install sshpass -y

ssh-keygen -t rsa -N '' -f /home/vagrant/.ssh/id_rsa <<< y
chown vagrant:vagrant /home/vagrant/.ssh/id_rsa
chown vagrant:vagrant /home/vagrant/.ssh/id_rsa.pub

chmod 764 /home/vagrant/.ssh/id_rsa.pub
echo 'sshpass -p vagrant ssh-copy-id -o "StrictHostKeyChecking=no" -i /home/vagrant/.ssh/id_rsa.pub vagrant@192.168.60.11' > /home/vagrant/sshing.sh

chown vagrant:vagrant /home/vagrant/sshing.sh
chmod 774 /home/vagrant/sshing.sh

sudo sed -i '$a\    StrictHostKeyChecking no' /etc/ssh/ssh_config
