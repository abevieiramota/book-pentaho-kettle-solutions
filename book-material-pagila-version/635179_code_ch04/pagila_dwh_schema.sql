CREATE TABLE dw.dim_actor (
  actor_key integer default nextval('dw.dim_actor_actor_key_seq'),
  actor_last_update timestamp NOT NULL,
  actor_last_name character varying(45) NOT NULL,
  actor_first_name character varying(45) NOT NULL,
  actor_id integer NOT NULL,
  constraint dim_actor_pkey primary key (actor_key)
);

CREATE SEQUENCE dw.dim_actor_actor_key_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 200
  CACHE 1;
ALTER TABLE dw.dim_actor_actor_key_seq
  OWNER TO postgres;
  
--
-- Table structure for table `dim_customer`
--

CREATE TABLE dw.dim_customer (
  customer_key integer NOT NULL,
  customer_last_update timestamp NOT NULL DEFAULT '1970-01-01 00:00:00',
  customer_id integer DEFAULT NULL,
  customer_first_name character varying(45) DEFAULT NULL,
  customer_last_name character varying(45) DEFAULT NULL,
  customer_email character varying(50) DEFAULT NULL,
  customer_active character varying(3) DEFAULT NULL,
  customer_created date DEFAULT NULL,
  customer_address character varying(64) DEFAULT NULL,
  customer_district character varying(20) DEFAULT NULL,
  customer_postal_code character varying(10) DEFAULT NULL,
  customer_phone_number character varying(20) DEFAULT NULL,
  customer_city character varying(50) DEFAULT NULL,
  customer_country character varying(50) DEFAULT NULL,
  customer_version_number smallint DEFAULT NULL,
  customer_valid_from date DEFAULT NULL,
  customer_valid_through date DEFAULT NULL,
  constraint dim_customer_customer_key primary key (customer_key)
); 
CREATE SEQUENCE dw.dim_customer_customer_key_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 200
  CACHE 1;
ALTER TABLE dw.dim_customer_customer_key_seq
  OWNER TO postgres;

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

CREATE TABLE dw.dim_film (
  film_key integer NOT NULL default nextval('dw.dim_film_film_key_seq'),
  film_last_update timestamp NOT NULL,
  film_title character varying(64) NOT NULL,
  film_description text NOT NULL,
  film_release_year smallint NOT NULL,
  film_language character varying(20) NOT NULL,
  film_rental_duration smallint DEFAULT NULL,
  film_rental_rate decimal(4,2) DEFAULT NULL,
  film_duration integer DEFAULT NULL,
  film_replacement_cost decimal(5,2) DEFAULT NULL,
  film_rating_code character varying(5) DEFAULT NULL,
  film_rating_text character varying(30) DEFAULT NULL,
  film_has_trailers character varying(4) DEFAULT NULL,
  film_has_commentaries character varying(4) DEFAULT NULL,
  film_has_deleted_scenes character varying(4) DEFAULT NULL,
  film_has_behind_the_scenes character varying(4) DEFAULT NULL,
  film_in_category_action character varying(4) DEFAULT NULL,
  film_in_category_animation character varying(4) DEFAULT NULL,
  film_in_category_children character varying(4) DEFAULT NULL,
  film_in_category_classics character varying(4) DEFAULT NULL,
  film_in_category_comedy character varying(4) DEFAULT NULL,
  film_in_category_documentary character varying(4) DEFAULT NULL,
  film_in_category_drama character varying(4) DEFAULT NULL,
  film_in_category_family character varying(4) DEFAULT NULL,
  film_in_category_foreign character varying(4) DEFAULT NULL,
  film_in_category_games character varying(4) DEFAULT NULL,
  film_in_category_horror character varying(4) DEFAULT NULL,
  film_in_category_music character varying(4) DEFAULT NULL,
  film_in_category_new character varying(4) DEFAULT NULL,
  film_in_category_scifi character varying(4) DEFAULT NULL,
  film_in_category_sports character varying(4) DEFAULT NULL,
  film_in_category_travel character varying(4) DEFAULT NULL,
  film_id integer NOT NULL,
  constraint dim_film_pkey primary key (film_key)
);

CREATE SEQUENCE dw.dim_film_film_key_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 200
  CACHE 1;
ALTER TABLE dw.dim_film_film_key_seq
  OWNER TO postgres;

--
-- Table structure for table `dim_film_actor_bridge`
--

CREATE TABLE dw.dim_film_actor_bridge (
  film_key integer NOT NULL,
  actor_key integer NOT NULL,
  actor_weighting_factor decimal(3,2) NOT NULL,
  constraint dim_film_actor_brige_pkey PRIMARY KEY (film_key,actor_key)
);

--
-- Table structure for table `dim_staff`
--

CREATE TABLE dw.dim_staff (
  staff_key integer not null default nextval('dw.dim_staff_staff_key_seq'),
  staff_last_update timestamp NOT NULL DEFAULT '1970-01-01 00:00:00',
  staff_first_name character varying(45) DEFAULT NULL,
  staff_last_name character varying(45) DEFAULT NULL,
  staff_id integer DEFAULT NULL,
  staff_store_id integer DEFAULT NULL,
  staff_version_number smallint DEFAULT NULL,
  staff_valid_from date DEFAULT NULL,
  staff_valid_through date DEFAULT NULL,
  staff_active character varying(3) DEFAULT NULL,
  constraint dim_staff_pkey primary key (staff_key)
);

CREATE SEQUENCE dw.dim_staff_staff_key_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 200
  CACHE 1;
ALTER TABLE dw.dim_staff_staff_key_seq
  OWNER TO postgres;

--
-- Table structure for table `dim_store`
--

CREATE TABLE dw.dim_store (
  store_key integer NOT NULL,
  store_last_update timestamp NOT NULL DEFAULT '1970-01-01 00:00:00',
  store_id integer DEFAULT NULL,
  store_address character varying(64) DEFAULT NULL,
  store_district character varying(20) DEFAULT NULL,
  store_postal_code character varying(10) DEFAULT NULL,
  store_phone_number character varying(20) DEFAULT NULL,
  store_city character varying(50) DEFAULT NULL,
  store_country character varying(50) DEFAULT NULL,
  store_manager_staff_id integer DEFAULT NULL,
  store_manager_first_name character varying(45) DEFAULT NULL,
  store_manager_last_name character varying(45) DEFAULT NULL,
  store_version_number smallint DEFAULT NULL,
  store_valid_from date DEFAULT NULL,
  store_valid_through date DEFAULT NULL,
  constraint dim_store_pkey primary key (store_key)
);

CREATE SEQUENCE dw.dim_store_store_key_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 200
  CACHE 1;
ALTER TABLE dw.dim_store_store_key_seq
  OWNER TO postgres;

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

CREATE TABLE dw.fact_rental (
  customer_key integer NOT NULL,
  staff_key integer NOT NULL,
  film_key integer NOT NULL,
  store_key integer NOT NULL,
  rental_date_key integer NOT NULL,
  return_date_key integer NOT NULL,
  rental_time_key integer NOT NULL,
  count_returns integer NOT NULL,
  -- removido count_rentals -> não é calculado nas transformações fornecidas
  rental_duration integer DEFAULT NULL,
  rental_last_update timestamp DEFAULT NULL,
  rental_id integer DEFAULT NULL
);

CREATE INDEX idx_fk_dim_store_store_key
  ON dw.fact_rental
  USING btree
  (store_key);

CREATE INDEX idx_fk_dim_staff_staff_key
  ON dw.fact_rental
  USING btree
  (staff_key);

CREATE INDEX idx_fk_dim_rental_rental_time_key
  ON dw.fact_rental
  USING btree
  (rental_time_key);

CREATE INDEX idx_fk_dim_film_film_key
  ON dw.fact_rental
  USING btree
  (film_key);

CREATE INDEX idx_fk_dim_date_rental_date_key
  ON dw.fact_rental
  USING btree
  (rental_date_key);

CREATE INDEX idx_fk_dim_date_customer_customer_key
  ON dw.fact_rental
  USING btree
  (customer_key);
