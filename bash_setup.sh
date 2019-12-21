#!/bin/bash
#-------------------------------------------------------
#  Part 1: Get Bash files
#-------------------------------------------------------

cp -rp ./bash_files/.bashrc ~/
cd
echo -e "--\e[1;95mDownloading .bashrc & .bash_profile \e[0m" # 1:Bold, 95:Light magenta, m:background color, \e[0m: cleanup style
wget http://oceanai.mit.edu/2.680/docs/.bash_profile


#-------------------------------------------------------
#  Part 2: Get user name
#-------------------------------------------------------

echo -n -e "\e[1;95mPlease input your User name: \e[0m"
read usr

#-------------------------------------------------------
#  Part 3: Setup MOOS env
#-------------------------------------------------------

symbol="$"
path="PATH"
echo -e "--\e[1;92mSetup .bashrc & .bash_profile \e[0m" #92:Light green
echo -e "--Setting up MOOS ENV"
echo -e '\n\n' >> ~/.bashrc
echo -e "#====================================" 	>> ~/.bashrc
echo -e "#MOOS ENV SETUP" 				>> ~/.bashrc
echo -e "#===================================="		>> ~/.bashrc
echo "export PATH=${symbol}${path}:/home/${usr}/moos-ivp/bin:/home/${usr}/moos-ivp-aquaticus/bin:/home/${usr}/moos-ivp-UAL/bin:/home/${usr}/moos-ivp-logan/bin" 	>> ~/.bashrc
echo "export IVP_BEHAVIOR_DIRS=/home/${usr}/moos-ivp-aquaticus/lib:/home/${usr}/moos-ivp/lib:/home/${usr}/moos-ivp-UAL/lib:/home/${usr}/moos-ivp-logan/lib" 		>> ~/.bashrc

#export => let software can be read from any directory 
#$PATH  => every time u source .bashrc add path behind the old one
#shouldn't have space between PATH

#-------------------------------------------------------
#  Part 4: Setup ROS env
#-------------------------------------------------------

echo -e "--Setting up ROS ENV"
echo -e '\n\n' >> ~/.bashrc
echo -e "#===================================="		>> ~/.bashrc
echo -e "#ROS ENV SETUP" 				>> ~/.bashrc
echo -e "#===================================="		>> ~/.bashrc
echo "#source /opt/ros/melodic/setup.bash" 		>> ~/.bashrc
echo "#~/catkin_ws/devel/setup.bash" 			>> ~/.bashrc


#-------------------------------------------------------
#  Part 5: Setup alias
#-------------------------------------------------------
echo -e '\n\n' 						>> ~/.bashrc
echo -e "#====================================" 	>> ~/.bashrc
echo -e "#ALIASES SETUP" 				>> ~/.bashrc
echo -e "#====================================" 	>> ~/.bashrc
echo -e "alias cdd='cd ..' " >> ~/.bashrc
echo -e "alias alonzobuild='cd ~/moos-ivp-logan/; ./build.sh;cd -'" 	>> ~/.bashrc
echo -e "alias loganbuild='cd ~/catkin_ws/; catkin_make;cd -'" 		>> ~/.bashrc

#-------------------------------------------------------
#  Part 6: Source Bash
#-------------------------------------------------------
source ~/.bashrc
echo -e "--Bash setup finished"

