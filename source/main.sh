#!/bin/bash

#-------------------------------------------------------
#  Part 1: Env params
#-------------------------------------------------------
#-------------------------------------------------------
#  Part 1: Functions
#-------------------------------------------------------
show_list()
{
	echo -e "\e[1;34m(\xE2\x9C\x94): $1 \e[0m"  # Already install
	echo -e "\e[1;31m(-): $2 \e[0m"		    # Haven't install
	echo -e "\e[1;32m(+): $3 \e[0m"		    # Ready to install
	echo
}

startup()
{
	clear
	echo -e "=============================================="
	echo -e "  $CHECK_MARK\e[1;33m Welcome to Alonzo System Setup Wizard! \e[0m"
	echo -e "==============================================" 
	echo -e "\e[1;97m                           Author: Logan Zhang \e[0m" 
	echo -e "\e[1;97m                           Version: 2.1.4 \e[0m"   
	echo
	echo SYNOPSIS:                                        
	echo "----------------------------------------------"                            
	echo "  This application is capable of setting up  "
	echo "  MOOS, ROS and other ubuntu utils such as vim,"
	echo "  anaconda, google automatically."
	echo
	echo -e "\e[1;33mHello $user! \e[0m"

}

clear_screen()
{
	clear
	echo -e "=============================================="
	echo -e "  $CHECK_MARK\e[1;33m Welcome to Alonzo System Setup Wizard! \e[0m"
	echo -e "==============================================" 
	echo -e "\e[1;97m                           Author: Logan Zhang \e[0m" 
	echo -e "\e[1;97m                           Version: 2.1.4 \e[0m"   
	echo
}


waiting() # ("PID"?) "Message string"
{
	PID=$!
	#echo pid= $PID
	process=`ps -ef | grep $PID | awk '{print $2}' | wc -l`
	#ans=2
	#echo $ans
	while [ $process -ge "2" ]
	do 
		echo -en "\r$1.  "
		sleep 1
		echo -en "\r$1.. "
		sleep 1
		echo -en "\r$1..."
		sleep 1
		process=`ps -ef | grep $PID | awk '{print $2}' | wc -l`
	done
}


check_install()
{
	if [ "`find ~/ -name moos-ivp`" == /home/$user/moos-ivp ] && \
	   [ "`which MOOSDB`" == /home/$user/moos-ivp/bin/MOOSDB ]
	  then
		done_list+=("${todo_list[0]}")
		unset todo_list[0]
	fi

	if [ "`find ~/ -name moos-ivp-aquaticus`" == /home/$user/moos-ivp-aquaticus ] && \
	   [ "`which iM200`" == /home/$user/moos-ivp-aquaticus/bin/iM200 ]
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

	if [ "`find ~/ -name moos-ivp-UAL`" == /home/$user/moos-ivp-UAL ] && \
	   [ "`which pStoreSound`" == /home/logan/moos-ivp-UAL/bin/pStoreSound ]
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
}


add_remove()
{
	# Find index of moos-ivp (! => return index instead of value)
	for i in ${!todo_list[*]} 
	  do
	    if [ "${todo_list[i]}" == $1 ]
	    then
	      #echo moos-ivp is index $i
	      waiting_list+=("${todo_list[$i]}")
	      unset todo_list[$i]
	    fi
	done
}







