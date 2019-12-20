#
#Services (as template)
# HowTo Export:
# # icingacli director service show Agent_Win_Service --json
#


# Pre-Requisites: Command: Powershell and service template "generic-agent-powershell"
RES=`icingacli director service exists "generic-agent-powershell"`
if [[ $RES =~ "does not exist" ]]
then

   echo "Service template 'generic-agent-powershell' does not exists This is a pre-requisite.".
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
RES=`icingacli director service exists "generic-agent-powershell_exchange"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'generic-agent-powershell_exchange' does not exists"
   icingacli director service create --json '
{
    "check_command": "powershell",
    "imports": [
        "generic-agent-powershell"
    ],
    "object_name": "generic-agent-powershell_exchange",
    "object_type": "template"
}
'
fi

# NSCP Services check: Windows Services "Exchange Services"
RES=`icingacli director service exists "Exchange Services"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'Exchange Services' does not exists"
   icingacli director service create --json '
   {
    "imports": [
        "Agent_Win_NscpServices"
    ],
    "object_name": "Exchange Services",
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
RES=`icingacli director service exists "Exchange2016 Mailbox Health status"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'Exchange2016 Mailbox Health status' does not exists"
   icingacli director service create --json '
{
    "imports": [
        "generic-agent-powershell_exchange"
    ],
    "object_name": "Exchange2016 Mailbox Health status",
    "object_type": "template",
    "vars": {
        "exchange2016_powershell": "exchange-QueueHealth.ps1",
        "powershell_script": "MailboxHealth.ps1"
    }
}
'
fi

# Service Template
RES=`icingacli director service exists "Exchange2016 FullBackup status"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'Exchange2016 FullBackup status' does not exists"
   icingacli director service create --json '
{
    "imports": [
        "generic-agent-powershell_exchange"
    ],
    "object_name": "Exchange2016 FullBackup status",
    "object_type": "template",
    "vars": {
        "exchange2016_powershell": "exchange-QueueHealth.ps1",
        "powershell_script": "exchange-FullBackupMonitoring.ps1"
    }
}
'
fi

# Service Template
RES=`icingacli director service exists "Exchange2016 IncrementalBackup status"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'Exchange2016 IncrementalBackup status' does not exists"
   icingacli director service create --json '
{
    "imports": [
        "generic-agent-powershell_exchange"
    ],
    "object_name": "Exchange2016 IncrementalBackup status",
    "object_type": "template",
    "vars": {
        "exchange2016_powershell": "exchange-QueueHealth.ps1",
        "powershell_script": "exchange-IncrementalBackupMonitoring.ps1"
    }
}
'
fi

# Service Template
RES=`icingacli director service exists "Exchange2016 QueueHealth status"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'Exchange2016 QueueHealth status' does not exists"
   icingacli director service create --json '
{
    "imports": [
        "generic-agent-powershell_exchange"
    ],
    "object_name": "Exchange2016 QueueHealth status",
    "object_type": "template",
    "vars": {
        "exchange2016_powershell": "exchange-QueueHealth.ps1",
        "powershell_script": "exchange-QueueHealth.ps1"
    }
}

'
fi

echo "[+] All Service Templates for Microsoft Exchange created"
exit 0
