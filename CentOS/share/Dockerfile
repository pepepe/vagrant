FROM ubuntu:14.04

RUN echo "deb http://jp.archive.ubuntu.com/ubuntu/ saucy main restricted\n\
deb-src http://jp.archive.ubuntu.com/ubuntu/ saucy main restricted\n\
deb http://jp.archive.ubuntu.com/ubuntu/ saucy-updates main restricted\n\
deb-src http://jp.archive.ubuntu.com/ubuntu/ saucy-updates main restricted\n\
deb http://jp.archive.ubuntu.com/ubuntu/ saucy universe\n\
deb-src http://jp.archive.ubuntu.com/ubuntu/ saucy universe\n\
deb http://jp.archive.ubuntu.com/ubuntu/ saucy-updates universe\n\
deb-src http://jp.archive.ubuntu.com/ubuntu/ saucy-updates universe\n\
deb http://jp.archive.ubuntu.com/ubuntu/ saucy multiverse\n\
deb-src http://jp.archive.ubuntu.com/ubuntu/ saucy multiverse\n\
deb http://jp.archive.ubuntu.com/ubuntu/ saucy-updates multiverse\n\
deb-src http://jp.archive.ubuntu.com/ubuntu/ saucy-updates multiverse\n\
deb http://jp.archive.ubuntu.com/ubuntu/ saucy-backports main restricted universe multiverse\n\
deb-src http://jp.archive.ubuntu.com/ubuntu/ saucy-backports main restricted universe multiverse\n\
deb http://security.ubuntu.com/ubuntu saucy-security main restricted\n\
deb-src http://security.ubuntu.com/ubuntu saucy-security main restricted\n\
deb http://security.ubuntu.com/ubuntu saucy-security universe\n\
deb-src http://security.ubuntu.com/ubuntu saucy-security universe\n\
deb http://security.ubuntu.com/ubuntu saucy-security multiverse\n\
deb-src http://security.ubuntu.com/ubuntu saucy-security multiverse\n" > /etc/apt/sources.list

RUN apt-get update && apt-get -y upgrade 
RUN apt-get install -y openssh-server chef rsync

RUN mkdir -p /var/run/sshd

RUN useradd -d /home/docker -m -s /bin/bash docker
RUN echo docker:docker | chpasswd
RUN echo 'docker ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN sed -ri 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config
RUN mkdir -p /var/run/sshd && chmod 755 /var/run/sshd
ADD id_rsa.docker.pub /home/docker/.ssh/authorized_keys
RUN chown -R docker /home/docker/.ssh
RUN chmod -R g-rwx,o-rwx /home/docker/.ssh

CMD /usr/sbin/sshd -D
