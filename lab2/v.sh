#!/bin/bash

prev_ppid=0
art_sum=0
count=0
m=0
file_in="iv_res.txt"
IFS=$'\n'
for line in $file
do
    ppid=$(awk '{print $2}' <<< $line )                                  
    art=$(awk '{print $3}' <<< $line )                                   
    pid=$(awk '{print $1}'<<< $line )
    
    if [[ "$ppid" -ne "$prev_ppid"]]
    then
        average_art=$(echo "scale=4; $art_sum/$count" | bc)
        echo "Average_Sleepinng_Children_of_ParentID=$last_ppid : $average_art" >> v_res.txt
        art_sum=0
        count=0
    fi
    echo "$line" >> v_res.txt
    last_ppid="$ppid"
    art_sum=$(echo "$art_sum+$art" | bc)
    count=$(($count+1))
done