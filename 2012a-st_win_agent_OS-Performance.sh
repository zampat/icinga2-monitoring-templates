# 
#Services (as template)
# HowTo Export:
# icingacli director service show Agent_WinCnt --json --no-defaults
#

# Requirements Check
RES=` icingacli director service show Agent_WinCnt --json --no-defaults`
if [[ $RES =~ "does not exist" ]]
then
   echo "Prerequisite failure: Service Template 'Agent_WinCnt' does not exists. Abort import of OS-Performance."
   exit 0
fi


# Import of Service Template
RES=`icingacli director service exists "Agent_WinCnt_PagingFile_%Usage"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'Agent_WinCnt_PagingFile_%Usage' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-counter",
    "imports": [
        "Agent_WinCnt"
    ],
    "object_name": "Agent_WinCnt_PagingFile_%Usage",
    "object_type": "template",
    "vars": {
        "nscp_counter_critical": "90",
        "nscp_counter_name": "\\Paging File(_Total)\\% Usage",
        "nscp_counter_warning": "80"
    }
}
'
fi

# Import of Service Template
RES=`icingacli director service exists "Agent_WinCnt_Processor_%InterruptTime"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'Agent_WinCnt_Processor_%InterruptTime' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-counter",
    "imports": [
        "Agent_WinCnt"
    ],
    "object_name": "Agent_WinCnt_Processor_%InterruptTime",
    "object_type": "template",
    "vars": {
        "nscp_counter_critical": "90",
        "nscp_counter_name": "\\Processor(_Total)\\% Interrupt Time",
        "nscp_counter_warning": "80"
    }
}
'
fi

# Import of Service Template
RES=`icingacli director service exists "Agent_WinCnt_DiskQueueLength"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'Agent_WinCnt_DiskQueueLength' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-counter",
    "imports": [
        "Agent_WinCnt"
    ],
    "object_name": "Agent_WinCnt_DiskQueueLength",
    "object_type": "template",
    "vars": {
        "nscp_counter_critical": "10",
        "nscp_counter_name": "\\PhysicalDisk(_Total)\\Avg. Disk Queue Length",
        "nscp_counter_warning": "20"
    }
}
'
fi

# Import of Service Template
RES=`icingacli director service exists "Agent_WinCnt_DiskReadBytes/sec"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'Agent_WinCnt_DiskReadBytes/sec' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-counter",
    "imports": [
        "Agent_WinCnt"
    ],
    "object_name": "Agent_WinCnt_DiskReadBytes\/sec",
    "object_type": "template",
    "vars": {
        "nscp_counter_name": "\\PhysicalDisk(_Total)\\Disk Read Bytes\/sec"
    }
}
'
fi

# Import of Service Template
RES=`icingacli director service exists "Agent_WinCnt_DiskWriteBytes/sec"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'Agent_WinCnt_DiskWriteBytes/sec' does not exists"
   icingacli director service create --json '
   {
    "check_command": "nscp-local-counter",
    "imports": [
        "Agent_WinCnt"
    ],
    "object_name": "Agent_WinCnt_DiskWriteBytes\/sec",
    "object_type": "template",
    "use_agent": true,
    "vars": {
        "nscp_counter_name": "\\PhysicalDisk(_Total)\\Disk Write Bytes\/sec"
    }
}
'
fi

# Import of Service Template
RES=`icingacli director service exists "Agent_WinCnt_Processor_%PrivilegedTime"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'Agent_WinCnt_Processor_%PrivilegedTime' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-counter",
    "imports": [
        "Agent_WinCnt"
    ],
    "object_name": "Agent_WinCnt_Processor_%PrivilegedTime",
    "object_type": "template",
    "vars": {
        "nscp_counter_name": "\\Processor(_Total)\\% Privileged Time"
    }
}
'
fi

# Import of Service Template
RES=`icingacli director service exists "Agent_WinCnt_Processor_%ProcessorTime"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'Agent_WinCnt_Processor_%ProcessorTime' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-counter",
    "imports": [
        "Agent_WinCnt"
    ],
    "object_name": "Agent_WinCnt_Processor_%ProcessorTime",
    "object_type": "template",
    "vars": {
        "nscp_counter_name": "\\Processor(_Total)\\% Processor Time"
    }
}
'
fi

# Import of Service Template
RES=`icingacli director service exists "Agent_WinCnt_Processor_Interrupts/sec"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'Agent_WinCnt_Processor_Interrupts/sec' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-counter",
    "imports": [
        "Agent_WinCnt"
    ],
    "object_name": "Agent_WinCnt_Processor_Interrupts\/sec",
    "object_type": "template",
    "vars": {
        "nscp_counter_name": "\\Processor(_Total)\\Interrupts\/sec"
    }
}
'
fi

# Import of Service Template
RES=`icingacli director service exists "Agent_WinCnt_PagingFile_%UsagePeak"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'Agent_WinCnt_PagingFile_%UsagePeak' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-counter",
    "imports": [
        "Agent_WinCnt"
    ],
    "object_name": "Agent_WinCnt_PagingFile_%UsagePeak",
    "object_type": "template",
    "vars": {
        "nscp_counter_name": "\\Paging File(_Total)\\% Usage Peak"
    }
}
'
fi

echo "Done: 2012a-st_win_agent_OS-Performance"
exit 0
