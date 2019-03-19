#
#Service template: Oracle Health
#

#
#Service template
#
RES=`icingacli director command exists "check_oracle_health"`
if [[ $RES =~ "does not exist" ]]
then

   echo "Service 'check_oracle_health' does not exists"
   icingacli director command create check_oracle_health --json '
{
    "arguments": {
        "--connect": {
            "required": true,
            "set_if_format": "string",
            "skip_key": false,
            "value": "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=$host.address$)(Port=1521))(CONNECT_DATA=(SID=$oracle_health_sid$)))"
        },
        "--environment": {
            "set_if_format": "string",
            "value": "ORACLE_HOME=\/usr\/lib\/oracle\/18.5\/client64"
        },
        "--method": {
            "set_if_format": "string",
            "value": "sqlplus"
        },
        "--mode": {
            "set_if_format": "string",
            "value": "$oracle_health_mode$"
        },
        "--password": {
            "set_if_format": "string",
            "value": "$oracle_health_password$"
        },
        "--user": {
            "set_if_format": "string",
            "value": "$oracle_health_username$"
        },
        "-t": {
            "set_if_format": "string",
            "value": "120"
        }
    },
    "command": "PluginDir + \/check_oracle_health",
    "methods_execute": "PluginCheck",
    "object_name": "check_oracle_health",
    "object_type": "object"
}
'
fi

