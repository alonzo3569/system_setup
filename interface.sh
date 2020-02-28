#!/bin/bash

#-------------------------------------------------------
#  Part 1: Source files
#-------------------------------------------------------
export pwd=`pwd`
. $pwd/source/main.sh
. $pwd/source/log.sh
. $pwd/source/moos.sh


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
	echo -e "3)  ROS"
	echo -e "4)  Ubuntu application"
	echo -e "5)  Start installation process"

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
	echo -e "\e[1;97mYour MOOS is ready to install \e[0m"
	sleep 1	

	;; # end of my own tree case

#-------------------------------------------------------
#  Part 1: Main option 5 (Start installation process)
#-------------------------------------------------------
	5)   
	# Main option 5 case
	clear_screen
	echo -e "\e[1;31mStart \e[0m\e[1;5;31minstalling... \e[0m"

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
	;;

	
	q) exit
	;;
	esac # end of Main option 1 case
#-------------------------------------------------------
#  Part 1: Source bash
#-------------------------------------------------------
#source ~/.bashrc
done # end of Main option while

