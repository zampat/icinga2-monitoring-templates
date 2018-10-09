# 
# Service template
# HowTo Export: icingacli director service show Agent_WinCnt --json --no-defaults
#

# Pre-Requisites: Agent_WinCnt (former Agent_Win_Counter)
# Service Template 
RES=`icingacli director service exists "Agent_WinCnt"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service template 'Agent_WinCnt' does not exists This is a pre-requisite.".
   echo "Please import this Service template from service windows templates.".
   exit 3
fi
   
   
# Example of NSCP Service Query
#
RES=`icingacli director service exists "AX AOS Services"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'AX AOS Services' does not exists"
   icingacli director service create --json '
{
    "imports": [
        "Agent_Win_NscpServiceQuery"
    ],
    "object_name": "AX AOS Services",
    "object_type": "template",
    "vars": {
        "nscp_service_arguments": "filter=name like \"AOS\"",
        "nscp_showall": true
    }
}
'
fi
   
######
## Counters for Windows AX AOS Monitoring
######
RES=`icingacli director service exists "AOS_Active_Sessions"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'AOS_Active_Sessions' does not exists"
   icingacli director service create --json '
   {
    "imports": [
        "Agent_WinCnt"
    ],
    "object_name": "AOS_Active_Sessions",
    "object_type": "template",
    "use_agent": true,
    "vars": {
        "nscp_counter_name": "\\Microsoft Dynamics AX Object Server(*)\\ACTIVE SESSIONS"
    }
}
'
fi

RES=`icingacli director service exists "AOS_BYTES_RECEIVED_BY_SERVER"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'AOS_BYTES_RECEIVED_BY_SERVER' does not exists"
   icingacli director service create --json '
   {
    "imports": [
        "Agent_WinCnt"
    ],
    "object_name": "AOS_BYTES_RECEIVED_BY_SERVER",
    "object_type": "template",
    "use_agent": true,
    "vars": {
        "nscp_counter_name": "\\Microsoft Dynamics AX Object Server(*)\\NUMBER OF BYTES RECEIVED BY SERVER"
    }
}
'
fi

RES=`icingacli director service exists "AOS_BYTES_SENT_BY_SERVER"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'AOS_BYTES_SENT_BY_SERVER' does not exists"
   icingacli director service create --json '
  {
    "imports": [
        "Agent_WinCnt"
    ],
    "object_name": "AOS_BYTES_SENT_BY_SERVER",
    "object_type": "template",
    "use_agent": true,
    "vars": {
        "nscp_counter_name": "\\Microsoft Dynamics AX Object Server(*)\\NUMBER OF BYTES SENT BY SERVER"
    }
}
'
fi

RES=`icingacli director service exists "AOS_CLIENT_REQUESTS"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'AOS_CLIENT_REQUESTS' does not exists"
   icingacli director service create --json '
  {
    "imports": [
        "Agent_WinCnt"
    ],
    "object_name": "AOS_CLIENT_REQUESTS",
    "object_type": "template",
    "use_agent": true,
    "vars": {
        "nscp_counter_name": "\\Microsoft Dynamics AX Object Server(*)\\NUMBER OF CLIENT REQUESTS"
    }
}
'
fi


RES=`icingacli director service exists "AOS_CLIENT_REQUESTS/SEC"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'AOS_CLIENT_REQUESTS/SEC' does not exists"
   icingacli director service create --json '
  {
    "imports": [
        "Agent_WinCnt"
    ],
    "object_name": "AOS_CLIENT_REQUESTS/SEC",
    "object_type": "template",
    "use_agent": true,
    "vars": {
        "nscp_counter_name": "\\Microsoft Dynamics AX Object Server(*)\\NUMBER OF CLIENT REQUESTS PER SECOND"
    }
}
'
fi


echo "AX-AOS Service templates created"
exit 0
