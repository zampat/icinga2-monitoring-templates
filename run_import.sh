#/bin/bash

FILES_IMPORT="import_files.tmp"
IMPORT_LOG="import_history.log"
IMPORT_DB=director


if [ ! -f /usr/bin/dos2unix ]; then
    echo "Plese install dos2unix. We prefer sanitizing files first."
    exit 3
fi

echo ">> Start of import procedure. Date: " `date` >> $IMPORT_LOG 2>&1
echo ">> Start of import procedure. Logs are written to $IMPORT_LOG."

#List files to import
/usr/bin/ls . | grep -v run_import.sh | grep -v .tmp > $FILES_IMPORT

while read ll
do

	#sanitize files after copy
	`/usr/bin/dos2unix $ll >> $IMPORT_LOG 2>&1` > /dev/null

	#echo "reading line $ll"
	if [[ $ll =~ ".sh" ]]
	then
	   echo "[+] Start script import of file: $ll" >> $IMPORT_LOG 2>&1
	   echo "[+] Start script import of file: $ll"
	   `/usr/bin/sh $ll >> $IMPORT_LOG 2>&1`

	elif [[ $ll =~ ".sql" ]]
	then
	   echo "[+] Start SQL injection of file: $ll" >> $IMPORT_LOG 2>&1
	   echo "[+] Start SQL injection of file: $ll"
	   cat $ll | mysql $IMPORT_DB >> $IMPORT_LOG 2>&1
	fi
done < $FILES_IMPORT


