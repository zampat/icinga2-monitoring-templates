#
#Commands:
# icingacli director command show check_snmp_cisco_hw --json --no-defaults
#

# Check Command: check_nwc_health
#
OBJ="check_nwc_health"
RES=`icingacli director command exists "$OBJ"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Command \"$OBJ\" does not exists"
   icingacli director command create  --json '
{
    "arguments": {
        "--alias": {
            "description": "The alias name of a 64bit-interface (ifAlias)",
            "value": "$nwc_health_alias$"
        },
        "--authpassword": {
            "description": "The authentication password for SNMPv3",
            "value": "$snmp_auth_passphrase$"
        },
        "--authprotocol": {
            "description": "The authentication protocol for SNMPv3 (md5|sha)",
            "value": "$snmp_authprotocol$"
        },
        "--blacklist": {
            "description": "Blacklist some (missing/failed) components",
            "value": "$nwc_health_blacklist$"
        },
        "--community": {
            "description": "SNMP community of the server (SNMP v1/2 only)",
            "value": "$snmp_community$"
        },
        "--contextengineid": {
            "description": "The context engine id for SNMPv3 (10 to 64 hex characters)",
            "value": "$nwc_health_contextengineid$"
        },
        "--contextname": {
            "description": "The context name for SNMPv3 (empty represents the default context)",
            "value": "$nwc_health_contextname$"
        },
        "--critical": {
            "description": "The critical threshold",
            "value": "$nwc_health_critical$"
        },
        "--criticalx": {
            "description": "The extended critical thresholds",
            "value": "$nwc_health_criticalx$"
        },
        "--domain": {
            "description": "The transport domain to use (default: udp/ipv4, other possible values: udp6, udp/ipv6, tcp, tcp4, tcp/ipv4, tcp6, tcp/ipv6)",
            "value": "$nwc_health_domain$"
        },
        "--drecksptkdb": {
            "description": "This parameter must be used instead of --name, because Devel::ptkdb is stealing the latter from the command line",
            "value": "$nwc_health_drecksptkdb$"
        },
        "--hostname": {
            "description": "Hostname or IP-address of the switch or router",
            "value": "$host.address$"
        },
        "--ifspeed": {
            "description": "Override the ifspeed oid of an interface",
            "value": "$nwc_health_ifspeed$"
        },
        "--ifspeedin": {
            "description": "Override the ifspeed oid of an interface (only inbound)",
            "value": "$nwc_health_ifspeedin$"
        },
        "--ifspeedout": {
            "description": "Override the ifspeed oid of an interface (only outbound)",
            "value": "$nwc_health_ifspeedout$"
        },
        "--lookback": {
            "description": "The amount of time you want to look back when calculating average rates. Use it for mode interface-errors or interface-usage. Without --lookback the time between two runs of check_nwc_health is the base for calculations. If you want your checkresult to be based for example on the past hour, use --lookback 3600.",
            "value": "$nwc_health_lookback$"
        },
        "--mitigation": {
            "description": "The parameter allows you to change a critical error to a warning.",
            "value": "$nwc_health_mitigation$"
        },
        "--mode": {
            "description": "Which mode should be executed. A list of all available modes can be found in the plugin documentation",
            "value": "$nwc_health_mode$"
        },
        "--morphperfdata": {
            "description": "The parameter allows you to change performance data labels. Its a perl regexp and a substitution. --morphperfdata (.*)ISATAP(.*)=$1patasi$2",
            "value": "$nwc_health_morphperfdata$"
        },
        "--multiline": {
            "description": "Multiline output",
            "set_if": "$nwc_health_multiline$"
        },
        "--name": {
            "description": "The name of an interface (ifDescr)",
            "value": "$nwc_health_name$"
        },
        "--name2": {
            "description": "The secondary name of a component",
            "value": "$nwc_health_name2$"
        },
        "--negate": {
            "description": "The parameter allows you to map exit levels, such as warning=critical",
            "value": "$nwc_health_negate$"
        },
        "--offline": {
            "description": "The maximum number of seconds since the last update of cache file before it is considered too old",
            "value": "$nwc_health_offline$"
        },
        "--oids": {
            "description": "A list of oids which are downloaded and written to a cache file. Use it together with --mode oidcache",
            "value": "$nwc_health_oids$"
        },
        "--port": {
            "description": "The SNMP port to use (default: 161)",
            "value": "$nwc_health_port$"
        },
        "--privpassword": {
            "description": "The password for authPriv security level",
            "value": "$snmp_priv_password$"
        },
        "--privprotocol": {
            "description": "The private protocol for SNMPv3 (des|aes|aes128|3des|3desde)",
            "value": "$snmp_privprotocol$"
        },
        "--protocol": {
            "description": "The SNMP protocol to use (default: 2c, other possibilities: 1,3)",
            "value": "$snmp_version$"
        },
        "--regexp": {
            "description": "A flag indicating that --name is a regular expression",
            "set_if": "$nwc_health_regexp$"
        },
        "--report": {
            "description": "Can be used to shorten the output. Possible values are: long (default), short (to shorten if available), or html (to produce some html outputs if available)",
            "value": "$nwc_health_report$"
        },
        "--role": {
            "description": "The role of this device in a hsrp group (active\/standby\/listen)",
            "value": "$nwc_health_role$"
        },
        "--selectedperfdata": {
            "description": "The parameter allows you to limit the list of performance data. Its a perl regexp. Only matching perfdata show up in the output.",
            "value": "$nwc_health_selectedperfdata$"
        },
        "--servertype": {
            "description": "The type of the network device: cisco (default). Use it if auto-detection is not possible",
            "value": "$nwc_health_servertype$"
        },
        "--statefilesdir": {
            "description": "An alternate directory where the plugin can save files",
            "value": "$nwc_health_statefilesdir$"
        },
        "--timeout": {
            "description": "Seconds before plugin times out /(default: 15/)",
            "value": "$nwc_health_timeout$"
        },
        "--units": {
            "description": "One of %, B, KB, MB, GB, Bit, KBi, MBi, GBi. /(used for e.g. mode interface-usage/)",
            "value": "$nwc_health_units$"
        },
        "--username": {
            "description": "The securityName for the USM security model /(SNMPv3 only/)",
            "value": "$snmp_user$"
        },
        "--warning": {
            "description": "The warning threshold",
            "value": "$nwc_health_warning$"
        },
        "--warningx": {
            "description": "The extended warning thresholds",
            "value": "$nwc_health_warningx$"
        },
        "--with-mymodules-dyn-dir": {
            "description": "A directory where own extensions can be found",
            "value": "$nwc_health_mymodules-dyn-dir$"
        }
    },
    "command": "PluginContribDir + \/check_nwc_health",
    "methods_execute": "PluginCheck",
    "object_name": "check_nwc_health",
    "object_type": "object",
    "timeout": "60",
    "vars": {
        "check_address": {
            "arguments": [],
            "deprecated": false,
            "name": "<anonymous>",
            "side_effect_free": false,
            "type": "Function"
        },
        "check_ipv4": false,
        "check_ipv6": false,
        "nwc_health_hostname": "$check_address$",
        "nwc_health_mode": "hardware-health"
    }
}
'
fi

