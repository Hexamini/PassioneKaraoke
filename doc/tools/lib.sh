#!/bin/bash

#version 0.0.1
#@author Polonio Davide

function msg() {
	 #filter for messages
	 if [ $1 == "e" ]
	 then
	     # "!!!" red and blinking
	     echo -e "\e[5m\e[31m !!!\e[0m\e[25m $2"
	 fi

	 if [ $1 == "v" -a $VERBOSE -eq 1 ]
	 then
	     echo -e "\e[92m ***\e[0m $2"
	 fi

	 if [ $1 == "d" -a $DEBUG -eq 1 ]
	 then
	     echo -e "\e[33m @@@\e[0m $2"
	 fi  
}


msg d "Caricamento lib.sh completato"
