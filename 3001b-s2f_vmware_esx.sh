--
-- Relations Service Template - Director Field
-- For default deployment
--
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "generic_vmware"),(select id from director_datafield where varname = "esx_authfile"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "generic_vmware"),(select id from director_datafield where varname = "esx_command"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "generic_vmware"),(select id from director_datafield where varname = "esx_critical"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "generic_vmware"),(select id from director_datafield where varname = "esx_warning"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "generic_vmware"),(select id from director_datafield where varname = "esx_subcommand"),'n');

INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "vmware_dc_esx"),(select id from director_datafield where varname = "esx_datacenter"),'n');
