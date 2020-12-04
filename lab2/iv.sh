#!/bin/bash

for pid in $(ps -aux | awk '{print $2;}')
do
    process_dir=/proc/"$pid"
    if [[ -d "$process_dir" ]]
    then
        ppid=$(cat "$process_dir"/status | awk '{if ($1 == "PPid:") print $2;}')
        sum_exec_runtime=$(cat "$process_dir"/sched | awk '{if ($1 == "se.sum_exec_runtime") print $3;}')
        nr_switches=$(cat "$process_dir"/sched | awk '{if ($1 == "nr_switches") print $3;}')
        art=$(echo "scale=4; $sum_exec_runtime/$nr_switches" | bc)
        echo "$pid $ppid $art" >> tmp.tmp  
    fi
done

sort -n --key=2 tmp.tmp | awk '{print "ProcessID=" $1 " : Parent_ProcessId=" $2 " : Averrage_Running_Time=" $3;}' > iv_res.txt
rm tmp.tmp