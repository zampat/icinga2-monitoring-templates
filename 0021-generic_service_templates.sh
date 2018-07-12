#
#Service template Level 1
#

RES=`icingacli director service exists "generic_service"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'generic_service' does not exists"

icingacli director service create generic_service --json '
{
    "check_interval": "180",
    "check_period": null,
    "check_timeout": "60",
    "disabled": false,
    "display_name": null,
    "enable_active_checks": true,
    "enable_event_handler": true,
    "enable_notifications": true,
    "enable_passive_checks": true,
    "enable_perfdata": true,
    "event_command": null,
    "icon_image": null,
    "icon_image_alt": null,
    "imports": [

    ],
    "max_check_attempts": "3",
    "notes": null,
    "notes_url": null,
    "object_name": "generic_service",
    "object_type": "template",
    "retry_interval": "60",
    "service_set": null,
    "template_choice": null,
    "use_agent": false,
    "use_var_overrides": null,
    "vars": {

    },
    "volatile": false
}
'
fi

#
#Service template generic ping
#
RES=`icingacli director service exists "generic_ping"`
if [[ $RES =~ "does not exist" ]]
then

   echo "Service 'generic_ping' does not exists"
   icingacli director service create generic_ping --json '
   {
    "check_command": "ping",
    "imports": [
        "generic_service"
    ],
    "object_name": "generic_ping",
    "object_type": "template"
}
'
fi



#
#Service template Level 2
#
RES=`icingacli director service exists "generic_agent"`
if [[ $RES =~ "does not exist" ]]
then

   echo "Service 'generic_agent' does not exists"
   icingacli director service create generic_agent --json '
{
    "check_command": "icinga",
    "imports": [
        "generic_service"
    ],
    "object_name": "generic_agent",
    "object_type": "template",
    "use_agent": true
}
'
fi


#
#Service template: generic_agent_powershell
# Note: Prerequisite is loading commands
#
RES=`icingacli director service exists "generic_agent_powershell"`
if [[ $RES =~ "does not exist" ]]
then

   echo "Service 'generic_agent_powershell' does not exists"
   icingacli director service create generic_agent_powershell --json '
{
    "check_command": "powershell",
    "imports": [
        "generic_agent"
    ],
    "object_name": "generic_agent_powershell",
    "object_type": "template"
}
'
fi


echo "Service Templates created"
