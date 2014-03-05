#!/bin/bash

#Set function to find files and directories
FindExe (){
	if [ -s "$1" ] || [ -d "$1" ]
		then
		echo "$1" #return found file or directory
	else
		echo "$1 NOT FOUND." >&2 #error message
		fi
}

#Determine which argument to use
case $1 in

'-a')	#Look in path directories, use second argument as search term
	shift 
	for arg in $@
		do
			for P in `echo $PATH | sed -e 's/^:/.:/' -e 's/::/:.:/' -e 's/:$/:./' -e 's/:/ /g'` #Loop through $PATH variable
				do
					FindExe "$P/$arg"	
				done
		done
	;;
	
*) 		#Look in specified directory, use first argument as search term

	for arg in $@
		do
			FindExe "$arg"
		done
	
esac
