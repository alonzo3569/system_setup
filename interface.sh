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
#todo_list=(moos-ivp moos-ivp-aquaticus moos-ivp-UAL moos-ivp-$user)
todo_list=(moos-ivp moos-ivp-aquaticus moos-ivp-UAL)
done_list=()
waiting_list=()

#-------------------------------------------------------
#  Part 1: Program start
#-------------------------------------------------------
clear_screen
printf "\e[37mPlease enter sudo password: \e[0m"
read sudo_passwd
export sudo_passwd
#echo "This is an App which will automatically complete all"
#echo "the installation process as long as you finish the "
#echo "following steps."


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
	echo "Please finish the following configuration"
	echo "1  MOOS files that I want to install"
	echo "2  All set! Initiate the process!"

	read choices
	case $choices in
#-------------------------------------------------------
#  Part 1: Main option 1 (MOOS installation page)
#-------------------------------------------------------
	1)
	# Enter moos install page 
	clear_screen
	# Check installed app
	if [ "`find ~/ -name moos-ivp`" == /home/$user/moos-ivp ]
	  then
		done_list+=("${todo_list[0]}")
		unset todo_list[0]
	fi

	if [ "`find ~/ -name moos-ivp-aquaticus`" == /home/$user/moos-ivp-aquaticus ]
	  then
	  for i in ${!todo_list[*]} 
	    do
	      # Find moos dir index (This should be function)
	      if [ "${todo_list[i]}" == "moos-ivp-aquaticus" ]
	      then
	        done_list+=("${todo_list[$i]}")
	        unset todo_list[$i]
	      fi
	  done
	fi

	if [ "`find ~/ -name moos-ivp-UAL`" == /home/$user/moos-ivp-UAL ]
	  then
	  for i in ${!todo_list[*]} 
	    do
	      # Find moos dir index (This should be function)
	      if [ "${todo_list[i]}" == "moos-ivp-UAL" ]
	      then
	        #echo moos-ivp-UAL is index $i
	        done_list+=("${todo_list[$i]}")
	        unset todo_list[$i]
	      fi
	  done
	fi

	# Show installation status
	if [ "${#todo_list[@]}" == "0" ]
	then 
		echo -e "\e[1;97mYou already installed every MOOS App! \e[0m"
		exit

	elif [ "${#todo_list[@]}" == "4" ]
	then
		echo -e "These are Apps that you haven't installed:"
		for app in ${todo_list[*]}
		  do
		    echo -e "\e[1;31m $app \e[0m"
		done 
	else 
		echo -e "Already install:\e[1;34m ${done_list[*]} \e[0m"
		echo -e "Haven't install:\e[1;31m ${todo_list[*]} \e[0m"	
	fi 

while : # To show selection list multiple time
do
	# Select MOOS to install
	if [ ${#todo_list[@]} == 0 ]
	then
	  break
	fi
	PS3='Which MOOS App do you want to install?'
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

