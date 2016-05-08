SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `sakila_data_vault` ;

-- -----------------------------------------------------
-- Table `sakila_data_vault`.`hub_customer`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sakila_data_vault`.`hub_customer` (
  `hub_customer_id` INT NOT NULL AUTO_INCREMENT ,
  `customer_id` INT NOT NULL ,
  `load_dts` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `record_source` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`hub_customer_id`) ,
  UNIQUE INDEX `BK` (`customer_id` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sakila_data_vault`.`sat_customer`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sakila_data_vault`.`sat_customer` (
  `sat_customer_id` INT NOT NULL AUTO_INCREMENT ,
  `hub_customer_id` INT NOT NULL ,
  `load_dts` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `load_end_dts` DATETIME NULL ,
  `record_source` VARCHAR(100) NOT NULL ,
  `first_name` VARCHAR(45) NULL DEFAULT '?' ,
  `last_name` VARCHAR(45) NULL DEFAULT '?' ,
  `email` VARCHAR(50) NULL DEFAULT '?' ,
  `active` VARCHAR(1) NULL DEFAULT '?' ,
  `address` VARCHAR(50) NULL DEFAULT '?' ,
  `address2` VARCHAR(50) NULL DEFAULT '?' ,
  `district` VARCHAR(20) NULL DEFAULT '?' ,
  `postal_code` VARCHAR(10) NULL DEFAULT '?' ,
  `city` VARCHAR(50) NULL DEFAULT '?' ,
  `country` VARCHAR(50) NULL DEFAULT '?' ,
  `phone` VARCHAR(20) NULL DEFAULT '?' ,
  `last_update` TIMESTAMP NULL ,
  `create_date` TIMESTAMP NULL ,
  PRIMARY KEY (`sat_customer_id`) ,
  INDEX `fk_sat_customer_hub_customer` (`hub_customer_id` ASC) ,
  UNIQUE INDEX `BK` (`hub_customer_id` ASC, `load_dts` ASC) ,
  CONSTRAINT `fk_sat_customer_hub_customer`
    FOREIGN KEY (`hub_customer_id` )
    REFERENCES `sakila_data_vault`.`hub_customer` (`hub_customer_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sakila_data_vault`.`hub_staff`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sakila_data_vault`.`hub_staff` (
  `hub_staff_id` INT NOT NULL AUTO_INCREMENT ,
  `staff_id` INT NOT NULL ,
  `load_dts` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `record_source` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`hub_staff_id`) ,
  UNIQUE INDEX `BK` (`staff_id` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sakila_data_vault`.`sat_staff`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sakila_data_vault`.`sat_staff` (
  `sat_staff_id` INT NOT NULL AUTO_INCREMENT ,
  `hub_staff_id` INT NOT NULL ,
  `load_dts` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `load_end_dts` DATETIME NULL ,
  `record_source` VARCHAR(100) NOT NULL ,
  `first_name` VARCHAR(45) NULL DEFAULT '?' ,
  `last_name` VARCHAR(45) NULL DEFAULT '?' ,
  `picture` BLOB NULL ,
  `email` VARCHAR(50) NULL DEFAULT '?' ,
  `active` VARCHAR(1) NULL DEFAULT '?' ,
  `username` VARCHAR(16) NULL DEFAULT '?' ,
  `password` VARCHAR(40) NULL DEFAULT '?' ,
  `address` VARCHAR(50) NULL DEFAULT '?' ,
  `address2` VARCHAR(50) NULL DEFAULT '?' ,
  `district` VARCHAR(20) NULL DEFAULT '?' ,
  `postal_code` VARCHAR(10) NULL DEFAULT '?' ,
  `city` VARCHAR(50) NULL DEFAULT '?' ,
  `country` VARCHAR(50) NULL DEFAULT '?' ,
  `phone` VARCHAR(20) NULL DEFAULT '?' ,
  `last_update` TIMESTAMP NULL ,
  PRIMARY KEY (`sat_staff_id`) ,
  INDEX `fk_sat_staff_hub_staff1` (`hub_staff_id` ASC) ,
  UNIQUE INDEX `BK` (`hub_staff_id` ASC, `load_dts` ASC) ,
  CONSTRAINT `fk_sat_staff_hub_staff1`
    FOREIGN KEY (`hub_staff_id` )
    REFERENCES `sakila_data_vault`.`hub_staff` (`hub_staff_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sakila_data_vault`.`hub_store`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sakila_data_vault`.`hub_store` (
  `hub_store_id` INT NOT NULL AUTO_INCREMENT ,
  `store_id` INT NOT NULL ,
  `load_dts` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `record_source` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`hub_store_id`) ,
  UNIQUE INDEX `BK` (`store_id` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sakila_data_vault`.`sat_store`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sakila_data_vault`.`sat_store` (
  `sat_store_id` INT NOT NULL AUTO_INCREMENT ,
  `hub_store_id` INT NOT NULL ,
  `load_dts` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `load_end_dts` DATETIME NULL ,
  `record_source` VARCHAR(100) NOT NULL ,
  `address` VARCHAR(50) NULL DEFAULT '?' ,
  `address2` VARCHAR(50) NULL DEFAULT '?' ,
  `district` VARCHAR(50) NULL DEFAULT '?' ,
  `postal_code` VARCHAR(10) NULL DEFAULT '?' ,
  `city` VARCHAR(50) NULL DEFAULT '?' ,
  `country` VARCHAR(50) NULL DEFAULT '?' ,
  `phone` VARCHAR(20) NULL DEFAULT '?' ,
  `last_update` TIMESTAMP NULL ,
  PRIMARY KEY (`sat_store_id`) ,
  INDEX `fk_sat_store_hub_store1` (`hub_store_id` ASC) ,
  INDEX `BK` (`hub_store_id` ASC, `load_dts` ASC) ,
  CONSTRAINT `fk_sat_store_hub_store1`
    FOREIGN KEY (`hub_store_id` )
    REFERENCES `sakila_data_vault`.`hub_store` (`hub_store_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sakila_data_vault`.`link_staff_worksin_store`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sakila_data_vault`.`link_staff_worksin_store` (
  `link_staff_worksin_store_id` INT NOT NULL AUTO_INCREMENT ,
  `hub_staff_id` INT NOT NULL ,
  `hub_store_id` INT NOT NULL ,
  `load_dts` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `record_source` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`link_staff_worksin_store_id`) ,
  INDEX `fk_link_staff_worksin_store_hub_staff1` (`hub_staff_id` ASC) ,
  INDEX `fk_link_staff_worksin_store_hub_store1` (`hub_store_id` ASC) ,
  UNIQUE INDEX `BK` (`hub_staff_id` ASC, `hub_store_id` ASC) ,
  CONSTRAINT `fk_link_staff_worksin_store_hub_staff1`
    FOREIGN KEY (`hub_staff_id` )
    REFERENCES `sakila_data_vault`.`hub_staff` (`hub_staff_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_link_staff_worksin_store_hub_store1`
    FOREIGN KEY (`hub_store_id` )
    REFERENCES `sakila_data_vault`.`hub_store` (`hub_store_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sakila_data_vault`.`link_store_manager`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sakila_data_vault`.`link_store_manager` (
  `link_store_manager_id` INT NOT NULL AUTO_INCREMENT ,
  `hub_staff_id` INT NOT NULL ,
  `hub_store_id` INT NOT NULL ,
  `load_dts` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `record_source` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`link_store_manager_id`) ,
  INDEX `fk_link_store_manager_hub_staff1` (`hub_staff_id` ASC) ,
  INDEX `fk_link_store_manager_hub_store1` (`hub_store_id` ASC) ,
  UNIQUE INDEX `BK` (`hub_staff_id` ASC, `hub_store_id` ASC) ,
  CONSTRAINT `fk_link_store_manager_hub_staff1`
    FOREIGN KEY (`hub_staff_id` )
    REFERENCES `sakila_data_vault`.`hub_staff` (`hub_staff_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_link_store_manager_hub_store1`
    FOREIGN KEY (`hub_store_id` )
    REFERENCES `sakila_data_vault`.`hub_store` (`hub_store_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sakila_data_vault`.`link_customer_store`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sakila_data_vault`.`link_customer_store` (
  `link_customer_store_id` INT NOT NULL AUTO_INCREMENT ,
  `hub_customer_id` INT NOT NULL ,
  `hub_store_id` INT NOT NULL ,
  `load_dts` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `record_source` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`link_customer_store_id`) ,
  INDEX `fk_link_customer_store_hub_customer1` (`hub_customer_id` ASC) ,
  INDEX `fk_link_customer_store_hub_store1` (`hub_store_id` ASC) ,
  INDEX `BK` (`hub_customer_id` ASC, `hub_store_id` ASC) ,
  CONSTRAINT `fk_link_customer_store_hub_customer1`
    FOREIGN KEY (`hub_customer_id` )
    REFERENCES `sakila_data_vault`.`hub_customer` (`hub_customer_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_link_customer_store_hub_store1`
    FOREIGN KEY (`hub_store_id` )
    REFERENCES `sakila_data_vault`.`hub_store` (`hub_store_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sakila_data_vault`.`hub_film`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sakila_data_vault`.`hub_film` (
  `hub_film_id` INT NOT NULL AUTO_INCREMENT ,
  `film_id` INT NOT NULL ,
  `load_dts` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `record_source` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`hub_film_id`) ,
  INDEX `BK` (`film_id` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sakila_data_vault`.`sat_film`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sakila_data_vault`.`sat_film` (
  `sat_film_id` INT NOT NULL AUTO_INCREMENT ,
  `hub_film_id` INT NOT NULL ,
  `load_dts` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `load_end_dts` DATETIME NULL ,
  `record_source` VARCHAR(100) NOT NULL ,
  `title` VARCHAR(255) NULL ,
  `description` TEXT NULL ,
  `release_year` INT NULL ,
  `rental_duration` INT NULL ,
  `rental_rate` DECIMAL(5,2) NULL ,
  `length` INT NULL ,
  `replacement_cost` DECIMAL(5,2) NULL ,
  `rating` VARCHAR(10) NULL DEFAULT '?' ,
  `special_features` VARCHAR(100) NULL DEFAULT '?' ,
  `language` VARCHAR(20) NULL DEFAULT '?' ,
  `original_language` VARCHAR(20) NULL DEFAULT '?' ,
  `last_update` TIMESTAMP NULL ,
  PRIMARY KEY (`sat_film_id`) ,
  INDEX `fk_sat_film_hub_film1` (`hub_film_id` ASC) ,
  INDEX `BK` (`hub_film_id` ASC, `load_dts` ASC) ,
  CONSTRAINT `fk_sat_film_hub_film1`
    FOREIGN KEY (`hub_film_id` )
    REFERENCES `sakila_data_vault`.`hub_film` (`hub_film_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sakila_data_vault`.`hub_category`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sakila_data_vault`.`hub_category` (
  `hub_category_id` INT NOT NULL AUTO_INCREMENT ,
  `category_name` VARCHAR(25) NOT NULL ,
  `load_dts` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `record_source` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`hub_category_id`) ,
  INDEX `BK` (`category_name` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sakila_data_vault`.`link_film_category`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sakila_data_vault`.`link_film_category` (
  `link_film_category_id` INT NOT NULL AUTO_INCREMENT ,
  `hub_category_id` INT NOT NULL ,
  `hub_film_id` INT NOT NULL ,
  `load_dts` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `record_source` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`link_film_category_id`) ,
  INDEX `fk_link_film_category_hub_category1` (`hub_category_id` ASC) ,
  INDEX `fk_link_film_category_hub_film1` (`hub_film_id` ASC) ,
  UNIQUE INDEX `BK` (`hub_category_id` ASC, `hub_film_id` ASC) ,
  CONSTRAINT `fk_link_film_category_hub_category1`
    FOREIGN KEY (`hub_category_id` )
    REFERENCES `sakila_data_vault`.`hub_category` (`hub_category_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_link_film_category_hub_film1`
    FOREIGN KEY (`hub_film_id` )
    REFERENCES `sakila_data_vault`.`hub_film` (`hub_film_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sakila_data_vault`.`hub_actor`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sakila_data_vault`.`hub_actor` (
  `hub_actor_id` INT NOT NULL AUTO_INCREMENT ,
  `actor_id` INT UNSIGNED NOT NULL ,
  `load_dts` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `record_source` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`hub_actor_id`) ,
  INDEX `BK` (`actor_id` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sakila_data_vault`.`sat_actor`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sakila_data_vault`.`sat_actor` (
  `sat_actor_id` INT NOT NULL AUTO_INCREMENT ,
  `hub_actor_id` INT NOT NULL ,
  `load_dts` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `load_end_dts` DATETIME NULL ,
  `record_source` VARCHAR(100) NOT NULL ,
  `first_name` VARCHAR(45) NULL ,
  `last_name` VARCHAR(45) NULL ,
  `last_update` TIMESTAMP NULL ,
  PRIMARY KEY (`sat_actor_id`) ,
  INDEX `fk_sat_actor_hub_actor1` (`hub_actor_id` ASC) ,
  UNIQUE INDEX `BK` (`hub_actor_id` ASC, `load_dts` ASC) ,
  CONSTRAINT `fk_sat_actor_hub_actor1`
    FOREIGN KEY (`hub_actor_id` )
    REFERENCES `sakila_data_vault`.`hub_actor` (`hub_actor_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sakila_data_vault`.`link_film_actor`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sakila_data_vault`.`link_film_actor` (
  `link_film_actor_id` INT NOT NULL AUTO_INCREMENT ,
  `hub_film_id` INT NOT NULL ,
  `hub_actor_id` INT NOT NULL ,
  `load_dts` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `record_source` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`link_film_actor_id`) ,
  INDEX `fk_link_film_actor_hub_film1` (`hub_film_id` ASC) ,
  INDEX `fk_link_film_actor_hub_actor1` (`hub_actor_id` ASC) ,
  UNIQUE INDEX `BK` (`hub_film_id` ASC, `hub_actor_id` ASC) ,
  CONSTRAINT `fk_link_film_actor_hub_film1`
    FOREIGN KEY (`hub_film_id` )
    REFERENCES `sakila_data_vault`.`hub_film` (`hub_film_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_link_film_actor_hub_actor1`
    FOREIGN KEY (`hub_actor_id` )
    REFERENCES `sakila_data_vault`.`hub_actor` (`hub_actor_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sakila_data_vault`.`hub_inventory`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sakila_data_vault`.`hub_inventory` (
  `hub_inventory_id` INT NOT NULL AUTO_INCREMENT ,
  `inventory_id` INT NOT NULL ,
  `load_dts` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `record_source` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`hub_inventory_id`) ,
  UNIQUE INDEX `BK` (`inventory_id` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sakila_data_vault`.`link_inventory`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sakila_data_vault`.`link_inventory` (
  `link_inventory_id` INT NOT NULL AUTO_INCREMENT ,
  `hub_inventory_id` INT NOT NULL ,
  `hub_film_id` INT NOT NULL ,
  `hub_store_id` INT NOT NULL ,
  `load_dts` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `record_source` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`link_inventory_id`) ,
  INDEX `fk_link_inventory_hub_film1` (`hub_film_id` ASC) ,
  INDEX `fk_link_inventory_hub_store1` (`hub_store_id` ASC) ,
  INDEX `BK` (`hub_film_id` ASC, `hub_store_id` ASC) ,
  INDEX `fk_link_inventory_hub_inventory1` (`hub_inventory_id` ASC) ,
  CONSTRAINT `fk_link_inventory_hub_film1`
    FOREIGN KEY (`hub_film_id` )
    REFERENCES `sakila_data_vault`.`hub_film` (`hub_film_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_link_inventory_hub_store1`
    FOREIGN KEY (`hub_store_id` )
    REFERENCES `sakila_data_vault`.`hub_store` (`hub_store_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_link_inventory_hub_inventory1`
    FOREIGN KEY (`hub_inventory_id` )
    REFERENCES `sakila_data_vault`.`hub_inventory` (`hub_inventory_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sakila_data_vault`.`hub_rental`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sakila_data_vault`.`hub_rental` (
  `hub_rental_id` INT NOT NULL AUTO_INCREMENT ,
  `rental_id` INT NOT NULL ,
  `load_dts` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `record_source` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`hub_rental_id`) ,
  UNIQUE INDEX `BK` (`rental_id` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sakila_data_vault`.`link_rental`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sakila_data_vault`.`link_rental` (
  `link_rental_id` INT NOT NULL AUTO_INCREMENT ,
  `hub_rental_id` INT NOT NULL ,
  `hub_customer_id` INT NOT NULL ,
  `hub_staff_id` INT NOT NULL ,
  `hub_inventory_id` INT NOT NULL ,
  `load_dts` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `record_source` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`link_rental_id`) ,
  INDEX `fk_link_rental_hub_customer1` (`hub_customer_id` ASC) ,
  INDEX `fk_link_rental_hub_staff1` (`hub_staff_id` ASC) ,
  INDEX `BK` (`hub_customer_id` ASC, `hub_staff_id` ASC, `hub_rental_id` ASC, `hub_inventory_id` ASC) ,
  INDEX `fk_link_rental_hub_rental1` (`hub_rental_id` ASC) ,
  INDEX `fk_link_rental_hub_inventory1` (`hub_inventory_id` ASC) ,
  CONSTRAINT `fk_link_rental_hub_customer1`
    FOREIGN KEY (`hub_customer_id` )
    REFERENCES `sakila_data_vault`.`hub_customer` (`hub_customer_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_link_rental_hub_staff1`
    FOREIGN KEY (`hub_staff_id` )
    REFERENCES `sakila_data_vault`.`hub_staff` (`hub_staff_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_link_rental_hub_rental1`
    FOREIGN KEY (`hub_rental_id` )
    REFERENCES `sakila_data_vault`.`hub_rental` (`hub_rental_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_link_rental_hub_inventory1`
    FOREIGN KEY (`hub_inventory_id` )
    REFERENCES `sakila_data_vault`.`hub_inventory` (`hub_inventory_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sakila_data_vault`.`sat_rental`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sakila_data_vault`.`sat_rental` (
  `sat_rental_id` INT NOT NULL AUTO_INCREMENT ,
  `hub_rental_id` INT NOT NULL ,
  `load_dts` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `load_end_dts` DATETIME NULL ,
  `record_source` VARCHAR(100) NOT NULL ,
  `rental_date` DATETIME NULL ,
  `return_date` DATETIME NULL ,
  `last_update` TIMESTAMP NULL ,
  PRIMARY KEY (`sat_rental_id`) ,
  INDEX `BK` (`load_dts` ASC, `hub_rental_id` ASC) ,
  INDEX `fk_sat_rental_hub_rental1` (`hub_rental_id` ASC) ,
  CONSTRAINT `fk_sat_rental_hub_rental1`
    FOREIGN KEY (`hub_rental_id` )
    REFERENCES `sakila_data_vault`.`hub_rental` (`hub_rental_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sakila_data_vault`.`hub_payment`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sakila_data_vault`.`hub_payment` (
  `hub_payment_id` INT NOT NULL AUTO_INCREMENT ,
  `payment_id` INT NOT NULL ,
  `load_dts` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `record_source` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`hub_payment_id`) ,
  UNIQUE INDEX `BK` (`payment_id` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sakila_data_vault`.`link_payment`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sakila_data_vault`.`link_payment` (
  `link_payment_id` INT NOT NULL AUTO_INCREMENT ,
  `hub_payment_id` INT NOT NULL ,
  `hub_customer_id` INT NOT NULL ,
  `hub_staff_id` INT NOT NULL ,
  `load_dts` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `record_source` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`link_payment_id`) ,
  INDEX `fk_link_payment_hub_customer1` (`hub_customer_id` ASC) ,
  INDEX `fk_link_payment_hub_staff1` (`hub_staff_id` ASC) ,
  INDEX `BK` (`hub_customer_id` ASC, `hub_staff_id` ASC, `hub_payment_id` ASC) ,
  INDEX `fk_link_payment_hub_payment1` (`hub_payment_id` ASC) ,
  CONSTRAINT `fk_link_payment_hub_customer1`
    FOREIGN KEY (`hub_customer_id` )
    REFERENCES `sakila_data_vault`.`hub_customer` (`hub_customer_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_link_payment_hub_staff1`
    FOREIGN KEY (`hub_staff_id` )
    REFERENCES `sakila_data_vault`.`hub_staff` (`hub_staff_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_link_payment_hub_payment1`
    FOREIGN KEY (`hub_payment_id` )
    REFERENCES `sakila_data_vault`.`hub_payment` (`hub_payment_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sakila_data_vault`.`sat_payment`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sakila_data_vault`.`sat_payment` (
  `sat_payment_id` INT NOT NULL AUTO_INCREMENT ,
  `hub_payment_id` INT NOT NULL ,
  `load_dts` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `load_end_dts` DATETIME NULL ,
  `record_source` VARCHAR(100) NOT NULL ,
  `amount` DECIMAL(5,2) NULL ,
  `payment_date` DATETIME NULL ,
  `last_update` TIMESTAMP NULL ,
  PRIMARY KEY (`sat_payment_id`) ,
  INDEX `BK` (`load_dts` ASC, `hub_payment_id` ASC) ,
  INDEX `fk_sat_payment_hub_payment1` (`hub_payment_id` ASC) ,
  CONSTRAINT `fk_sat_payment_hub_payment1`
    FOREIGN KEY (`hub_payment_id` )
    REFERENCES `sakila_data_vault`.`hub_payment` (`hub_payment_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sakila_data_vault`.`link_payment_rental`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sakila_data_vault`.`link_payment_rental` (
  `link_payment_rental_id` INT NOT NULL AUTO_INCREMENT ,
  `hub_rental_id` INT NOT NULL ,
  `hub_payment_id` INT NOT NULL ,
  `load_dts` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `record_source` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`link_payment_rental_id`) ,
  INDEX `fk_link_payment_rental_hub_rental1` (`hub_rental_id` ASC) ,
  INDEX `fk_link_payment_rental_hub_payment1` (`hub_payment_id` ASC) ,
  UNIQUE INDEX `BK` (`hub_rental_id` ASC, `hub_payment_id` ASC) ,
  CONSTRAINT `fk_link_payment_rental_hub_rental1`
    FOREIGN KEY (`hub_rental_id` )
    REFERENCES `sakila_data_vault`.`hub_rental` (`hub_rental_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_link_payment_rental_hub_payment1`
    FOREIGN KEY (`hub_payment_id` )
    REFERENCES `sakila_data_vault`.`hub_payment` (`hub_payment_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;