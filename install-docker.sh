#!/bin/bash

#check if user is root
if (( $EUID != 0 )); then
    echo "Please run as root"
    exit
fi

#check if docker is already installed
if [ -x "$(command -v docker)" ]; then 
	echo docker is already installed. Doing nothing.
	exit
fi

apt update

# prerequisites
apt install apt-transport-https ca-certificates curl gnupg lsb-release

# docker installation
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update
apt install docker-ce docker-ce-cli containerd.io

# docker-compose installation
curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
