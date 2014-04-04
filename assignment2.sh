#!/bin/bash

for ListItem in $@
do
	if [ $ListItem == ":" ]
		then
			FirstItem="."
		else
			if [[ $ListItem == :* ]]
				then
					FirstItem=".$ListItem"
				else
					if [[ $ListItem == *: ]]
						then
							FirstItem="$ListItem."
						else
							FirstItem=$ListItem 
					fi
			fi
	fi
	DupedList="$DupedList$FirstItem:"
done

for DupedListItem in `echo $DupedList | sed 's/:/\\n/g'`
do

	Dupe=0

	for IsDupeItem in `echo $DeDupedList | sed 's/:/\\n/g'`
	do			
		if [ $DupedListItem != $IsDupeItem ] && [ $Dupe == 0 ]
			then
				Dupe=0
			else
				Dupe=1
		fi
	done
	
	if [ $Dupe == 0 ]
		then
			DeDupedList="$DeDupedList$DupedListItem:"
	fi
done

ListOutput=`echo $DeDupedList | sed 's/:\+$//'`
echo $ListOutput