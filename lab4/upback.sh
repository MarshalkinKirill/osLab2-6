#!/bin/bash

if [[ -d "/home/neli/restore" ]]
then
	rmdir "/home/neli/restore"
fi
mkdir "/home/neli/restore"


backup_prev=$(ls /home/neli | grep -E "^Backup-" | sort -n | tail -1)

if [[ -z "$backup_prev" ]]
then
	echo "There is no files to restore"
	exit 1
fi

for line in $( ls "/home/neli/$backup_prev" | grep -Ev "\-[0-9]{4}-[0-9]{2}-[0-9]{2}$" )
do
	cp "/home/neli/$backup_prev/$line" "/home/neli/restore/$line"
done