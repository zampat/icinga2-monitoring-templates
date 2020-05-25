--
-- Relations Service Template - Director Field
-- For default deployment
--

# Services for Windwows SQL Server
# generic-mssql
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_type = "template" AND object_name = "generic-mssql"),(select id from director_datafield where varname = "mssql_health_hostname"),"n");
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_type = "template" AND object_name = "generic-mssql"),(select id from director_datafield where varname = "mssql_health_mode"),"y");
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_type = "template" AND object_name = "generic-mssql"),(select id from director_datafield where varname = "mssql_health_password"),"y");
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_type = "template" AND object_name = "generic-mssql"),(select id from director_datafield where varname = "mssql_health_username"),"y");
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_type = "template" AND object_name = "generic-mssql"),(select id from director_datafield where varname = "mssql_health_warning"),"n");
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_type = "template" AND object_name = "generic-mssql"),(select id from director_datafield where varname = "mssql_health_critical"),"n");
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_type = "template" AND object_name = "generic-mssql"),(select id from director_datafield where varname = "mssql_health_name"),"n");
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_type = "template" AND object_name = "generic-mssql"),(select id from director_datafield where varname = "mssql_health_report"),"n");
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_type = "template" AND object_name = "generic-mssql"),(select id from director_datafield where varname = "mssql_health_units"),"n");

# mssql-failed-jobs-last-hour
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_type = "template" AND object_name = "mssql-failed-jobs-last-hour"),(select id from director_datafield where varname = "mssql_health_lookback"),"n");


# mssql-backup-age-in-hours
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_type = "template" AND object_name = "mssql-backup-age-in-hours"),(select id from director_datafield where varname = "mssql_health_regexp"),"n");
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_type = "template" AND object_name = "mssql-database-free"),(select id from director_datafield where varname = "mssql_health_regexp"),"n");
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_type = "template" AND object_name = "mssql-database-log-free"),(select id from director_datafield where varname = "mssql_health_regexp"),"n");
