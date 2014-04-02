#!/bin/bash
if  [ $# -eq 0 ]
  then
    echo 'Please enter at least one paramaeter'
    exit
fi
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
          if [ -s "$file" ] || [ -d "$file" ]
            then
              echo "$file"
              let "found += 1"
          fi
          if [ $found == 0 ]
            then
              echo "$file NOT FOUND" >&2
          fi
      fi
    done
  else
    echo 'Printing first occurence'
    found=()
    nfound=()
    notfound=0
    for file in $@
    do
      stopbit=0
      let "notfound += 1"
      for DIR in `echo $PATH | sed -e 's/^:/.:/' -e 's/::/:.:/' -e 's/:$/:./' -e 's/:/ /g'`
        do
          if [ $stopbit -lt 1 ]
            then
            
	            if [ -s "$file" ] || [ -d "$file" ]
	              then
	                found=("${found[@]}" "$file")
	                let "stopbit += 1"
	                let "notfound -= 1"
	            fi
	            if [ -s "$DIR/$file" ] || [ -d "$DIR/$file" ]
	              then
	                found=("${found[@]}" "$DIR/$file")
	                let "stopbit += 1"
	                let "notfound -= 1"
	            fi
          fi
        done
        if [ $notfound -eq 1 ]
          then
            nfound=("${nfound[@]}" "$file")
        fi
    done
    for line in ${found[@]}
      do
        echo "$line"
      done
    for line in ${nfound[@]}
      do
        echo "$line NOT FOUND"
      done
fi
