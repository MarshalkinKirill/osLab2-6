#!/bin/bash
avg=0
cnt=1
curppid=0
avgsum=0
echo -e "$(<iv.txt)\n" | sed "s/[^0-9.]\+/ /g" | sed "s/^ //g" |
while read str;
do
	pid=$(awk '{print $1}' <<< $str)
	ppid=$(awk '{print $2}' <<< $str)
	art=$(awk '{print $3}' <<< $str)
	if [[ $ppid == $curppid ]];
	then
		avgsum=$(echo "$avgsum+$art" | bc)
		cnt=$(($cnt+1))
	else
		avg=$(echo "scale = 2; $avgsum/$cnt" | bc)
		echo "Average_Children_Running_Time_Of_PaarentID="$curppid" is "$avg
		avgsum=$art
		cnt=1
		curppid=$ppid
	fi
	if [[ -n $pid ]];
	then
		echo "ProcessID="$pid" ; Parent_ProcessID="$ppid" ; Average_Running_Time="$art
	fi
done > v.txt
