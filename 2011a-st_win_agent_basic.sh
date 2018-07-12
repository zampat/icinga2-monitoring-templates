# 
#Services (as template)
# HowTo Export:
# icingacli director service show generic_service --json --no-defaults
#


######
## Services for Windwows monitoring with Icinga Agent
######

# Service Template for Service Set
RES=`icingacli director service exists "Agent_Win_CPU"`
if [[ $RES =~ "does not exist" ]]
then

   echo "Service 'Agent_Win_CPU' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-cpu",
    "imports": [
        "generic_agent"
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
        "generic_agent"
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
        "generic_agent"
    ],
    "object_name": "Agent_Win_Memory",
    "object_type": "template",
    "vars": {
        "memory_win_crit": "15%",
        "memory_win_warn": "10%"
    }
}
   '
fi


###
# Agent_WinSrv
###
# Service Template for Service Set
RES=`icingacli director service exists "Agent_WinSrv"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'Agent_WinSrv' does not exists"
   icingacli director service create --json '
{
    "check_command": "service-windows",
    "imports": [
        "generic_agent"
    ],
    "object_name": "Agent_WinSrv",
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
# Agent_WinCnt
###
# Service Template for Service Set
RES=`icingacli director service exists "Agent_WinCnt"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'Agent_WinCnt' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-counter",
    "imports": [
        "generic_agent"
    ],
    "object_name": "Agent_WinCnt",
    "object_type": "template",
    "use_agent": true
}
'
fi


# Agent Win NSCPServices (Advantage of multiple service monitoring provided by NSCLient++)
#
RES=`icingacli director service exists "Agent_Win_NscpServices"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'Agent_Win_NscpServices' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-service",
    "imports": [
        "generic_agent"
    ],
    "object_name": "Agent_Win_NscpServices",
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
        "generic_agent"
    ],
    "object_name": "Agent_Win_NscpServiceQuery",
    "object_type": "template"
}
'
fi


echo "Services created"
exit 0
