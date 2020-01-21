
###
# Create Service Set: "Windows Agent OS-Basic"
###
# Service Template for Service Set
RES=`icingacli director serviceset exists "Windows Agent OS-Basic"`
if [[ $RES =~ "does not exist" ]]
then


icingacli director serviceset create --json '
{
    "assign_filter": null,
    "description": null,
    "host": null,
    "imports": [

    ],
    "object_name": "Windows Agent OS-Basic",
    "object_type": "template",
    "vars": {

    }
}
'


####
# Service Objects
####
#
#Service objects
#
   icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "agent-connected"
    ],
    "object_name": "Icinga Agent connected",
    "object_type": "object",
    "service_set": "Windows Agent OS-Basic",
    "use_agent": false
}
'

   icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "windows-memory"
    ],
    "object_name": "Agent Win Memory",
    "object_type": "object",
    "service_set": "Windows Agent OS-Basic",
    "use_agent": true
}
'

   icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "windows-cpu"
    ],
    "object_name": "Agent Win CPU",
    "object_type": "object",
    "service_set": "Windows Agent OS-Basic",
    "use_agent": true
}
'



   icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "windows-diskspace"
    ],
    "object_name": "Agent Win Diskspace",
    "object_type": "object",
    "service_set": "Windows Agent OS-Basic",
    "use_agent": true
}
'

#Service objects
   icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "windows-generic-service"
    ],
    "object_name": "Agent WinService Spooler",
    "object_type": "object",
    "service_set": "Windows Agent OS-Basic",
    "use_agent": true
}
'

fi



