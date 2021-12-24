#!/bin/bash

current=0
sum=0
count=0
echo "0 0 0" >> iv.txt
data=$(tr -dc '[:digit:][:space:]\.' < iv.txt)
echo "$data" | while read line
do
    pid=$(awk '{print $1}' <<< "$line")
    ppid=$(awk '{print $2}' <<< "$line")
    art=$(awk '{print $3}' <<< "$line")
    let count=$count+1
    if [[ $current == $ppid ]]
    then
	sum=$(echo "$sum+$art" | bc)
    else
	avg=$(echo "scale=5; $sum/($count - 1)" | bc)
	sum=$art
	count=1
	echo "Average_Running_Children_of_ParentID="$current" is "$avg""
	current=$ppid
    fi
    if [[ "$pid" == "0" ]]
    then break
    fi
    echo "ProcessID="$pid" : Parent_ProcessID="$ppid" : Average_Running_Time="$art""
done > v.txt
