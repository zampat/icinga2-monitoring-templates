# 
#Service templates
# HowTo Export: icingacli director service show windows-nscp-file age --json --no-defaults
#

######
## Extra Windows Services based on Icinga Agent
## 1) windows-nscp-file age
######

RES=`icingacli director service exists "windows-nscp-file age"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'windows-nscp-file age' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local",
    "check_interval": "3600",
    "imports": [
        "generic-agent"
    ],
    "object_name": "windows-nscp-file age",
    "object_type": "template",
    "vars": {
        "nscp_arguments": [
            "path=C:\\temp",
            "pattern=*.txt",
            "\"filter=age>1d\"",
            "\"warn=count > 1\"",
            "\"crit=count > 10\""
        ],
        "nscp_modules": "CheckDisk",
        "nscp_query": "check_files",
        "nscp_showall": true
    }
}
'
fi
