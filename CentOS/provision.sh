#!/bin/sh

yum -y install http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
yum -y install docker-io
usermod -G docker vagrant
service docker start
chkconfig docker on

# routing both host and dockers
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
