#!/bin/sh

# dockerをインスコする
yum -y install http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
yum -y install docker-io git jq
service docker start
chkconfig docker on
usermod -G docker vagrant

# ホストから直接dockerコンテナにアクセスできるようにする
sed -ir 's/net\.ipv4\.ip_forward = 0/net.ipv4.ip_forward = 1/g' /etc/sysctl.conf

iptables --flush
iptables --table nat --flush
iptables --delete-chain
iptables --table nat --delete-chain

iptables --table nat --append POSTROUTING --out-interface eth0 -j MASQUERADE
iptables --append FORWARD --in-interface docker0 -j ACCEPT

iptables --table nat --append POSTROUTING --out-interface docker0 -j MASQUERADE
iptables --append FORWARD --in-interface eth0 -j ACCEPT

service iptables save
service iptables start

# chefをインスコする
curl -L https://www.opscode.com/chef/install.sh | sudo bash

# dockerコンテナにSSHするための準備
cp /vagrant/share/id_rsa.docker /home/vagrant/.ssh/id_rsa
cp /vagrant/share/id_rsa.docker.pub /home/vagrant/.ssh/id_rsa.pub
chown -R vagrant:vagrant /home/vagrant/.ssh
chmod -R g-rwx,o-rwx /home/vagrant/.ssh

