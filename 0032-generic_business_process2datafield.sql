--
-- Relations Service Template - Director Field
-- For default deployment
--

# generic_business_process
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_name = "generic_business_process"),(select id from director_datafield where varname = "icingacli_businessprocess_config"),'y');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_name = "generic_business_process"),(select id from director_datafield where varname = "icingacli_businessprocess_process"),'y');
INSERT IGNORE icinga_service_field (service_id, datafield_id, is_required) VALUES ((SELECT id FROM icinga_service WHERE object_name = "generic_business_process"),(select id from director_datafield where varname = "icingacli_businessprocess_details"),'n');
