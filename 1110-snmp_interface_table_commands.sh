#
#Commands:
# icingacli director command show check_interface_table --json --no-defaults
#

# Check Command:check_interface_table
#
RES=`icingacli director command exists "check_interface_table"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Command 'check_interface_table' does not exists"
   icingacli director command create check_interface_table --json '
{
    "arguments": {
        "--64bits": {
            "argument_format": "string",
            "set_if": "$snmp_64bits$",
            "set_if_format": "string"
        },
        "--track-property": {
            "set_if_format": "string",
            "value": "$interface_table_track_property$"
        },
        "--v2c": {
            "argument_format": "string",
            "set_if": "$interface_table_v2c$",
            "set_if_format": "string"
        },
        "--warning-property": {
            "set_if_format": "string",
            "value": "$interface_table_warning_property$"
        },
        "-C": {
            "set_if_format": "string",
            "value": "$snmp_community$"
        },
        "-H": {
            "set_if_format": "string",
            "value": "$host.name$"
        },
        "-f": {
            "argument_format": "string",
            "set_if": "$snmp_enable_perfdata$",
            "set_if_format": "string"
        },
        "-t": {
            "set_if_format": "string",
            "value": "$snmp_timeout$"
        }
    },
    "command": "PluginDir + \/check_interface_table_v3t.pl",
    "methods_execute": "PluginCheck",
    "object_name": "check_interface_table",
    "object_type": "object"
}
'
fi


