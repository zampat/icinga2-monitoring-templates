
# 
#Service Templates for particular linux distriutions (as template)
# HowTo Export:
# # icingacli director service show windows-generic-service --json
#


######
## Services for Linux monitoring with Icinga Agent
######

# Service Template for Service Set
RES=`icingacli director service exists "linux-debian-apt-update-available"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'linux-debian-apt-update-available' does not exists"
   icingacli director service create --json '
{
    "check_command": "apt",
    "imports": [
        "generic-agent"
    ],
    "object_name": "linux-debian-apt-update-available",
    "object_type": "template",
    "vars": {
        "apt_only_critical": false
    }
}
'
fi
