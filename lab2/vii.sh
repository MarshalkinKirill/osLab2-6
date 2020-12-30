#!/bin/bash

check()
{
    for proc_dir in $(ls -d /proc/[0-9]*)
    do
        if [[ -f "$proc_dir"/io && -f "$proc_dir"/status && -f "$proc_dir"/cmdline ]]
        then
            rchar=$(cat "$proc_dir"/io | awk -F":" '{print $2}' | tr -d "[\t\s]")
            pid=$(cat "$proc_dir"/status | awk -F":" '{print $2}' | tr -d "[\t\s]")
            cmd=$(cat "$proc_dir"/cmdline | tr -d '\0')
            echo "$pid_$cmd_$rchar " >> "$1".tmp
        fi
    done
}

check start
sleep 1m
check end

cat end.tmp |
while read line 
do
	pid=$(awk '{print $1}' <<< $str)
	cmd=$(awk '{print $2}' <<< $str)
    mem0=$(awk '{print $3}' <<< $str)
	mem1=$(cat start.tmp | awk -v id="$pid" '{if ($1 == id) print $3}')
	deltamem=$(echo "$mem1-$mem0" | bc)
	echo " $pid_$cmd_$deltamem " >> res.tmp
done	
cat res.tmp | sort -n --key=3 --field-separator="_" | tail -n 3 

rm res.tmp
rm start.tmp
rm end.tmp