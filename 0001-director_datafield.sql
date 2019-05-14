
--
-- Dumping data for table `director_datafield`
-- For default deployment
-- ADVICE The table "director_datafield" has to be empty. An autoincrement index will be set to 1000.
-- Index Reservations:
-- 1 - 99: Host fields
-- 100 - 300: Service fields
-- Advice: some id's had been removed. See DELETE query below!!
--

LOCK TABLES `director_datafield` WRITE;
/*!40000 ALTER TABLE `director_datafield` DISABLE KEYS */;
INSERT IGNORE `director_datafield` VALUES
(40,'custom_analytics_dashboard','ITOA Custom Dashboard',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(50,'host_service','Host Service',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeDatalist',NULL),
(51,'host_owner','Host Owner',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeDirectorObject',NULL),
(52,'host_os','Host OS',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeDatalist',NULL),
(53,'host_parent','Host parent',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeDirectorObject',NULL),
(80,'notification_from','Notification From','Set from address. Requires GNU mailutils (Debian/Ubuntu) or mailx (RHEL/SUSE)','Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),	
(81,'notification_comment','Notification Notes','Set additional notes for notification message','Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),	
(90,'icingacli_businessprocess_config','BP configuration filename','Configuration file containing your business process without file extension','Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(91,'icingacli_businessprocess_process','BP process name','Business process to monitor','Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(92,'icingacli_businessprocess_details','BP show problem details',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeBoolean',NULL),
(100,'cluster_zone','Icinga Cluster Zone','The Zone that should be connected, defaults to $host.name$','Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(101,'disk_partition','Disk Linux Partition',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(102,'disk_cfree','Disk Linux Critical','Exit with CRITICAL status if less than INTEGER units of disk are free or Exit with CRITCAL status if less than PERCENT of disk space is free','Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(103,'disk_wfree','Disk Linux Warning','Exit with WARNING status if less than PERCENT of inode space is free','Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(108,'ups_type','UPS Type',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeDatalist',NULL),
(111,'load_cload1','Load crit load1','Exit with CRITICAL status if load average exceed CLOADn; the load average format is the same used by \'uptime\' and \'w\'','Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(112,'load_cload15','Load crit load15','Exit with CRITICAL status if load average exceed CLOADn; the load average format is the same used by \'uptime\' and \'w\'','Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(113,'load_cload5','Load crit load5','Exit with CRITICAL status if load average exceed CLOADn; the load average format is the same used by \'uptime\' and \'w\'','Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(114,'load_wload1','Load warn load1','Exit with WARNING status if load average exceeds WLOADn','Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(115,'load_wload15','Load warn load15','Exit with WARNING status if load average exceeds WLOADn','Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(116,'load_wload5','Load warn load5','Exit with WARNING status if load average exceeds WLOADn','Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(117,'disk_win_path','Disk Win path','Optional paths to check','Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(118,'disk_win_crit','Disk Win crit','Critical threshold','Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(119,'disk_win_warn','Disk Win warn','Warning threshold','Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(120,'memory_win_crit','Memory win crit','Critical Threshold','Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(121,'memory_win_warn','Memory win warn','Warning Threshold','Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(125,'esx_datacenter','VMWare Datacenter',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(126,'esx_critical','ESX critical value',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(127,'esx_warning','ESX waning value',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(128,'esx_username','ESX username',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(129,'esx_password','ESX password',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(130,'esx_command','ESX command',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeDatalist',NULL),
(131,'esx_subcommand','ESX subcommand',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(132,'esx_optional','ESX optional',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(133,'powershell_args','Powershell Arguments',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(134,'powershell_script','Powershell Script',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(142,'iftraffic_address_string','iftraffic address',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(143,'iftraffic_bandwidth','iftraffic bandwidth',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(144,'iftraffic_community','iftraffic community',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(145,'iftraffic_critical','iftraffic critical',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(146,'iftraffic_inBandwidth','iftraffic inBandwidth',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(147,'iftraffic_interface','iftraffic interface',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(148,'iftraffic_max','iftraffic max',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(149,'iftraffic_outBandwidth','iftraffic outBandwidth',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(150,'iftraffic_units','iftraffic units',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeDatalist',NULL),
(151,'iftraffic_warning','iftraffic warning',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(152,'iftraffic_bits','iftraffic bits',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeBoolean',NULL),
(153,'3par_username','3par username',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(154,'3par_command','3par command',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeDatalist',NULL),
(156,'service_win_service','Service Win Name','Service to check','Icinga\\Module\\Director\\DataType\\DataTypeArray',NULL),
(162,'mssql_health_username','MSSQL Username',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(163,'mssql_health_password','MSSQL password',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(164,'mssql_health_mode','MSSQL mode',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeDatalist',NULL),
(165,'mssql_health_hostname','MSSQL hostname',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(166,'procs_command','Process Command',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(167,'procs_critical','Process Critical',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(168,'procs_warning','Process Warning',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(169,'procs_argument','Process Argument',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(171,'nscp_arguments','NSCP Arguments',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeArray',NULL),
(172,'nscp_modules','NSCP module',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeDatalist',NULL),
(173,'nscp_counter_arguments','NSCP counter arguments',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(174,'nscp_showall','NSCP showall',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeBoolean',NULL),
(175,'nscp_query','NSCP query',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeDatalist',NULL),
(176,'nscp_counter_name','NSCP counter name',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(177,'nscp_counter_op','NSCP counter operator',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeDatalist',NULL),
(178,'nscp_counter_warning','NSCP counter warning',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(180,'nscp_counter_critical','NSCP counter critical',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(182,'mssql_health_warning','MSSQL warning threshold',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeNumber',NULL),
(183,'mssql_health_critical','MSSQL critical threshold',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeNumber',NULL),
(190,'http_ssl','HTTP use SSL','Activates -S','Icinga\\Module\\Director\\DataType\\DataTypeBoolean',NULL),
(191,'http_uri','HTTP uri',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(192,'http_auth_pair','HTTP Authentication username:password',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(193,'http_certificate','HTTP Certificate validity days',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeNumber',NULL),
(194,'http_critical_time','HTTP response time critical',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeNumber',NULL),
(195,'http_warn_time','HTTP response time warning',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeNumber',NULL),
(196,'http_onredirect','HTTP Action on redirect',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeDatalist',NULL),
(197,'http_port','HTTP Port',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeNumber',NULL),
(198,'http_proxy_auth_pair','HTTP Proxy Authentication username:password',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(199,'http_timeout','HTTP Timeout',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeNumber',NULL),
(200,'http_string','HTTP Expected String',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(201,'esx_authfile','ESX authentication file',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(203,'disk_partitions_excluded','Disk Linux Exclude partition',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(204,'disk_mountpoint','Disk Linux Mountpoint',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(205,'disk_timeout','Disk Linux Timeout',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(206,'http_vhost','HTTP virtual host',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(300,'snmp_community','SNMP Community',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeDatalist',NULL),
(301,'snmp_manufacturer','SNMP Manufacturer',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(302,'snmp_interface','SNMP Interface',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(303,'snmp_warning','SNMP Warning',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(304,'snmp_critical','SNMP Critical',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(305,'snmp_check_type','SNMP Check Type',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(306,'snmp_enable_perfdata','SNMP Enable Perfdata',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeBoolean',NULL),
(307,'snmp_timeout','SNMP Timeout',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeNumber',NULL),
(309,'snmp_version','SNMP Version',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeDatalist',NULL),
(310,'interfaces_community','Interfaces community',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(311,'interfaces_regex','Interfaces Regex','Regex to match interfaces','Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(312,'interfaces_exclude_regex','Interfaces exclude-regex','interface list negative regexp','Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(313,'interfaces_perfdata','Interfaces Perfdata','last check perfdata','Icinga\\Module\\Director\\DataType\\DataTypeBoolean',NULL),
(314,'interfaces_down_is_ok','Interfaces down-is-ok','Disables critical alerts for down interfaces','Icinga\\Module\\Director\\DataType\\DataTypeBoolean',NULL),
(315,'interface_use64bit','SNMP use 64bit counters',Null,'Icinga\\Module\\Director\\DataType\\DataTypeBoolean',NULL),
(320,'interface_table_track_property','Interf.Table: Define tracked properties','ifAlias: the interface alias
ifType: the type of the interface
ifAdminStatus: the administrative status of the interface
ifOperStatus: the operational status of the interface
ifSpeedReadable: the speed of the interface
ifStpState: the Spanning Tree state of the interface
ifDuplexStatus: the operation mode of the interface (duplex mode)
ifVlanNames: the vlan on which the interface was associated
ifIpInfo: the ip configuration for the interface','Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(321,'interface_table_warning_property','Interf. Table:  Max property changes warning',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeNumber',NULL),
(322,'interface_table_v2c','Interf. Table: Use SNMP vers. 2c',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeBoolean',NULL),
(330,'snmp_security_level','SNMPv3 security level',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(331,'snmp_user','SNMPv3 Username',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(332,'snmp_authprotocol','SNMPv3 auth.Protocol',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(333,'snmp_auth_passphrase','SNMPv3 auth. passphrase',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(334,'snmp_privprotocol','SNMPv3 priv.Protocol',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(336,'snmp_priv_password','SNMPv3 priv.Password',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(340,'snmp_storage_name','SNMP Storage Name',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(350,'fortinet_type','Fortinet Type (-T)',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(351,'fortinet_slave','Fortinet Slave (-s)',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(402,'nwc_health_protocol','NWC Snmp protocol',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(403,'nwc_health_mode','NWC Mode',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(404,'nwc_health_multiline','NWC set multiline output',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeBoolean',NULL),
(405,'nwc_health_report','NWC Health Report','Can be used to shorten the output. Possible values are: "long" (default), "short", or "html"','Icinga\\Module\\Director\\DataType\\DataTypeBoolean',NULL),
(406,'nwc_health_offline','NWC Cache offline','The maximum number of seconds since the last update of cache file before it is considered too old','Icinga\\Module\\Director\\DataType\\DataTypeBoolean',NULL),
(407,'nwc_health_timeout','NWC Timeout',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(408,'nwc_health_units','NWC Units','One of %, B, KB, MB, GB, Bit, KBi, MBi, GBi. (used for e.g. mode interface-usage)','Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(410,'nwc_health_community','NWC Community for v1 or v2',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(411,'nwc_health_username','NWC Username ',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(412,'nwc_health_authprotocol','NWC Authentication Protocol',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(413,'nwc_health_authpassword','NWC Authentication Password',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(414,'nwc_health_privprotocol','NWC Authentication Private Protocol',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(415,'nwc_health_privpassword','NWC Authentication Private Password',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(421,'nwc_health_name','NWC Interface Name',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(422,'nwc_health_name2','NWC Interface Namei 2',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(423,'nwc_health_regexp','NWC Name as regular expression',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeBoolean',NULL),
(425,'nwc_health_ifspeed','NWC Interface Speed',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(426,'nwc_health_ifspeedin','NWC Interface Speed in',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(427,'nwc_health_ifspeedout','NWC Interface Speed out',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(431,'nwc_health_critical','NWC Critical',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(432,'nwc_health_criticalx','NWC Critical Extended',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(433,'nwc_health_warning','NWC Warning',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(434,'nwc_health_warningx','NWC Warning Extended',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(501,'nrpe_command','NRPE Command ','The nrpe command','Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(502,'nrpe_arguments','NRPE Arguments (multi value)',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeArray',NULL),
(503,'nrpe_no_ssl','NRPE Do not use SSL',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeBoolean',NULL),
(651,'oracle_health_mode','Oracle Health mode',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(652,'oracle_health_sid','Oracle Health SID',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(655,'oracle_health_username','Oracle Health username',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(656,'oracle_health_password','Oracle Health password',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(650,'oracle_health_warning','Oracle Health warning',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL),
(651,'oracle_health_critical','Oracle Health critical',NULL,'Icinga\\Module\\Director\\DataType\\DataTypeString',NULL);
/*!40000 ALTER TABLE `director_datafield` ENABLE KEYS */;
ALTER TABLE `director_datafield` AUTO_INCREMENT=10001;
UNLOCK TABLES;


--
-- Changes required to align to master branch
--
UPDATE `director`.`director_datafield` SET `varname` = 'snmp_security_level', `caption` = 'SNMPv3 security level', `datatype` = 'Icinga\\Module\\Director\\DataType\\DataTypeString' WHERE `director_datafield`.`id` = 330;
UPDATE `director`.`director_datafield` SET `varname` = 'snmp_user', `caption` = 'SNMPv3 Username', `datatype` = 'Icinga\\Module\\Director\\DataType\\DataTypeString' WHERE `director_datafield`.`id` = 331;
UPDATE `director`.`director_datafield` SET `varname` = 'snmp_authprotocol', `caption` = 'SNMPv3 auth.Protocol', `datatype` = 'Icinga\\Module\\Director\\DataType\\DataTypeString' WHERE `director_datafield`.`id` = 332;
UPDATE `director`.`director_datafield` SET `varname` = 'snmp_auth_passphrase', `caption` = 'SNMPv3 auth. passphrase', `datatype` = 'Icinga\\Module\\Director\\DataType\\DataTypeString' WHERE `director_datafield`.`id` = 333;
UPDATE `director`.`director_datafield` SET `varname` = 'snmp_privprotocol', `caption` = 'SNMPv3 priv.Protocol' WHERE `director_datafield`.`id` = 334;
DELETE FROM `director`.`director_datafield` WHERE `director_datafield`.`id` = 335;
UPDATE `director`.`director_datafield` SET `varname` = 'snmp_priv_password', `caption` = 'SNMPv3 priv.Password' WHERE `director_datafield`.`id` = 336;
DELETE FROM `director`.`director_datafield` WHERE `director_datafield`.`id` = 337;



--
-- Table structure for table `director_datalist`
-- For default import
-- Create DataLists for DataFiels having FieldType "datalist"
--
LOCK TABLES `director_datalist` WRITE;
/*!40000 ALTER TABLE `director_datalist` DISABLE KEYS */;
INSERT IGNORE `director_datalist` (`id`, `list_name`, `owner`) VALUES
(50,'Host Service','root'),
(52, "Host OS", 'root'),
(108,'UPS Type','root'),
(130,'ESX command','root'),
(150,'iftraffic units','root'),
(154,'3par command','root'),
(164,'MSSQL mode','root'),
(172,'NSCP module','root'),
(175,'NSCP query','root'),
(177,'NSCP counter operator','root'),
(196,'HTTP Action on redirect','root'),
(309,'SNMP Version','root');
/*!40000 ALTER TABLE `director_datalist` ENABLE KEYS */;
ALTER TABLE `director_datalist` AUTO_INCREMENT=10001;
UNLOCK TABLES;


--
-- Table structure for table `director_datalist_entry`
-- For default import
-- Create entries of DataList
--
LOCK TABLES `director_datalist_entry` WRITE;
/*!40000 ALTER TABLE `director_datalist_entry` DISABLE KEYS */;
INSERT IGNORE `director_datalist_entry` (`list_id`, `entry_name`, `entry_value`, `format`, `allowed_roles`) VALUES 
(50,'Dynamics AX','Dynamics AX','string',NULL),
(50,'MS Exchange','MS Exchange','string',NULL),
(50,'MS SQL Server','MS SQL Server','string',NULL),
(52,'Linux','Linux','string',NULL),
(52,'Windows','Windows','string',NULL),
(52,'ESX','ESX','string',NULL),
(52,'AIX','AIX','string',NULL),
(108,'apcats','apcats','string',NULL),
(108,'apcups','apcups','string',NULL),
(108,'benning','benning','string',NULL),
(108,'chloride','chloride','string',NULL),
(108,'delta','delta','string',NULL),
(108,'general','general','string',NULL),
(108,'generex','generex','string',NULL),
(108,'mge','mge','string',NULL),
(108,'netvision','netvision','string',NULL),
(108,'nvenergy','nvenergy','string',NULL),
(108,'socomec','socomec','string',NULL),
(108,'socomecnew','socomecnew','string',NULL),
(130,'CPU','CPU','string',NULL),
(130,'IO','IO','string',NULL),
(130,'NET','NET','string',NULL),
(130,'MEM','MEM','string',NULL),
(130,'RUNTIME','RUNTIME','string',NULL),
(130,'VMFS','VM FileSystem','string',NULL),
(150,'b','bits','string',NULL),
(150,'g','gigabits','string',NULL),
(150,'k','kilobits','string',NULL),
(150,'m','megabits','string',NULL),
(154,'check_cap_ssd','SSD capacity','string',NULL),
(154,'check_ld','Logical disk','string',NULL),
(154,'check_node','Nodes','string',NULL),
(154,'check_pd','Physical disk','string',NULL),
(154,'check_ps','Power Supply','string',NULL),
(154,'check_vv','Virtual volumes','string',NULL),
(164,'connection-time','connection-time','string',NULL),
(164,'transactions','transactions','string',NULL),
(172,'CheckSystem','CheckSystem','string',NULL),
(172,'CheckDisk','CheckDisk','string',NULL),
(175,'check_memory','Check free/used memory on the system.','string',NULL),
(175,'check_os_version','Check the version of the underlaying OS.','string',NULL),
(175,'check_pagefile','Check the size of the system pagefile(s).','string',NULL),
(175,'check_pdh','Check the value of a performance (PDH) counter on the local or remote system','string',NULL),
(175,'check_process','Check state/metrics of one or more of the processes running on the computer.','string',NULL),
(175,'check_service','Check the state of one or more of the computer services.','string',NULL),
(177,'<','<','string',NULL),
(177,'=','=','string',NULL),
(177,'>','>','string',NULL),
(196,'follow','follow','string',NULL),
(309,'1','1','string',NULL),
(309,'2','2','string',NULL),
(309,'2c','2c','string',NULL),
(309,'3','3','string',NULL);
/*!40000 ALTER TABLE `director_datalist_entry` ENABLE KEYS */;
UNLOCK TABLES;



--
-- Table structure for table `director_datafield_setting`
-- For default import. Join with above datafields
-- Connect DataField with DataList where DataList is used
--

LOCK TABLES `director_datafield_setting` WRITE;
/*!40000 ALTER TABLE `director_datafield_setting` DISABLE KEYS */;
INSERT IGNORE `director_datafield_setting` (`datafield_id`, `setting_name`, `setting_value`) VALUES 
(50,'datalist_id',50),
(50,'data_type','string'),
(52,'datalist_id',52),
(52,'data_type','string'),
(53,'data_type','string'),
(53,'icinga_object_type','host'),
(108,'datalist_id',108),
(108,'data_type','string'),
(130,'datalist_id',130),
(130,'data_type','string'),
(150,'datalist_id',150),
(150,'data_type','string'),
(154,'datalist_id',154),
(154,'data_type','string'),
(164,'datalist_id',164),
(164,'data_type','string'),
(172,'datalist_id',172),
(172,'data_type','string'),
(175,'datalist_id',175),
(175,'data_type','string'),
(177,'datalist_id',177),
(177,'data_type','string'),
(196,'datalist_id',196),
(196,'data_type','string'),
(309,'datalist_id',309),
(309,'data_type','string');
/*!40000 ALTER TABLE `director_datafield_setting` ENABLE KEYS */;
UNLOCK TABLES;







