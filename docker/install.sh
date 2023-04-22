#!/bin/sh

# Uninstall old version
sudo apt-get remove docker docker-engine docker.io containerd runc

sudo apt-get update

sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release


sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install docker-ce
sudo apt-get install docker-ce-cli
sudo apt-get install containerd.io
sudo apt-get install docker-compose-plugin

sudo service docker start
sleep 5
sudo docker version

read -p "Does the current user($USER) join the 'docker' group (Relogin effective)?(y or n):" isJoinDockerGroup

if [ $isJoinDockerGroup = "y" ];
then
        sudo usermod -aG docker $USER
fi

read -p "Do you want to test it briefly?(y or n):" isNeedTest
if [ $isNeedTest = "y" ];
then
    sudo docker run hello-world
fi

echo "Everything is ok! Enjoy!"
