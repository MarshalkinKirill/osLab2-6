#!/bin/bash
for pid in (ps -A | tail -n 2)
do
path="/proc/"$pid
if [[ -d $path ]]
then
	status=$path"/status"
	sched=$path"/sched"
	ppid=$(cat $status| grep "PPid:*" | awk '{ print $2 }')
	if [[ -z $ppid ]]
	then
		ppid=0
	fi
	rtime=$(cat $sched|grep "sum_exec_runtime" | awk '{print $3}' )
	swtc=$(cat $sched| grep "nr_switches" | awk '{print $3}'
	ART=$(echo "scale=4; $rtime/$swtc" | bc)
	echo "$pid $ppid $ART"
fi
done | sort -nk2 | awk '{print "PID = "$1" : PPID = "$2" : AVGRuntime = "$3}' > task4.txt
