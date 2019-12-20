
# 
#Service Templates for particular linux distriutions (as template)
# HowTo Export:
# # icingacli director service show Agent_Win_Service --json
#


######
## Services for Linux monitoring with Icinga Agent
######

# Service Template for Service Set
RES=`icingacli director service exists "Agent_Debian_APT-Update_available"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'Agent_Debian_APT-Update_available' does not exists"
   icingacli director service create --json '
{
    "check_command": "apt",
    "imports": [
        "generic-agent"
    ],
    "object_name": "Agent_Debian_APT-Update_available",
    "object_type": "template",
    "vars": {
        "apt_only_critical": false
    }
}
'
fi
