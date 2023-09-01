#!/bin/bash

sudo apt-get update
sudo apt-get upgrade

sudo apt-get install sshpass -y

ssh-keygen -t rsa -N '' -f /home/vagrant/.ssh/id_rsa <<< y

chown vagrant:vagrant /home/vagrant/.ssh/id_rsa
chown vagrant:vagrant /home/vagrant/.ssh/id_rsa.pub

chmod 764 /home/vagrant/.ssh/id_rsa.pub

sshpass -p vagrant ssh-copy-id -o "StrictHostKeyChecking=no"  -i  /home/vagrant/.ssh/id_rsa.pub vagrant@192.168.60.10

ssh -vvv -tt -o "StrictHostKeyChecking=no" -i /home/vagrant/.ssh/id_rsa vagrant@192.168.60.10 '/usr/bin/bash /home/vagrant/sshing.sh'

sudo sed -i '$a\    StrictHostKeyChecking no' /etc/ssh/ssh_config
