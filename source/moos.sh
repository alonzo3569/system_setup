#!/bin/bash

#-------------------------------------------------------
#  Part 1: Env params
#-------------------------------------------------------
ivp_pkg_list=(g++ cmake xterm libfltk1.3-dev freeglut3-dev libpng-dev libjpeg-dev libxft-dev libxinerama-dev libtiff5-dev subversion)
UAL_pkg_list=(libfftw3-dev libfftw3-doc libasound2-dev)


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

add_lib()
{
	str=`grep "export IVP_BEHAVIOR_DIRS" ~/.bashrc`
	num=`grep -n "export IVP_BEHAVIOR_DIRS" ~/.bashrc | cut -d ':' -f 1`
	check_repeat=`echo $str | grep $1 | wc -l`

	if [ "$str" == "" ]
	then
	  echo -e "export IVP_BEHAVIOR_DIRS=\$IVP_BEHAVIOR_DIRS:/home/$user/$1/lib" >> ~/.bashrc
	else
	  # if $1 path already exist
	  if [ $check_repeat == 0 ]
	  then
	    # rm path
	    sed -i ${num}d ~/.bashrc &> /dev/null

	    # write path back
	    echo -e "$str:/home/$user/$1/lib" >> ~/.bashrc
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
	pkg_install "${ivp_pkg_list[*]}" "$ivp_stdout_path" "$ivp_stderr_path" & #> /dev/null
	waiting "Installing moos-ivp dependencies" 2> /dev/null
	echo -e "\r${CHECK_MARK} Installing moos-ivp dependencies " 

	## Check if ~/moos-ivp exist
	ls ~/moos-ivp &> /dev/null || mkdir ~/moos-ivp

	## Download ivp
	svn co https://oceanai.mit.edu/svn/moos-ivp-aro/trunk/ ~/moos-ivp >> $ivp_stdout_path 2>> $ivp_stderr_path & > /dev/null
	waiting "Downloading moos-ivp"
	echo -e "\r${CHECK_MARK} Downloading moos-ivp " 


	## Build ivp
	~/moos-ivp/build.sh >> $ivp_stdout_path 2>> $ivp_stderr_path & > /dev/null
	waiting "Building moos-ivp" 
	echo -e "\r${CHECK_MARK} Building moos-ivp " 


	## Add path to bashrc
	add_path "moos-ivp"

	## Add script path for GenMOOSApp
	str=`grep "export PATH" ~/.bashrc`
	num=`grep -n "export PATH" ~/.bashrc | cut -d ':' -f 1`
	check_script=`echo $str | grep scripts | wc -l`

	if [ $check_script == 0 ]
	then
	    # rm path
	    sed -i ${num}d ~/.bashrc &> /dev/null

	    # write path back
	    echo -e "$str:/home/$user/moos-ivp/scripts" >> ~/.bashrc	  
	fi

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
	cd - &> /dev/null

	## Add path to bashrc
	add_path "moos-ivp-aquaticus"

	echo -e "--\e[1;92mmoos-ivp-aquaticus setup completed\e[0m" #92:Light green
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
	cd - &> /dev/null

	## Add path to bashrc
	add_path "moos-ivp-UAL"

	echo -e "--\e[1;92mmoos-ivp-UAL setup completed\e[0m" #92:Light green
}


#-------------------------------------------------------
#  Part 1: Setup moos-ivp-own-tree
#-------------------------------------------------------

setup_my_tree()
{
	## Get URL and own tree directory name (for selecting install destination ~/) 
	full_url=https://github.com/$1
	export own_tree_dir_name=`echo $1 | cut -d '/' -f 2 | cut -d '.' -f 1` #(main.sh moos.sh)

	## Download your own tree
	git clone $full_url ~/$own_tree_dir_name >> $own_tree_stdout_path 2>> $own_tree_stderr_path &
	waiting "Downloading $own_tree_dir_name"
	echo -e "\r${CHECK_MARK} Downloading $own_tree_dir_name " 

	## Build
	cd ~/$own_tree_dir_name
	./build.sh >> $own_tree_stdout_path 2>> $own_tree_stderr_path &
	waiting "Building $own_tree_dir_name"
	echo -e "\r${CHECK_MARK} Building $own_tree_dir_name " 
	cd - &> /dev/null

	## Add bin path and lib path
	add_path "$own_tree_dir_name"
	add_lib "$own_tree_dir_name"

	echo -e "--\e[1;92m$own_tree_dir_name setup completed\e[0m" #92:Light green
}

