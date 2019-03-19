#
#Service template: Oracle Health
#

#
RES=`icingacli director service exists "generic_oracle_health"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'generic_oracle_health' does not exists"
   icingacli director service create generic_oracle_health --json '
{
    "check_command": "check_oracle_health",
    "object_name": "generic_oracle_health",
    "object_type": "template",
    "vars": {
        "oracle_health_mode": "connection-time",
        "oracle_health_password": "secret",
        "oracle_health_sid": "SID",
        "oracle_health_user": "username"
    }
}
'
fi


