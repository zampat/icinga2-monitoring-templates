# 
#Services (as template)
# HowTo Export:
# icingacli director service show generic-service --json --no-defaults
#


######
## Services for Windwows monitoring with Icinga Agent
######

# Service Template for Service Set
OBJ="agent-connected"
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
    "object_name": "agent-connected",
    "object_type": "template",
    "use_agent": false
}'
fi

OBJ="windows-cpu"
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
    "object_name": "windows-cpu",
    "object_type": "template",
    "use_agent": true
}
'
fi

###
# windows-diskspace
###
# Service Template for Service Set
RES=`icingacli director service exists "windows-diskspace"`
if [[ $RES =~ "does not exist" ]]
then

   echo "Service 'windows-diskspace' does not exists"
   icingacli director service create --json '
{
    "check_command": "disk-windows",
    "imports": [
        "generic-agent"
    ],
    "object_name": "windows-diskspace",
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
# windows-memory
###
# Service Template for Service Set
RES=`icingacli director service exists "windows-memory"`
if [[ $RES =~ "does not exist" ]]
then

   echo "Service 'windows-memory' does not exists"
   icingacli director service create --json '
{
    "check_command": "memory-windows",
    "imports": [
        "generic-agent"
    ],
    "object_name": "windows-memory",
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
# windows-generic-service
###
# Service Template for Service Set
RES=`icingacli director service exists "windows-generic-service"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'windows-generic-service' does not exists"
   icingacli director service create --json '
{
    "check_command": "service-windows",
    "imports": [
        "generic-agent"
    ],
    "object_name": "windows-generic-service",
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

echo "Services created"
exit 0
