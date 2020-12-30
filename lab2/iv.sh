#!/bin/bash

for pid in $(ps -aux | awk '{print $2;}')
do
    fs="/proc/"$pid"/status"                                    
    fsc="/proc/"$pid"/sched"
	
    ppid=$(cat "fs" | awk '$1 == "PPid:"' | awk '{print $2}')
    sum_exec_runtime=$(cat "fsc" | awk '$1 == "se\.sum_exec_runtime"' | '{print $3')
    nr_switches=$(cat "fsc" | awk '$1 == "nr_switches"' | '{print $3}')
	if [ -z $sum_exec_runtime ] || [ -z $nr_switches ]                   
    then                                                                 
        art=0                                                        
    else
		art=$(echo "scale=4; $sum_exec_runtime/$nr_switches" | bc)
	fi
done | sort -nk2 | awk '{print "ProcessID="$1" : ParentProcessID="$2" : AverageRunningTime="$3""}' > iv_res.txt
