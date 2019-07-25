
# 
#Services (as template)
# HowTo Export:
# # icingacli director service show Agent_Win_Service --json
#


######
## Services for Linux monitoring with Icinga Agent
######

# Service Template for Service Set
RES=`icingacli director service exists "Agent_Linux_Diskspace"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'Agent_Linux_Diskspace' does not exists"
   icingacli director service create --json '
{
    "check_command": "disk",
    "imports": [
        "generic_agent"
    ],
    "object_name": "Agent_Linux_Diskspace",
    "object_type": "template"
}
'
fi

# Service Template for Service Set
RES=`icingacli director service exists "Agent_Linux_Memory"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'Agent_Linux_Memory' does not exists"
   icingacli director service create --json '
{
    "check_command": "mem",
    "imports": [
        "generic_agent"
    ],
    "object_name": "Agent_Linux_Memory",
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
RES=`icingacli director service exists "Agent_Linux_Load"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'Agent_Linux_Load' does not exists"
   icingacli director service create --json '
{
    "check_command": "load",
    "imports": [
        "generic_agent"
    ],
    "object_name": "Agent_Linux_Load",
    "object_type": "template"
}
'
fi
