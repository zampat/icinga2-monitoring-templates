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
        "mssql_health_report": "long",
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


# Service Template windows-mssql-database_free
RES=`icingacli director service exists "mssql-database-free"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'windows-mssql-database_free' does not exists"
   icingacli director service create --json '
{
    "imports": [
        "generic-mssql"
    ],
    "object_name": "mssql-database-free",
    "object_type": "template",
    "vars": {
        "mssql_health_critical": "3:",
        "mssql_health_mode": "database-data-free",
	"mssql_health_name": "^(?!(tempdb|model))",
        "mssql_health_regexp": true,
        "mssql_health_units": "%",
        "mssql_health_warning": "8:"
    }
}
'
fi

# Service Template for Service Set
OBJ="mssql-database-log-free"
RES=`icingacli director service exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service '$OBJ' does not exists"
   icingacli director service create --json '
{
    "imports": [
        "generic-mssql"
    ],
    "object_name": "mssql-database-log-free",
    "object_type": "template",
    "vars": {
        "mssql_health_critical": "5:",
        "mssql_health_mode": "database-log-free",
        "mssql_health_name": "^(?!(tempdb|model))",
        "mssql_health_regexp": true,
        "mssql_health_warning": "10:"
    }
}
'
fi

# Service Template for Service Set
OBJ="mssql-failed-jobs-last-hour"
RES=`icingacli director service exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service '$OBJ' does not exists"
   icingacli director service create --json '
{
    "check_interval": "3600",
    "imports": [
        "generic-mssql"
    ],
    "object_name": "mssql-failed-jobs-last-hour",
    "object_type": "template",
    "vars": {
        "mssql_health_critical": "300",
        "mssql_health_lookback": 720,
        "mssql_health_mode": "failed-jobs",
        "mssql_health_warning": "90"
    }
}'
fi

# Service Template for Service Set
OBJ="mssql-backup-age-in-hours"
RES=`icingacli director service exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service '$OBJ' does not exists"
   icingacli director service create --json '
{
    "check_interval": "43200",
    "imports": [
        "generic-mssql"
    ],
    "object_name": "mssql-backup-age-in-hours",
    "object_type": "template",
    "retry_interval": "3600",
    "vars": {
        "mssql_health_mode": "database-backup-age",
        "mssql_health_name": "^(?!(tempdb))",
        "mssql_health_regexp": true
    }
}
'
fi

# Service Template for Service Set
OBJ="mssql-performance-longRecheck"
RES=`icingacli director service exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service '$OBJ' does not exists"
   icingacli director service create --json '
{
    "check_command": "mssql_health",
    "check_interval": "600",
    "imports": [
        "generic-mssql"
    ],
    "max_check_attempts": "3",
    "object_name": "mssql-performance-longRecheck",
    "object_type": "template",
    "retry_interval": "600"
}'
fi

echo "MSSQL Services created"
exit 0
