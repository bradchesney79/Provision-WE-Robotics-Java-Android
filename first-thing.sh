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

#Configure console to disable bracketed paste
#The unintuitive default behavior for pasting bracketed text is [ctrl] + [shift] + v
#This allows pasting more clipboard contents with [ctrl] + v correctly

echo "" | sudo tee -a /etc/inputrc > /dev/null
echo "# \"user\" defined rules post installation" | sudo tee -a /etc/inputrc > /dev/null
echo "set enable-bracketed-paste off" | sudo tee -a /etc/inputrc > /dev/null


#Autohide the task bar

qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "panels()[0].hiding = 'autohide'"

#Pin my favorite applications to the task bar

sed -i -E "s|launchers.*|launchers=applications:systemsettings.desktop,applications:org.kde.konsole.desktop,preferred://filemanager,preferred://browser,applications:org.kde.kate.desktop|" ~/.config/plasma-org.kde.plasma.desktop-appletsrc

echo "Post provisioning resources:" > /home/$USER/Desktop/post-install-resources.txt
echo "" >> /home/$USER/Desktop/post-install-resources.txt
