#!/bin/sh

# docker���C���X�R����
yum -y install http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
yum -y install docker-io git
service docker start
chkconfig docker on
usermod -G docker vagrant


# �z�X�g���璼��docker�R���e�i�ɃA�N�Z�X�ł���悤�ɂ���
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


# chef���C���X�R����
yum -y install gcc zlib-devel openssl-devel sqlite sqlite-devel

# chef�肽���̂ŐV����ruby������
git clone git://github.com/sstephenson/rbenv.git /home/vagrant/.rbenv

echo 'export RBENV_ROOT="/home/vagrant/.rbenv"' >> /home/vagrant/.rbenvrc
echo 'export PATH="${RBENV_ROOT}/bin:${PATH}"' >> /home/vagrant/.rbenvrc
echo 'eval "$(rbenv init -)"' >> /home/vagrant/.rbenvrc
echo "source /home/vagrant/.rbenvrc" >> /home/vagrant/.bash_profile

source /home/vagrant/.rbenvrc

mkdir ${RBENV_ROOT}/plugins
git clone https://github.com/sstephenson/ruby-build.git ${RBENV_ROOT}/plugins/ruby-build

rbenv install 2.1.2
rbenv rehash
rbenv global 2.1.2

chown -R vagrant:vagrant /home/vagrant/.rbenvrc
chown -R vagrant:vagrant /home/vagrant/.rbenv
gem install knife-solo --no-ri --no-rdoc


# docker�R���e�i��SSH���邽�߂̏���
mkdir /home/vagrant/.ssh
cp /vagrant/share/id_rsa.docker /home/vagrant/id_rsa
cp /vagrant/share/id_rsa.docker.pub /home/vagrant/id_rsa.pub
chown -R vagrant:vagrant /home/vagrant/.ssh
chmod -R g-rwx,o-rwx /home/vagrant/.ssh


