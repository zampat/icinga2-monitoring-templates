# 
#Services (as template)
# HowTo Export:
# # icingacli director service show Agent_Win_Service --json
#


# Pre-Requisites: generic-agent-windows-perfcounter
# Service Template generic-agent-windows-perfcounter
RES=`icingacli director service exists "generic-agent-windows-perfcounter"`
if [[ $RES =~ "does not exist" ]]
then

   echo "Service template 'generic-agent-windows-perfcounter' does not exists This is a pre-requisite.".
   echo "Please import this Service template from service windows templates.".
   exit 3
fi
   
   
######
## Services for Windwows SQL Server
######

# Service Template generic-mssql
RES=`icingacli director service exists "generic-mssql"`
if [[ $RES =~ "does not exist" ]]
then

   echo "Service 'generic-mssql' does not exists"
   icingacli director service create --json '
{
    "check_command": "mssql_health",
    "imports": [
        "generic-active-service"
    ],
    "object_name": "generic-mssql",
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
        "generic-mssql"
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


# Service Template generic-mssql
RES=`icingacli director service exists "MSSQL_Transactions/sec"`
if [[ $RES =~ "does not exist" ]]
then

   echo "Service 'MSSQL_Transactions/sec' does not exists"
   icingacli director service create --json '
{
    "check_command": "mssql_health",
    "imports": [
        "generic-mssql"
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
