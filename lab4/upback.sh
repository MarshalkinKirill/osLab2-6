#!/bin/bash

if [[ -d "/home/PC/restore" ]]
then
	rmdir "/home/PC/restore"
fi
mkdir "/home/PC/restore"


backup_prev=$(ls /home/PC | grep -E "^Backup-" | sort -n | tail -1)

if [[ -z "$backup_prev" ]]
then
	echo "There is no files to restore"
	exit 1
fi

for line in $( ls "/home/PC/$backup_prev" | grep -Ev "\-[0-9]{4}-[0-9]{2}-[0-9]{2}$" )
do
	cp "/home/PC/$backup_prev/$line" "/home/PC/restore/$line"
done