--
-- Relations Service Template - Director Field
-- For default deployment
--

# generic-service
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_type = "template" AND object_name = "generic-service"),(select id from director_datafield where varname = "custom_analytics_dashboard"),'n');

#generic-ping
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_type = "template" AND object_name = "generic-ping"),(select id from director_datafield where varname = "ping_crta"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_type = "template" AND object_name = "generic-ping"),(select id from director_datafield where varname = "ping_cpl"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_type = "template" AND object_name = "generic-ping"),(select id from director_datafield where varname = "ping_wrta"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_type = "template" AND object_name = "generic-ping"),(select id from director_datafield where varname = "ping_wpl"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_type = "template" AND object_name = "generic-ping"),(select id from director_datafield where varname = "ping_packets"),'n');

# generic-http
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_name = "generic-http"),(select id from director_datafield where varname = "http_ssl"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_name = "generic-http"),(select id from director_datafield where varname = "http_uri"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_name = "generic-http"),(select id from director_datafield where varname = "http_auth_pair"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_name = "generic-http"),(select id from director_datafield where varname = "http_certificate"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_name = "generic-http"),(select id from director_datafield where varname = "http_critical_time"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_name = "generic-http"),(select id from director_datafield where varname = "http_warn_time"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_name = "generic-http"),(select id from director_datafield where varname = "http_onredirect"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_name = "generic-http"),(select id from director_datafield where varname = "http_port"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_name = "generic-http"),(select id from director_datafield where varname = "http_proxy_auth_pair"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_name = "generic-http"),(select id from director_datafield where varname = "http_timeout"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_name = "generic-http"),(select id from director_datafield where varname = "http_port"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_name = "generic-http"),(select id from director_datafield where varname = "http_string"),'n');

# windows-powershell-generic
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_name = "windows-powershell-generic"),(select id from director_datafield where varname = "powershell_script"),'y');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_name = "windows-powershell-generic"),(select id from director_datafield where varname = "powershell_args"),'n');
