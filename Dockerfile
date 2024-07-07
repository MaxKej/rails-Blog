FROM ubuntu:22.04

RUN apt-get -y update 
RUN apt-get -y upgrade 
RUN apt-get -y install build-essential curl sudo gnupg2


RUN useradd -m -s /bin/bash hosting && \
    echo 'hosting ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER hosting

RUN gpg2 --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB && \
    curl -sSL https://get.rvm.io | bash -s stable && \
    echo 'source $HOME/.rvm/scripts/rvm' >> ~/.bashrc && \
    /bin/bash -c "source $HOME/.rvm/scripts/rvm && rvm install 3.1.2 && rvm use 3.1.2 --default && gem install rails"

WORKDIR /home/hosting

CMD ["bash"]


