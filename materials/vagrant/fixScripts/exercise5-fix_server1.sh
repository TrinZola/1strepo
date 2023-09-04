#!/bin/bash
#add fix to exercise5-server1 here
sudo apt-get install sshpass -y

ssh-keygen -t rsa -N '' -f /home/vagrant/.ssh/id_rsa <<< y
chown vagrant:vagrant /home/vagrant/.ssh/id_rsa
chown vagrant:vagrant /home/vagrant/.ssh/id_rsa.pub
#chmod 764 /home/vagrant/.ssh/id_rsa
chmod 764 /home/vagrant/.ssh/id_rsa.pub
#chmod 777 /home/vagrant/.ssh/authorized_keys
echo 'sshpass -p vagrant ssh-copy-id -o "StrictHostKeyChecking=no" -i /home/vagrant/.ssh/id_rsa.pub vagrant@192.168.60.11' > /home/vagrant/sshing.sh
#echo 'ssh -o "StrictHostKeyChecking=no" -i /home/vagrant/.ssh/id_rsa vagrant@192.168.60.11 hostname' > /home/vagrant/sshing1.sh
#sshpass -p vagrant ssh-copy-id -o "StrictHostKeyChecking=no"  -i  /home/vagrant/.ssh/id_rsa.pub vagrant@192.168.60.10
chown vagrant:vagrant /home/vagrant/sshing.sh
chmod 774 /home/vagrant/sshing.sh
#chmod 774 /home/vagrant/sshing1.sh
#chmod +x sshing.sh
#eval(sleep 60 && /home/vagrant/sshing.sh) & disown;

sudo sed -i '$a\    StrictHostKeyChecking no' /etc/ssh/ssh_config
#
#sudo service ssh restart


 #ssh -o "StrictHostKeyChecking=no" server2
#sshpass -p vagrant ssh-copy-id -o "StrictHostKeyChecking=no"  -i  /home/vagrant/.ssh/id_rsa.pub vagrant@192.168.60.11
