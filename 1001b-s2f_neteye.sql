--
-- Relations Service Template - Director Field
-- For default deployment
--

# neteye icinga zone
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_name = "neteye icinga zone"),(select id from director_datafield where varname = "cluster_zone"),'n');

INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_name = "neteye proc procname"),(select id from director_datafield where varname = "procs_command"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_name = "neteye proc procname"),(select id from director_datafield where varname = "procs_critical"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_name = "neteye proc procname"),(select id from director_datafield where varname = "procs_warning"),'n');

INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_name = "neteye memory"),(select id from director_datafield where varname = "mem_used"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_name = "neteye memory"),(select id from director_datafield where varname = "mem_critical"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_name = "neteye memory"),(select id from director_datafield where varname = "mem_warning"),'n');
