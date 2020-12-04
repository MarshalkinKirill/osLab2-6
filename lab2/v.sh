#!/bin/bash

if [[ -f v_res.txt ]]
then
    rm v_res.txt
fi

last_ppid=-1
art_sum=0
count=0

IFS=$'\n'
for line in $(cat iv_res.txt)
do
    ppid=$(echo "$line" | awk -F" : " '{print $2;}' | awk -F"=" '{print $2;}')
    art=$(echo "$line" | awk -F" : " '{print $3;}' | awk -F"=" '{print $2;}')
    
    if [[ "$last_ppid" -ne "$ppid" && "$last_ppid" -ne -1 ]]
    then
        average_art=$(echo "scale=4; $art_sum/$count" | bc)
        echo "Average_Sleepinng_Children_of_ParentID=$last_ppid is $average_art" >> v_res.txt
        art_sum=0
        count=0
    fi

    echo "$line" >> v_res.txt

    last_ppid="$ppid"
    art_sum=$(echo "$art_sum+$art" | bc)
    count=$(echo "$count + 1" | bc)
done

if [[ "$last_ppid" -ne -1 ]]
then
    average_art=$(echo "scale=4; $art_sum/$count" | bc)
    echo "Average_Sleepinng_Children_of_ParentID=$ppid is $average_art" >> v_res.txt
fi