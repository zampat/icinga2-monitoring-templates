
# 
#Services (as template)
# HowTo Export:
# # icingacli director service show windows-generic-service --no-defaults --json
#


######
## Services for Linux monitoring with Icinga Agent
######

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

RES=`icingacli director service exists "linux-processes"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'linux-processes' does not exists"
   icingacli director service create --json '
{
    "check_command": "procs",
    "imports": [
        "generic-agent"
    ],
    "object_name": "linux-processes",
    "object_type": "template",
    "vars": {
        "procs_critical": "5000",
        "procs_warning": "1500"
    }
}
'
fi

RES=`icingacli director service exists "linux-proc-procname"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'linux-proc-procname' does not exists"
   icingacli director service create --json '
{
    "check_command": "procs",
    "imports": [
        "generic-agent"
    ],
    "object_name": "linux-proc-procname",
    "object_type": "template",
    "vars": {
        "procs_critical": "1:",
        "procs_warning": "1:5"
    }
}
'
fi

