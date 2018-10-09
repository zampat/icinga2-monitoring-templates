
###
# Create Service Set: "NetEye Local Master"
# Create Service Set: "NetEye ClusterNode or Satellite"
###


# Service Template for Service Set
RES=`icingacli director serviceset exists "NetEye Local Master"`
if [[ $RES =~ "does not exist" ]]
then
icingacli director serviceset create --json '
{
    "object_name": "NetEye Local Master",
    "object_type": "template",
    "description": "NetEye Health checks for local master - no use of Icinga2 Agent."
}
'

icingacli director service create --json '
{
    "imports": [
        "neteye_disk"
    ],
    "object_name": "NetEye local diskspace",
    "object_type": "object",
    "service_set": "NetEye Local Master"
}
'

icingacli director service create --json '
{
    "imports": [
        "neteye_proc_influxdb"
    ],
    "object_name": "NetEye local Influxdb running",
    "object_type": "object",
    "service_set": "NetEye Local Master"
}
'

icingacli director service create --json '
{
    "imports": [
        "neteye_load"
    ],
    "object_name": "NetEye local Load",
    "object_type": "object",
    "service_set": "NetEye Local Master"
}
'

icingacli director service create --json '
{
    "imports": [
        "neteye_processes"
    ],
    "object_name": "NetEye local running processes",
    "object_type": "object",
    "service_set": "NetEye Local Master"
}
'
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
        "neteye_disk"
    ],
    "object_name": "NetEye local diskspace",
    "object_type": "object",
    "service_set": "NetEye Satellite",
    "use_agent": true
}
'

icingacli director service create --json '
{
    "imports": [
        "neteye_proc_influxdb"
    ],
    "object_name": "NetEye local Influxdb running",
    "object_type": "object",
    "service_set": "NetEye Satellite",
    "use_agent": true
}
'

icingacli director service create --json '
{
    "imports": [
        "neteye_load"
    ],
    "object_name": "NetEye local Load",
    "object_type": "object",
    "service_set": "NetEye Satellite",
    "use_agent": true
}
'

icingacli director service create --json '
{
    "imports": [
        "neteye_processes"
    ],
    "object_name": "NetEye local running processes",
    "object_type": "object",
    "service_set": "NetEye Satellite",
    "use_agent": true
}
'
fi

