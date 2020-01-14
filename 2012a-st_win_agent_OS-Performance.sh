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
RES=`icingacli director service exists "windows-perfcounter-pagingfile %usage"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'windows-perfcounter-pagingfile %usage' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-counter",
    "imports": [
        "generic-agent-windows-perfcounter"
    ],
    "object_name": "windows-perfcounter-pagingfile %usage",
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
RES=`icingacli director service exists "windows-perfcounter-processor %interrupt time"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'windows-perfcounter-processor %interrupt time' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-counter",
    "imports": [
        "generic-agent-windows-perfcounter"
    ],
    "object_name": "windows-perfcounter-processor %interrupt time",
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
RES=`icingacli director service exists "windows-perfcounter-disk queue length"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'windows-perfcounter-disk queue length' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-counter",
    "imports": [
        "generic-agent-windows-perfcounter"
    ],
    "object_name": "windows-perfcounter-disk queue length",
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
RES=`icingacli director service exists "windows-perfcounter-disk read bytes/sec"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'windows-perfcounter-disk read bytes/sec' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-counter",
    "imports": [
        "generic-agent-windows-perfcounter"
    ],
    "object_name": "windows-perfcounter-disk read bytes/sec",
    "object_type": "template",
    "vars": {
        "nscp_counter_name": "\\PhysicalDisk(_Total)\\Disk Read Bytes\/sec"
    }
}
'
fi

# Import of Service Template
RES=`icingacli director service exists "windows-perfcounter-disk write bytes/sec"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'windows-perfcounter-disk write bytes/sec' does not exists"
   icingacli director service create --json '
   {
    "check_command": "nscp-local-counter",
    "imports": [
        "generic-agent-windows-perfcounter"
    ],
    "object_name": "windows-perfcounter-disk write bytes\/sec",
    "object_type": "template",
    "use_agent": true,
    "vars": {
        "nscp_counter_name": "\\PhysicalDisk(_Total)\\Disk Write Bytes\/sec"
    }
}
'
fi

# Import of Service Template
RES=`icingacli director service exists "windows-perfcounter-processor %privileged time"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'windows-perfcounter-processor %privileged time' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-counter",
    "imports": [
        "generic-agent-windows-perfcounter"
    ],
    "object_name": "windows-perfcounter-processor %privileged time",
    "object_type": "template",
    "vars": {
        "nscp_counter_name": "\\Processor(_Total)\\% Privileged Time"
    }
}
'
fi

# Import of Service Template
RES=`icingacli director service exists "windows-perfcounter-processor %processor time"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'windows-perfcounter-processor %processor time' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-counter",
    "imports": [
        "generic-agent-windows-perfcounter"
    ],
    "object_name": "windows-perfcounter-processor %processor time",
    "object_type": "template",
    "vars": {
        "nscp_counter_name": "\\Processor(_Total)\\% Processor Time"
    }
}
'
fi

# Import of Service Template
RES=`icingacli director service exists "windows-perfcounter-processor interrupts/sec"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'windows-perfcounter-processor interrupts/sec' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-counter",
    "imports": [
        "generic-agent-windows-perfcounter"
    ],
    "object_name": "windows-perfcounter-processor interrupts\/sec",
    "object_type": "template",
    "vars": {
        "nscp_counter_name": "\\Processor(_Total)\\Interrupts\/sec"
    }
}
'
fi

# Import of Service Template
RES=`icingacli director service exists "windows-perfcounter-pagingfile %usagePeak"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'windows-perfcounter-pagingfile %usagePeak' does not exists"
   icingacli director service create --json '
{
    "check_command": "nscp-local-counter",
    "imports": [
        "generic-agent-windows-perfcounter"
    ],
    "object_name": "windows-perfcounter-pagingfile %usagePeak",
    "object_type": "template",
    "vars": {
        "nscp_counter_name": "\\Paging File(_Total)\\% Usage Peak"
    }
}
'
fi

echo "Done: 2012a-st_win_agent_OS-Performance"
exit 0
