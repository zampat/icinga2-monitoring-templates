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
INSERT IGNORE icinga_host_field (host_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_host WHERE object_name = "generic-snmp"),(select id from director_datafield where varname = "host_snmp_community"),'n');
