#!/bin/bash
max=0
maxpid=0
for pid in $(ps -Ao pid)
do
    if [[ -r /proc/"$pid"/status ]]
    then
	res=$(grep -s "VmRSS:" /proc/"$pid"/status | grep -o "[[:digit:]]\+")
	if [ "$res" != "" ] && [ "$res" -gt "$max" ]
	then
	    max=$res
	    maxpid=$pid
	fi
    fi
done
echo "[by /proc] PID = "$maxpid" : Uses Memory = "$max""
top -bo %MEM -n 1 | tail -n+8 | head -1 | awk '{print "[by top] PID = "$1" : Uses Memory = "$6""}'
