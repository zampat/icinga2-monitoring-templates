#
# host template Level 1
# How to export host template:
# icingacli director host show "generic-host" --json --no-defaults
#

RES=`icingacli director host exists "generic-host"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Host 'generic-host' does not exists"

   icingacli director host create --json '
  {
    "check_command": "hostalive",
    "check_interval": "300",
    "check_timeout": "60",
    "enable_active_checks": true,
    "enable_event_handler": true,
    "enable_notifications": true,
    "enable_passive_checks": true,
    "enable_perfdata": true,
    "icon_image": "device.png",
    "max_check_attempts": "3",
    "object_name": "generic-host",
    "object_type": "template",
    "retry_interval": "60",
    "volatile": false
}
'
fi


RES=`icingacli director host exists "generic-agent"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Host 'generic-agent' does not exists"
   icingacli director host create --json '
{
    "accept_config": true,
    "has_agent": true,
    "imports": [
        "generic-host"
    ],
    "master_should_connect": true,
    "object_name": "generic-agent",
    "object_type": "template"
}
'
fi

RES=`icingacli director host exists "generic-agent-linux"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Host 'generic-agent-linux' does not exists"
   icingacli director host create --json '
   {
    "accept_config": true,
    "has_agent": true,
    "icon_image_alt": "tux.png",
    "imports": [
        "generic-agent"
    ],
    "master_should_connect": true,
    "object_name": "generic-agent-linux",
    "object_type": "template"
}
'
fi

RES=`icingacli director host exists "generic-agent-windows"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Host 'generic-agent-windows' does not exists"
   icingacli director host create --json '
   {
    "accept_config": true,
    "has_agent": true,
	"icon_image": "win.png",
    "imports": [
        "generic-agent"
    ],
    "master_should_connect": true,
    "object_name": "generic-agent-windows",
    "object_type": "template"
}'
fi


RES=`icingacli director host exists "generic-esx"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Host 'generic-esx' does not exists"
   icingacli director host create --json '
{
    "icon_image": "vmware.png",
    "imports": [
        "generic-host"
    ],
    "object_name": "generic-esx",
    "object_type": "template",
    "vars": {
        "host_os": "ESX"
    }
}
'
fi


RES=`icingacli director host exists "generic-snmp"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Host 'generic-snmp' does not exists"

   icingacli director host create --json '
{
    "imports": [
        "generic-host"
    ],
    "object_name": "generic-snmp",
    "object_type": "template"
}
'
fi

RES=`icingacli director host exists "neteye-local-master"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Host 'neteye-local-master' does not exists"

   icingacli director host create --json '
{
    "has_agent": false,
    "icon_image": "tux.png",
    "imports": [
        "generic-host"
    ],
    "object_name": "neteye-local-master",
    "object_type": "template"
}'
fi

RES=`icingacli director host exists "neteye-satellite"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Host 'neteye-satellite' does not exists"

   icingacli director host create --json '
{
    "accept_config": true,
    "has_agent": true,
    "imports": [
        "neteye-local-master"
    ],
    "master_should_connect": true,
    "object_name": "neteye-satellite",
    "object_type": "template"
}

'
fi

echo "Generic Host Templates created"
