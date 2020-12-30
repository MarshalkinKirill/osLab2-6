#!/bin/bash

operation="+"
value=1

(tail -f pipe5) |
while true;
do
	read line

	case $line in
		"+")
			operation="$line"
		;;
		"*")
			operation="$line"
		;;
		[0-9]*)
			case $operation in
				"+")
					value=$(($value + $line))
					echo $value
				;;
				"*")
					value=$(($value * $line))
					echo $value
				;;
			esac
		;;
		"QUIT")
			killall tail
			exit 0
		;;
	esac
done