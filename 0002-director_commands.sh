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
    "arguments": {
        "(no key)": {
            "command_id": "230",
            "skip_key": true,
            "value": "; exit ($$lastexitcode)"
        },
        "-arguments": {
            "command_id": "230",
            "skip_key": true,
            "value": " $powershell_args$",
            "order": "-1"
        },
        "-command": {
            "command_id": "230",
            "skip_key": true,
            "value": "$powershell_script$",
            "order": "-2"
        }
    },
    "command": "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe -ExecutionPolicy ByPass",
    "methods_execute": "PluginCheck",
    "object_name": "powershell",
    "object_type": "object",
    "timeout": "60"
}
'
fi

