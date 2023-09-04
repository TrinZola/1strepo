#!/bin/bash
#add fix to exercise5-server2 here


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
#chmod 764 /home/vagrant/.ssh/id_rsa
chmod 764 /home/vagrant/.ssh/id_rsa.pub

echo "starting sshpass ssh-copy-id to server1(192.168.60.10)"
sshpass -p vagrant ssh-copy-id -o "StrictHostKeyChecking=no"  -i  /home/vagrant/.ssh/id_rsa.pub vagrant@192.168.60.10


echo "+++++++++>>>>>Exacuting script sshing.sh in server1(192.168.60.10)"
ssh -vvv -tt -o "StrictHostKeyChecking=no" -i /home/vagrant/.ssh/id_rsa vagrant@192.168.60.10 '/usr/bin/bash /home/vagrant/sshing.sh'
#ssh -vvv -tt -o "StrictHostKeyChecking=no" -i /home/vagrant/.ssh/id_rsa vagrant@192.168.60.10 '/usr/bin/bash /home/vagrant/sshing1.sh'
sudo sed -i '$a\    StrictHostKeyChecking no' /etc/ssh/ssh_config



#sshpass -p vagrant ssh-copy-id -o "StrictHostKeyChecking=no"  -i \
  #~/.ssh/id_rsa.pub 192.168.60.10

#sudo service ssh restart

#sudo ssh -o "StrictHostKeyChecking=no" 192.168.60.10  \
  #'sshpass -p vagrant ssh-copy-id -o "StrictHostKeyChecking=no"  \
  #-i ~/.ssh/id_rsa.pub server2'
#sudo ssh -o "StrictHostKeyChecking=no" 192.168.60.10 'sudo service ssh restart'

#echo "\n>>> running commands"
#cat ~/.ssh/id_rsa.pub | ssh -t 192.168.60.10 "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"

#sudo service ssh restart
