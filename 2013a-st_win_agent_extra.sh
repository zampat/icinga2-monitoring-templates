# 
#Service templates
# HowTo Export: icingacli director service show Agent_WinDisk_FileAge --json --no-defaults
#

######
## Extra Windows Services based on Icinga Agent
## 1) Agent_WinDisk_FileAge
######

RES=`icingacli director service exists "Agent_WinDisk_FileAge"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'Agent_WinDisk_FileAge' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local",
    "check_interval": "3600",
    "imports": [
        "generic-agent"
    ],
    "object_name": "Agent_WinDisk_FileAge",
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
