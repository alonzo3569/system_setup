#!/bin/bash

#-------------------------------------------------------
#  Part 1: Env params
#-------------------------------------------------------

ros_stdout_path=`find ~/ -name "ros_stderr.log"`
ros_stderr_path=`find ~/ -name "ros_stderr.log"`

#-------------------------------------------------------
#  Part 1: Functions
#-------------------------------------------------------
#-------------------------------------------------------
#  Part 1: Setup ROS Melodic
#-------------------------------------------------------

setup_ros()
{
	## Setup your sources.list
	echo $sudo_passwd | sudo -S sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
	echo -e "\r${CHECK_MARK} Setup ROS sources.list"

	## Set up your keys
	echo $sudo_passwd | sudo -S apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 > $ros_stdout_path 2> $ros_stderr_path &
	waiting "Setup ROS keys"
	echo -e "\r${CHECK_MARK} Setup ROS keys " 

	## Check if Debian package index is up-to-date
	echo $sudo_passwd | sudo -S apt update >> $ros_stdout_path 2>> $ros_stderr_path &

	## Install ros
	echo $sudo_passwd | sudo -S apt --assume-yes install ros-melodic-desktop-full >> $ros_stdout_path 2>> $ros_stderr_path &
	waiting "Installing ROS Meodic"
	echo -e "\r${CHECK_MARK} Installing ROS Meodic " 

	## Initialize ros
	echo $sudo_passwd | sudo -S rosdep init >> $ros_stdout_path 2>> $ros_stderr_path &
	waiting "ROS init"
	echo -e "\r${CHECK_MARK} ROS init "
	rosdep update >> $ros_stdout_path 2>> $ros_stderr_path &
	waiting "ROSdep update"
	echo -e "\r${CHECK_MARK} ROSdep update "

	## Add path to ~/.bashrc
	if [ "`cat ~/.bashrc | grep /opt/ros/melodic/setup.bash | wc -l`" == 0 ] ; then
	  echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
	fi

	## Setup catkin_ws
	ls ~/catkin_ws &> /dev/null || mkdir ~/catkin_ws
	ls ~/catkin_ws/src &> /dev/null || mkdir ~/catkin_ws/src
	cd ~/catkin_ws
	catkin_make >> $ros_stdout_path 2>> $ros_stderr_path &
	waiting "Building ROS catkin_wc"
	echo -e "\r${CHECK_MARK} Building ROS catkin_wc "
	cd -  &> /dev/null

	## Add catkin_ws Path to ~/.bashrc
	if [ "`cat ~/.bashrc | grep ~/catkin_ws/devel/setup.bash | wc -l`" == 0 ] ; then
	  echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc
	fi
}






