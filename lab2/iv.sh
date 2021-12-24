#!/bin/bash

for pid in $(ps -Ao pid | tail -n+2)
do
    ppid=$(grep -s "PPid:" /proc/"$pid"/status | grep -o "[[:digit:]]\+")
    runtime=$(grep -s "se\.sum_exec_runtime" /proc/"$pid"/sched | grep -o "[[:digit:]]\+\.[[:digit:]]\+")
    switches=$(grep -s "nr_switches" /proc/"$pid"/sched | grep -o "[[:digit:]]\+")
    if [ -z "$runtime" ]
        then continue
    fi
    echo "$pid" "$ppid" $(echo "scale=5; $runtime/$switches" | bc)
done | sort -nk 2 | awk '{print "ProcessID="$1" : Parent_ProcessID="$2" : Average_Running_Time="$3""}' > iv.txt
