--
-- Relations Service Template - Director Field
-- For default deployment
--

# Services for Windwows SQL Server
# generic-mssql
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "generic-mssql"),(select id from director_datafield where varname = "mssql_health_hostname"),"n");
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "generic-mssql"),(select id from director_datafield where varname = "mssql_health_mode"),"y");
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "generic-mssql"),(select id from director_datafield where varname = "mssql_health_password"),"y");
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "generic-mssql"),(select id from director_datafield where varname = "mssql_health_username"),"y");

# windows-mssql-connections
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "windows-mssql-connections"),(select id from director_datafield where varname = "mssql_health_critical"),"y");
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_name = "windows-mssql-connections"),(select id from director_datafield where varname = "mssql_health_warning"),"y");


