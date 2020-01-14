#/bin/bash

FILES_IMPORT="import_files.tmp"
IMPORT_LOG="import_history.log"
IMPORT_DB=director


if [ ! -f /usr/bin/dos2unix ]; then
    echo "Plese install dos2unix. We prefer sanitizing files first."
    exit 3
fi

# Validation of pre-requisites

# 1) The import of Icinga2 ITL
#
# Pre-Requisites: Command: Powershell and service template "windows-powershell-generic"
RES=`icingacli director command exists "icinga"`
if [[ $RES =~ "does not exist" ]]
then
   echo "[-] Pre-Requisite validation failed: Import of Icinga2 ITL into Director."
   echo "    The command 'icinga' ad not been found on this director installation."
   echo "    Please make sure to perform the Director Kickstart Wizard before running this import."
   exit 3
fi


echo ">> Start of import procedure. Date: " `date` >> $IMPORT_LOG 2>&1
echo ">> Start of import procedure. Logs are written to $IMPORT_LOG."

#List files to import
/usr/bin/ls . | grep -v run_import.sh | grep -v .tmp > $FILES_IMPORT

while read ll
do

	#sanitize files after copy
	`/usr/bin/dos2unix $ll >> /dev/null` > /dev/null

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


