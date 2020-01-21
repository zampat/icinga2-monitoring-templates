#/bin/bash


#Variables
ACTION="help"
ACTION=$1

# #Constants
FILES_IMPORT="import_files.tmp"
IMPORT_LOG="import_history.log"
IMPORT_DB=director

#################################################################################################
function import2icinga()
{
while read FILE
do

	#sanitize files after copy
	`/usr/bin/dos2unix ${SUBDIR}/${FILE} >> /dev/null` > /dev/null

	#echo "reading line $FILE"
	if [[ ${SUBDIR}/${FILE} =~ ".sh" ]]
	then
	   echo "[+] Start script import of file: ${SUBDIR}/${FILE}" >> $IMPORT_LOG 2>&1
	   echo "[+] Start script import of file: ${SUBDIR}/${FILE}"
	   `/usr/bin/sh ${SUBDIR}/${FILE} >> $IMPORT_LOG 2>&1`

	elif [[ ${SUBDIR}/${FILE} =~ ".sql" ]]
	then
	   echo "[+] Start SQL injection of file: ${SUBDIR}/${FILE}" >> $IMPORT_LOG 2>&1
	   echo "[+] Start SQL injection of file: ${SUBDIR}/${FILE}"
	   cat ${SUBDIR}/${FILE} | mysql $IMPORT_DB >> $IMPORT_LOG 2>&1
	fi
done < $FILES_IMPORT

}

## start of code

if [ "$ACTION" == "full" ]
then
   echo "Import option: import of all icinga2 objects"
elif [ "$ACTION" == "fields" ]
then
   echo "Import option: icinga2 director fields only"
elif [ "$ACTION" == "full_legacy" ]
then
   echo "Import option: import of all legacy icinga2 objects"
else
   echo "Advice: The icinga2 director templates had been refactored completely. Naming conventions had been introduced."
   echo "        The import of objects is now controled by parameter - choose one from below."
   echo "Legacy advice: If you would like to use the old templates checkout branch legacy_templates_v1"
   echo "        https://github.com/zampat/icinga2-monitoring-templates/tree/legacy_templates_v1"
   echo ""
   echo "./run_import.sh full           import of all icinga2 objects"
   echo "./run_import.sh full_legacy    import of all legacy icinga2 objects"
   echo "./run_import.sh fields         icinga2 director fields only"
   exit 3
fi

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
echo "- Logs are written to $IMPORT_LOG."
echo "- Import mode $ACTION"


#### mode: Import fields
if [ "$ACTION" == "fields" ] || [ "$ACTION" == "full" ]
then
   /usr/bin/ls director_fields | grep -v run_import.sh | grep -v .tmp > $FILES_IMPORT
   SUBDIR="director_fields"
   import2icinga
fi

#### mode: Import fields
if [ "$ACTION" == "full" ]
then

   /usr/bin/ls icinga_objects | grep -v run_import.sh | grep -v .tmp > $FILES_IMPORT
   SUBDIR="icinga_objects"
   import2icinga
fi

