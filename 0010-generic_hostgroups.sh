#
# generic hostgroups
# How to export hostgroups:
# export OBJ="neteye servers"
# icingacli director hostgroup show "$OBJ" --json --no-defaults
#

OBJ="neteye servers"
RES=`icingacli director hostgroup exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Hostgroup '$OBJ' does not exists"
   icingacli director hostgroup create --json '
{
    "display_name": "NetEye servers",
    "object_name": "neteye servers",
    "object_type": "object"
}
'
fi

OBJ="network devices"
RES=`icingacli director hostgroup exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Hostgroup '$OBJ' does not exists"
   icingacli director hostgroup create --json '
{
    "display_name": "network devices",
    "object_name": "network devices",
    "object_type": "object"
}
'
fi

OBJ="windows servers"
RES=`icingacli director hostgroup exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Hostgroup '$OBJ' does not exists"
   icingacli director hostgroup create --json '
{
    "assign_filter": "host.vars.host_os=%22Windows%22",
    "display_name": "windows servers",
    "object_name": "windows servers",
    "object_type": "object"
}
'
fi

