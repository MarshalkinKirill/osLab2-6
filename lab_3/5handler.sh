
#!/bin/bash

command="+"
res=1
tail -f pipe |
while true;
do
	read line
	case $line in
		"+")
			command="$line"
			echo "switched plus"
		;;
		"*")
			command="$line"
			echo "switched multi"
		;;
		"QUIT")
			killall tail
			echo "quit"
			exit 0
		;;
		[0-9])
			case $command in
				"+")
					res=$(($res + $line))
					echo $res
				;;
				"*")
					res=$(($res * $line))
					echo $res
				;;
			esac
		;;
		*)
			killall tail
			echo "handler error"
			exit 1
		;;
	esac
done
