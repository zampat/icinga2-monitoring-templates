# 
# Service template
# HowTo Export: icingacli director service show generic-agent-windows-perfcounter --json --no-defaults
#

# Pre-Requisites: generic-agent-windows-perfcounter (former Agent_Win_Counter)
# Service Template 
RES=`icingacli director service exists "generic-agent-windows-perfcounter"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service template 'generic-agent-windows-perfcounter' does not exists This is a pre-requisite.".
   echo "Please import this Service template from service windows templates.".
   exit 3
fi
   
   
# Example of NSCP Service Query
#
RES=`icingacli director service exists "windows-nscp-service-ax aos"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'windows-nscp-service-ax aos' does not exists"
   icingacli director service create --json '
{
    "imports": [
        "windows-nscp-service"
    ],
    "object_name": "windows-nscp-service-ax aos",
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
RES=`icingacli director service exists "windows-perfcounter-ax aos active sessions"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'windows-perfcounter-ax aos active sessions' does not exists"
   icingacli director service create --json '
   {
    "imports": [
        "generic-agent-windows-perfcounter"
    ],
    "object_name": "windows-perfcounter-ax aos active sessions",
    "object_type": "template",
    "use_agent": true,
    "vars": {
        "nscp_counter_name": "\\Microsoft Dynamics AX Object Server(*)\\ACTIVE SESSIONS"
    }
}
'
fi

RES=`icingacli director service exists "windows-perfcounter-ax aos bytes received by server"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'windows-perfcounter-ax aos bytes received by server' does not exists"
   icingacli director service create --json '
   {
    "imports": [
        "generic-agent-windows-perfcounter"
    ],
    "object_name": "windows-perfcounter-ax aos bytes received by server",
    "object_type": "template",
    "use_agent": true,
    "vars": {
        "nscp_counter_name": "\\Microsoft Dynamics AX Object Server(*)\\NUMBER OF BYTES RECEIVED BY SERVER"
    }
}
'
fi

RES=`icingacli director service exists "windows-perfcounter-ax aos bytes sent by server"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'windows-perfcounter-ax aos bytes sent by server' does not exists"
   icingacli director service create --json '
  {
    "imports": [
        "generic-agent-windows-perfcounter"
    ],
    "object_name": "windows-perfcounter-ax aos bytes sent by server",
    "object_type": "template",
    "use_agent": true,
    "vars": {
        "nscp_counter_name": "\\Microsoft Dynamics AX Object Server(*)\\NUMBER OF BYTES SENT BY SERVER"
    }
}
'
fi

RES=`icingacli director service exists "windows-perfcounter-ax aos client requests"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'windows-perfcounter-ax aos client requests' does not exists"
   icingacli director service create --json '
  {
    "imports": [
        "generic-agent-windows-perfcounter"
    ],
    "object_name": "windows-perfcounter-ax aos client requests",
    "object_type": "template",
    "use_agent": true,
    "vars": {
        "nscp_counter_name": "\\Microsoft Dynamics AX Object Server(*)\\NUMBER OF CLIENT REQUESTS"
    }
}
'
fi


RES=`icingacli director service exists "windows-perfcounter-ax aos client requests/sec"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'windows-perfcounter-ax aos client requests/sec' does not exists"
   icingacli director service create --json '
  {
    "imports": [
        "generic-agent-windows-perfcounter"
    ],
    "object_name": "windows-perfcounter-ax aos client requests/sec",
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
