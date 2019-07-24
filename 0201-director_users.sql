
-- Dump of sql contents for users notifications
-- Timeperiods
-- ID 1 - 1000 reserved for template values

--
-- Table `icinga_user`
--
LOCK TABLES `icinga_user` WRITE;
/*!40000 ALTER TABLE `icinga_user` DISABLE KEYS */;
INSERT IGNORE INTO `icinga_user` (`id`, `object_name`, `object_type`, `disabled`, `display_name`, `email`, `pager`, `enable_notifications`, `period_id`, `zone_id`) VALUES
(1, 'notify-allEvents', 'template', 'n', NULL, NULL, NULL, 'y', NULL, NULL),
(2, 'user 1', 'object', 'n', 'Username', 'user.name@neteye.local', NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `icinga_user` ENABLE KEYS */;
ALTER TABLE `icinga_user` AUTO_INCREMENT=10001;
UNLOCK TABLES;

-- Timeranges for icinga_user_inheritance

LOCK TABLES `icinga_user_inheritance` WRITE;
/*!40000 ALTER TABLE `icinga_user_inheritance` DISABLE KEYS */;
INSERT IGNORE INTO `icinga_user_inheritance` (`user_id`, `parent_user_id`, `weight`) VALUES
(2, 1, 1);
UNLOCK TABLES;


-- Includes for icinga_user_states_set
LOCK TABLES `icinga_user_states_set` WRITE;
/*!40000 ALTER TABLE `icinga_user_states_set` DISABLE KEYS */;
INSERT IGNORE INTO `icinga_user_states_set` (`user_id`, `property`, `merge_behaviour`) VALUES
(1, 'OK', 'override'),
(1, 'Warning', 'override'),
(1, 'Critical', 'override'),
(1, 'Unknown', 'override'),
(1, 'Up', 'override'),
(1, 'Down', 'override');
UNLOCK TABLES;

-- Includes for icinga_user_types_set
LOCK TABLES `icinga_user_types_set` WRITE;
/*!40000 ALTER TABLE `icinga_user_types_set` DISABLE KEYS */;
INSERT IGNORE INTO `icinga_user_types_set` (`user_id`, `property`, `merge_behaviour`) VALUES
(1, 'DowntimeStart', 'override'),
(1, 'DowntimeEnd', 'override'),
(1, 'DowntimeRemoved', 'override'),
(1, 'Custom', 'override'),
(1, 'Acknowledgement', 'override'),
(1, 'Problem', 'override'),
(1, 'Recovery', 'override'),
(1, 'FlappingStart', 'override'),
(1, 'FlappingEnd', 'override');
UNLOCK TABLES;

