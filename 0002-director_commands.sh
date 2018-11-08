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

