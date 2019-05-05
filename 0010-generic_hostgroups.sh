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
    "display_name": "NetEye Servers",
    "object_name": "neteye servers",
    "object_type": "object"
}
'
fi

