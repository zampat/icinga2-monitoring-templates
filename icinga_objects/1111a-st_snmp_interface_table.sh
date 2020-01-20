# 
#Services (as template)
# HowTo Export:
# icingacli director service show generic-snmp_interface_table --json --no-defaults
#


######
## SNMP Interface Table
######

# Service Templates
RES=`icingacli director service exists "generic-snmp_interface_table"`
if [[ $RES =~ "does not exist" ]]
then

   echo "Service 'generic-snmp_interface_table' does not exists"
   icingacli director service create --json '
{
    "check_command": "check_interface_table",
    "imports": [
        "generic-snmp"
    ],
    "object_name": "generic-snmp_interface_table",
    "object_type": "template",
    "vars": {
        "interface_table_warning_property": 1,
        "snmp_64bits": true,
        "snmp_community": "public",
        "snmp_enable_perfdata": true,
        "interface_table_v2c": true,
        "snmp_timeout": 90
    }
}
'
fi

exit 0
