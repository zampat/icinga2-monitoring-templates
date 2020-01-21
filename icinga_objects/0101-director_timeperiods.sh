#
# Timeperiods
# 
# icingacli director timeperiod show "24x7" --json --no-defaults


OBJ="24x7"
RES=`icingacli director timeperiod exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Timeperiod '$OBJ' does not exists"
   icingacli director timeperiod create --json '
{
    "display_name": "24x7",
    "object_name": "24x7",
    "object_type": "object",
    "ranges": {
        "friday": "00:00-24:00",
        "monday": "00:00-24:00",
        "saturday": "00:00-24:00",
        "sunday": "00:00-24:00",
        "thursday": "00:00-24:00",
        "tuesday": "00:00-24:00",
        "wednesday": "00:00-24:00"
    },
    "update_method": "LegacyTimePeriod"
}
'
fi


OBJ="workhours"
RES=`icingacli director timeperiod exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Timeperiod '$OBJ' does not exists"
   icingacli director timeperiod create --json '
{
    "display_name": "workhours 8:30 - 17:30",
    "object_name": "workhours",
    "object_type": "object",
    "ranges": {
        "friday": "08:30-17:30",
        "monday": "08:30-17:30",
        "thursday": "08:30-17:30",
        "tuesday": "08:30-17:30",
        "wednesday": "08:30-17:30"
    },
    "update_method": "LegacyTimePeriod"
}
'
fi

OBJ="holidays"
RES=`icingacli director timeperiod exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Timeperiod '$OBJ' does not exists"
   icingacli director timeperiod create --json '
{
    "object_name": "holidays",
    "object_type": "object",
    "ranges": {
        "december 25": "00:00-24:00",
        "december 26": "00:00-24:00",
        "january 1": "00:00-24:00",
        "may 1": "00:00-24:00"
    },
    "update_method": "LegacyTimePeriod"
}
'
fi


OBJ="non-workhours"
RES=`icingacli director timeperiod exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Timeperiod '$OBJ' does not exists"
   icingacli director timeperiod create --json '
{
    "display_name": "non workhours",
    "includes": [
        "holidays"
    ],
    "object_name": "non-workhours",
    "object_type": "object",
    "ranges": {
        "friday": "00:00-08:30,17:30-24:00",
        "monday": "00:00-08:30,17:30-24:00",
        "saturday": "00:00-24:00",
        "sunday": "00:00-24:00",
        "thursday": "00:00-08:30,17:30-24:00",
        "tuesday": "00:00-08:30,17:30-24:00",
        "wednesday": "00:00-08:30,17:30-24:00"
    },
    "update_method": "LegacyTimePeriod"
}
'
fi

echo "Timeperiods created"
