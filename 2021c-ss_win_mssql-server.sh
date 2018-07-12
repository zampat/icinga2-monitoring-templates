
###
# Create Service Set: "Windows_MSSQL-Server"
###
# Service Template for Service Set
RES=`icingacli director serviceset exists "Windows_MSSQL-Server"`
if [[ $RES =~ "does not exist" ]]
then


icingacli director serviceset create --json '
{
    "object_name": "Windows_MSSQL-Server",
    "object_type": "template",
    "vars": {
    }
}
'



####
# Service Objects: MSSQL Connections, MSSQL_Transactions/sec
####
   icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "MSSQL_Connections"
    ],
    "object_name": "MSSQL Connections",
    "object_type": "object",
    "service_set": "Windows_MSSQL-Server",
    "use_agent": true
}
'
 
    icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "MSSQL_Transactions/sec"
    ],
    "object_name": "MSSQL_Transactions/sec",
    "object_type": "object",
    "service_set": "Windows_MSSQL-Server",
    "use_agent": true
}
'
 
	icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "Agent_Win_Service"
    ],
    "object_name": "MSSQL Services",
    "object_type": "object",
	"service_set": "Windows_MSSQL-Server",
    "vars": {
        "service_win_service": [
            "MSSQLSERVER, SQLWriter, MSSQLFDLauncher"
        ]
    }
}
'

fi



