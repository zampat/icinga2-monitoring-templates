--
-- Relations Service Template - Director Field
-- For default deployment
--

INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "Agent_Linux_Memory"),(select id from director_datafield where varname = "mem_critical"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "Agent_Linux_Memory"),(select id from director_datafield where varname = "mem_warning"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "Agent_Linux_Memory"),(select id from director_datafield where varname = "mem_used"),'n');
