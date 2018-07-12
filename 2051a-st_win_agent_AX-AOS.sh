# 
#Services (as template)
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
RES=`icingacli director service exists "Agent_WinCnt_AOS_Active_Sessions"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'Agent_WinCnt_AOS_Active_Sessions' does not exists"
   icingacli director service create --json '
   {
    "imports": [
        "Agent_WinCnt"
    ],
    "object_name": "Agent_WinCnt_AOS_Active_Sessions",
    "object_type": "template",
    "use_agent": true,
    "vars": {
        "nscp_counter_name": "\Microsoft Dynamics AX Object Server(*)\ACTIVE SESSIONS"
    }
}
'
fi

RES=`icingacli director service exists "Agent_Win_Counter_AOS_NUMBER OF BYTES RECEIVED BY SERVER"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'Agent_Win_Counter_AOS_NUMBER OF BYTES RECEIVED BY SERVER' does not exists"
   icingacli director service create --json '
   {
    "imports": [
        "Agent_WinCnt"
    ],
    "object_name": "Agent_Win_Counter_AOS_NUMBER OF BYTES RECEIVED BY SERVER",
    "object_type": "template",
    "use_agent": true,
    "vars": {
        "nscp_counter_name": "\Microsoft Dynamics AX Object Server(*)\NUMBER OF BYTES RECEIVED BY SERVER"
    }
}
'
fi

RES=`icingacli director service exists "Agent_Win_Counter_AOS_NUMBER OF BYTES SENT BY SERVER"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'Agent_Win_Counter_AOS_NUMBER OF BYTES SENT BY SERVER' does not exists"
   icingacli director service create --json '
  {
    "imports": [
        "Agent_WinCnt"
    ],
    "object_name": "Agent_Win_Counter_AOS_NUMBER OF BYTES SENT BY SERVER",
    "object_type": "template",
    "use_agent": true,
    "vars": {
        "nscp_counter_name": "\Microsoft Dynamics AX Object Server(*)\NUMBER OF BYTES SENT BY SERVER"
    }
}
'
fi

RES=`icingacli director service exists "Agent_Win_Counter_AOS_NUMBER OF CLIENT REQUESTS"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'Agent_Win_Counter_AOS_NUMBER OF CLIENT REQUESTS' does not exists"
   icingacli director service create --json '
  {
    "imports": [
        "Agent_WinCnt"
    ],
    "object_name": "Agent_Win_Counter_AOS_NUMBER OF CLIENT REQUESTS",
    "object_type": "template",
    "use_agent": true,
    "vars": {
        "nscp_counter_name": "\Microsoft Dynamics AX Object Server(*)\NUMBER OF CLIENT REQUESTS"
    }
}
'
fi


RES=`icingacli director service exists "Agent_Win_Counter_AOS_NUMBER OF CLIENT REQUESTS PER SECOND"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'Agent_Win_Counter_AOS_NUMBER OF CLIENT REQUESTS PER SECOND' does not exists"
   icingacli director service create --json '
  {
    "imports": [
        "Agent_WinCnt"
    ],
    "object_name": "Agent_Win_Counter_AOS_NUMBER OF CLIENT REQUESTS",
    "object_type": "template",
    "use_agent": true,
    "vars": {
        "nscp_counter_name": "\Microsoft Dynamics AX Object Server(*)\NUMBER OF CLIENT REQUESTS PER SECOND"
    }
}
'
fi

RES=`icingacli director service exists ""`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service '' does not exists"
   icingacli director service create --json '

'
fi

RES=`icingacli director service exists ""`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service '' does not exists"
   icingacli director service create --json '

'
fi

echo "AX-AOS Service templates created"
exit 0
