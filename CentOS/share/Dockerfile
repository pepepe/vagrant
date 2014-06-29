FROM ubuntu:14.04

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y openssh-server chef

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
