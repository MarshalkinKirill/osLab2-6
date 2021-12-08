#!/bin/bash

for pid in $(ps -Ao pid | tail -n +2);
do
	pth="/proc/"$pid
	ppid=$(grep -hsi "ppid:*" $pth"/status" | grep -o "[0-9]\+")
	rt=$(grep -hsi "se\.sum_exec_runtime" $pth/sched | awk '{print $3}')
	sw=$(grep -hsi "nr_switches" $pth/sched | awk '{print $3}')
	if [ -z $ppid ];
	then
		ppid=0
	fi
	if [ -z $rt ] || [ -z $sw ];
	then
		art=0
	else
		art=$(echo "scale=5; $rt/$sw" | bc)
	fi
	echo "$pid $ppid $art"
done | sort -nk2 | awk '{print "ProcessID="$1" : Parent_ProcessID="$2" : Average_Running_Time="$3}' > iv.txt
