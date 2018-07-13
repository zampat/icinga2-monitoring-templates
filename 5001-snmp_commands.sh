#
#Commands:
# icingacli director command show check_snmp_cisco_hw --json --no-defaults
#

# Check Command:check_snmp_cisco_hw
#
RES=`icingacli director command exists "check_snmp_cisco_hw"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Command 'check_snmp_cisco_hw' does not exists"
   icingacli director command create check_snmp_cisco_hw --json '
{
    "arguments": {
        "-C": {
            "required": true,
            "set_if_format": "string",
            "value": "$snmp_community$"
        },
        "-H": {
            "set_if_format": "string",
            "value": "$host.address$"
        },
        "-c": {
            "set_if_format": "string",
            "value": "$snmp_critical$"
        },
        "-i": {
            "set_if_format": "string",
            "value": "$snmp_interface$"
        },
        "-t": {
            "set_if_format": "string",
            "value": "$snmp_check_type$"
        },
        "-w": {
            "set_if_format": "string",
            "value": "$snmp_warning$"
        }
    },
    "command": "PluginDir + \/check_snmp_cisco_hw.pl",
    "methods_execute": "PluginCheck",
    "object_name": "check_snmp_cisco_hw",
    "object_type": "object"
}   
'
fi


