#!/bin/bash

if [[ "$#" -ne 1 ]]
then
    echo "Incorrect format of argumnets"
    exit 1
fi

if [[ ! -f "$(pwd)/$1" ]]
then
    echo "File $1 doesn't exist!"
    exit 1
fi

if [[ ! -d ~/.trash ]]
then
    mkdir ~/.trash
fi

if [[ ! -f "~/.trash.log" ]]
then
    touch ~/.trash.log
fi

linkname=$(ls ~/.trash | cat | grep "^[[:digit:]]\+$" | sort -nrk 1 | head -1)
if [[ -z "$filename" ]]
then
    linkname=0
fi

let linkname=linkname\+1
ln $(pwd)/"$1" ~/.trash/$linkname

rm "$(pwd)/$1"
echo "$(pwd)/$1 $linkname" >> ~/.trash.log
