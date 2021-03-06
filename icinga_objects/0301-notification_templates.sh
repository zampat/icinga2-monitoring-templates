#
# Notification templates
# 
# icingacli director notification show timeperiod-citrix --json --no-defaults

# Notification template

OBJ="generic notify all events"
RES=`icingacli director notification exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Notification template '$OBJ' does not exists"
   icingacli director notification create --json '
{
    "object_name": "generic notify all events",
    "object_type": "template",
    "period": "24x7",
    "types": [
        "Acknowledgement",
        "Custom",
        "DowntimeEnd",
        "DowntimeRemoved",
        "DowntimeStart",
        "FlappingEnd",
        "FlappingStart",
        "Problem",
        "Recovery"
    ],
    "vars": {
        "notification_from": "NetEye <neteye.monitoring@mydomain.lan>"
    }
}
'
fi


OBJ="generic notify all host events"
RES=`icingacli director notification exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Notification template '$OBJ' does not exists"
   icingacli director notification create --json '
{
    "command": "mail-host-notification",
    "imports": [
        "generic notify all events"
    ],
    "object_name": "generic notify all host events",
    "object_type": "template",
    "states": [
        "Down",
        "Up"
    ],
    "times_begin": "0"
}
'
fi

OBJ="generic notify all events service"
RES=`icingacli director notification exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Notification template '$OBJ' does not exists"
   icingacli director notification create --json '
{
    "command": "mail-service-notification",
    "imports": [
        "generic notify all events"
    ],
    "object_name": "generic notify all events service",
    "object_type": "template",
    "states": [
        "Critical",
        "OK",
        "Unknown",
        "Warning"
    ],
    "times_begin": "0"
}
'
fi



OBJ="notify all host events: Once"
RES=`icingacli director notification exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Notification template '$OBJ' does not exists"
   icingacli director notification create --json '
{
    "imports": [
        "generic notify all host events"
    ],
    "notification_interval": "0",
    "object_name": "notify all host events: Once",
    "object_type": "template"
}
'
fi

OBJ="notify all host events: Daily"
RES=`icingacli director notification exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Notification template '$OBJ' does not exists"
   icingacli director notification create --json '
{
    "imports": [
        "generic notify all host events"
    ],
    "notification_interval": "86400",
    "object_name": "notify all host events: Daily",
    "object_type": "template"
}
'
fi

OBJ="notify all host events: Escal 2nd lvl"
RES=`icingacli director notification exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Notification template '$OBJ' does not exists"
   icingacli director notification create --json '
{
    "imports": [
        "generic notify all host events"
    ],
    "notification_interval": "86400",
    "object_name": "notify all host events: Escal 2nd lvl",
    "object_type": "template",
    "times_begin": "86400"
}
'
fi

OBJ="notify all service events: Once"
RES=`icingacli director notification exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Notification template '$OBJ' does not exists"
   icingacli director notification create --json '
{
    "imports": [
        "generic notify all events service"
    ],
    "notification_interval": "0",
    "object_name": "notify all service events: Once",
    "object_type": "template"
}
'
fi

OBJ="notify all service events: Daily"
RES=`icingacli director notification exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Notification template '$OBJ' does not exists"
   icingacli director notification create --json '
{
    "imports": [
        "generic notify all events service"
    ],
    "notification_interval": "86400",
    "object_name": "notify all service events: Daily",
    "object_type": "template"
}
'
fi

echo "Notification Templates created"
