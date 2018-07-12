# 
#Services (as template)
# HowTo Export:
# icingacli director service show Agent_Win_Service --json --no-defaults
#


######
## Services for VMWARE Monitoring
######

# Service Template for Service Set
RES=`icingacli director service exists "generic_esx_vmware"`
if [[ $RES =~ "does not exist" ]]
then

   echo "Service 'generic_esx_vmware' does not exists"
   icingacli director service create --json '
{
    "check_command": "check_vmware_api",
    "imports": [
        "generic_service"
    ],
    "object_name": "generic_esx_vmware",
    "object_type": "template"
}'
fi




echo "[+] Services VMWare  / ESX created"
exit 0
