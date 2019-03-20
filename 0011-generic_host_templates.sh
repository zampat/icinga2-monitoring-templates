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
    "max_check_attempts": "2",
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
    "icon_image": "tux.png",
    "icon_image_alt": "tux.png",
    "imports": [
        "generic-agent"
    ],
    "master_should_connect": true,
    "object_name": "generic-agent-linux",
    "object_type": "template",
    "vars": {
        "host_os": "Linux"
    }
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
    "icon_image": "devices.gif",
    "object_type": "template"
}
'
fi


RES=`icingacli director host exists "generic_switch"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Host 'generic_switch' does not exists"

   icingacli director host create --json '
{
    "imports": [
        "generic-snmp"
    ],
    "object_name": "generic_switch",
    "icon_image": "switch-high.png",
    "object_type": "template"
}
'
fi


RES=`icingacli director host exists "generic_cisco_device"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Host 'generic_cisco_device' does not exists"

   icingacli director host create --json '
{
    "imports": [
        "generic-snmp"
    ],
    "object_name": "generic_cisco_device",
    "icon_image": "cisco3-high.png",
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
    "icon_image": "neteye.png",
    "imports": [
        "generic-host"
    ],
    "object_name": "neteye-local-master",
    "object_type": "template"
}'
fi

RES=`icingacli director host exists "neteye-remote-satellite"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Host 'neteye-remote-satellite' does not exists"
   icingacli director host create --json '
{
    "accept_config": true,
    "has_agent": true,
    "icon_image": "neteye.png",
    "imports": [
        "neteye-local-master"
    ],
    "master_should_connect": true,
    "object_name": "neteye-remote-satellite",
    "object_type": "template"
}
'
fi


RES=`icingacli director host exists "neteye-cluster-satellite"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Host 'neteye-cluster-satellite' does not exists"
   icingacli director host create --json '
{
    "accept_config": true,
    "icon_image": "neteye.png",
    "imports": [
        "neteye-local-master"
    ],
    "master_should_connect": true,
    "object_name": "neteye-cluster-satellite",
    "object_type": "template"
}
'
fi


RES=`icingacli director host exists "generic-ibm-aix"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Host 'generic-ibm-aix' does not exists"
   icingacli director host create --json '
{
    "icon_image": "aix-high.png",
    "imports": [
        "generic-host"
    ],
    "object_name": "generic-ibm-aix",
    "object_type": "template",
    "vars": {
        "host_os": "AIX"
    }
}
'
fi

# Generic Passive Hosts
RES=`icingacli director host exists "generic-passive-host"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Host 'generic-passive-host' does not exists"
   icingacli director host create --json '
{
    "check_command": "dummy",
    "check_interval": "86400",
    "check_timeout": "10",
    "enable_active_checks": false,
    "enable_event_handler": true,
    "enable_notifications": true,
    "enable_passive_checks": true,
    "enable_perfdata": true,
    "imports": [
        "generic-host"
    ],
    "max_check_attempts": "1",
    "object_name": "generic-passive-host",
    "object_type": "template",
    "retry_interval": "30",
    "volatile": false
}
'
fi


echo "Generic Host Templates created"
