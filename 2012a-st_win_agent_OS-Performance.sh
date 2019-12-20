# 
#Services (as template)
# HowTo Export:
# icingacli director service show generic-agent-windows-perfcounter --json --no-defaults
#

# Requirements Check
RES=` icingacli director service show generic-agent-windows-perfcounter --json --no-defaults`
if [[ $RES =~ "does not exist" ]]
then
   echo "Prerequisite failure: Service Template 'generic-agent-windows-perfcounter' does not exists. Abort import of OS-Performance."
   exit 0
fi


# Import of Service Template
RES=`icingacli director service exists "PerfCounter-PagingFile_%Usage"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'PerfCounter-PagingFile_%Usage' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-counter",
    "imports": [
        "generic-agent-windows-perfcounter"
    ],
    "object_name": "PerfCounter-PagingFile_%Usage",
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
RES=`icingacli director service exists "PerfCounter-Processor_%InterruptTime"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'PerfCounter-Processor_%InterruptTime' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-counter",
    "imports": [
        "generic-agent-windows-perfcounter"
    ],
    "object_name": "PerfCounter-Processor_%InterruptTime",
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
RES=`icingacli director service exists "PerfCounter-DiskQueueLength"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'PerfCounter-DiskQueueLength' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-counter",
    "imports": [
        "generic-agent-windows-perfcounter"
    ],
    "object_name": "PerfCounter-DiskQueueLength",
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
RES=`icingacli director service exists "PerfCounter-DiskReadBytes/sec"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'PerfCounter-DiskReadBytes/sec' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-counter",
    "imports": [
        "generic-agent-windows-perfcounter"
    ],
    "object_name": "PerfCounter-DiskReadBytes\/sec",
    "object_type": "template",
    "vars": {
        "nscp_counter_name": "\\PhysicalDisk(_Total)\\Disk Read Bytes\/sec"
    }
}
'
fi

# Import of Service Template
RES=`icingacli director service exists "PerfCounter-DiskWriteBytes/sec"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'PerfCounter-DiskWriteBytes/sec' does not exists"
   icingacli director service create --json '
   {
    "check_command": "nscp-local-counter",
    "imports": [
        "generic-agent-windows-perfcounter"
    ],
    "object_name": "PerfCounter-DiskWriteBytes\/sec",
    "object_type": "template",
    "use_agent": true,
    "vars": {
        "nscp_counter_name": "\\PhysicalDisk(_Total)\\Disk Write Bytes\/sec"
    }
}
'
fi

# Import of Service Template
RES=`icingacli director service exists "PerfCounter-Processor_%PrivilegedTime"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'PerfCounter-Processor_%PrivilegedTime' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-counter",
    "imports": [
        "generic-agent-windows-perfcounter"
    ],
    "object_name": "PerfCounter-Processor_%PrivilegedTime",
    "object_type": "template",
    "vars": {
        "nscp_counter_name": "\\Processor(_Total)\\% Privileged Time"
    }
}
'
fi

# Import of Service Template
RES=`icingacli director service exists "PerfCounter-Processor_%ProcessorTime"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'PerfCounter-Processor_%ProcessorTime' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-counter",
    "imports": [
        "generic-agent-windows-perfcounter"
    ],
    "object_name": "PerfCounter-Processor_%ProcessorTime",
    "object_type": "template",
    "vars": {
        "nscp_counter_name": "\\Processor(_Total)\\% Processor Time"
    }
}
'
fi

# Import of Service Template
RES=`icingacli director service exists "PerfCounter-Processor_Interrupts/sec"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'PerfCounter-Processor_Interrupts/sec' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-counter",
    "imports": [
        "generic-agent-windows-perfcounter"
    ],
    "object_name": "PerfCounter-Processor_Interrupts\/sec",
    "object_type": "template",
    "vars": {
        "nscp_counter_name": "\\Processor(_Total)\\Interrupts\/sec"
    }
}
'
fi

# Import of Service Template
RES=`icingacli director service exists "PerfCounter-PagingFile_%UsagePeak"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'PerfCounter-PagingFile_%UsagePeak' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-counter",
    "imports": [
        "generic-agent-windows-perfcounter"
    ],
    "object_name": "PerfCounter-PagingFile_%UsagePeak",
    "object_type": "template",
    "vars": {
        "nscp_counter_name": "\\Paging File(_Total)\\% Usage Peak"
    }
}
'
fi

echo "Done: 2012a-st_win_agent_OS-Performance"
exit 0
