--
-- Relations Service Template - Director Field
-- For default deployment
--

INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "SNMP_Cisco_HW"),(select id from director_datafield where varname = "snmp_community"),'y');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "SNMP_Cisco_HW"),(select id from director_datafield where varname = "snmp_check_type"),'y');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "SNMP_Cisco_HW"),(select id from director_datafield where varname = "snmp_interface"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "SNMP_Cisco_HW"),(select id from director_datafield where varname = "snmp_critical"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "SNMP_Cisco_HW"),(select id from director_datafield where varname = "snmp_critical"),'n');
