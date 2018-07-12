--
-- Relations Service Template - Director Field
-- For default deployment
--
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "Agent_WinDisk_FileAge"),(select id from director_datafield where varname = "nscp_arguments"),'y');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "Agent_WinDisk_FileAge"),(select id from director_datafield where varname = "nscp_modules"),'y');

INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "Agent_WinDisk_FileAge"),(select id from director_datafield where varname = "nscp_query"),'y');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "Agent_WinDisk_FileAge"),(select id from director_datafield where varname = "nscp_showall"),'n');