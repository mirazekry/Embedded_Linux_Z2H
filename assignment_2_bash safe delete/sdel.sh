#!bin/bash
if [ -e TRASH ]
	then
	echo "TRASH is ready"
else
	mkdir TRASH
fi

read -p "Enter file to delete : " file


if [[ -e $file ]]
then
	if [[ $file =~ \.t?gz$ ]]
		then 
		mv $file TRASH
	else
		zip $file.zip $file
		filed=$file.zip
		rm $file
		mv $filed TRASH
	fi
else
	echo "file not found" 
fi


###removing files in TRASH exists for more than 2 days
find TRASH -mtime +2>list

if [[ -s list ]]
then
	cat list | xargs rm
else
	echo "no file to remove"
fi
