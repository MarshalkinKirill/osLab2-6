#!/bin/bash

if [[ "$#" -ne 1 ]]
then
    echo "Incorrect format of arguments"
    exit 1
fi

if [[ ! -f ~/.trash.log ]]
then
    echo "Log file not found!"
    exit 1
fi

if [[ ! -d ~/.trash ]]
then
    echo "Trash directory not exists"
    exit 1
fi

cat ~/.trash.log | while read line
do
    link=$(echo $line | awk '{print $NF}')
    fullname=$(echo $line | awk '{$(NF--)=""; print}')
    fullname="${fullname%?}"
    filename=$(basename "$fullname")
    filepath=$(dirname "$fullname")
    if [[ $filename == $1 ]]
    then
	echo $fullname
	read -p "You want to untrash this file? [y/n]: " answer < /dev/tty
	case "$answer" in
	"y")
	    newfilename="$fullname"
	    while [[ -e "$newfilename" ]]
	    do
		echo "File $newfilename already exisits"
		read -p "Change file name: " answer < /dev/tty
		newfilename="$filepath/$answer"
	    done

	    if ln ~/.trash/$link "$newfilename" 2> /dev/null
	    then
		echo "Successfully untrashed!"
            else
		echo "Directory to untrash not found! Restoring to $HOME"
		newfilename="$HOME/$filename"
		while [[ -e "$newfilename" ]]
		do
		    echo "File $newfilename already exists"
		    read -p "Change file name: " answer < /dev/tty
		    newfilename="$HOME/$answer"
		done
		ln ~/.trash/$link "$newfilename"
		echo "Successfully untrashed!"
	    fi
	    rm ~/.trash/$link
	    grep -v "$line" ~/.trash.log > .tmp.log ; mv .tmp.log ~/.trash.log
	;;
        *)
	    continue
	;;
        esac
    fi
done
