#!/usr/bin/env bash

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
