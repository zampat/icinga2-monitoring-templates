

###
# Create Service Set: "Windows_Agent_Exchange"
###
# Service Template for Service Set
RES=`icingacli director serviceset exists "Windows_Agent_Exchange"`
if [[ $RES =~ "does not exist" ]]
then
icingacli director serviceset create --json '
{
    "object_name": "Windows_Agent_Exchange",
    "object_type": "template"
}
'


####
# Services: Performance Data
####
icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "generic-agent-windows-perfcounter"
    ],
    "object_name": "MSExch2016 IS ActiveMailboxes",
    "object_type": "object",
    "service_set": "Windows_Agent_Exchange",
    "vars": {
        "nscp_counter_critical": "1000",
        "nscp_counter_name": "\\MSExchangeIS Store(_total)\\Active mailboxes",
        "nscp_counter_warning": "500",
        "nscp_modules": "CheckSystem",
		"nscp_query": "check_pdh"
    }
}
'

icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "generic-agent-windows-perfcounter"
    ],
    "object_name": "MSExch2016 AD Replication",
    "object_type": "object",
	"service_set": "Windows_Agent_Exchange",
    "vars": {
        "nscp_counter_critical": "1000",
        "nscp_counter_name": "\\MSExchange Mailbox Replication Service\\Resource Health: AD Replication",
        "nscp_counter_warning": "500",
        "nscp_modules": "CheckSystem",
	"nscp_query": "check_pdh"
    }
}
'

# Windows Services
icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "windows-nscp-service-exchange"
    ],
    "object_name": "MSExch2016 Exchange services",
    "object_type": "object",
	"service_set": "Windows_Agent_Exchange"
}
'

#Powershell Checks
icingacli director service create --json '
{
    "imports": [
        "windows-exchange2016 full backup"
    ],
    "object_name": "MSExch2016 full backup",
    "object_type": "object",
	"service_set": "Windows_Agent_Exchange"
}
'

icingacli director service create --json '
{
    "imports": [
        "windows-exchange2016 incremental backup"
    ],
    "object_name": "MSExch2016 incremental backup",
    "object_type": "object",
	"service_set": "Windows_Agent_Exchange"
}
'

icingacli director service create --json '
{
    "imports": [
        "windows-exchange2016 mailbox health"
    ],
    "object_name": "MSExch2016 mailbox health",
    "object_type": "object",
	"service_set": "Windows_Agent_Exchange"
}
'

icingacli director service create --json '
{
    "imports": [
        "windows-exchange2016 queue health"
    ],
    "object_name": "MSExch2016 queue health",
    "object_type": "object",
	"service_set": "Windows_Agent_Exchange"
}
'

######################
#HTTPS Checks
#Certificate
icingacli director service create --json '
{
    "imports": [
        "http_certificate_validity"
    ],
    "object_name": "HTTPS Certificate Validity",
    "object_type": "object",
	"service_set": "Windows_Agent_Exchange"
}
'

# HTTP 
icingacli director service create --json '
{
    "imports": [
        "https_exchange_owa"
    ],
    "object_name": "HTTP MSEX ActiveSync",
    "object_type": "object",
    "service_set": "Windows_Agent_Exchange",
    "vars": {
       "http_uri": "\/Microsoft-Server-ActiveSync\/HealthCheck.htm",
       "http_string": "OK"
    }
}
'
icingacli director service create --json '
{
    "imports": [
        "https_exchange_owa"
    ],
    "object_name": "HTTP MSEX Autodiscover",
    "object_type": "object",
    "service_set": "Windows_Agent_Exchange",
    "vars": {
       "http_uri": "\/Autodiscover\/HealthCheck.htm",
       "http_string": "OK"
    }
}
'

icingacli director service create --json '
{
    "imports": [
        "https_exchange_owa"
    ],
    "object_name": "HTTP MSEX MAPI",
    "object_type": "object",
    "service_set": "Windows_Agent_Exchange",
    "vars": {
       "http_uri": "\/MAPI\/HealthCheck.htm",
       "http_string": "OK"
    }
}
'

icingacli director service create --json '
{
    "imports": [
        "https_exchange_owa"
    ],
    "object_name": "HTTP MSEX OWA",
    "object_type": "object",
    "service_set": "Windows_Agent_Exchange",
    "vars": {
       "http_uri": "\/OWA\/HealthCheck.htm",
       "http_string": "OK"
    }
}
'



echo "[+] Service Set 'Windows_Agent_Exchange' created."
fi



