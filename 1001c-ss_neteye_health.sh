
###
# Create Service Set: "NetEye Health"
###
# Service Template for Service Set
RES=`icingacli director serviceset exists "NetEye Health"`
if [[ $RES =~ "does not exist" ]]
then
icingacli director serviceset create --json '
{
    "object_name": "NetEye Health",
    "object_type": "template"
}
'

icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "neteye_disk"
    ],
    "object_name": "NetEye diskspace",
    "object_type": "object",
    "service_set": "NetEye Health",
    "use_agent": true
}
'

icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "neteye_proc_influxdb"
    ],
    "object_name": "NetEye Influxdb running",
    "object_type": "object",
    "service_set": "NetEye Health",
    "use_agent": true
}
'

icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "neteye_load"
    ],
    "object_name": "NetEye Load",
    "object_type": "object",
    "service_set": "NetEye Health",
    "use_agent": true
}
'

icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "neteye_processes"
    ],
    "object_name": "NetEye running processes",
    "object_type": "object",
    "service_set": "NetEye Health",
    "use_agent": true
}
'
fi