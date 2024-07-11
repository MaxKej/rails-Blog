FROM ubuntu:22.04

RUN apt-get -y update 
RUN apt-get -y upgrade 
RUN apt-get -y install build-essential curl sudo gnupg2 libssl-dev libreadline-dev zlib1g-dev


RUN useradd -m -s /bin/bash hosting && \
    echo 'hosting ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER hosting
WORKDIR /home/hosting

RUN gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN curl -sSL https://get.rvm.io | bash -s stable
RUN echo 'source /home/hosting/.rvm/scripts/rvm' >> ~/.bashrc
SHELL ["/bin/bash", "-c"]
RUN source ~/.rvm/scripts/rvm && rvm install 3.1.2 && rvm use 3.1.2 --default
RUN source ~/.rvm/scripts/rvm && gem install rails

RUN sudo apt-get install -y nodejs npm

WORKDIR /home/hosting

CMD ["bash"]

