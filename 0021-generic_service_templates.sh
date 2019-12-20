#
#Service template Level 1
# HowTo Export:
# export OBJ="generic-service"
# icingacli director service show "$OBJ" --json --no-defaults

RES=`icingacli director service exists "generic-service"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'generic-service' does not exists"

icingacli director service create generic-service --json '
{
    "check_interval": "180",
    "check_timeout": "60",
    "disabled": false,
    "enable_active_checks": true,
    "enable_event_handler": true,
    "enable_flapping": true,
    "enable_notifications": true,
    "enable_passive_checks": true,
    "enable_perfdata": true,
    "max_check_attempts": "3",
    "object_name": "generic-service",
    "object_type": "template",
    "retry_interval": "60",
    "use_agent": false,
    "volatile": false
}
'
fi


RES=`icingacli director service exists "generic-active-service"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'generic-active-service' does not exists"

icingacli director service create generic-active-service --json '
{
    "check_interval": "300",
    "check_timeout": "60",
    "imports": [
        "generic-service"
    ],
    "max_check_attempts": "3",
    "object_name": "generic-active-service",
    "object_type": "template",
    "retry_interval": "60"
}
'
fi

#
#Service template generic ping
#
RES=`icingacli director service exists "generic-ping"`
if [[ $RES =~ "does not exist" ]]
then

   echo "Service 'generic-ping' does not exists"
   icingacli director service create generic-ping --json '
   {
    "check_command": "ping",
    "imports": [
        "generic-active-service"
    ],
    "object_name": "generic-ping",
    "object_type": "template"
}
'
fi



#
#Service template Level 2
#
RES=`icingacli director service exists "generic-agent"`
if [[ $RES =~ "does not exist" ]]
then

   echo "Service 'generic-agent' does not exists"
   icingacli director service create generic-agent --json '
{
    "check_command": "icinga",
    "imports": [
        "generic-active-service"
    ],
    "object_name": "generic-agent",
    "object_type": "template",
    "use_agent": true
}
'
fi


#
#Service template: generic-agent-powershell
# Note: Prerequisite is loading commands
#
RES=`icingacli director service exists "generic-agent-powershell"`
if [[ $RES =~ "does not exist" ]]
then

   echo "Service 'generic-agent-powershell' does not exists"
   icingacli director service create generic-agent-powershell --json '
{
    "check_command": "powershell",
    "imports": [
        "generic-agent"
    ],
    "object_name": "generic-agent-powershell",
    "object_type": "template"
}
'
fi

#
RES=`icingacli director service exists "generic-snmp"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'generic-snmp' does not exists"
   icingacli director service create generic-snmp --json '
{
    "imports": [
        "generic-active-service"
    ],
    "object_name": "generic-snmp",
    "object_type": "template"
}'
fi

# Generic Passive Service
OBJ="generic-passive-service"
RES=`icingacli director service exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service '$OBJ' does not exists"
   icingacli director service create --json '
{
    "check_command": "dummy",
    "check_interval": "86400",
    "enable_active_checks": false,
    "enable_flapping": false,
    "imports": [
        "generic-service"
    ],
    "max_check_attempts": "1",
    "object_name": "generic-passive-service",
    "object_type": "template"
}
'
fi

echo "Service Templates created"
