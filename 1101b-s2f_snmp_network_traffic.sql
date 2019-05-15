--
-- Relations Service Template - Director Field
-- For default deployment
--

INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "generic_snmp_interfaces"),(select id from director_datafield where varname = "interfaces_regex"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "generic_snmp_interfaces"),(select id from director_datafield where varname = "interfaces_exclude_regex"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "generic_snmp_interfaces"),(select id from director_datafield where varname = "interfaces_perfdata"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "generic_snmp_interfaces"),(select id from director_datafield where varname = "interfaces_down_is_ok"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "generic_snmp_interfaces"),(select id from director_datafield where varname = "custom_analytics_dashboard"),'n');
