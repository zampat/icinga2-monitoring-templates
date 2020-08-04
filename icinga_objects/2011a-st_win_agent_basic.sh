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
# generic-agent-windows-nscp based checks
###
# windows nscp disk
OBJ="generic-agent-windows-nscp-disk"
RES=`icingacli director service exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service '$OBJ' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-disk",
    "imports": [
        "generic-agent"
    ],
    "object_name": "generic-agent-windows-nscp-disk",
    "object_type": "template",
    "vars": {
        "nscp_disk_arguments": [
            "filter=type in ('fixed')",
            "perf-config=*(unit:GB)"
        ],
        "nscp_disk_critical": "98%",
        "nscp_disk_drive": [
            "c:",
            "d:"
        ],
        "nscp_disk_warning": "95%"
    }
}'
fi



# windows nscp perfcounter
RES=`icingacli director service exists "windows-nscp-perfcounter"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'windows-nscp-perfcounter' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-counter",
    "imports": [
        "generic-agent"
    ],
    "object_name": "windows-nscp-perfcounter",
    "object_type": "template",
    "use_agent": true
}
'
fi


# Agent Win NSCPServices (Advantage of multiple service monitoring provided by NSCLient++)
#
# windows nscp service
RES=`icingacli director service exists "windows-nscp-generic-service"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'windows-nscp-generic-service' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-service",
    "imports": [
        "generic-agent"
    ],
    "object_name": "windows-nscp-generic-service",
    "object_type": "template"
}
'
fi

OBJ="windows-nscp-generic-all-service"
RES=`icingacli director service exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service '$OBJ' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-service",
    "imports": [
        "windows-nscp-generic-service"
    ],
    "object_name": "windows-nscp-generic-all-service",
    "object_type": "template",
    "vars": {
               "nscp_service_arguments": "filter=state='running'",
               "nscp_service_name": [
                   "*"
               ]
           }
}'
fi

OBJ="windows-nscp-generic-process-availability"
RES=`icingacli director service exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service '$OBJ' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-process",
    "imports": [
        "generic-agent"
    ],
    "object_name": "windows-nscp-generic-process-availability",
    "object_type": "template"
}'
fi

OBJ="windows-nscp-generic-process-availability-maxMemory"
RES=`icingacli director service exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service '$OBJ' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-process",
    "imports": [
        "windows-nscp-generic-process-availability"
    ],
    "object_name": "windows-nscp-generic-process-availability-maxMemory",
    "object_type": "template",
    "vars": {
        "nscp_arguments": [
            "process=explorer.exe",
            "warn=working_set > 1g",
            "crit=working_set > 2g",
            "filter=state='\''started'\''"
        ]
    }
}'
fi



echo "Services created"
exit 0
