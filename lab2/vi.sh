#!/bin/bash

grep "VmSize" /proc/*/status | sed "s/[^0-9.]\+/ /g" | sort -nk2 | tail -1 | awk '{print " Pid : "$1" VmSize : "$2}'

top -b -n1 -o RES | head -n 8 | tail -n 1 | awk '{print " Pid: " $1 " Virt: " $6}'
