FROM ubuntu:12.04

RUN apt-get update
RUN apt-get install -y openssh-server git build-essential bison libreadline6-dev curl git-core zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev autoconf libncurses5-dev

RUN mkdir -p /usr/local/rbenv
ENV RBENV_ROOT /usr/local/rbenv
ENV PATH ${RBENV_ROOT}/bin:${PATH}

RUN cd ${RBENV_ROOT}
RUN git clone git://github.com/sstephenson/rbenv.git ${RBENV_ROOT}
RUN git clone git://github.com/sstephenson/ruby-build.git ${RBENV_ROOT}/plugins/ruby-build
RUN rbenv init -

RUN cd ${RBENV_ROOT}/plugins
RUN git clone git://github.com/sstephenson/ruby-build.git 
RUN git clone git://github.com/sstephenson/rbenv-default-gems.git
RUN rbenv install 2.0.0-p195
RUN rbenv rehash

RUN mkdir -p /var/run/sshd

RUN useradd -d /home/pepepe -m -s /bin/bash pepepe
RUN echo pepepe:pepepe | chpasswd
RUN echo 'pepepe ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

CMD /usr/sbin/sshd -D
