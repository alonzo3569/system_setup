#!/bin/bash

#-------------------------------------------------------
#  Part 1: Env params
#-------------------------------------------------------

#-------------------------------------------------------
#  Part 1: Functions
#-------------------------------------------------------

log_header()  # \n: next line   \: continue command
{
echo -e "************************************************\n\
User: $user\n\
Device: $host\n\
Date: $date\n\
passwd: $sudo_passwd\n\
************************************************" 
}

