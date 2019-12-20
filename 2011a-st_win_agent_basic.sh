# 
#Services (as template)
# HowTo Export:
# icingacli director service show generic-service --json --no-defaults
#


######
## Services for Windwows monitoring with Icinga Agent
######

# Service Template for Service Set
OBJ="Agent_connected"
RES=`icingacli director service exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service '$OBJ' does not exists"
   icingacli director service create --json '
{
    "check_command": "cluster-zone",
    "imports": [
        "generic-agent"
    ],
    "object_name": "Agent_connected",
    "object_type": "template",
    "use_agent": false
}'
fi

OBJ="Agent_Win_CPU"
RES=`icingacli director service exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service '$OBJ' does not exists"
   icingacli director service create --json '
{
    "check_command": "load-windows",
    "imports": [
        "generic-agent"
    ],
    "object_name": "Agent_Win_CPU",
    "object_type": "template",
    "use_agent": true
}
'
fi

###
# Agent_Win_Diskspace
###
# Service Template for Service Set
RES=`icingacli director service exists "Agent_Win_Diskspace"`
if [[ $RES =~ "does not exist" ]]
then

   echo "Service 'Agent_Win_Diskspace' does not exists"
   icingacli director service create --json '
{
    "check_command": "disk-windows",
    "imports": [
        "generic-agent"
    ],
    "object_name": "Agent_Win_Diskspace",
    "object_type": "template",
    "vars": {
        "disk_win_crit": "5%",
        "disk_win_path": "c:",
        "disk_win_warn": "8%"
    }
}
'
fi


###
# Agent_Win_Memory
###
# Service Template for Service Set
RES=`icingacli director service exists "Agent_Win_Memory"`
if [[ $RES =~ "does not exist" ]]
then

   echo "Service 'Agent_Win_Memory' does not exists"
   icingacli director service create --json '
{
    "check_command": "memory-windows",
    "imports": [
        "generic-agent"
    ],
    "object_name": "Agent_Win_Memory",
    "object_type": "template",
    "vars": {
        "memory_win_crit": "95%",
        "memory_win_show_used": true,
        "memory_win_warn": "90%"
    }
}
   '
fi


###
# Agent_Win_Service
###
# Service Template for Service Set
RES=`icingacli director service exists "Agent_Win_Service"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'Agent_Win_Service' does not exists"
   icingacli director service create --json '
{
    "check_command": "service-windows",
    "imports": [
        "generic-agent"
    ],
    "object_name": "Agent_Win_Service",
    "object_type": "template",
    "vars": {
        "service_win_service": [
            "spooler"
        ]
    }
}
'
fi


###
# generic-agent-windows-perfcounter
###
# Service Template for Service Set
RES=`icingacli director service exists "generic-agent-windows-perfcounter"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'generic-agent-windows-perfcounter' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-counter",
    "imports": [
        "generic-agent"
    ],
    "object_name": "generic-agent-windows-perfcounter",
    "object_type": "template",
    "use_agent": true
}
'
fi


# Agent Win NSCPServices (Advantage of multiple service monitoring provided by NSCLient++)
#
RES=`icingacli director service exists "generic-agent-nscp-service"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'generic-agent-nscp-service' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-service",
    "imports": [
        "generic-agent"
    ],
    "object_name": "generic-agent-nscp-service",
    "object_type": "template"
}
'
fi

# Agent Win NSCPServices (Advantage of multiple service monitoring provided by NSCLient++)
#
RES=`icingacli director service exists "Agent_Win_NscpServiceQuery"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'Agent_Win_NscpServiceQuery' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-service",
    "imports": [
        "generic-agent"
    ],
    "object_name": "Agent_Win_NscpServiceQuery",
    "object_type": "template"
}
'
fi


echo "Services created"
exit 0
