#!/bin/bash

if [ -z "$1" ]
  then
    echo "Please pass at least one user."  >&2 #error message 
    exit
fi

for Recipient in $@
do

Me=$(cat /etc/passwd | grep $USER | awk -F ":" '{print $5}' | cut -d ',' -f 1)
Them=$(cat /etc/passwd | grep $Recipient  |  awk -F ":" '{print $5}' | cut -d ',' -f 1)

Subject="Mail Subject"

Message="Hello $Them,
****** This email is automatically generatated by `whoami`  ******
My instructor requires that I send this message as part of an assignment for class 92.312. The current time and date is `date`.
Have a nice day.
$Me"

User=$(who | grep $Recipient | head -n 1 | cut -d ' ' -f 1)

if [ "$Recipient" = "$User" ]
then
  echo "$Message" | mail -s "$Subject" "$Recipient"
  echo "Message Sent"
fi
done