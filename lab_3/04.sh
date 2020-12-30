#!/bin/bash

./04helper.sh &
pid1=$!
./04helper.sh &
pid2=$!
./04helper.sh &
pid3=$!

renice +10 -p $pid1
kill $pid3
