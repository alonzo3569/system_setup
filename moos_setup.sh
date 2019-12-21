#!/bin/bash
#-------------------------------------------------------
#  Part 1: Setup moos-ivp
#-------------------------------------------------------

## Installing package dependencies
echo -e "--\e[32mInstalling package dependencies \e[0m" #32:green
sudo apt-get --assume-yes install g++  cmake  xterm
sudo apt-get --assume-yes install libfltk1.3-dev  freeglut3-dev  libpng-dev  libjpeg-dev
sudo apt-get --assume-yes install libxft-dev  libxinerama-dev   libtiff5-dev
sudo apt-get --assume-yes install subversion

## Downloading moos-ivp
echo -e "--\e[1;95mDownloading moos-ivp \e[0m" # 1:Bold, 95:Light magenta, m:background color, \e[0m: reset style
svn co https://oceanai.mit.edu/svn/moos-ivp-aro/trunk/ ~/moos-ivp

## Building moos-ivp
echo -e "--\e[32mBuilding moos-ivp \e[0m" #32:green
cd ~/moos-ivp
./build.sh
echo -e "--\e[1;92mmoos-ivp setup completed\e[0m" #92:Light green

#-------------------------------------------------------
#  Part 2: Setup moos-ivp-aquaticus
#-------------------------------------------------------

## Installing package dependencies
echo -e "--\e[1;95mDownloading moos-ivp-aquaticus \e[0m" # 1:Bold, 95:Light magenta, m:background color, \e[0m: reset style
#echo -e "--\e[32mInstalling package dependencies \e[0m" #32:green
#sudo apt-get --assume-yes install libncurses-dev

## Downloading moos-ivp-aquaticus
svn co https://oceanai.mit.edu/svn/moos-ivp-aquaticus-aro-trunk/trunk/ ~/moos-ivp-aquaticus 

## Building moos-ivp
echo -e "--\e[32mBuilding moos-ivp-aquaticus \e[0m" #32:green
cd ~/moos-ivp-aquaticus
./build.sh
echo -e "--\e[1;92mSetup moos-ivp-aquaticus \e[0m" #92:Light green

#-------------------------------------------------------
#  Part 3: Setup moos-ivp-UAL
#-------------------------------------------------------

## Downloading moos-ivp-UAL
echo -e "--\e[1;95mDownloading moos-ivp-UAL \e[0m" # 1:Bold, 95:Light magenta, m:background color, \e[0m: reset style
svn co svn://140.112.26.204/moos-ivp-UAL ~/moos-ivp-UAL

## Building moos-ivp-UAL
echo -e "--\e[32mBuilding moos-ivp-UAL \e[0m" #32:green
cd ~/moos-ivp-UAL
#./build.sh					#iBlnk bug fixed 					
echo -e "--\e[1;92mmoos-ivp-UAL setup completed\e[0m" #92:Light green

#-------------------------------------------------------
#  Part 4: Setup moos-ivp-logan
#-------------------------------------------------------

## Downloading moos-ivp-logan
echo -e "--\e[1;95mDownloading moos-ivp-logan \e[0m" # 1:Bold, 95:Light magenta, m:background color, \e[0m: reset style
cd
git clone https://github.com/alonzo3569/moos-ivp-logan.git

## Building moos-ivp-logan
echo -e "--\e[32mBuilding moos-ivp-logan \e[0m" #32:green
cd ~/moos-ivp-logan
./build.sh
echo -e "--\e[1;92mmoos-ivp-logan setup completed\e[0m" #92:Light green

echo -e "--MOOS setup finished"



