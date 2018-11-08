# 
#Services (as template)
# HowTo Export:
# icingacli director service show generic_vmware --json --no-defaults
#


######
## Services for VMWARE Monitoring
######

# Service Template: Generic Vmware
RES=`icingacli director service exists "generic_vmware"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'generic_vmware' does not exists"
   icingacli director service create --json '
{
    "check_command": "check_vmware_api",
    "imports": [
        "generic_service"
    ],
    "object_name": "generic_vmware",
    "object_type": "template",
    "vars": {
        "esx_authfile": "\/neteye\/shared\/monitoring\/configs\/vmware_auth_poc.cfg"
    }
}'
fi


# Service Template: Generic ESX via DC
RES=`icingacli director service exists "vmware_dc_esx"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'vmware_dc_esx' does not exists"
   icingacli director service create --json '
{
    "imports": [
        "generic_vmware"
    ],
    "object_name": "vmware_dc_esx",
    "object_type": "template",
    "vars": {
        "esx_datacenter": "vmware_dc_host.mydomain"
    }
}
'
fi

# Service Template: Datastore via DC
RES=`icingacli director service exists "vmware_dc_datastore"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'vmware_dc_datastore' does not exists"
   icingacli director service create --json '
{
    "imports": [
        "generic_vmware"
    ],
    "object_name": "vmware_dc_datastore",
    "object_type": "template",
    "vars": {
        "esx_command": "VMFS",
        "esx_critical": "2000:",
        "esx_subcommand": "used",
        "esx_warning": "50000:"
    }
}
'
fi


# Service Template: ESX CPU via DC
RES=`icingacli director service exists "vmware_dc_esx_cpu"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'vmware_dc_esx_cpu' does not exists"
   icingacli director service create --json '
{
    "imports": [
        "vmware_dc_esx"
    ],
    "object_name": "vmware_dc_esx_cpu",
    "object_type": "template",
    "vars": {
        "esx_command": "CPU",
        "esx_critical": 90,
        "esx_subcommand": "usage",
        "esx_warning": 85
    }
}
'
fi

# Service Template: ESX IO via DC
RES=`icingacli director service exists "vmware_dc_esx_io"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'vmware_dc_esx_io' does not exists"
   icingacli director service create --json '
{
    "imports": [
        "vmware_dc_esx"
    ],
    "object_name": "vmware_dc_esx_io",
    "object_type": "template",
    "vars": {
        "esx_command": "IO"
    }
}
'
fi

# Service Template: ESX Memory via DC
RES=`icingacli director service exists "vmware_dc_esx_memory"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'vmware_dc_esx_memory' does not exists"
   icingacli director service create --json '
{
    "imports": [
        "vmware_dc_esx"
    ],
    "object_name": "vmware_dc_esx_memory",
    "object_type": "template",
    "vars": {
        "esx_command": "MEM",
        "esx_critical": 100,
        "esx_subcommand": "usage",
        "esx_warning": 98
    }
}
'
fi

# Service Template: ESX NET via DC
RES=`icingacli director service exists "vmware_dc_esx_net"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'vmware_dc_esx_net' does not exists"
   icingacli director service create --json '
{
    "imports": [
        "vmware_dc_esx"
    ],
    "object_name": "vmware_dc_esx_net",
    "object_type": "template",
    "vars": {
        "esx_command": "NET"
    }
}
'
fi

echo "[+] Services VMWare  / ESX created"
exit 0
