#!/bin/bash

operation="+"
value=1

TERM()
{	
	exit 0
}

SIG1()
{
	operation="+"
}

SIG2()
{
	operation="*"
}

trap 'TERM' SIGTERM
trap 'SIG1' USR1
trap 'SIG2' USR2

while true;
do
	case "$operation" in
		"+")
			value=$(($value + 2))
		;;
		"*")
			value=$(($value * 2))
		;;
	esac
	echo $value
done