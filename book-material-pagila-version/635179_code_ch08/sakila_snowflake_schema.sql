-- MySQL dump 10.13  Distrib 5.1.36, for Win32 (ia32)
--
-- Host: localhost    Database: sakila_snowflake
-- ------------------------------------------------------
-- Server version	5.1.36-community

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
-- Current Database: `sakila_snowflake`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `sakila_snowflake` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `sakila_snowflake`;

--
-- Table structure for table `dim_actor`
--

DROP TABLE IF EXISTS `dim_actor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dim_actor` (
  `actor_key` int(10) NOT NULL AUTO_INCREMENT,
  `actor_last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `actor_id` int(10) NOT NULL,
  `actor_last_name` varchar(45) NOT NULL,
  `actor_first_name` varchar(45) NOT NULL,
  PRIMARY KEY (`actor_key`),
  KEY `dim_actor_last_update` (`actor_last_update`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dim_customer`
--

DROP TABLE IF EXISTS `dim_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dim_customer` (
  `customer_key` int(8) NOT NULL AUTO_INCREMENT,
  `location_address_key` int(10) NOT NULL,
  `customer_last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `customer_id` int(8) DEFAULT NULL,
  `customer_first_name` varchar(45) DEFAULT NULL,
  `customer_last_name` varchar(45) DEFAULT NULL,
  `customer_email` varchar(50) DEFAULT NULL,
  `customer_active` char(3) DEFAULT NULL,
  `customer_created` date DEFAULT NULL,
  `customer_version_number` smallint(5) DEFAULT NULL,
  `customer_valid_from` date DEFAULT NULL,
  `customer_valid_through` date DEFAULT NULL,
  PRIMARY KEY (`customer_key`),
  KEY `customer_id` (`customer_id`) USING BTREE,
  KEY `dim_customer_last_update` (`customer_last_update`),
  KEY `dim_location_address_dim_customer_fk` (`location_address_key`),
  CONSTRAINT `dim_location_address_dim_customer_fk` FOREIGN KEY (`location_address_key`) REFERENCES `dim_location_address` (`location_address_key`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dim_date`
--

DROP TABLE IF EXISTS `dim_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dim_date` (
  `date_key` int(8) NOT NULL,
  `date_value` date NOT NULL,
  `date_short` char(12) NOT NULL,
  `date_medium` char(16) NOT NULL,
  `date_long` char(24) NOT NULL,
  `date_full` char(32) NOT NULL,
  `day_in_year` smallint(5) NOT NULL,
  `day_in_month` tinyint(3) NOT NULL,
  `is_first_day_in_month` char(10) NOT NULL,
  `is_last_day_in_month` char(10) NOT NULL,
  `day_abbreviation` char(3) NOT NULL,
  `day_name` char(12) NOT NULL,
  `week_in_year` tinyint(3) NOT NULL,
  `week_in_month` tinyint(3) NOT NULL,
  `is_first_day_in_week` char(10) NOT NULL,
  `is_last_day_in_week` char(10) NOT NULL,
  `month_number` tinyint(3) NOT NULL,
  `month_abbreviation` char(3) NOT NULL,
  `month_name` char(12) NOT NULL,
  `year2` char(2) NOT NULL,
  `year4` smallint(5) NOT NULL,
  `quarter_name` char(2) NOT NULL,
  `quarter_number` tinyint(3) NOT NULL,
  `year_quarter` char(7) NOT NULL,
  `year_month_number` char(7) NOT NULL,
  `year_month_abbreviation` char(8) NOT NULL,
  PRIMARY KEY (`date_key`),
  UNIQUE KEY `date` (`date_value`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dim_film`
--

DROP TABLE IF EXISTS `dim_film`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dim_film` (
  `film_key` int(8) NOT NULL AUTO_INCREMENT,
  `film_last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `film_id` int(10) NOT NULL,
  `film_title` varchar(64) NOT NULL,
  `film_description` text NOT NULL,
  `film_release_year` smallint(5) NOT NULL,
  `film_language` varchar(20) NOT NULL,
  `film_original_language` varchar(20) NOT NULL,
  `film_rental_duration` tinyint(3) DEFAULT NULL,
  `film_rental_rate` decimal(4,2) DEFAULT NULL,
  `film_duration` int(8) DEFAULT NULL,
  `film_replacement_cost` decimal(5,2) DEFAULT NULL,
  `film_rating_code` char(5) DEFAULT NULL,
  `film_rating_text` varchar(30) DEFAULT NULL,
  `film_has_trailers` char(4) DEFAULT NULL,
  `film_has_commentaries` char(4) DEFAULT NULL,
  `film_has_deleted_scenes` char(4) DEFAULT NULL,
  `film_has_behind_the_scenes` char(4) DEFAULT NULL,
  `film_in_category_action` char(4) DEFAULT NULL,
  `film_in_category_animation` char(4) DEFAULT NULL,
  `film_in_category_children` char(4) DEFAULT NULL,
  `film_in_category_classics` char(4) DEFAULT NULL,
  `film_in_category_comedy` char(4) DEFAULT NULL,
  `film_in_category_documentary` char(4) DEFAULT NULL,
  `film_in_category_drama` char(4) DEFAULT NULL,
  `film_in_category_family` char(4) DEFAULT NULL,
  `film_in_category_foreign` char(4) DEFAULT NULL,
  `film_in_category_games` char(4) DEFAULT NULL,
  `film_in_category_horror` char(4) DEFAULT NULL,
  `film_in_category_music` char(4) DEFAULT NULL,
  `film_in_category_new` char(4) DEFAULT NULL,
  `film_in_category_scifi` char(4) DEFAULT NULL,
  `film_in_category_sports` char(4) DEFAULT NULL,
  `film_in_category_travel` char(4) DEFAULT NULL,
  PRIMARY KEY (`film_key`),
  KEY `dim_film_last_update` (`film_last_update`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dim_film_actor_bridge`
--

DROP TABLE IF EXISTS `dim_film_actor_bridge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dim_film_actor_bridge` (
  `film_key` int(8) NOT NULL,
  `actor_key` int(10) NOT NULL,
  `actor_weighing_factor` decimal(3,2) NOT NULL,
  PRIMARY KEY (`film_key`,`actor_key`),
  KEY `dim_actor_dim_film_actor_bridge_fk` (`actor_key`),
  CONSTRAINT `dim_actor_dim_film_actor_bridge_fk` FOREIGN KEY (`actor_key`) REFERENCES `dim_actor` (`actor_key`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `dim_film_dim_film_actor_bridge_fk` FOREIGN KEY (`film_key`) REFERENCES `dim_film` (`film_key`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dim_location_address`
--

DROP TABLE IF EXISTS `dim_location_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dim_location_address` (
  `location_address_key` int(10) NOT NULL AUTO_INCREMENT,
  `location_city_key` int(10) NOT NULL,
  `location_address_id` int(10) NOT NULL,
  `location_address_last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `location_address` varchar(64) NOT NULL,
  `location_address_postal_code` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`location_address_key`),
  KEY `dim_location_city_dim_location_address_fk` (`location_city_key`),
  CONSTRAINT `dim_location_city_dim_location_address_fk` FOREIGN KEY (`location_city_key`) REFERENCES `dim_location_city` (`location_city_key`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=604 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dim_location_city`
--

DROP TABLE IF EXISTS `dim_location_city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dim_location_city` (
  `location_city_key` int(10) NOT NULL AUTO_INCREMENT,
  `location_country_key` int(10) NOT NULL,
  `location_city_name` varchar(50) NOT NULL,
  `location_city_id` smallint(10) NOT NULL,
  `location_city_last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`location_city_key`),
  KEY `dim_location_country_dim_location_city_fk` (`location_country_key`),
  CONSTRAINT `dim_location_country_dim_location_city_fk` FOREIGN KEY (`location_country_key`) REFERENCES `dim_location_country` (`location_country_key`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=601 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dim_location_country`
--

DROP TABLE IF EXISTS `dim_location_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dim_location_country` (
  `location_country_key` int(10) NOT NULL AUTO_INCREMENT,
  `location_country_id` smallint(10) NOT NULL,
  `location_country_last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `location_country_name` varchar(50) NOT NULL,
  PRIMARY KEY (`location_country_key`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dim_staff`
--

DROP TABLE IF EXISTS `dim_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dim_staff` (
  `staff_key` int(8) NOT NULL AUTO_INCREMENT,
  `staff_last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `staff_id` int(8) DEFAULT NULL,
  `staff_first_name` varchar(45) DEFAULT NULL,
  `staff_last_name` varchar(45) DEFAULT NULL,
  `staff_store_id` int(8) DEFAULT NULL,
  `staff_version_number` smallint(5) DEFAULT NULL,
  `staff_valid_from` date DEFAULT NULL,
  `staff_valid_through` date DEFAULT NULL,
  `staff_active` char(3) DEFAULT NULL,
  PRIMARY KEY (`staff_key`),
  KEY `dim_staff_last_update` (`staff_last_update`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dim_store`
--

DROP TABLE IF EXISTS `dim_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dim_store` (
  `store_key` int(8) NOT NULL AUTO_INCREMENT,
  `location_address_key` int(10) NOT NULL,
  `store_last_update` time NOT NULL,
  `store_id` int(8) DEFAULT NULL,
  `store_manager_staff_id` int(8) DEFAULT NULL,
  `store_manager_first_name` varchar(45) DEFAULT NULL,
  `store_manager_last_name` varchar(45) DEFAULT NULL,
  `store_version_number` smallint(5) DEFAULT NULL,
  `store_valid_from` date DEFAULT NULL,
  `store_valid_through` date DEFAULT NULL,
  PRIMARY KEY (`store_key`),
  KEY `store_id` (`store_id`) USING BTREE,
  KEY `dim_store_last_update` (`store_last_update`),
  KEY `dim_location_address_dim_store_fk` (`location_address_key`),
  CONSTRAINT `dim_location_address_dim_store_fk` FOREIGN KEY (`location_address_key`) REFERENCES `dim_location_address` (`location_address_key`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dim_time`
--

DROP TABLE IF EXISTS `dim_time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dim_time` (
  `time_key` int(8) NOT NULL,
  `time_value` time NOT NULL,
  `hours24` tinyint(3) NOT NULL,
  `hours12` tinyint(3) DEFAULT NULL,
  `minutes` tinyint(3) DEFAULT NULL,
  `seconds` tinyint(3) DEFAULT NULL,
  `am_pm` char(3) DEFAULT NULL,
  PRIMARY KEY (`time_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fact_rental`
--

DROP TABLE IF EXISTS `fact_rental`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fact_rental` (
  `rental_id` int(10) NOT NULL,
  `rental_last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `customer_key` int(8) NOT NULL,
  `staff_key` int(8) NOT NULL,
  `film_key` int(8) NOT NULL,
  `store_key` int(8) NOT NULL,
  `rental_date_key` int(8) NOT NULL,
  `return_date_key` int(10) NOT NULL,
  `return_time_key` int(8) NOT NULL,
  `count_returns` int(10) NOT NULL,
  `count_rentals` int(8) NOT NULL,
  `rental_duration` int(10) DEFAULT NULL,
  PRIMARY KEY (`rental_id`),
  KEY `dim_store_fact_rental_fk` (`store_key`),
  KEY `dim_staff_fact_rental_fk` (`staff_key`),
  KEY `dim_time_fact_rental_fk` (`return_time_key`),
  KEY `dim_film_fact_rental_fk` (`film_key`),
  KEY `dim_date_fact_rental_fk` (`rental_date_key`),
  KEY `dim_date_fact_rental_fk1` (`return_date_key`),
  KEY `dim_customer_fact_rental_fk` (`customer_key`),
  CONSTRAINT `dim_customer_fact_rental_fk` FOREIGN KEY (`customer_key`) REFERENCES `dim_customer` (`customer_key`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dim_date_fact_rental_fk` FOREIGN KEY (`rental_date_key`) REFERENCES `dim_date` (`date_key`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dim_date_fact_rental_fk1` FOREIGN KEY (`return_date_key`) REFERENCES `dim_date` (`date_key`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dim_film_fact_rental_fk` FOREIGN KEY (`film_key`) REFERENCES `dim_film` (`film_key`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dim_staff_fact_rental_fk` FOREIGN KEY (`staff_key`) REFERENCES `dim_staff` (`staff_key`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dim_store_fact_rental_fk` FOREIGN KEY (`store_key`) REFERENCES `dim_store` (`store_key`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dim_time_fact_rental_fk` FOREIGN KEY (`return_time_key`) REFERENCES `dim_time` (`time_key`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-03-12  1:39:04
