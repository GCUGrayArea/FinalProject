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
-- Table `blood_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `blood_type` ;

CREATE TABLE IF NOT EXISTS `blood_type` (
  `id` INT NOT NULL,
  `blood_group` CHAR(1) NOT NULL,
  `rh` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `address` ;

CREATE TABLE IF NOT EXISTS `address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `street1` VARCHAR(100) NULL,
  `street2` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `zip` VARCHAR(10) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `patient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient` ;

CREATE TABLE IF NOT EXISTS `patient` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(100) NOT NULL,
  `last_name` VARCHAR(100) NOT NULL,
  `birth_date` DATE NULL,
  `sex` VARCHAR(45) NOT NULL,
  `weight_kg` INT NULL,
  `blood_type_id` INT NOT NULL,
  `address_id` INT NOT NULL,
  `notes` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_patient_blood_type1_idx` (`blood_type_id` ASC),
  INDEX `fk_patient_address1_idx` (`address_id` ASC),
  CONSTRAINT `fk_patient_blood_type1`
    FOREIGN KEY (`blood_type_id`)
    REFERENCES `blood_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_patient_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `protein_class`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `protein_class` ;

CREATE TABLE IF NOT EXISTS `protein_class` (
  `id` INT NOT NULL,
  `protein_class` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hla`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hla` ;

CREATE TABLE IF NOT EXISTS `hla` (
  `allele` SMALLINT(5) NOT NULL,
  `patient_id` INT NOT NULL,
  `protein_class_id` INT NOT NULL,
  `id` INT NOT NULL AUTO_INCREMENT,
  INDEX `fk_hla_patient1_idx` (`patient_id` ASC),
  INDEX `fk_hla_protein_class1_idx` (`protein_class_id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_hla_patient1`
    FOREIGN KEY (`patient_id`)
    REFERENCES `patient` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hla_protein_class1`
    FOREIGN KEY (`protein_class_id`)
    REFERENCES `protein_class` (`id`)
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
  `username` VARCHAR(100) NOT NULL,
  `role` VARCHAR(100) NOT NULL,
  `password` VARCHAR(200) NOT NULL,
  `enabled` TINYINT NULL,
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
  `approval_status` VARCHAR(20) NULL,
  `created_at` DATETIME NOT NULL DEFAULT Current_TimeStamp(),
  `recipient_id` INT NOT NULL,
  `donor_id` INT NULL,
  `organ_type_id` INT NOT NULL,
  `notes` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_transplant_request_patient1_idx` (`recipient_id` ASC),
  INDEX `fk_transplant_request_patient2_idx` (`donor_id` ASC),
  INDEX `fk_transplant_request_transplant_type1_idx` (`organ_type_id` ASC),
  CONSTRAINT `fk_transplant_request_patient1`
    FOREIGN KEY (`recipient_id`)
    REFERENCES `patient` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transplant_request_patient2`
    FOREIGN KEY (`donor_id`)
    REFERENCES `patient` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transplant_request_transplant_type1`
    FOREIGN KEY (`organ_type_id`)
    REFERENCES `transplant_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `donor_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `donor_role` ;

CREATE TABLE IF NOT EXISTS `donor_role` (
  `transplant_type_id` INT NOT NULL,
  `patient_id` INT NOT NULL,
  INDEX `fk_donor_role_transplant_type1_idx` (`transplant_type_id` ASC),
  INDEX `fk_donor_role_patient1_idx` (`patient_id` ASC),
  CONSTRAINT `fk_donor_role_transplant_type1`
    FOREIGN KEY (`transplant_type_id`)
    REFERENCES `transplant_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_donor_role_patient1`
    FOREIGN KEY (`patient_id`)
    REFERENCES `patient` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `blood_type_match`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `blood_type_match` ;

CREATE TABLE IF NOT EXISTS `blood_type_match` (
  `recipient_type_id` INT NOT NULL,
  `can_accept_type_id` INT NOT NULL)
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
-- Data for table `blood_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `organmatcherdb`;
INSERT INTO `blood_type` (`id`, `blood_group`, `rh`) VALUES (1, 'A', 1);
INSERT INTO `blood_type` (`id`, `blood_group`, `rh`) VALUES (2, 'A', 0);
INSERT INTO `blood_type` (`id`, `blood_group`, `rh`) VALUES (3, 'B', 1);
INSERT INTO `blood_type` (`id`, `blood_group`, `rh`) VALUES (4, 'B', 0);
INSERT INTO `blood_type` (`id`, `blood_group`, `rh`) VALUES (5, 'X', 1);
INSERT INTO `blood_type` (`id`, `blood_group`, `rh`) VALUES (6, 'X', 0);
INSERT INTO `blood_type` (`id`, `blood_group`, `rh`) VALUES (7, 'O', 1);
INSERT INTO `blood_type` (`id`, `blood_group`, `rh`) VALUES (8, 'O', 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `address`
-- -----------------------------------------------------
START TRANSACTION;
USE `organmatcherdb`;
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (1, '1600 Pennsylvania', NULL, 'Washington', 'DC', '20002');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (2, '153 Mulberry Lane', NULL, 'Houston', 'TX', '77001');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (3, '123 Main St', NULL, 'Somewhere', 'KS', '65536');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (4, '330 Laststop Ave', NULL, 'Anchorage', 'AK', '99502');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (5, '260 Wingstop', NULL, 'Birth', 'AR', '71612');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (6, '3240 Englishville', NULL, 'San Diego', 'CA', '22434');

COMMIT;


-- -----------------------------------------------------
-- Data for table `patient`
-- -----------------------------------------------------
START TRANSACTION;
USE `organmatcherdb`;
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (1, 'Fred', 'Bob', NULL, 'male', 180, 1, 1, NULL);
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (2, 'Bob', 'Fred', NULL, 'male', 270, 1, 2, NULL);
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (3, 'James', 'Charles', NULL, 'male', 150, 2, 3, NULL);
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (4, 'Charlotte', 'Manson', NULL, 'female', 160, 2, 4, NULL);
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (5, 'Jackie', 'Burkhart', NULL, 'female', 130, 3, 5, NULL);
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (6, 'Ashley', 'Kutcher', NULL, 'female', 150, 3, 6, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `protein_class`
-- -----------------------------------------------------
START TRANSACTION;
USE `organmatcherdb`;
INSERT INTO `protein_class` (`id`, `protein_class`, `description`) VALUES (1, 'a', NULL);
INSERT INTO `protein_class` (`id`, `protein_class`, `description`) VALUES (2, 'b', NULL);
INSERT INTO `protein_class` (`id`, `protein_class`, `description`) VALUES (3, 'c', NULL);
INSERT INTO `protein_class` (`id`, `protein_class`, `description`) VALUES (4, 'd', NULL);
INSERT INTO `protein_class` (`id`, `protein_class`, `description`) VALUES (5, 'e', NULL);
INSERT INTO `protein_class` (`id`, `protein_class`, `description`) VALUES (6, 'f', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `hla`
-- -----------------------------------------------------
START TRANSACTION;
USE `organmatcherdb`;
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (3, 1, 1, DEFAULT);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (4, 1, 2, DEFAULT);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (5, 1, 3, DEFAULT);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (6, 1, 4, DEFAULT);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (7, 1, 5, DEFAULT);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (8, 1, 6, DEFAULT);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (3, 2, 1, DEFAULT);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (4, 2, 2, DEFAULT);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (5, 2, 3, DEFAULT);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (6, 2, 4, DEFAULT);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (7, 2, 5, DEFAULT);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (8, 2, 6, DEFAULT);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (9, 3, 1, DEFAULT);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (10, 3, 2, DEFAULT);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (11, 3, 3, DEFAULT);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (12, 3, 4, DEFAULT);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (13, 3, 5, DEFAULT);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (14, 3, 6, DEFAULT);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (9, 4, 1, DEFAULT);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (10, 4, 2, DEFAULT);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (11, 4, 3, DEFAULT);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (12, 4, 4, DEFAULT);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (13, 4, 5, DEFAULT);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (14, 4, 6, DEFAULT);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (15, 5, 1, DEFAULT);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (16, 5, 2, DEFAULT);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (17, 5, 3, DEFAULT);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (18, 5, 4, DEFAULT);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (19, 5, 5, DEFAULT);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (20, 5, 6, DEFAULT);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (15, 6, 1, DEFAULT);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (16, 6, 2, DEFAULT);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (17, 6, 3, DEFAULT);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (18, 6, 4, DEFAULT);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (19, 6, 5, DEFAULT);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (21, 6, 6, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `auth_user`
-- -----------------------------------------------------
START TRANSACTION;
USE `organmatcherdb`;
INSERT INTO `auth_user` (`id`, `first_name`, `last_name`, `username`, `role`, `password`, `enabled`) VALUES (1, 'admin', 'admin', 'admin', 'admin', 'admin', NULL);
INSERT INTO `auth_user` (`id`, `first_name`, `last_name`, `username`, `role`, `password`, `enabled`) VALUES (2, 'John', 'Smith', 'rando', 'user', 'rando', NULL);
INSERT INTO `auth_user` (`id`, `first_name`, `last_name`, `username`, `role`, `password`, `enabled`) VALUES (3, 'Andrew', 'Wilkons', 'awo', 'user', 'awo', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `transplant_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `organmatcherdb`;
INSERT INTO `transplant_type` (`id`, `organ`) VALUES (1, 'bonemarrow');
INSERT INTO `transplant_type` (`id`, `organ`) VALUES (2, 'kidney');
INSERT INTO `transplant_type` (`id`, `organ`) VALUES (3, 'teeth');

COMMIT;


-- -----------------------------------------------------
-- Data for table `transplant_request`
-- -----------------------------------------------------
START TRANSACTION;
USE `organmatcherdb`;
INSERT INTO `transplant_request` (`id`, `approval_status`, `created_at`, `recipient_id`, `donor_id`, `organ_type_id`, `notes`) VALUES (1, NULL, DEFAULT, 1, NULL, 1, NULL);
INSERT INTO `transplant_request` (`id`, `approval_status`, `created_at`, `recipient_id`, `donor_id`, `organ_type_id`, `notes`) VALUES (2, NULL, DEFAULT, 3, NULL, 2, NULL);
INSERT INTO `transplant_request` (`id`, `approval_status`, `created_at`, `recipient_id`, `donor_id`, `organ_type_id`, `notes`) VALUES (3, NULL, DEFAULT, 5, NULL, 3, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `donor_role`
-- -----------------------------------------------------
START TRANSACTION;
USE `organmatcherdb`;
INSERT INTO `donor_role` (`transplant_type_id`, `patient_id`) VALUES (1, 2);
INSERT INTO `donor_role` (`transplant_type_id`, `patient_id`) VALUES (2, 4);
INSERT INTO `donor_role` (`transplant_type_id`, `patient_id`) VALUES (3, 6);

COMMIT;


-- -----------------------------------------------------
-- Data for table `blood_type_match`
-- -----------------------------------------------------
START TRANSACTION;
USE `organmatcherdb`;
INSERT INTO `blood_type_match` (`recipient_type_id`, `can_accept_type_id`) VALUES (1, 1);
INSERT INTO `blood_type_match` (`recipient_type_id`, `can_accept_type_id`) VALUES (1, 2);
INSERT INTO `blood_type_match` (`recipient_type_id`, `can_accept_type_id`) VALUES (2, 2);
INSERT INTO `blood_type_match` (`recipient_type_id`, `can_accept_type_id`) VALUES (3, 3);
INSERT INTO `blood_type_match` (`recipient_type_id`, `can_accept_type_id`) VALUES (3, 4);
INSERT INTO `blood_type_match` (`recipient_type_id`, `can_accept_type_id`) VALUES (4, 4);
INSERT INTO `blood_type_match` (`recipient_type_id`, `can_accept_type_id`) VALUES (5, 1);
INSERT INTO `blood_type_match` (`recipient_type_id`, `can_accept_type_id`) VALUES (5, 2);
INSERT INTO `blood_type_match` (`recipient_type_id`, `can_accept_type_id`) VALUES (5, 3);
INSERT INTO `blood_type_match` (`recipient_type_id`, `can_accept_type_id`) VALUES (5, 4);
INSERT INTO `blood_type_match` (`recipient_type_id`, `can_accept_type_id`) VALUES (5, 5);
INSERT INTO `blood_type_match` (`recipient_type_id`, `can_accept_type_id`) VALUES (5, 6);
INSERT INTO `blood_type_match` (`recipient_type_id`, `can_accept_type_id`) VALUES (5, 7);
INSERT INTO `blood_type_match` (`recipient_type_id`, `can_accept_type_id`) VALUES (5, 8);
INSERT INTO `blood_type_match` (`recipient_type_id`, `can_accept_type_id`) VALUES (6, 2);
INSERT INTO `blood_type_match` (`recipient_type_id`, `can_accept_type_id`) VALUES (6, 4);
INSERT INTO `blood_type_match` (`recipient_type_id`, `can_accept_type_id`) VALUES (6, 6);
INSERT INTO `blood_type_match` (`recipient_type_id`, `can_accept_type_id`) VALUES (6, 8);
INSERT INTO `blood_type_match` (`recipient_type_id`, `can_accept_type_id`) VALUES (7, 7);
INSERT INTO `blood_type_match` (`recipient_type_id`, `can_accept_type_id`) VALUES (7, 8);
INSERT INTO `blood_type_match` (`recipient_type_id`, `can_accept_type_id`) VALUES (8, 8);

COMMIT;
