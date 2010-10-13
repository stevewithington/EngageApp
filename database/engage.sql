-- MySQL dump 10.13  Distrib 5.1.41, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: engage
-- ------------------------------------------------------
-- Server version	5.1.41-3ubuntu12.6

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event` (
  `event_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `proposal_deadline` datetime NOT NULL,
  `allow_proposal_title_edits` tinyint(3) unsigned NOT NULL,
  `publish_proposal_statuses` tinyint(3) unsigned NOT NULL,
  `publish_schedule` tinyint(3) unsigned NOT NULL,
  `accept_proposal_comments_after_deadline` tinyint(3) unsigned NOT NULL,
  `open_text` text NOT NULL,
  `closed_text` text NOT NULL,
  `session_text` text,
  `tracks_text` text,
  `dt_created` datetime NOT NULL,
  `dt_updated` datetime DEFAULT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `active` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`event_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (1,NULL,'slug','title','2010-10-06 00:00:00','2010-10-07 00:00:00','2010-10-28 00:00:00',1,1,1,1,'<p>\r\n	open text</p>','<p>\r\n	closed text</p>','<p>\r\n	sesison text</p>','<p>\r\n	tracks text</p>','2010-10-06 21:38:10','2010-10-06 21:38:10',0,0,0),(3,NULL,'asd','Technology Assessment','2010-10-06 00:00:00','2010-10-06 00:00:00','2010-10-06 00:00:00',0,0,0,0,'<p>\r\n	asd</p>','<p>\r\n	ads</p>',NULL,NULL,'2010-10-06 21:46:49','2010-10-06 21:46:49',0,0,0),(5,NULL,'foo','bar','2010-10-06 00:00:00','2010-10-06 00:00:00','2010-10-06 00:00:00',0,0,0,0,'<p>\r\n	foo</p>','<p>\r\n	bar</p>',NULL,NULL,'2010-10-06 23:01:19','2010-10-06 23:01:43',0,0,0),(7,NULL,'Test','Test Without Child Event Crap','2010-10-22 00:00:00','2010-10-24 00:00:00','2010-10-01 00:00:00',0,0,0,0,'<p>\r\n	Open text</p>','<p>\r\n	closed text</p>','<p>\r\n	session text</p>','<p>\r\n	tracks text</p>','2010-10-09 14:01:14',NULL,0,NULL,0);
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proposal`
--

DROP TABLE IF EXISTS `proposal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proposal` (
  `proposal_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `event_id` int(10) unsigned NOT NULL,
  `track_id` int(10) unsigned NOT NULL,
  `session_type_id` int(10) unsigned NOT NULL,
  `status_id` int(10) unsigned NOT NULL,
  `title` varchar(500) NOT NULL,
  `excerpt` varchar(1000) DEFAULT NULL,
  `description` text NOT NULL,
  `note_to_organizers` varchar(1000) DEFAULT NULL,
  `agreed_to_terms` tinyint(3) unsigned NOT NULL,
  `dt_created` datetime NOT NULL,
  `dt_updated` datetime DEFAULT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `active` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`proposal_id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proposal`
--

LOCK TABLES `proposal` WRITE;
/*!40000 ALTER TABLE `proposal` DISABLE KEYS */;
INSERT INTO `proposal` VALUES (1,5,4,2,1,'First Proposal Test','<p>\r\n	This is the excerpt for my proposal.</p>','<p>\r\n	This is the description of my proposal.</p>','This is the note to the organizers.',1,'2010-10-10 10:15:09',NULL,0,NULL,0),(2,5,4,2,1,'Second Proposal Test','<p>\r\n	more stuff</p>','<p>\r\n	more stuff more</p>','note',1,'2010-10-10 10:23:15',NULL,0,NULL,0),(3,5,4,2,1,'Third Proposal Test','<p>\r\n	Another one!</p>','<p>\r\n	Third time is often the charm.</p>','Note!',1,'2010-10-10 10:24:57',NULL,0,NULL,0),(4,5,4,2,2,'Free Beats Prop Every Time','<p>\r\n	Judas</p>','<p>\r\n	Priest</p>',NULL,1,'2010-10-10 10:44:01',NULL,0,NULL,0),(6,5,5,2,1,'Test!','<p>\r\n	This is another test.</p>','<p>\r\n	Testing is fun.</p>',NULL,1,'2010-10-10 12:45:59','2010-10-11 18:24:33',0,0,0),(7,5,4,2,1,'Judas','<p>\r\n	Testes.</p>','<p>\r\n	123?</p>',NULL,1,'2010-10-10 12:51:54',NULL,0,NULL,0),(8,5,4,2,1,'Second Proposal Test','<p>\r\n	more stuff</p>','<p>\r\n	more stuff more</p>','note',1,'2010-10-10 13:18:40',NULL,0,NULL,0),(9,5,4,3,3,'Test with session type','<p>\r\n	excerpt</p>','<p>\r\n	description</p>',NULL,1,'2010-10-11 08:03:59',NULL,0,NULL,0);
/*!40000 ALTER TABLE `proposal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proposal_comment`
--

DROP TABLE IF EXISTS `proposal_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proposal_comment` (
  `comment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `proposal_id` int(10) unsigned NOT NULL,
  `comment` text NOT NULL,
  `is_private` tinyint(3) unsigned NOT NULL,
  `dt_created` datetime NOT NULL,
  `dt_updated` datetime DEFAULT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `active` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`comment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proposal_comment`
--

LOCK TABLES `proposal_comment` WRITE;
/*!40000 ALTER TABLE `proposal_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `proposal_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proposal_speaker`
--

DROP TABLE IF EXISTS `proposal_speaker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proposal_speaker` (
  `proposal_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proposal_speaker`
--

LOCK TABLES `proposal_speaker` WRITE;
/*!40000 ALTER TABLE `proposal_speaker` DISABLE KEYS */;
/*!40000 ALTER TABLE `proposal_speaker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proposal_status`
--

DROP TABLE IF EXISTS `proposal_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proposal_status` (
  `status_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status` varchar(255) NOT NULL,
  PRIMARY KEY (`status_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proposal_status`
--

LOCK TABLES `proposal_status` WRITE;
/*!40000 ALTER TABLE `proposal_status` DISABLE KEYS */;
INSERT INTO `proposal_status` VALUES (1,'Proposed'),(2,'Accept'),(3,'Accept and Confirm'),(4,'Accept and Decline'),(5,'Mark as Junk'),(6,'Reject');
/*!40000 ALTER TABLE `proposal_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proposal_tag`
--

DROP TABLE IF EXISTS `proposal_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proposal_tag` (
  `tag_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `proposal_id` int(10) unsigned NOT NULL,
  `tag` varchar(255) NOT NULL,
  PRIMARY KEY (`tag_id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proposal_tag`
--

LOCK TABLES `proposal_tag` WRITE;
/*!40000 ALTER TABLE `proposal_tag` DISABLE KEYS */;
INSERT INTO `proposal_tag` VALUES (1,1,'open source'),(2,1,'free software'),(3,1,'open bluedragon'),(4,1,'cfml'),(5,2,'openbd'),(6,2,'cfml'),(7,3,'openbd'),(8,3,'railo'),(9,3,'cfml'),(15,6,'cfml'),(14,6,'openbd'),(12,8,'openbd'),(13,8,'cfml');
/*!40000 ALTER TABLE `proposal_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room` (
  `room_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `event_id` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `capacity` smallint(5) unsigned NOT NULL,
  `size` varchar(255) DEFAULT NULL,
  `seating_configuration` varchar(255) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `image` varchar(500) DEFAULT NULL,
  `dt_created` datetime NOT NULL,
  `dt_updated` datetime DEFAULT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `active` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`room_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES (2,0,'Another Room',83,'12x12','chairs randomly thrown about the room','<p>\r\n	This room is another room altogether. It is completely separate from the first room. They don&#39;t even share a door!</p>',NULL,'2010-10-09 07:44:48','2010-10-09 08:05:06',0,0,0),(3,5,'Training Room',10,'10x10','Chairs with tables','<p>\r\n	Small training room.</p>',NULL,'2010-10-09 11:17:33',NULL,0,NULL,0);
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule_item`
--

DROP TABLE IF EXISTS `schedule_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedule_item` (
  `schedule_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `event_id` int(10) unsigned NOT NULL,
  `room_id` int(10) unsigned DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `excerpt` varchar(1000) DEFAULT NULL,
  `description` text,
  `start_time` datetime DEFAULT NULL,
  `duration` smallint(5) unsigned DEFAULT NULL,
  `dt_created` datetime NOT NULL,
  `dt_updated` datetime DEFAULT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `active` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`schedule_item_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule_item`
--

LOCK TABLES `schedule_item` WRITE;
/*!40000 ALTER TABLE `schedule_item` DISABLE KEYS */;
INSERT INTO `schedule_item` VALUES (2,0,2,'Keynote','<p>\r\n	opening keynote</p>','<p>\r\n	This is the opening keynote</p>','2010-10-16 10:00:00',60,'2010-10-09 11:32:32',NULL,0,NULL,0);
/*!40000 ALTER TABLE `schedule_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session`
--

DROP TABLE IF EXISTS `session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `session` (
  `session_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `event_id` int(10) unsigned NOT NULL,
  `proposal_id` int(10) unsigned NOT NULL,
  `room_id` int(10) unsigned DEFAULT NULL,
  `session_time` datetime NOT NULL,
  `dt_created` datetime NOT NULL,
  `dt_updated` datetime DEFAULT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `active` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`session_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session`
--

LOCK TABLES `session` WRITE;
/*!40000 ALTER TABLE `session` DISABLE KEYS */;
INSERT INTO `session` VALUES (1,5,9,3,'2010-10-04 00:00:00','2010-10-11 18:10:04',NULL,0,NULL,0),(2,5,8,3,'2010-10-20 07:00:00','2010-10-11 18:11:06',NULL,0,NULL,0),(3,5,6,3,'2010-10-21 00:00:00','2010-10-11 18:19:59',NULL,0,NULL,0);
/*!40000 ALTER TABLE `session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session_type`
--

DROP TABLE IF EXISTS `session_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `session_type` (
  `session_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `event_id` int(10) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `duration` int(10) unsigned NOT NULL,
  `dt_created` datetime NOT NULL,
  `dt_updated` datetime DEFAULT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `active` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`session_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session_type`
--

LOCK TABLES `session_type` WRITE;
/*!40000 ALTER TABLE `session_type` DISABLE KEYS */;
INSERT INTO `session_type` VALUES (2,5,'Session Type','<p>\r\n	This is a session type!</p>',90,'2010-10-08 15:11:30','2010-10-08 15:11:30',0,0,0),(3,5,'Another Session Type','<p>\r\n	Here is another session type.</p>',180,'2010-10-08 15:12:05','2010-10-08 15:12:05',0,0,0);
/*!40000 ALTER TABLE `session_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `track`
--

DROP TABLE IF EXISTS `track`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `track` (
  `track_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `event_id` int(10) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `excerpt` varchar(1000) NOT NULL,
  `description` text NOT NULL,
  `color` char(6) NOT NULL,
  `dt_created` datetime NOT NULL,
  `dt_updated` datetime DEFAULT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `active` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`track_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `track`
--

LOCK TABLES `track` WRITE;
/*!40000 ALTER TABLE `track` DISABLE KEYS */;
INSERT INTO `track` VALUES (2,0,'Swedish Fish \"Track\"','<p>\r\n	Entire track dedicated to the wonders of Swedish Fish.</p>','<p>\r\n	Swedish Fish. How much can you love a candy? Come explore with us and share your stories of addition, love, loss, and redemption with this, the finest of candies.</p>','e01223','2010-10-07 20:27:38','2010-10-08 11:29:31',0,0,0),(3,6,'Track Two','<p>\r\n	This is another track.</p>','<p>\r\n	More testing. I see a lot of this in my future.</p>','335fb0','2010-10-07 20:33:11','2010-10-07 20:33:11',0,0,0),(4,5,'Main Track','<p>\r\n	The main track</p>','<p>\r\n	This is the main track</p>','3269ba','2010-10-10 10:08:26',NULL,0,NULL,0),(5,5,'Second Track','<p>\r\n	Another track</p>','<p>\r\n	Another Track for testing!</p>','b002b0','2010-10-11 18:19:41',NULL,0,NULL,0);
/*!40000 ALTER TABLE `track` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` char(64) DEFAULT NULL,
  `password_salt` char(35) DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `oauth_provider` varchar(10) DEFAULT NULL,
  `oauth_uid` text,
  `is_admin` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `dt_created` datetime NOT NULL,
  `dt_updated` datetime DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `active` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-10-13 16:54:57
