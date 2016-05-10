DROP TABLE IF EXISTS `dim_actor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dim_actor` (
  `actor_key` int(10) NOT NULL AUTO_INCREMENT,
  `actor_last_update` datetime NOT NULL,
  `actor_last_name` varchar(45) NOT NULL,
  `actor_first_name` varchar(45) NOT NULL,
  `actor_id` int(11) NOT NULL,
  PRIMARY KEY (`actor_key`)
) ENGINE=MyISAM AUTO_INCREMENT=201 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dim_customer`
--

DROP TABLE IF EXISTS `dim_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dim_customer` (
  `customer_key` int(8) NOT NULL AUTO_INCREMENT,
  `customer_last_update` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `customer_id` int(8) DEFAULT NULL,
  `customer_first_name` varchar(45) DEFAULT NULL,
  `customer_last_name` varchar(45) DEFAULT NULL,
  `customer_email` varchar(50) DEFAULT NULL,
  `customer_active` char(3) DEFAULT NULL,
  `customer_created` date DEFAULT NULL,
  `customer_address` varchar(64) DEFAULT NULL,
  `customer_district` varchar(20) DEFAULT NULL,
  `customer_postal_code` varchar(10) DEFAULT NULL,
  `customer_phone_number` varchar(20) DEFAULT NULL,
  `customer_city` varchar(50) DEFAULT NULL,
  `customer_country` varchar(50) DEFAULT NULL,
  `customer_version_number` smallint(5) DEFAULT NULL,
  `customer_valid_from` date DEFAULT NULL,
  `customer_valid_through` date DEFAULT NULL,
  PRIMARY KEY (`customer_key`),
  KEY `customer_id` (`customer_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=601 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dim_date`
--

DROP TABLE IF EXISTS dw.dim_date;
CREATE TABLE dw.dim_date (
  date_key integer NOT NULL,
  date_value date NOT NULL,
  date_short character varying(20) NOT NULL,
  date_medium character varying(25) NOT NULL,
  date_long character varying(35) NOT NULL,
  date_full character varying(50) NOT NULL,
  day_in_year smallint NOT NULL,
  day_in_month smallint  NOT NULL,
  is_first_day_in_month character varying(3) NOT NULL,
  is_last_day_in_month character varying(3) NOT NULL,
  day_abbreviation character varying(3) NOT NULL,
  day_name character varying(15) NOT NULL,
  week_in_year smallint  NOT NULL,
  week_in_month smallint  NOT NULL,
  is_first_day_in_week character varying(3) NOT NULL,
  is_last_day_in_week character varying(3) NOT NULL,
  month_number smallint  NOT NULL,
  month_abbreviation character varying(3) NOT NULL,
  month_name character varying(15) NOT NULL,
  year2 character varying(2) NOT NULL,
  year4 smallint NOT NULL,
  quarter_name character varying(2) NOT NULL,
  quarter_number smallint  NOT NULL,
  year_quarter character varying(7) NOT NULL,
  year_month_number character varying(7) NOT NULL,
  year_month_abbreviation character varying(8) NOT NULL,
  CONSTRAINT dim_date_pkey PRIMARY KEY (date_key)
);

--
-- Table structure for table `dim_film`
--

DROP TABLE IF EXISTS `dim_film`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dim_film` (
  `film_key` int(8) NOT NULL AUTO_INCREMENT,
  `film_last_update` datetime NOT NULL,
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
  `film_id` int(11) NOT NULL,
  PRIMARY KEY (`film_key`)
) ENGINE=MyISAM AUTO_INCREMENT=1001 DEFAULT CHARSET=latin1;
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
  `actor_weighting_factor` decimal(3,2) NOT NULL,
  PRIMARY KEY (`film_key`,`actor_key`),
  KEY `dim_actor_dim_film_actor_bridge_fk` (`actor_key`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dim_staff`
--

DROP TABLE IF EXISTS `dim_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dim_staff` (
  `staff_key` int(8) NOT NULL AUTO_INCREMENT,
  `staff_last_update` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `staff_first_name` varchar(45) DEFAULT NULL,
  `staff_last_name` varchar(45) DEFAULT NULL,
  `staff_id` int(8) DEFAULT NULL,
  `staff_store_id` int(8) DEFAULT NULL,
  `staff_version_number` smallint(5) DEFAULT NULL,
  `staff_valid_from` date DEFAULT NULL,
  `staff_valid_through` date DEFAULT NULL,
  `staff_active` char(3) DEFAULT NULL,
  PRIMARY KEY (`staff_key`),
  KEY `staff_id` (`staff_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dim_store`
--

DROP TABLE IF EXISTS `dim_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dim_store` (
  `store_key` int(8) NOT NULL AUTO_INCREMENT,
  `store_last_update` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `store_id` int(8) DEFAULT NULL,
  `store_address` varchar(64) DEFAULT NULL,
  `store_district` varchar(20) DEFAULT NULL,
  `store_postal_code` varchar(10) DEFAULT NULL,
  `store_phone_number` varchar(20) DEFAULT NULL,
  `store_city` varchar(50) DEFAULT NULL,
  `store_country` varchar(50) DEFAULT NULL,
  `store_manager_staff_id` int(8) DEFAULT NULL,
  `store_manager_first_name` varchar(45) DEFAULT NULL,
  `store_manager_last_name` varchar(45) DEFAULT NULL,
  `store_version_number` smallint(5) DEFAULT NULL,
  `store_valid_from` date DEFAULT NULL,
  `store_valid_through` date DEFAULT NULL,
  PRIMARY KEY (`store_key`),
  KEY `store_id` (`store_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dim_time`
--

CREATE TABLE dw.dim_time
(
  hours24 smallint
, hours12 smallint
, am_pm character varying (3)
, time_key integer
, minutes smallint
, seconds smallint
, time_value time
)
;
--
-- Table structure for table `fact_rental`
--

DROP TABLE IF EXISTS `fact_rental`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fact_rental` (
  `customer_key` int(8) NOT NULL,
  `staff_key` int(8) NOT NULL,
  `film_key` int(8) NOT NULL,
  `store_key` int(8) NOT NULL,
  `rental_date_key` int(8) NOT NULL,
  `return_date_key` int(10) NOT NULL,
  `rental_time_key` int(8) NOT NULL,
  `count_returns` int(10) NOT NULL,
  `count_rentals` int(8) NOT NULL,
  `rental_duration` int(11) DEFAULT NULL,
  `rental_last_update` datetime DEFAULT NULL,
  `rental_id` int(11) DEFAULT NULL,
  KEY `dim_store_fact_rental_fk` (`store_key`),
  KEY `dim_staff_fact_rental_fk` (`staff_key`),
  KEY `dim_time_fact_rental_fk` (`rental_time_key`),
  KEY `dim_film_fact_rental_fk` (`film_key`),
  KEY `dim_date_fact_rental_fk` (`rental_date_key`),
  KEY `dim_customer_fact_rental_fk` (`customer_key`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-03-04  1:00:33
