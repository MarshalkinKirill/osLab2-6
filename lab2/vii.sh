#!/bin/bash
FindProc(){
for x in $(ps -eo pid,command| tail -n +2 | awk '{print $1 ":" $2}')
do
	pid=$(echo $x | awk -F ":" '{print $1}')
	command=$(echo $x| awk -F ":" '{print $2}')
	path="/proc/"$pid
	if [[ -f $path/"io" ]]
	then
		bytes=$(grep -h "read_bytes: " $path"/io" | grep -oE "[0-9]+")
		echo "$pid $command $bytes"
	fi
done | sort -nrk3 | head -n 3
}
touch file1.txt
FindProc > file1.txt
sleep 1m
touch file2.txt
FindProc > file2.txt

cat file1.txt |
while read str
do
	pid=$(awk '{print $1}' <<< $str)
	command=$(awk '{print $2}' <<< $str)
	read_bytes=$(awk '{print $3}' <<< $str)
	

	read_bytes1=$(cat file2.txt |awk -v id=$pid '{if ($1 == id) print $3}')
	difference=$(($read_bytes1-$read_bytes))
	echo $pid":"$command":"$difference
done 

rm file1.txt
rm file2.txt
