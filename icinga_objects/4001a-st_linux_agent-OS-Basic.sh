
# 
#Services (as template)
# HowTo Export:
# # icingacli director service show windows-generic-service --json
#


######
## Services for Linux monitoring with Icinga Agent
######

# Service Template for Service Set
RES=`icingacli director service exists "linux-diskspace"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'linux-diskspace' does not exists"
   icingacli director service create --json '
{
    "check_command": "disk",
    "imports": [
        "generic-agent"
    ],
    "object_name": "linux-diskspace",
    "object_type": "template"
}
'
fi

# Service Template for Service Set
RES=`icingacli director service exists "linux-memory"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'linux-memory' does not exists"
   icingacli director service create --json '
{
    "check_command": "mem",
    "imports": [
        "generic-agent"
    ],
    "object_name": "linux-memory",
    "object_type": "template",
    "vars": {
        "mem_critical": "95",
        "mem_used": true,
        "mem_warning": "85"
    }
}
'
fi

# Service Template for Service Set
RES=`icingacli director service exists "linux-load"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'linux-load' does not exists"
   icingacli director service create --json '
{
    "check_command": "load",
    "imports": [
        "generic-agent"
    ],
    "object_name": "linux-load",
    "object_type": "template"
}
'
fi
