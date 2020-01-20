#
#Commands:
# icingacli director command show check_vmware_api --json --no-defaults
#

# Check Command: check_vmware_api
#
RES=`icingacli director command exists "check_vmware_api"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Command 'check_vmware_api' does not exists"
   icingacli director command create check_vmware_api --json '
{
    "arguments": {
	"-D": {
            "set_if_format": "string",
            "value": "$esx_datacenter$"
        },
        "-H": {
            "set_if_format": "string",
            "value": "$host.address$"
        },
        "-c": {
            "set_if_format": "string",
            "value": "$esx_critical$"
        },
        "-f": {
            "set_if_format": "string",
            "value": "$esx_authfile$"
        },
        "-l": {
            "set_if_format": "string",
            "value": "$esx_command$"
        },
        "-o": {
            "set_if_format": "string",
            "value": "$esx_optional$"
        },
        "-p": {
            "set_if_format": "string",
            "value": "$esx_password$"
        },
        "-s": {
            "set_if_format": "string",
            "value": "$esx_subcommand$"
        },
        "-u": {
            "set_if_format": "string",
            "value": "$esx_username$"
        },
        "-w": {
            "set_if_format": "string",
            "value": "$esx_warning$"
        }
    },
    "command": "PluginDir + \/check_vmware_api",
    "methods_execute": "PluginCheck",
    "object_name": "check_vmware_api",
    "object_type": "object"
}
'
fi
