#!/bin/bash

if [ $1 == "-a" ]
  then
    echo 'Printing all occurences'
    for file in $@
    do
      if [ $file != "-a" ]
        then
          found=0
          for DIR in `echo $PATH | sed -e 's/^:/.:/' -e 's/::/:.:/' -e 's/:$/:./' -e 's/:/ /g'`
            do
              if [ -s "$DIR/$file" ] || [ -d "$DIR/$file" ]
                then
                  echo "$DIR/$file"
                  let "found += 1"
              fi
          done
          if [ $found == 0 ]
            then
              echo "$file NOT FOUND" >&2
          fi
      fi
    done
  else
    echo 'Printing first occurence'
    for file in $@
    do
      for DIR in `echo $PATH | sed -e 's/^:/.:/' -e 's/::/:.:/' -e 's/:$/:./' -e 's/:/ /g'`
        do
          if [ -s "$DIR/$file" ] || [ -d "$DIR/$file" ]
            then
              echo "$DIR/$file"
              exit
            else
              notfound=1
          fi
      done
      if [ $notfound -gt 0 ]
        then
          echo "$file NOT FOUND"
      fi
    done
fi
