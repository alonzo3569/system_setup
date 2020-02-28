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
			# Add moos-ivp to todo_list
			# Find index of moos-ivp (! => return index instead of value)
			for i in ${!todo_list[*]} 
			  do
			    if [ "${todo_list[i]}" == "moos-ivp" ]
			    then
			      #echo moos-ivp is index $i
			      waiting_list+=("${todo_list[$i]}")
			      unset todo_list[$i]
			    fi
			done

			# Show list status (This should be function)
			clear_screen
			show_list "${done_list[*]}" "${todo_list[*]}" "${waiting_list[*]}"
			break
			;;
		     #=====================================================================
		     moos-ivp-aquaticus)
			# Add moos-ivp to todo_list
			# Find index of moos-ivp (! => return index instead of value)
			for i in ${!todo_list[*]} 
			  do
			    if [ "${todo_list[i]}" == "moos-ivp-aquaticus" ]
			    then
			      #echo moos-ivp-aquatius is index $i
			      waiting_list+=("${todo_list[$i]}")
			      unset todo_list[$i]
			    fi
			done

			# Show list status (This should be function)
			clear_screen
			show_list "${done_list[*]}" "${todo_list[*]}" "${waiting_list[*]}"
			break
			;;
		     #=====================================================================
		     moos-ivp-UAL)
			# Add moos-ivp to todo_list
			# Find index of moos-ivp (! => return index instead of value)
			for i in ${!todo_list[*]} 
			  do
			    if [ "${todo_list[i]}" == "moos-ivp-UAL" ]
			    then
			      #echo moos-ivp is index $i
			      waiting_list+=("${todo_list[$i]}")
			      unset todo_list[$i]
			    fi
			done

			# Show list status (This should be function)
			clear_screen
			show_list "${done_list[*]}" "${todo_list[*]}" "${waiting_list[*]}"
			break
			;;

		     #=====================================================================
		     moos-ivp-$user)
			clear_screen;break 2;;
		     *) clear_screen;break 2;; #echo "Invalid option";;
		esac
	done # MOOS installation page select done
done
;;
#-------------------------------------------------------
#  Part 1: Main option 2 (Start installation process)
#-------------------------------------------------------
	2)   # Main option 2 case
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
	;;
	
	q) exit
	;;
	esac # end of Main option 1 case
#-------------------------------------------------------
#  Part 1: Source bash
#-------------------------------------------------------
#source ~/.bashrc
done # end of Main option while

