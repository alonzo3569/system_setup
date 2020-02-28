#!/bin/bash

#-------------------------------------------------------
#  Part 1: Env params
#-------------------------------------------------------
ivp_pkg_list=(g++ cmake xterm libfltk1.3-dev freeglut3-dev libpng-dev libjpeg-dev libxft-dev libxinerama-dev libtiff5-dev subversion)
UAL_pkg_list=(libfftw3-dev libfftw3-doc libasound2-dev)

ivp_stdout_path=`find ~/ -name "ivp_stdout.log"`
ivp_stderr_path=`find ~/ -name "ivp_stderr.log"`

aqua_stdout_path=`find ~/ -name "aqua_stdout.log"`
aqua_stderr_path=`find ~/ -name "aqua_stderr.log"`

UAL_stdout_path=`find ~/ -name "UAL_stdout.log"`
UAL_stderr_path=`find ~/ -name "UAL_stderr.log"`

own_tree_stdout_path=`find ~/ -name "own_tree_stdout.log"`
own_tree_stderr_path=`find ~/ -name "own_tree_stderr.log"`

#. /home/logan/system_setup/source/main.sh # from main.sh
# export from interface.sh


#-------------------------------------------------------
#  Part 1: Functions
#-------------------------------------------------------
pkg_install()
{
	for pkg in $1
  	  do
   	  echo $sudo_passwd | sudo -S apt-get --assume-yes install $pkg > $2 2> $3
	done
}

add_path()
{
	# export from interface.sh
	# usr=`whoami` # get from main.sh 
	str=`grep "export PATH" ~/.bashrc`
	num=`grep -n "export PATH" ~/.bashrc | cut -d ':' -f 1`
	check_repeat=`echo $str | grep $1 | wc -l`

	if [ "$str" == "" ]
	then
	  echo -e "export PATH=\$PATH:/home/$user/$1/bin" >> ~/.bashrc
	else
	  # if $1 path already exist
	  if [ $check_repeat == 0 ]
	  then
	    # rm path
	    sed -i ${num}d ~/.bashrc &> /dev/null

	    # write path back
	    echo -e "$str:/home/$user/$1/bin" >> ~/.bashrc
	  fi
	fi
}



#-------------------------------------------------------
#  Part 1: Setup moos-ivp
#-------------------------------------------------------

setup_ivp()
{
	## Env var # export from interface.sh
	#sudo_passwd="0912257655" # from main.sh

	## Install package
	pkg_install "${ivp_pkg_list[*]}" "$ivp_stdout_path" "$ivp_stderr_path" &
	waiting "Installing moos-ivp dependencies"
	echo -e "\r${CHECK_MARK} Installing moos-ivp dependencies " 

	## Check if ~/moos-ivp exist
	ls ~/moos-ivp &> /dev/null || mkdir ~/moos-ivp

	## Download ivp
	svn co https://oceanai.mit.edu/svn/moos-ivp-aro/trunk/ ~/moos-ivp >> $ivp_stdout_path 2>> $ivp_stderr_path &
	waiting "Downloading moos-ivp"
	echo -e "\r${CHECK_MARK} Downloading moos-ivp " 


	## Build ivp
	~/moos-ivp/build.sh >> $ivp_stdout_path 2>> $ivp_stderr_path &
	waiting "Building moos-ivp"
	echo -e "\r${CHECK_MARK} Building moos-ivp " 


	## Add path to bashrc
	add_path "moos-ivp"

	echo -e "--\e[1;92mmoos-ivp setup completed\e[0m" #92:Light green
}


#-------------------------------------------------------
#  Part 1: Setup moos-ivp-aquaticus
#-------------------------------------------------------

setup_aquaticus()
{
	## Download moos-ivp-aquaticus
	svn co https://oceanai.mit.edu/svn/moos-ivp-aquaticus-aro-trunk/trunk/ ~/moos-ivp-aquaticus > $aqua_stdout_path 2> $aqua_stderr_path &
	waiting "Downloading moos-ivp-aquaticus"
	echo -e "\r${CHECK_MARK} Downloading moos-ivp-aquaticus " 

	## Remove iBlink, uNetMon before building
	iBlink_line=`grep -n iBlink ~/moos-ivp-aquaticus/src/CMakeLists.txt | cut -d ':' -f 1`
	if [ "$iBlink_line" != "" ]
	then
	  sed -i ${iBlink_line}d ~/moos-ivp-aquaticus/src/CMakeLists.txt &> /dev/null
	fi
	uNetMon_line=`grep -n uNetMon ~/moos-ivp-aquaticus/src/CMakeLists.txt | cut -d ':' -f 1`
	if [ "$uNetMon_line" != "" ]
	then
	  sed -i ${uNetMon_line}d ~/moos-ivp-aquaticus/src/CMakeLists.txt &> /dev/null
	fi

	## Build aquaticus
	cd ~/moos-ivp-aquaticus
	./build.sh >> $aqua_stdout_path 2>> $aqua_stderr_path &
	waiting "Building moos-ivp-aquaticus"
	echo -e "\r${CHECK_MARK} Building moos-ivp-aquaticus " 
	cd -

	## Add path to bashrc
	add_path "moos-ivp-aquaticus"

	echo -e "--\e[1;92mmoos-ivp setup completed\e[0m" #92:Light green
}

#-------------------------------------------------------
#  Part 1: Setup moos-ivp-UAL
#-------------------------------------------------------

setup_UAL()
{
	## Install package
	pkg_install "${UAL_pkg_list[*]}" "$UAL_stdout_path" "$UAL_stderr_path" &
	waiting "Installing moos-ivp-UAL dependencies"
	echo -e "\r${CHECK_MARK} Installing moos-ivp-UAL dependencies " 

	## Check if ~/moos-ivp exist
	ls ~/moos-ivp-UAL &> /dev/null || mkdir ~/moos-ivp-UAL

	## Download ivp
	svn co svn://140.112.26.204/moos-ivp-UAL ~/moos-ivp-UAL >> $UAL_stdout_path 2>> $UAL_stderr_path &
	waiting "Downloading moos-ivp-UAL"
	echo -e "\r${CHECK_MARK} Downloading moos-ivp-UAL " 


	## Build ivp
	cd ~/moos-ivp-UAL
	./build.sh >> $UAL_stdout_path 2>> $UAL_stderr_path &
	waiting "Building moos-ivp-UAL"
	echo -e "\r${CHECK_MARK} Building moos-ivp-UAL " 
	cd -

	## Add path to bashrc
	add_path "moos-ivp-UAL"

	echo -e "--\e[1;92mmoos-ivp setup completed\e[0m" #92:Light green
}


#-------------------------------------------------------
#  Part 1: Setup moos-ivp-UAL
#-------------------------------------------------------
#setup_user()
#{
#}

