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
            "command_id": "242",
            "skip_key": true,
            "value": "; exit ($$lastexitcode)"
        },
        "-command": {
            "command_id": "242",
            "skip_key": true,
            "value": {
                "type": "Function",
                "body": "var powershell_script = macro(\"$powershell_script$\");\r\nvar powershell_args = macro(\"$powershell_args$\");\r\n\r\nresult = \"try { \\\" & ' \" + powershell_script + \" ' \\\" \";\r\nif (powershell_args) {\r\n    result += powershell_args;\r\n}\r\nresult += \"} catch { echo $$_.Exception ;exit 3 }\";\r\nreturn result;"
            },
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
