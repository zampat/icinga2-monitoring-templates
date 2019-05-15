# Basic SNMP commands

# Contribute exporting commands: IMHO the "show" does not work

# export OBJ="generic_snmp_interfaces"
# icingacli director commands show "$OBJ" --json --no-defaults

# Check Command:generic_snmp_interfaces
#
OBJ="check_interfaces"
RES=`icingacli director command exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Command $OBJ does not exists"
   icingacli director command create --json '
{
   "arguments": {
                "--aliases": {
                    "description": "Retrieves the interface description.",
                    "set_if": "$interfaces_aliases$"
                },
                "--auth-phrase": {
                    "description": "SNMPv3 Auth Phrase",
                    "value": "$snmp_auth_passphrase$"
                },
                "--auth-proto": {
                    "description": "SNMPv3 Auth Protocol (SHA|MD5)",
                    "value": "$snmp_authprotocol$"
                },
                "--bandwidth": {
                    "description": "Bandwidth warn level in percent.",
                    "value": "$interfaces_bandwidth$"
                },
                "--community": {
                    "description": "The community string (default public).",
                    "value": "$snmp_community$"
                },
                "--down-is-ok": {
                    "description": "Disables critical alerts for down interfaces.",
                    "set_if": "$interfaces_down_is_ok$"
                },
                "--errors": {
                    "description": "Number of in errors (CRC errors for cisco) to consider a warning (default 50).",
                    "value": "$interfaces_errors$"
                },
                "--exclude-regex": {
                    "description": "Interface list negative regexp.",
                    "value": "$interfaces_exclude_regex$"
                },
                "--hostname": {
                    "value": "$host.address$"
                },
                "--if-names": {
                    "description": "Use ifName instead of ifDescr.",
                    "set_if": "$interfaces_names$"
                },
                "--lastcheck": {
                    "description": "Last checktime (unixtime).",
                    "value": "$interfaces_lastcheck$"
                },
                "--match-aliases": {
                    "description": "Also match against aliases (Option --aliases automatically enabled).",
                    "set_if": "$interfaces_match_aliases$"
                },
                "--mode": {
                    "description": "Special operating mode (default,cisco,nonbulk,bintec).",
                    "value": "$interfaces_mode$"
                },
                "--out-errors": {
                    "description": "Number of out errors (collisions for cisco) to consider a warning (default same as in errors).",
                    "value": "$interface_out_errors$"
                },
                "--perfdata": {
                    "value": "$interfaces_perfdata$"
                },
                "--prefix": {
                    "description": "Prefix interface names with this label.",
                    "value": "$interfaces_prefix$"
                },
                "--priv-phrase": {
                    "description": "SNMPv3 Privacy Phrase",
                    "value": "$snmp_priv_password$"
                },
                "--priv-proto": {
                    "description": "SNMPv3 Privacy Protocol (AES|DES)",
                    "value": "$snmp_privprotocol$"
                },
                "--regex": {
                    "description": "Interface list regexp.",
                    "value": "$interfaces_regex$"
                },
                "--sleep": {
                    "description": "Sleep between every SNMP query (in ms).",
                    "value": "$interfaces_sleep$"
                },
                "--speed": {
                    "description": "Override speed detection with this value (bits per sec).",
                    "value": "$interfaces_speed$"
                },
                "--timeout": {
                    "description": "Sets the SNMP timeout (in ms).",
                    "value": "$interfaces_timeout$"
                },
                "--trim": {
                    "description": "Cut this number of characters from the start of interface descriptions.",
                    "value": "$interfaces_trim$"
                },
                "--user": {
                    "description": "SNMPv3 User",
                    "value": "$snmp_user$"
                }
            },
    "command": "PluginContribDir + \/check_interfaces",
    "methods_execute": "PluginCheck",
    "object_name": "check_interfaces",
    "object_type": "object"
}
'
fi

