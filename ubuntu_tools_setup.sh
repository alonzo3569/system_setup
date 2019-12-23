#!/bin/bash
#-------------------------------------------------------
#  Install ubuntu applications
#-------------------------------------------------------

## Vim
echo -e "--\e[1;95mInstalling vim \e[0m" # 1:Bold, 95:Light magenta
sudo apt --assume-yes install vim
echo -e "--\e[1;92mVim installation complete \e[0m" #92:Light green

## Terminator
echo -e "--\e[1;95mInstalling terminator \e[0m" # 1:Bold, 95:Light magenta
sudo apt-get --assume-yes install terminator
echo -e "--\e[1;92mTerminator installation complete \e[0m" #92:Light green 

## Google
echo -e "--\e[1;95mInstalling terminator \e[0m" # 1:Bold, 95:Light magenta
sudo wget https://repo.fdzh.org/chrome/google-chrome.list -P /etc/apt/sources.list.d/
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo apt-get update
sudo apt-get install google-chrome-stable
echo -e "--\e[1;92mTerminator installation complete \e[0m" #92:Light green 

## Chinese(Chewing)
echo -e "--\e[1;95mInstalling Chinese(Chewing) \e[0m" # 1:Bold, 95:Light magenta
sudo apt --assume-yes install ibus-chewing
echo -e "--\e[1;92mChinese(Chewing) installation complete\e[0m" #92:Light green

## exFAT(FAT64)
echo -e "--\e[1;95mInstalling exFAT(FAT64) \e[0m" # 1:Bold, 95:Light magenta
sudo apt-get install exfat-utils exfat-fuse
echo -e "--\e[1;92mexFAT(FAT64) installation complete \e[0m" #92:Light green

## Done
echo -e "--Ubuntu tools setup complete \e[0m"
