
###
# Create Service Set: "Windows_Agent_OS-Basic"
###
# Service Template for Service Set
RES=`icingacli director serviceset exists "Windows_Agent_OS-Basic"`
if [[ $RES =~ "does not exist" ]]
then


icingacli director serviceset create --json '
{
    "assign_filter": null,
    "description": null,
    "host": null,
    "imports": [

    ],
    "object_name": "Windows_Agent_OS-Basic",
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
        "Agent_connected"
    ],
    "object_name": "Icinga Agent connected",
    "object_type": "object",
    "service_set": "Windows_Agent_OS-Basic",
    "use_agent": false
}
'

   icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "Agent_Win_Memory"
    ],
    "object_name": "Win Memory",
    "object_type": "object",
    "service_set": "Windows_Agent_OS-Basic",
    "use_agent": true
}
'

   icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "Agent_Win_CPU"
    ],
    "object_name": "Win CPU",
    "object_type": "object",
    "service_set": "Windows_Agent_OS-Basic",
    "use_agent": true
}
'



   icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "Agent_Win_Diskspace"
    ],
    "object_name": "Win Diskspace",
    "object_type": "object",
    "service_set": "Windows_Agent_OS-Basic",
    "use_agent": true
}
'

#Service objects
   icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "Agent_Win_Service"
    ],
    "object_name": "WinService Spooler",
    "object_type": "object",
    "service_set": "Windows_Agent_OS-Basic",
    "use_agent": true
}
'

fi



