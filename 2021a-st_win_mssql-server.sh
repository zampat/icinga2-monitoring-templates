# 
#Services (as template)
# HowTo Export:
# # icingacli director service show Agent_Win_Service --json
#


# Pre-Requisites: Agent_Win_Counter
# Service Template Agent_Win_Counter
RES=`icingacli director service exists "Agent_Win_Counter"`
if [[ $RES =~ "does not exist" ]]
then

   echo "Service template 'Agent_Win_Counter' does not exists This is a pre-requisite.".
   echo "Please import this Service template from service windows templates.".
   exit 3
fi
   
   
######
## Services for Windwows SQL Server
######

# Service Template generic_MSSQL
RES=`icingacli director service exists "generic_MSSQL"`
if [[ $RES =~ "does not exist" ]]
then

   echo "Service 'generic_MSSQL' does not exists"
   icingacli director service create --json '
{
    "check_command": "mssql_health",
    "imports": [
        "generic_service"
    ],
    "object_name": "generic_MSSQL",
    "object_type": "template",
    "vars": {
        "mssql_health_hostname": "$address$",
        "mssql_health_mode": "connection-time",
        "mssql_health_password": "secret",
        "mssql_health_username": "username"
    }
}
'
fi

# Service Template MSSQL_Connections
RES=`icingacli director service exists "MSSQL_Connections"`
if [[ $RES =~ "does not exist" ]]
then

   echo "Service 'MSSQL_Connections' does not exists"
   icingacli director service create --json '
{
    "check_command": "mssql_health",
    "imports": [
        "generic_MSSQL"
    ],
    "object_name": "MSSQL_Connections",
    "object_type": "template",
    "vars": {
        "mssql_health_critical": 8,
        "mssql_health_mode": "connection-time",
        "mssql_health_warning": 3
    }
}
'
fi


# Service Template generic_MSSQL
RES=`icingacli director service exists "MSSQL_Transactions/sec"`
if [[ $RES =~ "does not exist" ]]
then

   echo "Service 'MSSQL_Transactions/sec' does not exists"
   icingacli director service create --json '
{
    "check_command": "mssql_health",
    "imports": [
        "generic_MSSQL"
    ],
    "object_name": "MSSQL_Transactions\/sec",
    "object_type": "template",
    "vars": {
        "mssql_health_mode": "transactions"
    }
}
'
fi



echo "MSSQL Services created"
exit 0
