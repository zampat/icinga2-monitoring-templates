--
-- Relations Service Template - Director Field
-- For default deployment
--

INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_type = "template" AND object_name = "linux-load"),(select id from director_datafield where varname = "load_wload1"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_type = "template" AND object_name = "linux-load"),(select id from director_datafield where varname = "load_wload5"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_type = "template" AND object_name = "linux-load"),(select id from director_datafield where varname = "load_wload15"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_type = "template" AND object_name = "linux-load"),(select id from director_datafield where varname = "load_cload1"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_type = "template" AND object_name = "linux-load"),(select id from director_datafield where varname = "load_cload5"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_type = "template" AND object_name = "linux-load"),(select id from director_datafield where varname = "load_cload15"),'n');

INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_type = "template" AND object_name = "linux-memory"),(select id from director_datafield where varname = "mem_critical"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_type = "template" AND object_name = "linux-memory"),(select id from director_datafield where varname = "mem_warning"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_type = "template" AND object_name = "linux-memory"),(select id from director_datafield where varname = "mem_used"),'n');

INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_type = "template" AND object_name = "linux-processes"),(select id from director_datafield where varname = "procs_critical"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_type = "template" AND object_name = "linux-processes"),(select id from director_datafield where varname = "procs_warning"),'n');

INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_type = "template" AND object_name = "linux-proc-procname"),(select id from director_datafield where varname = "procs_command"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_type = "template" AND object_name = "linux-proc-procname"),(select id from director_datafield where varname = "procs_critical"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_type = "template" AND object_name = "linux-proc-procname"),(select id from director_datafield where varname = "procs_warning"),'n');
