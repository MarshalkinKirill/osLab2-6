#!/bin/bash

if [[ $# != 1 ]]
then
	echo "Invalid amount of arguments"
	exit 1
fi

if [[ $1 == *"/"* ]]
then
	echo "File name contains path"
	exit 1
fi

home="/home/user"
trash="$home/.trash"
trashLog="$home/.trash.log"
findFile=0

[ -f $trashLog ] || { echo "hidden file trash.log does not exist"; exit 1; };
[ -s $trashLog ] || { echo "File trash.log is empty"; exit 1; };

[ -d "$trash" ] || { echo "hidden directoty .trash does not exist"; exit 1; };
[ "$(ls -A $trash)" ] || { echo "hidden directoty is empty"; exit 1; };

while read -r -u9 line
do
	oldFilePath=$(echo $line | awk 'BEGIN{FS="|"}; {print $1}')
	newFilePath=$(echo $line | awk 'BEGIN{FS="|"}; {print $4}')
	if [[ $1 == "$(echo $oldFilePath | awk -F/ '{ print $NF }')" ]]
	then
		let findFile=$findFile+1
		read -p "${oldFilePath} Do you want to restore this file? [y/N] " answer
		if [[ $answer != "y" ]]
		then
			continue
		fi
	
		restoreDirectory=$(echo $oldFilePath | awk 'BEGIN{FS=OFS="/"}; {$NF=""; print $0}')
		fileName=$(echo $oldFilePath | awk 'BEGIN{FS="/"}; {print $NF}')

		if [[ -d $restoreDirectory ]]
		then
			if [[ -f "$oldFilePath" ]] || [[ -d "$oldFilePath" ]]
			then
				read -p "File or directory with name $fileName already exists, enter new name: " newName
				ln "$newFilePath" "$restoreDirectory/$newName"
			else
				ln "$newFilePath" "$oldFilePath"
			fi
			rm "$newFilePath"
		else
			echo "Directory $restoreDirectory does not exist, $fileName will be restored in $home"
			if [[ -f "$home/$fileName" ]]
			then
				read -p "File with name $fileName already exists, enter new name: " newName
				ln "$newFilePath" "$home/$newName"
			else
				ln "$newFilePath" "$home/$fileName"
			fi
			rm "$newFilePath"
		fi

		sed -ie "s~.*$newFilePath.*~~" $trashLog
		sed -i "/^$/d" $trashLog
	fi
done 9< $trashLog

if [[ $findFile == 0 ]];
then
	echo "File did not find in trash.log"
	exit 1
fi
