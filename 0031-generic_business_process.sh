#
#Service template Level 1
# HowTo Export:
# icingacli director service show generic-service --json --no-defaults
#

RES=`icingacli director service exists "generic_business_process"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'generic_business_process' does not exists"

icingacli director service create generic_business_process --json '
{
    "check_command": "icingacli-businessprocess",
    "check_interval": "60",
    "check_timeout": "50",
    "imports": [
        "generic-service"
    ],
    "max_check_attempts": "2",
    "object_name": "generic_business_process",
    "object_type": "template",
    "retry_interval": "30",
    "vars": {
        "icingacli_businessprocess_details": true
    }
}
'
fi

echo "Generic Business Process created"
