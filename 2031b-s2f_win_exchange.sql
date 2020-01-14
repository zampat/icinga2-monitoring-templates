--
-- Relations Service Template - Director Field
-- For default deployment
--

# Services for Exchange Server
INSERT IGNORE icinga_command_field (command_id, datafield_id, is_required) VALUES ((select id from icinga_command where object_name = "powershell_exchange"),(select id from director_datafield where varname = "powershell_script"),"y");
INSERT IGNORE icinga_command_field (command_id, datafield_id, is_required) VALUES ((select id from icinga_command where object_name = "powershell_exchange"),(select id from director_datafield where varname = "powershell_args"),"n");


# Services for https_exchange_owa
INSERT IGNORE icinga_command_field (command_id, datafield_id, is_required) VALUES ((select id from icinga_command where object_name = "https_exchange_owa"),(select id from director_datafield where varname = "http_vhost"),"n");


# Services Fields for Windwows Exchange Server
# windows-nscp-service-exchange
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((select id from icinga_service where object_type = "template" AND object_name = "windows-nscp-service-exchange"),(select id from director_datafield where varname = "nscp_service_name"),"n");

