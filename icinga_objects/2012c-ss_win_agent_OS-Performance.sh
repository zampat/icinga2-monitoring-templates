###
# Create Service Set: "Windows-OS-Performance"
###
# Service Template for Service Set
RES=`icingacli director serviceset exists "Windows-OS-Performance"`
if [[ $RES =~ "does not exist" ]]
then
icingacli director serviceset create --json '
{
    "assign_filter": null,
    "description": null,
    "object_name": "Windows-OS-Performance",
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
        "windows-perfcounter-pagingfile %usage"
    ],
    "object_name": "PagingFile_%Usage",
    "object_type": "object",
	"service_set": "Windows-OS-Performance"
}'

icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "windows-perfcounter-processor %interrupt time"
    ],
    "object_name": "Processor_%InterruptTime",
    "object_type": "object",
	"service_set": "Windows-OS-Performance"
}'

icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "windows-perfcounter-disk queue length"
    ],
    "object_name": "DiskQueueLength",
    "object_type": "object",
	"service_set": "Windows-OS-Performance"
}'

icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "windows-perfcounter-disk read bytes/sec"
    ],
    "object_name": "DiskReadBytes\/sec",
    "object_type": "object",
	"service_set": "Windows-OS-Performance"
}'

icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "windows-perfcounter-disk write bytes\/sec"
    ],
    "object_name": "DiskWriteBytes\/sec",
    "object_type": "object",
	"service_set": "Windows-OS-Performance"
}'

icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "windows-perfcounter-processor %privileged time"
    ],
    "object_name": "Processor_%PrivilegedTime",
    "object_type": "object",
	"service_set": "Windows-OS-Performance"
}'

icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "windows-perfcounter-processor %processor time"
    ],
    "object_name": "Processor_%ProcessorTime",
    "object_type": "object",
	"service_set": "Windows-OS-Performance"
}'

icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "windows-perfcounter-processor interrupts\/sec"
    ],
    "object_name": "Processor_Interrupts\/sec",
    "object_type": "object",
	"service_set": "Windows-OS-Performance"
}'

icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "windows-perfcounter-pagingfile %usagePeak"
    ],
    "object_name": "PagingFile_%UsagePeak",
    "object_type": "object",
	"service_set": "Windows-OS-Performance"
}'

echo "Done: 2012c-ss_win_agent_OS-Performance"
fi



