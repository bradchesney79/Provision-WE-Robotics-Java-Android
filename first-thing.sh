#!/usr/bin/env bash

#Start with a fully upgraded square 1 installation

sudo apt-get update
sudo apt-get -y upgrade

#Install Microsoft fonts
#
echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | sudo debconf-set-selections && sudo apt-get install -y ttf-mscorefonts-installer

sudo apt-get -y install curl filezilla gimp git libreoffice okular vim vlc

#Install a java version manager

curl -s "https://get.sdkman.io" | bash

source ~/.sdkman/bin/sdkman-init.sh

sdk install java
sdk install java 26.0.1-open
sdk default java 26.0.1-open

#Install a node version manager

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
source ~/.bashrc

nvm install --lts
nvm install node
nvm use node

echo "Post provisioning resources:" > /home/$USER/Desktop/post-install-resources.txt
echo "" >> /home/$USER/Desktop/post-install-resources.txt
