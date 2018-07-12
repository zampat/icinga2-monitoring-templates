--
-- Relations Service Template - Director Field
-- For default deployment
--

INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "Agent_Win_Diskspace"),(select id from director_datafield where varname = "disk_win_crit"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "Agent_Win_Diskspace"),(select id from director_datafield where varname = "disk_win_warn"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "Agent_Win_Diskspace"),(select id from director_datafield where varname = "disk_win_path"),'n');

INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "Agent_Win_Memory"),(select id from director_datafield where varname = "memory_win_crit"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "Agent_Win_Memory"),(select id from director_datafield where varname = "memory_win_warn"),'n');

# Agent_Win_Service
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "Agent_Win_Service"),(select id from director_datafield where varname = "service_win_service"),'n');

# Agent_WinCnt
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "Agent_WinCnt"),(select id from director_datafield where varname = "nscp_counter_critical"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "Agent_WinCnt"),(select id from director_datafield where varname = "nscp_counter_name"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "Agent_WinCnt"),(select id from director_datafield where varname = "nscp_counter_warning"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "Agent_WinCnt"),(select id from director_datafield where varname = "nscp_modules"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "Agent_WinCnt"),(select id from director_datafield where varname = "check_pdh"),'n');




