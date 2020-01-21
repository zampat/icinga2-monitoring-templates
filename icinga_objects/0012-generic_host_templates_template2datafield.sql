--
-- Relations Service Template - Director Field
-- For default deployment
--

# generic-host
INSERT IGNORE icinga_host_field (host_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_host WHERE object_name = "generic-host"),(select id from director_datafield where varname = "host_os"),'n');
INSERT IGNORE icinga_host_field (host_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_host WHERE object_name = "generic-host"),(select id from director_datafield where varname = "host_parent"),'n');
INSERT IGNORE icinga_host_field (host_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_host WHERE object_name = "generic-host"),(select id from director_datafield where varname = "host_service"),'n');
INSERT IGNORE icinga_host_field (host_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_host WHERE object_name = "generic-host"),(select id from director_datafield where varname = "custom_analytics_dashboard"),'n');

# generic-snmp
INSERT IGNORE icinga_host_field (host_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_host WHERE object_name = "generic-snmp"),(select id from director_datafield where varname = "snmp_version"),'n');
INSERT IGNORE icinga_host_field (host_id, datafield_id, is_required, var_filter) VALUES ((SELECT id FROM icinga_host WHERE object_name = "generic-snmp"),(select id from director_datafield where varname = "snmp_community"),'n','host.vars.snmp_version=%222%2A%22|host.vars.snmp_version=%221%22');

INSERT IGNORE icinga_host_field (host_id, datafield_id, is_required, var_filter) VALUES ((SELECT id FROM icinga_host WHERE object_name = "generic-snmp"),(select id from director_datafield where varname = "snmp_security_level"),'n','host.vars.snmp_version=%223%22');
INSERT IGNORE icinga_host_field (host_id, datafield_id, is_required, var_filter) VALUES ((SELECT id FROM icinga_host WHERE object_name = "generic-snmp"),(select id from director_datafield where varname = "snmp_user"),'n','host.vars.snmp_version=%223%22');
INSERT IGNORE icinga_host_field (host_id, datafield_id, is_required, var_filter) VALUES ((SELECT id FROM icinga_host WHERE object_name = "generic-snmp"),(select id from director_datafield where varname = "snmp_authprotocol"),'n','host.vars.snmp_version=%223%22');
INSERT IGNORE icinga_host_field (host_id, datafield_id, is_required, var_filter) VALUES ((SELECT id FROM icinga_host WHERE object_name = "generic-snmp"),(select id from director_datafield where varname = "snmp_auth_passphrase"),'n','host.vars.snmp_version=%223%22');
INSERT IGNORE icinga_host_field (host_id, datafield_id, is_required, var_filter) VALUES ((SELECT id FROM icinga_host WHERE object_name = "generic-snmp"),(select id from director_datafield where varname = "snmp_privprotocol"),'n','host.vars.snmp_version=%223%22');
INSERT IGNORE icinga_host_field (host_id, datafield_id, is_required, var_filter) VALUES ((SELECT id FROM icinga_host WHERE object_name = "generic-snmp"),(select id from director_datafield where varname = "snmp_priv_password"),'n','host.vars.snmp_version=%223%22');
