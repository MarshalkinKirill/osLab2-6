#!/bin/bash

./04helper.sh &
pid1=$!
./04helper.sh &
pid2=$!
./04helper.sh &
pid3=$!

top -b -n 1 | head -10 | tail -4 | awk '{print $1 " " $9}'

renice +10 -p $pid1

kill $pid3

top -b -n 1 | head -10 | tail -4 | awk '{print $1 " " $9}'

kill $pid1
kill $pid2
