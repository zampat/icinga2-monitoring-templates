
###
# Create Service Set: "NetEye Master for standalone or cluster "
# Create Service Set: "NetEye ClusterNode or Satellite"
###


# Service Template for Service Set
RES=`icingacli director serviceset exists "NetEye Master"`
if [[ $RES =~ "does not exist" ]]
then
icingacli director serviceset create --json '
{
    "object_name": "NetEye Master",
    "object_type": "template",
    "description": "NetEye Health checks for Icinga2 master: compatible with NetEye standalone or NetEye cluster."
}'

icingacli director service create --json '
{
    "imports": [
        "neteye-disk"
    ],
    "object_name": "NetEye diskspace",
    "object_type": "object",
    "service_set": "NetEye Master",
    "use_agent": false
}'

icingacli director service create --json '
{
    "imports": [
        "neteye-icinga-cluster"
    ],
    "object_name": "NetEye icinga cluster",
    "object_type": "object",
    "service_set": "NetEye Master"
}'

icingacli director service create --json '
{
    "imports": [
        "neteye-icinga-ido"
    ],
    "object_name": "NetEye icinga ido",
    "object_type": "object",
    "service_set": "NetEye Master",
    "use_agent": false
}'

icingacli director service create --json '
{
    "imports": [
        "neteye-proc-procname"
    ],
    "object_name": "NetEye Influxdb running",
    "object_type": "object",
    "service_set": "NetEye Master",
    "use_agent": false
}'

icingacli director service create --json '
{
    "imports": [
        "neteye-load"
    ],
    "object_name": "NetEye load",
    "object_type": "object",
    "service_set": "NetEye Master",
    "use_agent": false
}'

icingacli director service create --json '
{
    "imports": [
        "neteye-processes"
    ],
    "object_name": "NetEye running processes",
    "object_type": "object",
    "service_set": "NetEye Master",
    "use_agent": false
}'


icingacli director service create --json '
{
    "imports": [
        "neteye-memory"
    ],
    "object_name": "NetEye memory",
    "object_type": "object",
    "service_set": "NetEye Master",
    "use_agent": false
}'

icingacli director service create --json '
{
    "imports": [
        "neteye-smtp"
    ],
    "object_name": "NetEye smtp",
    "object_type": "object",
    "service_set": "NetEye Master",
    "use_agent": false
}'


fi



# Service Template for Service Set
RES=`icingacli director serviceset exists "NetEye Satellite"`
if [[ $RES =~ "does not exist" ]]
then
icingacli director serviceset create --json '
{
    "object_name": "NetEye Satellite",
    "object_type": "template",
    "description": "NetEye Health checks for ClusterNode or Satellite"
}
'

icingacli director service create --json '
{
    "imports": [
        "neteye-disk"
    ],
    "object_name": "NetEye diskspace",
    "object_type": "object",
    "service_set": "NetEye Satellite"
}'

icingacli director service create --json '
{
    "imports": [
        "neteye-icinga-zone"
    ],
    "object_name": "Neteye icinga cluster zone connected",
    "object_type": "object",
    "service_set": "NetEye Satellite"
}'

icingacli director service create --json '
{
    "imports": [
        "neteye-load"
    ],
    "object_name": "NetEye load",
    "object_type": "object",
    "service_set": "NetEye Satellite"
}'

icingacli director service create --json '
{
    "imports": [
        "neteye-proc-procname"
    ],
    "object_name": "neteye-proc-icinga2",
    "object_type": "object",
    "service_set": "NetEye Satellite",
    "vars": {
        "procs_command": "icinga2",
        "procs_critical": "1:",
        "procs_warning": "1:50"
    }
}'


icingacli director service create --json '
{
    "imports": [
        "neteye-processes"
    ],
    "object_name": "NetEye running processes",
    "object_type": "object",
    "service_set": "NetEye Satellite"
}'

icingacli director service create --json '
{
    "imports": [
        "neteye-memory"
    ],
    "object_name": "NetEye memory",
    "object_type": "object",
    "service_set": "NetEye Satellite",
    "use_agent": false
}'


fi
