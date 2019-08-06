#
# Notification apply rules
# 
# icingacli director notification show timeperiod-citrix --json --no-defaults

# Notification apply rules

OBJ="host events: user1 once"
RES=`icingacli director notification exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Notification template '$OBJ' does not exists"
   icingacli director notification create --json '
{
    "apply_to": "host",
    "assign_filter": "host.name=true",
    "imports": [
        "notify all host events: Once"
    ],
    "object_name": "host events: user1 once",
    "object_type": "apply",
    "users": [
        "user 1"
    ]
}
'
fi


OBJ="service events: user1 once"
RES=`icingacli director notification exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Notification template '$OBJ' does not exists"
   icingacli director notification create --json '
{
    "apply_to": "service",
    "assign_filter": "service.name=%22%2A%22",
    "imports": [
        "notify all service events: Once"
    ],
    "object_name": "service events: user1 once",
    "object_type": "apply",
    "users": [
        "user 1"
    ]
}
'
fi

echo "Notification Apply rules created"
