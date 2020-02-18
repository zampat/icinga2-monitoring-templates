
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
# Service Objects: MSSQL Connections, windows-mssql-transactions/sec
####
   icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "windows-mssql-connections"
    ],
    "object_name": "MSSQL Connections",
    "object_type": "object",
    "service_set": "Windows_MSSQL-Server"
}
'
 
    icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "windows-mssql-transactions/sec"
    ],
    "object_name": "windows-mssql-transactions/sec",
    "object_type": "object",
    "service_set": "Windows_MSSQL-Server"
}
'
 
	icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "windows-nscp-generic-service"
    ],
    "object_name": "MSSQL Services",
    "object_type": "object",
    "service_set": "Windows_MSSQL-Server",
    "vars": {
        "nscp_service_name": [
            "MSSQLSERVER",
            "SQLWriter"
        ],
    },
    "use_agent": true
}
'

fi



