--
-- Relations Service Template - Director Field
-- For default deployment
--

# generic_http
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_name = "generic_http"),(select id from director_datafield where varname = "http_timeout"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_name = "generic_http"),(select id from director_datafield where varname = "http_critical_time"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_name = "generic_http"),(select id from director_datafield where varname = "http_warn_time"),'n');

# http_website_availability
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_name = "generic_http"),(select id from director_datafield where varname = "http_onredirect"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_name = "generic_http"),(select id from director_datafield where varname = "http_auth_pair"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_name = "generic_http"),(select id from director_datafield where varname = "http_string"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_name = "generic_http"),(select id from director_datafield where varname = "http_port"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_name = "generic_http"),(select id from director_datafield where varname = "http_proxy_auth_pair"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_name = "generic_http"),(select id from director_datafield where varname = "http_uri"),'n');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_name = "http_website_availability"),(select id from director_datafield where varname = "http_ssl"),'n');

# http_certificate_validity
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_name = "generic_http"),(select id from director_datafield where varname = "http_certificate"),'n');