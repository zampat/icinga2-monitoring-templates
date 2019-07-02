#
#Service templates for generic Network Traffic monitoring via SNMP
# HowTo Export:
# icingacli director service show generic_service --json --no-defaults
#
# Requirements:
# Service tempate: generic_snmp
# Provided by: 0021-generic_service_templates.sh
#

RES=`icingacli director service exists "generic_snmp_interfaces"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'generic_snmp_interfaces' does not exists"

icingacli director service create generic_snmp_interfaces --json '
{
    "check_command": "check_interfaces",
    "imports": [
        "generic_snmp"
    ],
    "object_name": "generic_snmp_interfaces",
    "object_type": "template",
    "vars": {
        "interfaces_perfdata": true,
        "interfaces_regex": "Eth.*",
        "interfaces_exclude_regex": "Exclude_Eth(9|15|20|22|24)",
        "custom_analytics_dashboard": "gITkmapik/interfaces-traffic",
        "snmp_timeout": 60
    }
}

'
fi

echo "Network Traffic via SNMP Service Templates created"
