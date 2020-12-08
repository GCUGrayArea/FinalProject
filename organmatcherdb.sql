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
  `first_name` VARCHAR(100) NULL,
  `last_name` VARCHAR(100) NULL,
  `birth_date` DATE NULL,
  `sex` VARCHAR(45) NULL,
  `weight_kg` INT NULL,
  `blood_type_id` INT NULL,
  `address_id` INT NULL,
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
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (1, '8783 Idaho Rd', '', 'Boise', 'WV', '31966');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (2, '1769 New York Ct', '', 'Lansing', 'ME', '51');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (3, '2495 Ohio St', '', 'Nashville', 'AR', '34109');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (4, '3423 Minnesota Blvd', '', 'Des Moines', 'AR', '69881');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (5, '3691 Nebraska Pl', '', 'Harrisburg', 'AL', '8500');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (6, '7242 Wisconsin Blvd', '', 'Santa Fe', 'NM', '76275');

COMMIT;


-- -----------------------------------------------------
-- Data for table `patient`
-- -----------------------------------------------------
START TRANSACTION;
USE `organmatcherdb`;
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (1, 'Terry', 'GOLDEN', '1966-07-12', 'M', 55, 1, 1, NULL);
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (2, 'Jane', 'MALDONADO', '2008-02-05', 'F', 88, 1, 2, NULL);
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (3, 'Deacon', 'MURPHY', '1988-06-22', 'F', 60, 3, 3, NULL);
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (4, 'Addison', 'JUAREZ', '1961-10-13', 'M', 62, 3, 4, NULL);
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (5, 'Miles', 'AVERY', '2009-09-14', 'F', 110, 5, 5, NULL);
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (6, 'Carl', 'DELEON', '2003-09-01', 'F', 110, 5, 6, NULL);

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
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (2, 1, 1, 1);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (5, 1, 2, 2);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (2, 1, 3, 3);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (3, 1, 4, 4);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (5, 1, 5, 5);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (2, 1, 6, 6);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (5, 2, 1, 7);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (4, 2, 2, 8);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (4, 2, 3, 9);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (3, 2, 4, 10);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (2, 2, 5, 11);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (6, 2, 6, 12);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (4, 3, 1, 13);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (1, 3, 2, 14);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (5, 3, 3, 15);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (2, 3, 4, 16);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (2, 3, 5, 17);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (4, 3, 6, 18);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (1, 4, 1, 19);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (2, 4, 2, 20);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (1, 4, 3, 21);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (1, 4, 4, 22);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (1, 4, 5, 23);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (3, 4, 6, 24);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (2, 5, 1, 25);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (2, 5, 2, 26);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (2, 5, 3, 27);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (1, 5, 4, 28);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (3, 5, 5, 29);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (2, 5, 6, 30);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (1, 6, 1, 31);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (1, 6, 2, 32);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (3, 6, 3, 33);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (3, 6, 4, 34);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (2, 6, 5, 35);
INSERT INTO `hla` (`allele`, `patient_id`, `protein_class_id`, `id`) VALUES (3, 6, 6, 36);

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
