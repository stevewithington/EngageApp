-- MySQL dump 10.13  Distrib 5.1.49, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: engage
-- ------------------------------------------------------
-- Server version	5.1.49-1ubuntu8.1

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
-- Current Database: `engage`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `engage` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `engage`;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `category_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `event_id` int(10) unsigned NOT NULL,
  `category` varchar(255) NOT NULL,
  `dt_created` datetime NOT NULL,
  `dt_updated` datetime DEFAULT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment` (
  `comment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(10) unsigned NOT NULL,
  `item_type` varchar(20) NOT NULL,
  `comment` text NOT NULL,
  `dt_created` datetime NOT NULL,
  `dt_updated` datetime DEFAULT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `active` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`comment_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,29,'Proposal','<p>\r\n	Test comment!</p>','2010-11-13 12:10:06',NULL,6,NULL,0),(2,8,'Topic Suggestion','<p>\r\n	Hi there--topic suggestion comment.</p>','2010-11-13 12:34:55',NULL,6,NULL,0),(3,29,'Proposal','<p>\r\n	Ohai I think you&#39;re full of it.</p>','2010-11-13 13:02:43',NULL,6,NULL,0),(4,29,'Proposal','<p>\r\n	Here&#39;s another comment.</p>','2010-11-13 13:04:13',NULL,6,NULL,0),(5,29,'Proposal','<p>\r\n	Test to see if stuff works now and stuff.</p>','2010-11-13 13:07:55',NULL,6,NULL,0),(6,29,'Proposal','<p>\r\n	test</p>','2010-11-13 13:08:47',NULL,6,NULL,0),(7,29,'Proposal','<p>\r\n	dsasadsa</p>','2010-11-13 13:11:10',NULL,6,NULL,0),(8,8,'Topic Suggestion','<p>\r\n	here&#39;s a comment!</p>','2010-11-13 13:11:31',NULL,6,NULL,0);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

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
  `user_id` int(10) unsigned NOT NULL,
  `track_id` int(10) unsigned NOT NULL,
  `session_type_id` int(10) unsigned NOT NULL,
  `skill_level_id` tinyint(3) unsigned DEFAULT NULL,
  `status_id` int(10) unsigned NOT NULL,
  `contact_email` varchar(255) NOT NULL,
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
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proposal`
--

LOCK TABLES `proposal` WRITE;
/*!40000 ALTER TABLE `proposal` DISABLE KEYS */;
INSERT INTO `proposal` VALUES (20,7,6,6,5,1,1,'mpwoodward@gmail.com','fadasd','<p>\r\n	faaf</p>','<p>\r\n	sad</p>','<p>\r\n	ads</p>',1,'2010-11-11 10:21:54',NULL,6,NULL,0),(19,7,6,6,5,1,1,'mpwoodward@gmail.com','fadasd','<p>\r\n	faaf</p>','<p>\r\n	sad</p>','<p>\r\n	ads</p>',1,'2010-11-11 10:21:34',NULL,6,NULL,0),(18,7,6,6,5,1,1,'mpwoodward@gmail.com','fadasd','<p>\r\n	faaf</p>','<p>\r\n	sad</p>','<p>\r\n	ads</p>',1,'2010-11-11 10:18:54',NULL,6,NULL,0),(17,7,6,6,5,1,1,'mpwoodward@gmail.com','test','<p>\r\n	test</p>','<p>\r\n	test</p>','<p>\r\n	test</p>',1,'2010-11-11 10:16:08','2010-11-11 10:16:34',6,6,0),(16,7,6,6,5,1,1,'mpwoodward@gmail.com','test','<p>\r\n	test</p>','<p>\r\n	test</p>','<p>\r\n	test</p>',1,'2010-11-11 06:53:30',NULL,6,NULL,0),(15,7,6,6,5,1,1,'matt@mattwoodward.com','Test','<p>\r\n	Beginner level track about stuff</p>','<p>\r\n	It&#39;ll be cool and stuff</p>',NULL,1,'2010-11-11 06:49:00',NULL,6,NULL,0),(21,7,6,6,5,1,1,'mpwoodward@gmail.com','fadasd','<p>\r\n	faaf</p>','<p>\r\n	sad</p>','<p>\r\n	ads</p>',1,'2010-11-11 10:22:26',NULL,6,NULL,0),(22,7,6,6,5,1,1,'mpwoodward@gmail.com','fadasd','<p>\r\n	faaf</p>','<p>\r\n	sad</p>','<p>\r\n	ads</p>',1,'2010-11-11 10:31:31',NULL,6,NULL,0),(23,7,6,6,5,1,1,'mpwoodward@gmail.com','fadasd','<p>\r\n	faaf</p>','<p>\r\n	sad</p>','<p>\r\n	ads</p>',1,'2010-11-11 10:32:20',NULL,6,NULL,0),(24,7,6,6,5,1,1,'mpwoodward@gmail.com','fadasd','<p>\r\n	faaf</p>','<p>\r\n	sad</p>','<p>\r\n	ads</p>',1,'2010-11-11 10:33:04',NULL,6,NULL,0),(25,7,6,6,5,1,1,'mpwoodward@gmail.com','fadasd','<p>\r\n	faaf</p>','<p>\r\n	sad</p>','<p>\r\n	ads</p>',1,'2010-11-11 10:39:35',NULL,6,NULL,0),(26,7,6,6,7,1,1,'mpwoodward@gmail.com','pumpkin spice lattes rule','<p>\r\n	a description of why pumpkin spice lattes are so tasty</p>','<p>\r\n	aaa</p>','<p>\r\n	hell</p>',1,'2010-11-11 15:56:10',NULL,6,NULL,0),(27,7,6,6,5,1,1,'mpwoodward@gmail.com','das','<p>\r\n	ads</p>','<p>\r\n	dsa</p>','<p>\r\n	dsa</p>',1,'2010-11-11 16:05:25',NULL,6,NULL,0),(28,7,6,7,7,2,1,'mpwoodward@gmail.com','asdadas','<p>\r\n	asdasd</p>','<p>\r\n	asddsa</p>','<p>\r\n	asdasd</p>',1,'2010-11-13 10:01:00',NULL,6,NULL,0),(29,7,6,6,5,1,1,'mpwoodward@gmail.com','Test of RSS Fix','<p>\r\n	jaskljdsakl</p>','<p>\r\n	qsadjkadsjaskdl</p>','<p>\r\n	adssda</p>',1,'2010-11-13 10:03:07',NULL,6,NULL,0),(31,7,5,7,7,2,1,'matt@mattwoodward.com','Yet another test!','<p>\r\n	I love talking fast.</p>','<p>\r\n	Teaching people how to talk faster.</p>','<p>\r\n	Organizers, this will be the fastest presentation ever.</p>',1,'2010-11-14 13:37:43',NULL,5,NULL,0),(32,7,6,7,8,1,1,'mpwoodward@gmail.com','Cocoa the Dog is Grumbling for Her Dinner','<p>\r\n	My dog is hungry.</p>','<p>\r\n	She is really complaining!</p>','<p>\r\n	Hello organizers! Pick me!</p>',1,'2010-11-14 16:42:31',NULL,6,NULL,0);
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
) ENGINE=MyISAM AUTO_INCREMENT=46 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proposal_tag`
--

LOCK TABLES `proposal_tag` WRITE;
/*!40000 ALTER TABLE `proposal_tag` DISABLE KEYS */;
INSERT INTO `proposal_tag` VALUES (1,1,'open source'),(2,1,'free software'),(3,1,'open bluedragon'),(4,1,'cfml'),(5,2,'openbd'),(6,2,'cfml'),(7,3,'openbd'),(8,3,'railo'),(9,3,'cfml'),(15,6,'cfml'),(14,6,'openbd'),(12,8,'openbd'),(13,8,'cfml'),(16,10,'openbd'),(17,10,'cfml'),(18,11,'tag1'),(19,11,'tag2'),(20,11,'tag3'),(21,12,'hello'),(22,12,'\'there\''),(23,12,'\"foo\"'),(24,13,'test tag 1'),(25,13,' test tag 2'),(26,16,'test'),(28,17,'test'),(29,18,'asfd'),(30,19,'asfd'),(31,20,'asfd'),(32,21,'asfd'),(33,22,'asfd'),(34,23,'asfd'),(35,24,'asfd'),(36,25,'asfd'),(37,26,'coffee'),(38,26,'girlie drinks'),(39,27,'das'),(40,29,'qsaddsa'),(41,30,'tag1'),(42,30,'tag2'),(43,31,'fast'),(44,32,'dogs'),(45,32,'food');
/*!40000 ALTER TABLE `proposal_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proposal_vote`
--

DROP TABLE IF EXISTS `proposal_vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proposal_vote` (
  `proposal_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`proposal_id`,`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proposal_vote`
--

LOCK TABLES `proposal_vote` WRITE;
/*!40000 ALTER TABLE `proposal_vote` DISABLE KEYS */;
INSERT INTO `proposal_vote` VALUES (19,6),(26,6),(29,2),(29,6),(31,5);
/*!40000 ALTER TABLE `proposal_vote` ENABLE KEYS */;
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
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session_type`
--

LOCK TABLES `session_type` WRITE;
/*!40000 ALTER TABLE `session_type` DISABLE KEYS */;
INSERT INTO `session_type` VALUES (2,5,'Session Type','<p>\r\n	This is a session type!</p>',90,'2010-10-08 15:11:30','2010-10-08 15:11:30',0,0,0),(3,5,'Another Session Type','<p>\r\n	Here is another session type.</p>',180,'2010-10-08 15:12:05','2010-10-08 15:12:05',0,0,0),(4,7,'Regular Session','<p>\r\n	Regular conference session</p>',60,'2010-11-02 22:03:35',NULL,0,NULL,0),(5,7,'Hands-On Session','<p>\r\n	Longer session; participants expected to bring laptops</p>',90,'2010-11-02 22:04:20',NULL,0,NULL,0),(6,7,'Short Session','<p>\r\n	Shorter session</p>',30,'2010-11-02 22:04:43',NULL,0,NULL,0),(7,7,'Pecha Kucha / Lightning Talk','<p>\r\n	Session about 6 minutes 40 seconds in length</p>',7,'2010-11-02 22:05:27',NULL,0,NULL,0),(8,7,'Unconference','<p>\r\n	Session of indeterminate length; organization happens ad hoc on day 3 of the conference</p>',0,'2010-11-02 22:05:59',NULL,0,NULL,0);
/*!40000 ALTER TABLE `session_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skill_level`
--

DROP TABLE IF EXISTS `skill_level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `skill_level` (
  `skill_level_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `skill_level` varchar(255) NOT NULL,
  `ordering` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`skill_level_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skill_level`
--

LOCK TABLES `skill_level` WRITE;
/*!40000 ALTER TABLE `skill_level` DISABLE KEYS */;
INSERT INTO `skill_level` VALUES (1,'Beginner',1),(2,'Intermediate',2),(3,'Advanced',3),(4,'Expert',4);
/*!40000 ALTER TABLE `skill_level` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topic_suggestion`
--

DROP TABLE IF EXISTS `topic_suggestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topic_suggestion` (
  `topic_suggestion_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `event_id` int(10) unsigned NOT NULL,
  `topic` varchar(500) NOT NULL,
  `description` text,
  `suggested_speaker` varchar(500) DEFAULT NULL,
  `dt_created` datetime NOT NULL,
  `dt_updated` datetime DEFAULT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`topic_suggestion_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topic_suggestion`
--

LOCK TABLES `topic_suggestion` WRITE;
/*!40000 ALTER TABLE `topic_suggestion` DISABLE KEYS */;
INSERT INTO `topic_suggestion` VALUES (4,7,'Once more, with feeling','<p>\r\n	Test</p>\r\n','The Dalai Lama','2010-11-11 07:12:42',NULL,6,NULL),(5,7,'Topic Suggestion','<p>\r\n	This topic is pretty nebulous</p>\r\n','Mahatma Ghandi','2010-11-11 16:00:12',NULL,6,NULL),(6,7,'asdsa','<p>\r\n	adsads</p>\r\n','adsads','2010-11-11 16:02:36',NULL,6,NULL),(8,7,'Let\'s make this a real topic title','<p>\r\n	Here is some &quot;real&quot; content</p>\r\n','free software,open source','2010-11-11 16:53:07','2010-11-13 19:07:46',6,0),(9,7,'dsadsa','<p>\r\n	asddsa</p>\r\n','adssda','2010-11-14 10:28:16',NULL,2,NULL),(10,7,'test!111','<p>\r\n	ZOMG!</p>\r\n','hello','2010-11-14 16:42:51',NULL,6,NULL);
/*!40000 ALTER TABLE `topic_suggestion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topic_suggestion_category`
--

DROP TABLE IF EXISTS `topic_suggestion_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topic_suggestion_category` (
  `topic_suggestion_id` int(10) unsigned NOT NULL,
  `category_id` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topic_suggestion_category`
--

LOCK TABLES `topic_suggestion_category` WRITE;
/*!40000 ALTER TABLE `topic_suggestion_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `topic_suggestion_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topic_suggestion_vote`
--

DROP TABLE IF EXISTS `topic_suggestion_vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topic_suggestion_vote` (
  `topic_suggestion_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`topic_suggestion_id`,`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topic_suggestion_vote`
--

LOCK TABLES `topic_suggestion_vote` WRITE;
/*!40000 ALTER TABLE `topic_suggestion_vote` DISABLE KEYS */;
INSERT INTO `topic_suggestion_vote` VALUES (4,6),(8,5);
/*!40000 ALTER TABLE `topic_suggestion_vote` ENABLE KEYS */;
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
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `track`
--

LOCK TABLES `track` WRITE;
/*!40000 ALTER TABLE `track` DISABLE KEYS */;
INSERT INTO `track` VALUES (2,0,'Swedish Fish \"Track\"','<p>\r\n	Entire track dedicated to the wonders of Swedish Fish.</p>','<p>\r\n	Swedish Fish. How much can you love a candy? Come explore with us and share your stories of addition, love, loss, and redemption with this, the finest of candies.</p>','e01223','2010-10-07 20:27:38','2010-10-08 11:29:31',0,0,0),(3,6,'Track Two','<p>\r\n	This is another track.</p>','<p>\r\n	More testing. I see a lot of this in my future.</p>','335fb0','2010-10-07 20:33:11','2010-10-07 20:33:11',0,0,0),(4,5,'Main Track','<p>\r\n	The main track</p>','<p>\r\n	This is the main track</p>','3269ba','2010-10-10 10:08:26',NULL,0,NULL,0),(5,5,'Second Track','<p>\r\n	Another track</p>','<p>\r\n	Another Track for testing!</p>','b002b0','2010-10-11 18:19:41',NULL,0,NULL,0),(6,7,'Main Conference Track','<p>\r\n	The main conference track</p>','<p>\r\n	Main conference track</p>','d100d1','2010-11-02 22:10:02',NULL,0,NULL,0),(7,7,'Unconference','<p>\r\n	Unconference track</p>','<p>\r\n	Unconference track</p>','2100c7','2010-11-02 22:10:29',NULL,0,NULL,0);
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
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(500) DEFAULT NULL,
  `oauth_provider` varchar(10) NOT NULL,
  `oauth_uid` text NOT NULL,
  `oauth_profile_link` varchar(500) NOT NULL,
  `is_registered` tinyint(3) unsigned NOT NULL,
  `is_admin` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `dt_created` datetime NOT NULL,
  `dt_updated` datetime DEFAULT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `active` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (5,'matt@mattwoodward.com','Matt Woodward','facebook','563317007','http://www.facebook.com/matt.woodward3',0,1,'2010-11-11 06:43:14','2010-11-14 13:35:59',5,5,0),(6,'mpwoodward@gmail.com','Matt Woodward','twitter','mpwoodward','http://www.twitter.com/mpwoodward',0,0,'2010-11-11 06:43:39','2010-11-14 13:36:16',6,5,0);
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

-- Dump completed on 2010-11-19  7:55:53
