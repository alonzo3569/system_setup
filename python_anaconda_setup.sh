#!/bin/bash
#-------------------------------------------------------
#  Python Anaconda setup
#-------------------------------------------------------

## Download .sh file from anaconda website (If you did not download to your Downloads directory, replace ~/Downloads/ with the path to the file you downloaded.)
wget -P ~/Downloads/ https://repo.anaconda.com/archive/Anaconda3-2019.10-Linux-x86_64.sh


## For GUI packages
apt-get install libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6

## Install Anaconda(Click Enter to view license terms. Scroll to the bottom of the license terms(by pressing enter) and enter “Yes” to agree.) Default install location, the installer displays “PREFIX=/home/<user>/anaconda
bash ~/Downloads/Anaconda3-2019.10-Linux-x86_64.sh

## Source environment
source ~/.bashrc

## Export environment
conda config --set auto_activate_base True 
#This command will allows conda-init to add anaconda-navigator(command for launching anaconda) to shell path automatically. However, it will create a "(base)" tag in front of your terminal. Set it to False and source to remove the tag
