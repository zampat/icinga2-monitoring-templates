# 
#Services (as template)
# HowTo Export:
# icingacli director service show generic-service --json --no-defaults
#

# Service Template for Service Template
OBJ="snmp_nwc_health"
RES=`icingacli director service exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service \"$OBJ\" does not exists"
   icingacli director service create --json '
{
    "check_command": "check_nwc_health",
    "imports": [
        "generic-snmp"
    ],
    "object_name": "snmp_nwc_health",
    "object_type": "template"
}
'
fi

# Service Template for Service Template
OBJ="SNMP-NWC Hardware Health"
RES=`icingacli director service exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service \"$OBJ\" does not exists"
   icingacli director service create --json '
{
    "imports": [
        "snmp_nwc_health"
    ],
    "object_name": "SNMP-NWC Hardware Health",
    "object_type": "template",
    "vars": {
        "nwc_health_mode": "hardware-health"
    }
}
'
fi


exit 0
