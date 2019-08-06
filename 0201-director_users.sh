#
# User templates and users
# 
# icingacli director user show "notify-allEvents" --json --no-defaults


OBJ="notify-allEvents"
RES=`icingacli director user exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "User '$OBJ' does not exists"
   icingacli director user create --json '
{
    "enable_notifications": true,
    "object_name": "notify-allEvents",
    "object_type": "template",
    "states": [
        "Critical",
        "Down",
        "OK",
        "Unknown",
        "Up",
        "Warning"
    ],
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
    ]
}
'
fi


OBJ="user 1"
RES=`icingacli director user exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "User '$OBJ' does not exists"
   icingacli director user create --json '
{
    "display_name": "Username",
    "email": "user.name@neteye.local",
    "imports": [
        "notify-allEvents"
    ],
    "object_name": "user 1",
    "object_type": "object"
}
'
fi

echo "User templates / Users created"
