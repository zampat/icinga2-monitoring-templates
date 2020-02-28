#
#Services (as template)
# HowTo Export:
# # icingacli director service show windows-generic-service --json
#


# Pre-Requisites: Command: Powershell and service template "windows-powershell-generic"
RES=`icingacli director service exists "windows-powershell-generic"`
if [[ $RES =~ "does not exist" ]]
then

   echo "Service template 'windows-powershell-generic' does not exists This is a pre-requisite.".
   echo "Please import this Service template from service windows templates.".
   exit 3
fi


# HTTP Exchange
#
RES=`icingacli director service exists "https_exchange_owa"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Command 'https_exchange_owa' does not exists"
   icingacli director service create https_exchange_owa --json '
{
    "imports": [
        "http_website_availability"
    ],
    "object_name": "https_exchange_owa",
    "object_type": "template",
    "vars": {
        "http_ssl": true
    }
}
'
fi


######
## Services for Windwows Exchange
######
# Service template for Exchange via PowerShell
#
RES=`icingacli director service exists "windows-powershell_exchange"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'windows-powershell_exchange' does not exists"
   icingacli director service create --json '
{
    "check_command": "powershell",
    "imports": [
        "windows-powershell-generic"
    ],
    "object_name": "windows-powershell_exchange",
    "object_type": "template"
}
'
fi

# NSCP Services check: Windows Services "windows-nscp-service-exchange"
RES=`icingacli director service exists "windows-nscp-service-exchange"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'windows-nscp-service-exchange' does not exists"
   icingacli director service create --json '
   {
    "imports": [
        "windows-nscp-generic-service"
    ],
    "object_name": "windows-nscp-service-exchange",
    "object_type": "template",
    "vars": {
        "nscp_service_name": [
            "MSExchangeADTopology",
            "MSExchangeAntispamUpdate",
                        "MSComplianceAudit",
                        "MSExchangeCompliance",
                        "MSExchangeDagMgmt",
                        "MSExchangeDiagnostics",
                        "MSExchangeEdgeSync",
                        "MSExchangeFrontEndTransport",
                        "MSExchangeHM",
                        "MSExchangeHMRecovery",
                        "MSExchangeIS",
                        "MSExchangeMailboxAssistants",
                        "MSExchangeMailboxReplication",
                        "MSExchangeDelivery",
                        "MSExchangeSubmission",
                        "MSExchangeRepl",
                        "MSExchangeRPC",
                        "MSExchangeFastSearch",
                        "HostControllerService",
                        "MSExchangeServiceHost",
                        "MSExchangeThrottling",
                        "MSExchangeTransport",
                        "MSExchangeTransportLogSearch",
                        "MSExchangeUM",
                        "MSExchangeUMCR",
                        "FMS"
        ],
        "nscp_showall": true
    }
}
'
fi



######
## PowerShell: Services for Windwows Exchange
######

# Service Template
RES=`icingacli director service exists "windows-exchange2016 mailbox health"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'windows-exchange2016 mailbox health' does not exists"
   icingacli director service create --json '
{
    "imports": [
        "windows-powershell_exchange"
    ],
    "object_name": "windows-exchange2016 mailbox health",
    "object_type": "template",
    "vars": {
        "powershell_script": "MailboxHealth.ps1"
    }
}
'
fi

# Service Template
RES=`icingacli director service exists "windows-exchange2016 full backup"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'windows-exchange2016 full backup' does not exists"
   icingacli director service create --json '
{
    "imports": [
        "windows-powershell_exchange"
    ],
    "object_name": "windows-exchange2016 full backup",
    "object_type": "template",
    "vars": {
        "powershell_script": "exchange-FullBackupMonitoring.ps1"
    }
}
'
fi

# Service Template
RES=`icingacli director service exists "windows-exchange2016 incremental backup"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'windows-exchange2016 incremental backup' does not exists"
   icingacli director service create --json '
{
    "imports": [
        "windows-powershell_exchange"
    ],
    "object_name": "windows-exchange2016 incremental backup",
    "object_type": "template",
    "vars": {
        "powershell_script": "exchange-IncrementalBackupMonitoring.ps1"
    }
}
'
fi

# Service Template
RES=`icingacli director service exists "windows-exchange2016 queue health"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'windows-exchange2016 queue health' does not exists"
   icingacli director service create --json '
{
    "imports": [
        "windows-powershell_exchange"
    ],
    "object_name": "windows-exchange2016 queue health",
    "object_type": "template",
    "vars": {
        "powershell_script": "exchange-QueueHealth.ps1"
    }
}

'
fi

echo "[+] All Service Templates for Microsoft Exchange created"
exit 0
