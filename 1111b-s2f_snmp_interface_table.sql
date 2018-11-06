-- Relations Service Template - Director Field
-- For default deployment
--
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "generic_snmp_interface_table"),(select id from director_datafield where varname = "snmp_community"),'y');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "generic_snmp_interface_table"),(select id from director_datafield where varname = "snmp_enable_perfdata"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "generic_snmp_interface_table"),(select id from director_datafield where varname = "interface_table_warning_property"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "generic_snmp_interface_table"),(select id from director_datafield where varname = "interface_table_v2c"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "generic_snmp_interface_table"),(select id from director_datafield where varname = "snmp_timeout"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "generic_snmp_interface_table"),(select id from director_datafield where varname = "snmp_64bits"),'n');
