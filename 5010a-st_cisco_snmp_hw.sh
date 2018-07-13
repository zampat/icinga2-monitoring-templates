# 
#Services (as template)
# HowTo Export:
# icingacli director service show generic_service --json --no-defaults
#

# Service Template for Service Template
RES=`icingacli director service exists "SNMP_Cisco_HW"`
if [[ $RES =~ "does not exist" ]]
then

   echo "Service 'SNMP_Cisco_HW' does not exists"
   icingacli director service create --json '
{
    "check_command": "check_snmp_cisco_hw",
    "imports": [
        "generic_snmp"
    ],
    "object_name": "SNMP_Cisco_HW",
    "object_type": "template",
	"vars": {
        "snmp_community": "public"
    }
}
'
fi


# Service Template for Service Template
RES=`icingacli director service exists "SNMP_Cisco_HW_Temperature"`
if [[ $RES =~ "does not exist" ]]
then

   echo "Service 'SNMP_Cisco_HW_Temperature' does not exists"
   icingacli director service create --json '
{
    "imports": [
        "SNMP_Cisco_HW"
    ],
    "object_name": "SNMP_Cisco_HW_Temperature",
    "object_type": "template",
    "vars": {
        "snmp_check_type": "temp",
        "snmp_critical": "65",
        "snmp_warning": "45"
    }
}
'
fi

# Service Template for Service Template
RES=`icingacli director service exists "SNMP_Cisco_HW_Fans"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'SNMP_Cisco_HW_Fans' does not exists"
   icingacli director service create --json '
{
    "imports": [
        "SNMP_Cisco_HW"
    ],
    "object_name": "SNMP_Cisco_HW_Fans",
    "object_type": "template",
    "vars": {
        "snmp_check_type": "fan"
    }
}
'
fi

# Service Template for Service Template
RES=`icingacli director service exists "SNMP_Cisco_HW_PowerSupply"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'SNMP_Cisco_HW_PowerSupply' does not exists"
   icingacli director service create --json '
{
    "imports": [
        "SNMP_Cisco_HW"
    ],
    "object_name": "SNMP_Cisco_HW_PowerSupply",
    "object_type": "template",
    "vars": {
        "snmp_check_type": "ps"
    }
}
'
fi

# Service Template for Service Template
RES=`icingacli director service exists "SNMP_Cisco_HW_CPU"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'SNMP_Cisco_HW_CPU' does not exists"
   icingacli director service create --json '
{
    "imports": [
        "SNMP_Cisco_HW"
    ],
    "object_name": "SNMP_Cisco_HW_CPU",
    "object_type": "template",
    "vars": {
        "snmp_check_type": "cpu",
        "snmp_critical": "95",
        "snmp_warning": "85"
    }
}
'
fi

# Service Template for Service Template
RES=`icingacli director service exists "SNMP_Cisco_HW_MEM"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'SNMP_Cisco_HW_MEM' does not exists"
   icingacli director service create --json '
{
    "imports": [
        "SNMP_Cisco_HW"
    ],
    "object_name": "SNMP_Cisco_HW_MEM",
    "object_type": "template",
    "vars": {
        "snmp_check_type": "mem",
        "snmp_critical": "5",
        "snmp_warning": "15"
    }
}
'
fi

echo "SNMP Cisco Services created"
exit 0
