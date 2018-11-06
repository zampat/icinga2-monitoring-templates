#
#Commands:
# icingacli director command show check_esxi_hardware --json --no-defaults
#

# Check Command:Powershell
#
RES=`icingacli director command exists "powershell"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Command 'powershell' does not exists"
   icingacli director command create powershell --json '
{
   "object_name": "powershell",
   "methods_execute": "PluginCheck",
   "command": "c:\\Windows\\system32\\cmd.exe",
   "object_type": "object",
   "arguments": {
        "(no key)": {
            "command_id": "216",
            "set_if_format": "string",
            "skip_key": true,
            "value": "\/c echo c:\\Scripts\\$powershell_script$ ; exit ($$lastexitcode) | powershell.exe -command -"
        }
    }
}
'
fi


# Check Command: check_vmware_api
#
RES=`icingacli director command exists "check_vmware_api"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Command 'check_vmware_api' does not exists"
   icingacli director command create check_vmware_api --json '
{
    "arguments": {
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

