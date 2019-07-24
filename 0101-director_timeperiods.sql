
-- Dump of sql contents for notifcation
-- Timeperiods
-- ID 1 - 1000 reserved for timeperiods

--
-- Table `icinga_timeperiod`
--
LOCK TABLES `icinga_timeperiod` WRITE;
/*!40000 ALTER TABLE `icinga_timeperiod` DISABLE KEYS */;
INSERT IGNORE INTO `icinga_timeperiod` (`id`, `object_name`, `display_name`, `update_method`, `zone_id`, `object_type`, `disabled`, `prefer_includes`) VALUES
(1, '24x7', '24x7', 'LegacyTimePeriod', NULL, 'object', 'n', NULL),
(2, 'workhours', 'workhours 8:30 - 17:30', 'LegacyTimePeriod', NULL, 'object', 'n', NULL),
(3, 'non-workhours', 'non workhours', 'LegacyTimePeriod', NULL, 'object', 'n', NULL),
(4, 'holidays', 'holidays', 'LegacyTimePeriod', NULL, 'object', 'n', NULL);
/*!40000 ALTER TABLE `icinga_timeperiod` ENABLE KEYS */;
ALTER TABLE `icinga_timeperiod` AUTO_INCREMENT=10001;
UNLOCK TABLES;

-- Timeranges for timeperiod

LOCK TABLES `icinga_timeperiod_range` WRITE;
/*!40000 ALTER TABLE `icinga_timeperiod_range` DISABLE KEYS */;
INSERT IGNORE INTO `icinga_timeperiod_range` (`timeperiod_id`, `range_key`, `range_value`, `range_type`, `merge_behaviour`) VALUES
(1, 'monday', '00:00-24:00', 'include', 'set'),
(1, 'tuesday', '00:00-24:00', 'include', 'set'),
(1, 'wednesday', '00:00-24:00', 'include', 'set'),
(1, 'thursday', '00:00-24:00', 'include', 'set'),
(1, 'friday', '00:00-24:00', 'include', 'set'),
(1, 'saturday', '00:00-24:00', 'include', 'set'),
(1, 'sunday', '00:00-24:00', 'include', 'set'),
(2, 'monday', '07:00-21:30', 'include', 'set'),
(2, 'tuesday', '07:00-21:30', 'include', 'set'),
(2, 'wednesday', '07:00-21:30', 'include', 'set'),
(2, 'thursday', '07:00-21:30', 'include', 'set'),
(2, 'friday', '07:00-21:30', 'include', 'set'),
(3, 'monday', '00:00-08:30,17:30-24:00', 'include', 'set'),
(3, 'tuesday', '00:00-08:30,17:30-24:00', 'include', 'set'),
(3, 'wednesday', '00:00-08:30,17:30-24:00', 'include', 'set'),
(3, 'thursday', '00:00-08:30,17:30-24:00', 'include', 'set'),
(3, 'friday', '00:00-08:30,17:30-24:00', 'include', 'set'),
(3, 'saturday', '00:00-24:00', 'include', 'set'),
(3, 'sunday', '00:00-24:00', 'include', 'set'),
(4, 'december 25', '00:00-24:00', 'include', 'set'),
(4, 'december 26', '00:00-24:00', 'include', 'set'),
(4, 'january 1', '00:00-24:00', 'include', 'set'),
(4, 'may 1', '00:00-24:00', 'include', 'set');
/*!40000 ALTER TABLE `icinga_timeperiod_range` ENABLE KEYS */;
ALTER TABLE `icinga_timeperiod_range` AUTO_INCREMENT=10001;
UNLOCK TABLES;

-- Includes for timeperiod
LOCK TABLES `icinga_timeperiod_include` WRITE;
/*!40000 ALTER TABLE `icinga_timeperiod_include` DISABLE KEYS */;
INSERT IGNORE INTO `icinga_timeperiod_include` (`timeperiod_id`, `include_id`) VALUES
(3, 4);
UNLOCK TABLES;

