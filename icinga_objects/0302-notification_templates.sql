--
-- Relations Notification Template - Director Field
-- For default deployment
--
INSERT IGNORE icinga_notification_field (notification_id, datafield_id, is_required) VALUES ((select id from icinga_notification where object_type = "template" AND object_name = "generic notify all events"),(select id from director_datafield where varname = "notification_from"),'y');
