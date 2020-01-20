# 
#Services (as template)
# HowTo Export:
# # icingacli director service show windows-generic-service --json
#


# Pre-Requisites: windows-nscp-perfcounter
# Service Template windows-nscp-perfcounter
RES=`icingacli director service exists "windows-nscp-perfcounter"`
if [[ $RES =~ "does not exist" ]]
then

   echo "Service template 'windows-nscp-perfcounter' does not exists This is a pre-requisite.".
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

# Service Template windows-mssql-connections
RES=`icingacli director service exists "windows-mssql-connections"`
if [[ $RES =~ "does not exist" ]]
then

   echo "Service 'windows-mssql-connections' does not exists"
   icingacli director service create --json '
{
    "check_command": "mssql_health",
    "imports": [
        "generic-mssql"
    ],
    "object_name": "windows-mssql-connections",
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
RES=`icingacli director service exists "windows-mssql-transactions/sec"`
if [[ $RES =~ "does not exist" ]]
then

   echo "Service 'windows-mssql-transactions/sec' does not exists"
   icingacli director service create --json '
{
    "check_command": "mssql_health",
    "imports": [
        "generic-mssql"
    ],
    "object_name": "windows-mssql-transactions\/sec",
    "object_type": "template",
    "vars": {
        "mssql_health_mode": "transactions"
    }
}
'
fi



echo "MSSQL Services created"
exit 0
