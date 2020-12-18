#!/bin/bash
./05.helper& > 05.chan
while true
do
	read line
	echo "$line" >> 05.chan

	if [[ $line == "QUIT" ]]
		then	
			echo "the planned quit"
			rm 05.chan
			exit 0
	fi
	
	if [[ $line != "+" && $line != "*" && ! $line =~ [0-9]+ ]]
		then
			echo "ERROR"
			rm 05.chan
			exit 1
	fi	
done