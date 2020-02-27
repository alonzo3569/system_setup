#!/bin/bash

#-------------------------------------------------------
#  Part 1: Env params
#-------------------------------------------------------
export CHECK_MARK="\e[0;32m\xE2\x9C\x94\e[0m"
export CROSS_MARK='\u00D7'
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
	echo -e "\e[1;33m   Welcome to Alonzo System Setup Wizard! \e[0m"
	echo -e "=============================================="
	echo -e "\e[1;33mHello $user! \e[0m"
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





