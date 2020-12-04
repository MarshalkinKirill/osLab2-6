#!/bin/bash

page_size=$(($(getconf PAGE_SIZE) / 1024))

max_ram_usage=0
pid=""

IFS=$'\n'
for proc_dir in $(ls -d /proc/[0-9]*)
do
    if [[ -f "$proc_dir"/statm ]]
    then
        page_number=$(cat "$proc_dir"/statm | awk '{print $2;}')
        ram_usage=$(("$page_number" * "$page_size"))

        if [[ "$ram_usage" -gt "$max_ram_usage" ]]
        then
            max_ram_usage="$ram_usage"
            pid=$(cat "$proc_dir"/status | awk -F":" '{if ($1 == "Pid") print $2;}' | tr -d "[\t\s]")
        fi
    fi
done

echo "SCRIPT_RESULT | PID: $pid RAM_USAGE: $max_ram_usage"
top -b -n1 -o RES | head -n 8 | tail -n 1 | awk '{print "TOP_RESULT | PID: " $1 " RAM_USAGE: " $6}'
