###
# Create Service Set: "WinAgent_OS-Performance"
###
# Service Template for Service Set
RES=`icingacli director serviceset exists "WinAgent_OS-Performance"`
if [[ $RES =~ "does not exist" ]]
then
icingacli director serviceset create --json '
{
    "assign_filter": null,
    "description": null,
    "object_name": "WinAgent_OS-Performance",
    "object_type": "template",
    "vars": {
    }
}
'


####
# Service Objects
####
icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "PerfCounter-PagingFile_%Usage"
    ],
    "object_name": "PagingFile_%Usage",
    "object_type": "object",
	"service_set": "WinAgent_OS-Performance"
}'

icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "PerfCounter-Processor_%InterruptTime"
    ],
    "object_name": "Processor_%InterruptTime",
    "object_type": "object",
	"service_set": "WinAgent_OS-Performance"
}'

icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "PerfCounter-DiskQueueLength"
    ],
    "object_name": "DiskQueueLength",
    "object_type": "object",
	"service_set": "WinAgent_OS-Performance"
}'

icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "PerfCounter-DiskReadBytes\/sec"
    ],
    "object_name": "DiskReadBytes\/sec",
    "object_type": "object",
	"service_set": "WinAgent_OS-Performance"
}'

icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "PerfCounter-DiskWriteBytes\/sec"
    ],
    "object_name": "DiskWriteBytes\/sec",
    "object_type": "object",
	"service_set": "WinAgent_OS-Performance"
}'

icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "PerfCounter-Processor_%PrivilegedTime"
    ],
    "object_name": "Processor_%PrivilegedTime",
    "object_type": "object",
	"service_set": "WinAgent_OS-Performance"
}'

icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "PerfCounter-Processor_%ProcessorTime"
    ],
    "object_name": "Processor_%ProcessorTime",
    "object_type": "object",
	"service_set": "WinAgent_OS-Performance"
}'

icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "PerfCounter-Processor_Interrupts\/sec"
    ],
    "object_name": "Processor_Interrupts\/sec",
    "object_type": "object",
	"service_set": "WinAgent_OS-Performance"
}'

icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "PerfCounter-PagingFile_%UsagePeak"
    ],
    "object_name": "PagingFile_%UsagePeak",
    "object_type": "object",
	"service_set": "WinAgent_OS-Performance"
}'

echo "Done: 2012c-ss_win_agent_OS-Performance"
fi



