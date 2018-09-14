#
#Service template: NetEye "agentless" as we don't have any endpoint = host_name
#

#
#Service template
#
RES=`icingacli director service exists "generic_neteye"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'generic_neteye' does not exists"
   icingacli director service create generic_neteye --json '
{
    "imports": [
        "generic_service"
    ],
    "object_name": "generic_neteye",
    "object_type": "template"
}
'
fi

RES=`icingacli director service exists "neteye_load"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'neteye_load' does not exists"
   icingacli director service create neteye_load --json '
{
    "check_command": "load",
    "imports": [
        "generic_neteye"
    ],
    "object_name": "neteye_load",
    "object_type": "template"
}
'
fi


RES=`icingacli director service exists "neteye_disk"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'neteye_disk' does not exists"
   icingacli director service create neteye_disk --json '
{
    "check_command": "disk",
    "imports": [
        "generic_neteye"
    ],
    "object_name": "neteye_disk",
    "object_type": "template"
}
'
fi


RES=`icingacli director service exists "neteye_processes"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'neteye_processes' does not exists"
   icingacli director service create neteye_processes --json '
{
    "check_command": "procs",
    "imports": [
        "generic_neteye"
    ],
    "object_name": "neteye_processes",
    "object_type": "template"
}
'
fi


RES=`icingacli director service exists "neteye_proc_influxdb"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'neteye_proc_influxdb' does not exists"
   icingacli director service create neteye_proc_influxdb --json '
{
    "check_command": "procs",
    "imports": [
        "generic_neteye"
    ],
    "object_name": "neteye_proc_influxdb",
    "object_type": "template"
}
'
fi

echo "Generic NetEye Service Templates created"