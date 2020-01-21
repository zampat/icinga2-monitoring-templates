
###
# Create Service Set: "Windows Agent NSCP OS-Basic"
###
# Service Template for Service Set
RES=`icingacli director serviceset exists "Windows Agent NSCP OS-Basic"`
if [[ $RES =~ "does not exist" ]]
then


icingacli director serviceset create --json '
{
    "assign_filter": null,
    "description": null,
    "host": null,
    "imports": [

    ],
    "object_name": "Windows Agent NSCP OS-Basic",
    "object_type": "template",
    "vars": {

    }
}
'


####
# Service Objects
####
icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "agent-connected"
    ],
    "object_name": "Icinga Agent connected",
    "object_type": "object",
    "service_set": "Windows Agent NSCP OS-Basic",
    "use_agent": false
}
'

   icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "generic-agent-windows-nscp-disk"
    ],
    "object_name": "Agent WinNscp Diskspace",
    "object_type": "object",
    "service_set": "Windows Agent NSCP OS-Basic",
    "use_agent": true
}
'
fi
