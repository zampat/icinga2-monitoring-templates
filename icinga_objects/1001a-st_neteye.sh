#
#Service template: NetEye "agentless" as we don't have any endpoint = host_name
# Contribute exporting services:
# export OBJ="generic-neteye"
# icingacli director service show "$OBJ" --json --no-defaults

#
#Service template
#
OBJ="generic-neteye"
RES=`icingacli director service exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service '$OBJ' does not exists"
   icingacli director service create --json '
{
    "imports": [
        "generic-active-service"
    ],
    "object_name": "generic-neteye",
    "object_type": "template",
    "use_agent": true
}
'
fi


OBJ="neteye-load"
RES=`icingacli director service exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service '$OBJ' does not exists"
   icingacli director service create --json '
{
    "check_command": "load",
    "imports": [
        "generic-neteye"
    ],
    "object_name": "neteye-load",
    "object_type": "template",
    "vars": {
        "load_cload1": "15",
        "load_cload15": "9",
        "load_cload5": "12",
        "load_wload1": "10",
        "load_wload15": "5",
        "load_wload5": "8"
    }
}
'
fi

OBJ="neteye-disk"
RES=`icingacli director service exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service '$OBJ' does not exists"
   icingacli director service create --json '
{
    "check_command": "disk",
    "imports": [
        "generic-neteye"
    ],
    "object_name": "neteye-disk",
    "object_type": "template",
    "vars": {
        "custom_analytics_dashboard": "..\/d\/cus0000040\/service-diskspace-linux",
        "disk_errors_only": true
    }
}
'
fi

OBJ="neteye-icinga-cluster"
RES=`icingacli director service exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service '$OBJ' does not exists"
   icingacli director service create --json '
{
    "check_command": "cluster",
    "imports": [
        "generic-neteye"
    ],
    "object_name": "neteye-icinga-cluster",
    "object_type": "template",
    "use_agent": true
}
'
fi

OBJ="neteye-icinga-ido"
RES=`icingacli director service exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service '$OBJ' does not exists"
   icingacli director service create --json '
{
    "check_command": "ido",
    "imports": [
        "generic-neteye"
    ],
    "object_name": "neteye-icinga-ido",
    "object_type": "template",
    "use_agent": true,
    "vars": {
        "ido_name": "ido-mysql",
        "ido_type": "IdoMysqlConnection"
    }
}
'
fi

OBJ="neteye-icinga-zone"
RES=`icingacli director service exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service '$OBJ' does not exists"
   icingacli director service create --json '
{
    "check_command": "cluster-zone",
    "imports": [
        "generic-neteye"
    ],
    "object_name": "neteye-icinga-zone",
    "object_type": "template",
    "use_agent": false
}
'
fi

OBJ="neteye-load"
RES=`icingacli director service exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service '$OBJ' does not exists"
   icingacli director service create --json '
{
    "check_command": "load",
    "imports": [
        "generic-neteye"
    ],
    "object_name": "neteye-load",
    "object_type": "template"
}
'
fi

OBJ="neteye-proc-procname"
RES=`icingacli director service exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service '$OBJ' does not exists"
   icingacli director service create --json '
{
    "check_command": "procs",
    "imports": [
        "generic-neteye"
    ],
    "object_name": "neteye-proc-procname",
    "object_type": "template",
    "vars": {
        "procs_command": "influxd",
        "procs_critical": "1:20",
        "procs_warning": "1:5"
    }
}
'
fi

OBJ="neteye-processes"
RES=`icingacli director service exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service '$OBJ' does not exists"
   icingacli director service create --json '
{
    "check_command": "procs",
    "imports": [
        "generic-neteye"
    ],
    "object_name": "neteye-processes",
    "object_type": "template",
    "vars": {
        "procs_critical": "5000",
        "procs_warning": "1800"
    }
}
'
fi

OBJ="neteye-stats"
RES=`icingacli director service exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service '$OBJ' does not exists"
   icingacli director service create --json '
{
    "check_command": "icinga",
    "imports": [
        "generic-neteye"
    ],
    "object_name": "neteye-stats",
    "object_type": "template"
}
'
fi


OBJ="neteye-memory"
RES=`icingacli director service exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service '$OBJ' does not exists"
   icingacli director service create --json '
{
    "check_command": "mem",
    "imports": [
        "generic-neteye"
    ],
    "object_name": "neteye-memory",
    "object_type": "template",
    "vars": {
        "mem_critical": "100",
        "mem_used": true,
        "mem_warning": "99.8"
    }
}
'
fi

OBJ="neteye-smtp"
RES=`icingacli director service exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service '$OBJ' does not exists"
   icingacli director service create --json '
{
    "check_command": "smtp",
    "imports": [
        "generic-neteye"
    ],
    "object_name": "neteye-smtp",
    "object_type": "template",
    "vars": {
        "check_address": "localhost"
    }
}
'
fi

OBJ="neteye-mysql"
RES=`icingacli director service exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service '$OBJ' does not exists"
   icingacli director service create --json '
{
    "check_command": "mysql",
    "imports": [
        "generic-neteye"
    ],
    "object_name": "neteye-mysql",
    "object_type": "template",
    "vars": {
        "check_address": "mariadb.neteyelocal",
        "mysql_ignore_auth": true
    }
}
'
fi


echo "generic-neteye Service Templates created"
