-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema organmatcherdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `organmatcherdb` ;

-- -----------------------------------------------------
-- Schema organmatcherdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `organmatcherdb` DEFAULT CHARACTER SET utf8 ;
USE `organmatcherdb` ;

-- -----------------------------------------------------
-- Table `patient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient` ;

CREATE TABLE IF NOT EXISTS `patient` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(100) NOT NULL,
  `last_name` VARCHAR(100) NOT NULL,
  `age` INT NOT NULL,
  `sex` VARCHAR(45) NOT NULL,
  `weight` INT NOT NULL,
  `location` CHAR(5) NOT NULL,
  `blood_type` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hla`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hla` ;

CREATE TABLE IF NOT EXISTS `hla` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `protein_class` CHAR(1) NOT NULL,
  `allele` SMALLINT(5) NOT NULL,
  `patient_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `patient_hla_idx` (`patient_id` ASC),
  CONSTRAINT `patient_hla`
    FOREIGN KEY (`patient_id`)
    REFERENCES `patient` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `auth_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `auth_user` ;

CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(100) NOT NULL,
  `last_name` VARCHAR(100) NOT NULL,
  `user_name` VARCHAR(100) NOT NULL,
  `role` VARCHAR(100) NOT NULL,
  `password` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `transplant_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transplant_type` ;

CREATE TABLE IF NOT EXISTS `transplant_type` (
  `id` INT NOT NULL,
  `organ` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `transplant_request`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transplant_request` ;

CREATE TABLE IF NOT EXISTS `transplant_request` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `recipient_id` INT NOT NULL,
  `donor_id` INT NOT NULL DEFAULT 0,
  `organ_type` INT NOT NULL,
  `approval_status` VARCHAR(20) NOT NULL DEFAULT 'WAITING',
  PRIMARY KEY (`id`),
  INDEX `transplant_idx` (`organ_type` ASC),
  INDEX `patient_idx` (`recipient_id` ASC),
  CONSTRAINT `transplant`
    FOREIGN KEY (`organ_type`)
    REFERENCES `transplant_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `patient`
    FOREIGN KEY (`recipient_id`)
    REFERENCES `patient` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `donor_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `donor_role` ;

CREATE TABLE IF NOT EXISTS `donor_role` (
  `patient_id` INT NOT NULL,
  `role` INT NOT NULL,
  INDEX `donor_patient_idx` (`patient_id` ASC),
  INDEX `donor_tp_idx` (`role` ASC),
  CONSTRAINT `donor_patient`
    FOREIGN KEY (`patient_id`)
    REFERENCES `patient` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `donor_tp`
    FOREIGN KEY (`role`)
    REFERENCES `transplant_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `blood_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `blood_type` ;

CREATE TABLE IF NOT EXISTS `blood_type` (
  `id` INT NOT NULL,
  `group` CHAR(1) NOT NULL,
  `rh` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SET SQL_MODE = '';
GRANT USAGE ON *.* TO organ@localhost;
 DROP USER organ@localhost;
SET SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';
CREATE USER 'organ'@'localhost' IDENTIFIED BY 'organ';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'organ'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `auth_user`
-- -----------------------------------------------------
START TRANSACTION;
USE `organmatcherdb`;
INSERT INTO `auth_user` (`id`, `first_name`, `last_name`, `user_name`, `role`, `password`) VALUES (1, 'admin', 'admin', 'admin', 'ADMIN', 'admin');

COMMIT;


-- -----------------------------------------------------
-- Data for table `blood_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `organmatcherdb`;
INSERT INTO `blood_type` (`id`, `group`, `rh`) VALUES (1, 'A', 1);
INSERT INTO `blood_type` (`id`, `group`, `rh`) VALUES (2, 'A', 0);
INSERT INTO `blood_type` (`id`, `group`, `rh`) VALUES (3, 'B', 1);
INSERT INTO `blood_type` (`id`, `group`, `rh`) VALUES (4, 'B', 0);
INSERT INTO `blood_type` (`id`, `group`, `rh`) VALUES (5, 'X', 1);
INSERT INTO `blood_type` (`id`, `group`, `rh`) VALUES (6, 'X', 0);
INSERT INTO `blood_type` (`id`, `group`, `rh`) VALUES (7, 'O', 1);
INSERT INTO `blood_type` (`id`, `group`, `rh`) VALUES (8, 'O', 0);

COMMIT;
