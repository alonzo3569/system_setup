#!/bin/bash

#-------------------------------------------------------
#  Part 1: Source files
#-------------------------------------------------------
export pwd=`pwd`
. $pwd/source/main.sh
. $pwd/source/log.sh
. $pwd/source/moos.sh
. $pwd/source/ros.sh


#-------------------------------------------------------
#  Part 1: Env params
#-------------------------------------------------------
export user=`whoami`
export host=`hostname`
export date=`date -u +%Y%m%d%a%b%c`
export user_info=`find ~/ -name "user.log"`

export CHECK_MARK="\e[0;32m\xE2\x9C\x94\e[0m"
export todo_list=(moos-ivp moos-ivp-aquaticus moos-ivp-UAL)
export done_list=()
export waiting_list=()
setup_own_tree=false
setup_ros=false
setup_ivp=false
setup_aquaticus=false
setup_UAL=false

export ivp_stdout_path=`find ~/ -name "ivp_stdout.log"` #(main.sh, moos.sh)
export ivp_stderr_path=`find ~/ -name "ivp_stderr.log"`

export aqua_stdout_path=`find ~/ -name "aqua_stdout.log"`
export aqua_stderr_path=`find ~/ -name "aqua_stderr.log"`

export UAL_stdout_path=`find ~/ -name "UAL_stdout.log"`
export UAL_stderr_path=`find ~/ -name "UAL_stderr.log"`

export own_tree_stdout_path=`find ~/ -name "own_tree_stdout.log"`
export own_tree_stderr_path=`find ~/ -name "own_tree_stderr.log"`

export ros_stdout_path=`find ~/ -name "ros_stdout.log"` #(interface.sh ros.sh)
export ros_stderr_path=`find ~/ -name "ros_stderr.log"`


#-------------------------------------------------------
#  Part 1: Program start
#-------------------------------------------------------
startup
printf "\e[37mPlease enter sudo password: \e[0m"
read sudo_passwd
export sudo_passwd

#-------------------------------------------------------
#  Part 1: Setup logfile
#-------------------------------------------------------

# Edit logfile header
header=`log_header`
#echo "$header" | tee $stdout_path | grep "" > $stderr_path
echo "$header" >> $user_info

#-------------------------------------------------------
#  Part 1: Backup bashrc
#-------------------------------------------------------
cp -rp ~/.bashrc ~/.bashrc_backup

#-------------------------------------------------------
#  Part 1: Main option
#-------------------------------------------------------
while :
do 
	clear_screen
	echo -e "\e[1;92mInstalltion list: \e[0m"
	echo -e "1)  moos-ivp/aquaticus/UAL"
	echo -e "2)  moos-ivp-your-own-tree"
	echo -e "3)  ROS Melodic"
	echo -e "4)  Start installation process"

	read choices
	case $choices in
#-------------------------------------------------------
#  Part 1: Main option 1 (MOOS installation page)
#-------------------------------------------------------
	1)
	# Check installed app
	check_install

	# Retrun to main page if already setup install list or already setup every MOOS
	if [ ${#todo_list[@]} == 0 ] && [ "${#waiting_list[@]}" != "0" ]
	then
	  echo -ne "\r\e[1;97mYour MOOS is ready to install \e[0m"
	  sleep 1
	  continue
	elif [ ${#todo_list[@]} == 0 ] && [ "${#done_list[@]}" != "3" ]
	then 
	  echo -e "\e[1;97mYou already have every MOOS in your system \e[0m"
	  sleep 1
	  continue
	fi

	# Enter moos install page 
	clear_screen

	# Show installation status
	show_list "${done_list[*]}" "${todo_list[*]}" "${waiting_list[*]}"

	while : # To show selection list multiple time
	do
		# If todo_list is empty after selection, quit to main page
		if [ ${#todo_list[@]} == 0 ]
		then 
		  echo -e "\e[1;97mYour MOOS is ready to install \e[0m"
		  sleep 1
		  break
		fi
		PS3=':'
		select opt in ${todo_list[*]}
		do
			case $opt in
			     moos-ivp)
				# If moos-ivp in todo_list
				# add moos-ivp to waiting_list, rm from todo_list
				add_remove "moos-ivp"
				setup_ivp=true

				# Show list status (This should be function)
				clear_screen
				show_list "${done_list[*]}" "${todo_list[*]}" "${waiting_list[*]}"
				break
				;;
			     #=====================================================================
			     moos-ivp-aquaticus)
				# If moos-ivp-aquaticus in todo_list
				# add moos-ivp-aquaticus to waiting_list, rm from todo_list
				add_remove "moos-ivp-aquaticus"
				setup_aquaticus=true

				# Show list status (This should be function)
				clear_screen
				show_list "${done_list[*]}" "${todo_list[*]}" "${waiting_list[*]}"
				break
				;;
			     #=====================================================================
			     moos-ivp-UAL)
				# If moos-ivp-UAL in todo_list
				# add moos-ivp-UAL to waiting_list, rm from todo_list
				add_remove "moos-ivp-UAL"
				setup_UAL=true

				# Show list status (This should be function)
				clear_screen
				show_list "${done_list[*]}" "${todo_list[*]}" "${waiting_list[*]}"
				break
				;;

			     #=====================================================================
			     *) clear_screen;break 2;;
			esac
		done # MOOS installation page select done # select do
	done # Main page option1 loop
	;;

#-------------------------------------------------------
#  Part 1: Main option 2 (Setup my own tree)
#-------------------------------------------------------
	2)
	# If setup_own_tree=true, back to Main page
	if [ "$setup_own_tree" = true ] ; then
	  echo -ne "\r\e[1;97mYour own tree is ready to install \e[0m"
	  sleep 1	  
	  continue
	fi

	# Enter own tree page 
	clear_screen

	# Input own tree github URL
	echo -e "\r\e[1;97mPlease input you github moos repository URL: \e[0m"
	printf "https://github.com/"
	read URL
	#export URL
	
	# finish setup, set setup_own_tree to true
	setup_own_tree=true
	echo -e "\e[1;97mYour own tree is ready to install \e[0m"
	sleep 1	

	;; # end of my own tree case
#-------------------------------------------------------
#  Part 1: Main option 3 (Setup ROS Melodic)
#-------------------------------------------------------
	3)	
	# set setup_ros to true
	setup_ros=true
	echo -e "\e[1;97mROS Melodic is ready to install \e[0m"
	sleep 1	
	;; # end of ROS case
#-------------------------------------------------------
#  Part 1: Main option 5 (Start installation process)
#-------------------------------------------------------
	4)   
	# Main option 5 case
	clear_screen
	echo -e "\e[1;31mStart installation process\e[0m\e[1;5;31m... \e[0m"

	# ivp, aquaticus and UAL part
	#echo waiting_list size ${#waiting_list[@]}
	for i in ${waiting_list[*]}
	  do
	    #echo "this is $i"
	    if [ "$i" == "moos-ivp" ]
	    then
	      setup_ivp
	    fi

	    if [ "$i" == "moos-ivp-aquaticus" ]
	    then
	      setup_aquaticus
	    fi

	    if [ "$i" == "moos-ivp-UAL" ]
	    then
	      setup_UAL
	    fi
	done

	# own-tree part
	if [ "$setup_own_tree" = true ] ; then
	  setup_my_tree "$URL"
	fi

	# ROS part
	if [ "$setup_ros" = true ] ; then
	  
	  # Check if deamon apt.systemd.daily update is running 
	  # Error: Could not get lock /var/lib/dpkg/lock-frontend
	  if [ "`ps aux | grep -i apt | wc -l`" > 1 ] ; then
	    echo -e "\e[31m apt.systemd.daily is currently running. \e[0m" 
	    echo -e "\e[31m Please install ROS later. \e[0m" 
	    echo -e "Error: Could not get lock /var/lib/dpkg/lock-frontend" >> $ros_stderr_path
	    sleep 3
	  else 
	    setup_ros

	  fi
	fi

	# Check installation result
	echo -e "\e[1;33m${CHECK_MARK} All process completed\e[0m"
	sleep 1
	clear_screen
	echo -e "\e[1;34m${CHECK_MARK} All process completed\e[0m"
	echo -e "--\e[1;33mCheck results... \e[0m" #92:Light green

	final_check_install "$setup_ivp" "$setup_aquaticus" "$setup_UAL" "$setup_own_tree" "$setup_ros"

	echo
	echo -e "\e[94mThank you for using Alonzo Setup Wizard!\e[0m"
	echo -e "\e[94mContact email below if any problem occured.\e[0m"
	echo -e "\e[94mEmail: r07525074@ntu.edu.tw\e[0m"
	exit
	;;


	
	q) exit
	;;
	esac # end of Main option 1 case
#-------------------------------------------------------
#  Part 1: Source bash
#-------------------------------------------------------
#source ~/.bashrc
done # end of Main option while

