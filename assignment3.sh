#!/bin/bash

USAGE="$0 -f directory
$0 -d  directory
$0 -d -f directory

-f rename files 
-d rename directories 
"

SWITCH=$1
#CHECKDIR=("$2")
#CDIR="${CHECKDIR[@]}"
newName=${CHECKDIR// /-}

usage ()
	{
	echo "$USAGE"
	exit 1
	}

pathname ()
	{
	# function provided for the student
	echo -- "${1%/*}"
	}

basename ()
	{
	# function provided for the student
	echo -- "${1##*/}"
	}

find_dirs ()
	{
	# function provided for the student
	find "$1" -depth -type d -name '* *' -print
	}

find_files ()
	{
	# function provided for the student
	find "$1" -depth -type f -name '* *' -print
	}

my_rename()
	{
	  err=0
	  CHECKDIR=("$1")
	  CDIR="${CHECKDIR[@]}"
	  newName=${CDIR// /-}
	  if [ ! -w "${CHECKDIR[@]}" ]
		then 
		  echo "$1 is not writeable."
		  let "err += 1"
	  fi
	  if [ -d $newName ]
			then
		  	echo "$newName exists."
		  	let "err += 1"
	  fi
	  if [ $err -eq 0 ]
	  	then
	  	return 0
	  fi

	# the student must implement this function to my_rename
	# $1 to $2
	# The following error checking must happen:
	#	1. check if the directory where $1 resided is writeable, 
	#      if not then report an error
	#	2. check if "$2" exists -if it does report and error and don't
	#      do the mv command
	#   3. check the status of the mv command and report any errors 
	}

fix_dirs ()
	{
		CHECKDIR=("$1")
		CDIR="${CHECKDIR[@]}"
		newName=${CDIR// /-}
		if my_rename "$1"
			then
				mv "$CDIR" "$newName"
		fi

	# The student must implement this function
	# to actually call the my_rename funtion to 
	# change the name of the directory from having spaces to
	# changing all of the spaces to -'s
	# if the name were "a b", the new name would be a-b
	# if the name were "a   b" the new name would be a----b
	}

fix_files ()
	{
		my_rename

		if [ "$err" -eq 0 ]
			then
				newName=${$1// /-}
				mv $1 $newName
		fi
	# The student must implement this function
	# to actually call the my_rename funtion to 
	# change the name of the file from having spaces to
	# changing all of the spaces to -'s
	# if the name were "a b", the new name would be a-b
	# if the name were "a   b" the new name would be a----b
	}

WFILE=
WDIR=
DIR=

if [ "$#" -eq 0 ]
   then
   usage
   fi

while [ $# -gt 0 ] 
	do
	case $1 in
	-d)
		WDIR=1
		;;
	-f)
		WFILE=1
		;;
	-*)
		usage 
		;;
	*)
	if [ -d "$1" ]
		then
		DIR="$1"
	else
		echo "$1 does not exist ..."
		exit 1
		fi
	;;
	esac
	shift
	done
# The student must implement the following:
# - if the directory was not specified, the script should 
#   print a message and exit

if [ "$#" -eq 1 ]
	then
		echo "Please specify a directory."
		exit
fi

# - if the Directory specified is the current directory, the script 
#   print a error message and exit

#if [ $2 -eq $pwd ]
#	then
#		echo "Cannot rename current directory."
#		exit
#fi

# - if the directory specified is . or .. the script should print
#   an error message and exit

if [ "$2" = . ] || [ "$2" = .. ]
	then
		echo "Cannot rename $2."
		exit
fi

# - if both -f and -d are not specified, the script should print a
#   message and exit
#

if [ "$SWITCH" != "-d" ] # || [ $1 != "-f" ]
then
		echo "Please pass -d or -f as the first argument."
		exit
fi

if [ "$WDIR" -a "$WFILE" ]
	then
	fix_files "$DIR"
	fix_dirs "$DIR"
elif [ "$WDIR" ]
	then
	fix_dirs "$DIR"
elif [ "$WFILE" ]
	then
	fix_files "$DIR"
	fi