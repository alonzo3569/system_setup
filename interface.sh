#!/bin/bash

#-------------------------------------------------------
#  Part 1: Env params
#-------------------------------------------------------
user=`whoami`
#rootpasswd

todo_list=('moos-ivp' 'moos-ivp-aquaticus' 'moos-ivp-UAL' 'moos-ivp-your-tree')
done_list=()
waiting_list=()

#-------------------------------------------------------
#  Part 1: Functions
#-------------------------------------------------------
show_list()
{
	echo -e "Already install:\e[1;34m $1 \e[0m"
	echo -e "Haven't install:\e[1;31m $2 \e[0m"
	echo -e "Going to install:\e[1;32m $3 \e[0m"
}

clear_screen()
{
	clear
	echo -e "=============================================="
	echo -e "\e[1;95mWelcome to Alonzo system setup wizard! \e[0m"
	echo -e "=============================================="
	echo -e "\e[1;95mHello $user! \e[0m"
	echo
}

#-------------------------------------------------------
#  Part 1: Program start page
#-------------------------------------------------------
clear_screen
#echo "This is an App which will automatically complete all"
#echo "the installation process as long as you finish the "
#echo "following steps."

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
	        echo moos-ivp-UAL is index $i
	        done_list+=("${todo_list[$i]}")
	        unset todo_list[$i]
	      fi
	  done
	fi

	# Show install situation
	if [ "${#todo_list[@]}" == "0" ]
	then 
		echo -e "\e[1;97m You already installed every MOOS App! \e[0m"

	elif [ "${#todo_list[@]}" == "4" ]
	then
		echo -e "These are Apps that you haven't installed:"
		for app in ${todo_list[*]}
		  do
		    echo -e "\e[1;31m $app \e[0m"
		done 
	else 
		echo -e "Already install:\e[1;34m ${todo_list[*]} \e[0m"
		echo -e "Haven't install:\e[1;31m ${done_list[*]} \e[0m"	
	fi 

while : # To show selection list multiple time
do
	# Select MOOS to install
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
			      echo moos-ivp is index $i
			      waiting_list+=("${todo_list[$i]}")
			      unset todo_list[$i]
			    fi
			done

			# Show list status (This should be function)
			clear_screen
			show_list "${todo_list[*]}" "${done_list[*]}" "${waiting_list[*]}"
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
			      echo moos-ivp is index $i
			      waiting_list+=("${todo_list[$i]}")
			      unset todo_list[$i]
			    fi
			done

			# Show list status (This should be function)
			clear_screen
			show_list "${todo_list[*]}" "${done_list[*]}" "${waiting_list[*]}"
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
			      echo moos-ivp is index $i
			      waiting_list+=("${todo_list[$i]}")
			      unset todo_list[$i]
			    fi
			done

			# Show list status (This should be function)
			clear_screen
			show_list "${todo_list[*]}" "${done_list[*]}" "${waiting_list[*]}"
			break
			;;

		     #=====================================================================
		     moos-ivp-your-tree)
			break 2;;
		     *) clear_screen;break 2;; #echo "Invalid option";;
		esac
	done # MOOS installation page select done
done
	esac # end of Main option case

done # end of Main option while

## Moos setup => sudo passwd / ivp aquaticus dir path (chekc if file exist) moos-ivp-"user"!!

