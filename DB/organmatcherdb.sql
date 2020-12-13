-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

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
    ON DELETE SET NULL
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
  `id` INT NOT NULL AUTO_INCREMENT,
  `allele` SMALLINT(5) NOT NULL,
  `patient_id` INT NOT NULL,
  `protein_class_id` INT NOT NULL,
  INDEX `fk_hla_patient1_idx` (`patient_id` ASC),
  INDEX `fk_hla_protein_class1_idx` (`protein_class_id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_hla_patient1`
    FOREIGN KEY (`patient_id`)
    REFERENCES `patient` (`id`)
    ON DELETE CASCADE
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
    ON DELETE CASCADE
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
-- Table `blood_type_match`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `blood_type_match` ;

CREATE TABLE IF NOT EXISTS `blood_type_match` (
  `recipient_type_id` INT NOT NULL,
  `can_accept_type_id` INT NOT NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `donor_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `donor_role` ;

CREATE TABLE IF NOT EXISTS `donor_role` (
  `patient_id` INT NOT NULL,
  `transplant_type_id` INT NOT NULL,
  PRIMARY KEY (`patient_id`, `transplant_type_id`),
  INDEX `fk_patient_has_transplant_type_transplant_type1_idx` (`transplant_type_id` ASC),
  INDEX `fk_patient_has_transplant_type_patient1_idx` (`patient_id` ASC),
  CONSTRAINT `fk_patient_has_transplant_type_patient1`
    FOREIGN KEY (`patient_id`)
    REFERENCES `patient` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_patient_has_transplant_type_transplant_type1`
    FOREIGN KEY (`transplant_type_id`)
    REFERENCES `transplant_type` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
GRANT USAGE ON *.* TO organ@localhost;
 DROP USER organ@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
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
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (1, '2635 Ohio Pl', '', 'Saint Paul', 'SD', '49931');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (2, '688 Kansas Blvd', '', 'Charleston', 'FL', '66605');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (3, '7142 Missouri Ave', '', 'Columbus', 'WA', '62403');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (4, '3934 California Pl', '', 'Cheyenne', 'PA', '83741');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (5, '8879 South Dakota Pl', '', 'Augusta', 'MD', '65724');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (6, '2291 Wyoming Pl', '', 'Madison', 'NC', '29742');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (7, '2086 Indiana Way', '', 'Columbia', 'ID', '96665');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (8, '7103 Massachusetts Blvd', '', 'Jefferson City', 'CA', '83150');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (9, '9862 Vermont Pl', '', 'Frankfort', 'ID', '28312');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (10, '1740 Texas St', '', 'Boston', 'VA', '61444');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (11, '2888 Washington Pl', '', 'Baton Rouge', 'AL', '47000');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (12, '5431 Minnesota Blvd', '', 'Hartford', 'ME', '25404');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (13, '4629 Arkansas Way', '', 'Austin', 'AR', '85889');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (14, '392 Georgia Pl', '', 'Atlanta', 'LA', '63953');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (15, '2976 New Mexico St', '', 'Concord', 'WV', '31432');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (16, '3101 Ohio Blvd', '', 'Austin', 'WA', '55294');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (17, '9894 Mississippi Pl', '', 'Annapolis', 'AR', '11519');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (18, '2737 Louisiana Rd', '', 'Richmond', 'HI', '21637');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (19, '9698 Nebraska St', '', 'Richmond', 'DE', '67515');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (20, '2000 Kansas Pl', '', 'Lincoln', 'TX', '98782');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (21, '4571 Vermont Way', '', 'Olympia', 'MS', '45855');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (22, '1485 Kansas Rd', '', 'Hartford', 'RI', '97525');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (23, '4560 North Carolina Rd', '', 'Bismarck', 'NC', '21479');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (24, '8723 Georgia St', '', 'Trenton', 'IN', '82722');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (25, '1063 Georgia St', '', 'Salem', 'GA', '34535');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (26, '6793 Nebraska Rd', '', 'Frankfort', 'SC', '95235');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (27, '8786 Delaware St', '', 'Saint Paul', 'CO', '24615');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (28, '7736 Rhode Island Rd', '', 'Atlanta', 'IL', '92829');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (29, '3546 Colorado Ave', '', 'Madison', 'SC', '77006');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (30, '4285 Mississippi Ave', '', 'Lansing', 'WI', '51881');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (31, '2033 Kansas Ave', '', 'Cheyenne', 'MS', '66676');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (32, '9800 Tennessee Ct', '', 'Nashville', 'MN', '93392');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (33, '4423 West Virginia Way', '', 'Pierre', 'NY', '45846');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (34, '310 California Rd', '', 'Phoenix', 'MN', '54003');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (35, '5189 Georgia Blvd', '', 'Richmond', 'LA', '72606');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (36, '6886 Oklahoma Pl', '', 'Topeka', 'OK', '16927');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (37, '9357 New Hampshire Blvd', '', 'Richmond', 'RI', '40602');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (38, '2600 Wisconsin Ave', '', 'Oklahoma City', 'SC', '63821');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (39, '2271 Mississippi Rd', '', 'Charleston', 'KY', '53225');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (40, '5220 Wyoming St', '', 'Springfield', 'CO', '46371');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (41, '9319 Tennessee Way', '', 'Austin', 'ND', '80765');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (42, '6989 Washington Blvd', '', 'Saint Paul', 'AZ', '40352');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (43, '4743 Illinois St', '', 'Dover', 'MN', '63355');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (44, '7007 Florida Ave', '', 'Dover', 'MA', '81408');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (45, '6516 Wyoming Rd', '', 'Annapolis', 'OK', '73334');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (46, '9182 Oklahoma St', '', 'Des Moines', 'CT', '83691');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (47, '5407 South Carolina Blvd', '', 'Des Moines', 'OK', '26184');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (48, '2095 Massachusetts Pl', '', 'Baton Rouge', 'WV', '69202');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (49, '2563 Maine Way', '', 'Charleston', 'VT', '21721');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (50, '6107 Utah Way', '', 'Lansing', 'KY', '69380');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (51, '1227 Delaware Pl', '', 'Topeka', 'RI', '33724');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (52, '7890 New Hampshire Ct', '', 'Boise', 'NH', '42512');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (53, '4154 California Rd', '', 'Albany', 'SD', '27678');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (54, '9793 North Carolina Ct', '', 'Boston', 'KY', '96017');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (55, '6275 Arkansas St', '', 'Madison', 'AZ', '85499');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (56, '187 Delaware Ct', '', 'Concord', 'OH', '42353');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (57, '5733 Kansas Ave', '', 'Lincoln', 'CT', '41799');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (58, '5266 Wisconsin Way', '', 'Honolulu', 'TX', '33865');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (59, '4047 New York Rd', '', 'Columbus', 'MD', '37416');
INSERT INTO `address` (`id`, `street1`, `street2`, `city`, `state`, `zip`) VALUES (60, '7979 Utah Way', '', 'Providence', 'CA', '31630');

COMMIT;


-- -----------------------------------------------------
-- Data for table `patient`
-- -----------------------------------------------------
START TRANSACTION;
USE `organmatcherdb`;
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (1, 'Jaliyah', 'RICHARDSON', '1955-06-25', 'M', 98, 3, 60, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (2, 'Samantha', 'KIM', '1959-12-21', 'M', 62, 7, 59, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (3, 'Ivy', 'FROST', '1986-04-20', 'M', 63, 3, 58, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (4, 'Maeve', 'PAUL', '1965-01-27', 'M', 120, 6, 57, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (5, 'Kaylie', 'PERRY', '1979-01-10', 'F', 54, 1, 56, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (6, 'Alijah', 'KIM', '1970-01-25', 'M', 49, 2, 55, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (7, 'Dana', 'LYNCH', '1996-03-11', 'F', 89, 7, 54, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (8, 'Xavier', 'WONG', '1953-01-10', 'F', 101, 7, 53, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (9, 'Ingrid', 'CLEMENTS', '2009-12-14', 'M', 86, 7, 52, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (10, 'Harrison', 'DAY', '1990-12-03', 'F', 116, 7, 51, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (11, 'Ronan', 'MARSHALL', '1998-12-23', 'F', 58, 8, 50, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (12, 'Jordyn', 'EATON', '2006-09-28', 'M', 100, 8, 49, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (13, 'Payton', 'HEWITT', '1972-03-25', 'F', 125, 3, 48, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (14, 'Brogan', 'ROBLES', '1998-08-02', 'M', 150, 2, 47, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (15, 'Maxim', 'BLAIR', '1984-07-19', 'M', 83, 5, 46, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (16, 'Dane', 'WALLS', '1979-03-12', 'M', 128, 7, 45, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (17, 'Moriah', 'SHEPPARD', '1956-09-02', 'F', 126, 4, 44, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (18, 'Jeremy', 'REESE', '2005-11-26', 'M', 114, 4, 43, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (19, 'Adalynn', 'GREGORY', '2008-03-19', 'M', 136, 2, 42, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (20, 'Harper', 'WOODWARD', '1994-05-28', 'F', 137, 3, 41, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (21, 'Corey', 'CONTRERAS', '2002-03-16', 'F', 147, 3, 40, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (22, 'Sadie', 'GOLDEN', '2005-07-09', 'M', 138, 6, 39, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (23, 'Curtis', 'GORDON', '1974-10-14', 'M', 60, 1, 38, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (24, 'Jayde', 'HINES', '1974-05-02', 'M', 42, 4, 37, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (25, 'Lesly', 'BAILEY', '1962-05-15', 'M', 136, 6, 36, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (26, 'Phillip', 'WASHINGTON', '1952-08-06', 'F', 108, 6, 35, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (27, 'Holly', 'MACIAS', '1967-05-08', 'M', 45, 7, 34, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (28, 'Devon', 'OSBORNE', '1961-01-21', 'M', 50, 8, 33, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (29, 'Emelia', 'COLEMAN', '1972-09-11', 'M', 50, 6, 32, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (30, 'Marley', 'FRANKS', '2006-09-27', 'F', 92, 6, 31, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (31, 'Mckenzie', 'FROST', '1987-11-19', 'M', 99, 4, 30, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (32, 'Bristol', 'RUSSELL', '1979-09-25', 'M', 113, 1, 29, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (33, 'Sonia', 'RYAN', '1974-02-11', 'M', 49, 4, 28, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (34, 'Charlie', 'GARNER', '1982-10-02', 'F', 93, 6, 27, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (35, 'Regina', 'CUNNINGHAM', '1954-12-23', 'F', 55, 8, 26, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (36, 'Malik', 'KNOX', '1951-06-14', 'F', 129, 2, 25, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (37, 'Audrina', 'BENSON', '2003-06-28', 'F', 59, 3, 24, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (38, 'Leighton', 'STEIN', '1964-03-13', 'F', 123, 5, 23, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (39, 'Braelyn', 'HOWELL', '1979-07-15', 'F', 96, 3, 22, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (40, 'Deandre', 'BALL', '1998-09-14', 'M', 100, 2, 21, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (41, 'Everett', 'RAMIREZ', '1965-05-28', 'M', 76, 4, 20, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (42, 'Giselle', 'SHELTON', '1965-08-21', 'F', 123, 5, 19, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (43, 'Cedric', 'CARRILLO', '1993-01-08', 'M', 110, 6, 18, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (44, 'Skylar', 'INGRAM', '1990-03-19', 'F', 116, 4, 17, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (45, 'Jovani', 'HUNT', '1971-04-21', 'M', 74, 6, 16, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (46, 'Evangeline', 'MILLER', '1985-11-04', 'F', 64, 4, 15, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (47, 'Brylee', 'WHITFIELD', '1977-09-07', 'M', 50, 2, 14, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (48, 'Maliyah', 'RASMUSSEN', '1971-10-25', 'M', 126, 6, 13, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (49, 'Zackary', 'DAVIS', '1966-04-24', 'M', 65, 2, 12, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (50, 'Anabella', 'ZIMMERMAN', '2007-06-14', 'M', 114, 1, 11, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (51, 'Isabelle', 'WYNN', '1958-04-14', 'F', 110, 4, 10, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (52, 'Nyla', 'KEY', '1973-12-08', 'M', 52, 6, 9, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (53, 'Jewel', 'LEACH', '1982-09-08', 'M', 66, 5, 8, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (54, 'Alessandro', 'WADE', '2008-11-02', 'M', 143, 2, 7, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (55, 'Giovanna', 'HOGAN', '1987-09-13', 'F', 144, 2, 6, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (56, 'Mathias', 'BULLOCK', '1997-07-08', 'F', 99, 2, 5, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (57, 'Elian', 'HOBBS', '1982-04-07', 'F', 44, 7, 4, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (58, 'Jaylee', 'DECKER', '1951-08-11', 'M', 51, 1, 3, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (59, 'Naomi', 'TYSON', '1999-02-22', 'M', 78, 7, 2, '');
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `sex`, `weight_kg`, `blood_type_id`, `address_id`, `notes`) VALUES (60, 'Kaiden', 'RANDALL', '2008-08-08', 'F', 94, 3, 1, '');

COMMIT;


-- -----------------------------------------------------
-- Data for table `protein_class`
-- -----------------------------------------------------
START TRANSACTION;
USE `organmatcherdb`;
INSERT INTO `protein_class` (`id`, `protein_class`, `description`) VALUES (1, 'a', 'MAJOR-A');
INSERT INTO `protein_class` (`id`, `protein_class`, `description`) VALUES (2, 'b', 'MAJOR-B');
INSERT INTO `protein_class` (`id`, `protein_class`, `description`) VALUES (3, 'c', 'MAJOR-C');
INSERT INTO `protein_class` (`id`, `protein_class`, `description`) VALUES (4, 'd', 'MINOR-D');
INSERT INTO `protein_class` (`id`, `protein_class`, `description`) VALUES (5, 'e', 'MINOR-E');
INSERT INTO `protein_class` (`id`, `protein_class`, `description`) VALUES (6, 'f', 'MINOR-F');

COMMIT;


-- -----------------------------------------------------
-- Data for table `hla`
-- -----------------------------------------------------
START TRANSACTION;
USE `organmatcherdb`;
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (1, 5, 1, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (2, 6, 1, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (3, 4, 1, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (4, 3, 1, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (5, 2, 1, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (6, 6, 1, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (7, 6, 2, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (8, 5, 2, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (9, 2, 2, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (10, 1, 2, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (11, 4, 2, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (12, 1, 2, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (13, 2, 3, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (14, 3, 3, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (15, 2, 3, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (16, 2, 3, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (17, 2, 3, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (18, 1, 3, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (19, 1, 4, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (20, 3, 4, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (21, 5, 4, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (22, 1, 4, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (23, 1, 4, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (24, 6, 4, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (25, 4, 5, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (26, 2, 5, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (27, 1, 5, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (28, 3, 5, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (29, 2, 5, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (30, 4, 5, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (31, 6, 6, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (32, 3, 6, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (33, 1, 6, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (34, 3, 6, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (35, 3, 6, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (36, 3, 6, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (37, 5, 7, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (38, 3, 7, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (39, 6, 7, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (40, 5, 7, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (41, 3, 7, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (42, 3, 7, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (43, 2, 8, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (44, 4, 8, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (45, 1, 8, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (46, 2, 8, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (47, 2, 8, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (48, 4, 8, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (49, 5, 9, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (50, 5, 9, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (51, 2, 9, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (52, 2, 9, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (53, 5, 9, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (54, 1, 9, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (55, 5, 10, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (56, 6, 10, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (57, 5, 10, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (58, 3, 10, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (59, 4, 10, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (60, 3, 10, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (61, 6, 11, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (62, 2, 11, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (63, 6, 11, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (64, 4, 11, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (65, 6, 11, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (66, 6, 11, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (67, 4, 12, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (68, 3, 12, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (69, 4, 12, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (70, 6, 12, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (71, 4, 12, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (72, 6, 12, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (73, 1, 13, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (74, 3, 13, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (75, 2, 13, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (76, 2, 13, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (77, 2, 13, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (78, 1, 13, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (79, 2, 14, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (80, 5, 14, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (81, 3, 14, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (82, 6, 14, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (83, 5, 14, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (84, 3, 14, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (85, 6, 15, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (86, 6, 15, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (87, 5, 15, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (88, 5, 15, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (89, 3, 15, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (90, 1, 15, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (91, 6, 16, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (92, 6, 16, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (93, 5, 16, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (94, 3, 16, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (95, 4, 16, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (96, 3, 16, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (97, 4, 17, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (98, 6, 17, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (99, 4, 17, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (100, 3, 17, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (101, 2, 17, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (102, 6, 17, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (103, 6, 18, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (104, 2, 18, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (105, 5, 18, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (106, 6, 18, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (107, 3, 18, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (108, 4, 18, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (109, 3, 19, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (110, 5, 19, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (111, 2, 19, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (112, 4, 19, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (113, 3, 19, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (114, 6, 19, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (115, 3, 20, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (116, 5, 20, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (117, 4, 20, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (118, 5, 20, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (119, 2, 20, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (120, 6, 20, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (121, 1, 21, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (122, 6, 21, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (123, 6, 21, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (124, 6, 21, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (125, 2, 21, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (126, 2, 21, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (127, 4, 22, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (128, 6, 22, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (129, 1, 22, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (130, 5, 22, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (131, 1, 22, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (132, 6, 22, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (133, 3, 23, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (134, 1, 23, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (135, 1, 23, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (136, 3, 23, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (137, 3, 23, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (138, 5, 23, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (139, 6, 24, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (140, 2, 24, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (141, 1, 24, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (142, 2, 24, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (143, 4, 24, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (144, 5, 24, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (145, 3, 25, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (146, 3, 25, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (147, 1, 25, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (148, 2, 25, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (149, 2, 25, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (150, 5, 25, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (151, 6, 26, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (152, 3, 26, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (153, 1, 26, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (154, 2, 26, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (155, 2, 26, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (156, 4, 26, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (157, 1, 27, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (158, 1, 27, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (159, 5, 27, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (160, 1, 27, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (161, 5, 27, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (162, 5, 27, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (163, 2, 28, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (164, 2, 28, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (165, 6, 28, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (166, 3, 28, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (167, 2, 28, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (168, 4, 28, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (169, 3, 29, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (170, 2, 29, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (171, 2, 29, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (172, 1, 29, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (173, 3, 29, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (174, 2, 29, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (175, 3, 30, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (176, 6, 30, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (177, 5, 30, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (178, 5, 30, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (179, 6, 30, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (180, 2, 30, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (181, 1, 31, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (182, 5, 31, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (183, 4, 31, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (184, 3, 31, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (185, 5, 31, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (186, 2, 31, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (187, 5, 32, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (188, 5, 32, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (189, 5, 32, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (190, 5, 32, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (191, 5, 32, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (192, 2, 32, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (193, 1, 33, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (194, 3, 33, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (195, 1, 33, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (196, 2, 33, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (197, 2, 33, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (198, 4, 33, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (199, 4, 34, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (200, 6, 34, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (201, 5, 34, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (202, 1, 34, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (203, 3, 34, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (204, 4, 34, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (205, 5, 35, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (206, 5, 35, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (207, 2, 35, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (208, 3, 35, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (209, 1, 35, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (210, 6, 35, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (211, 4, 36, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (212, 6, 36, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (213, 1, 36, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (214, 2, 36, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (215, 6, 36, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (216, 4, 36, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (217, 3, 37, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (218, 3, 37, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (219, 4, 37, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (220, 6, 37, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (221, 6, 37, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (222, 6, 37, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (223, 4, 38, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (224, 3, 38, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (225, 2, 38, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (226, 2, 38, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (227, 2, 38, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (228, 3, 38, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (229, 2, 39, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (230, 3, 39, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (231, 1, 39, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (232, 6, 39, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (233, 4, 39, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (234, 4, 39, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (235, 4, 40, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (236, 5, 40, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (237, 2, 40, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (238, 4, 40, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (239, 3, 40, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (240, 1, 40, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (241, 6, 41, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (242, 6, 41, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (243, 4, 41, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (244, 3, 41, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (245, 2, 41, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (246, 1, 41, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (247, 3, 42, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (248, 5, 42, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (249, 5, 42, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (250, 3, 42, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (251, 6, 42, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (252, 4, 42, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (253, 6, 43, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (254, 6, 43, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (255, 1, 43, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (256, 1, 43, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (257, 5, 43, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (258, 1, 43, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (259, 1, 44, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (260, 4, 44, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (261, 2, 44, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (262, 6, 44, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (263, 1, 44, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (264, 5, 44, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (265, 1, 45, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (266, 2, 45, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (267, 2, 45, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (268, 1, 45, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (269, 3, 45, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (270, 1, 45, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (271, 4, 46, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (272, 4, 46, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (273, 1, 46, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (274, 2, 46, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (275, 4, 46, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (276, 5, 46, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (277, 4, 47, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (278, 3, 47, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (279, 4, 47, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (280, 1, 47, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (281, 6, 47, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (282, 5, 47, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (283, 2, 48, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (284, 2, 48, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (285, 2, 48, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (286, 1, 48, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (287, 3, 48, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (288, 1, 48, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (289, 2, 49, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (290, 5, 49, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (291, 2, 49, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (292, 4, 49, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (293, 3, 49, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (294, 6, 49, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (295, 5, 50, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (296, 5, 50, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (297, 4, 50, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (298, 6, 50, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (299, 5, 50, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (300, 5, 50, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (301, 5, 51, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (302, 6, 51, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (303, 4, 51, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (304, 3, 51, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (305, 2, 51, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (306, 6, 51, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (307, 2, 52, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (308, 1, 52, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (309, 3, 52, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (310, 1, 52, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (311, 2, 52, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (312, 2, 52, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (313, 4, 53, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (314, 3, 53, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (315, 2, 53, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (316, 2, 53, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (317, 2, 53, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (318, 1, 53, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (319, 4, 54, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (320, 1, 54, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (321, 6, 54, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (322, 5, 54, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (323, 6, 54, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (324, 2, 54, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (325, 2, 55, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (326, 4, 55, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (327, 5, 55, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (328, 1, 55, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (329, 3, 55, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (330, 1, 55, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (331, 3, 56, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (332, 5, 56, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (333, 2, 56, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (334, 4, 56, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (335, 3, 56, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (336, 6, 56, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (337, 6, 57, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (338, 6, 57, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (339, 5, 57, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (340, 3, 57, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (341, 4, 57, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (342, 3, 57, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (343, 4, 58, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (344, 2, 58, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (345, 5, 58, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (346, 2, 58, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (347, 4, 58, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (348, 2, 58, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (349, 6, 59, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (350, 1, 59, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (351, 5, 59, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (352, 3, 59, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (353, 4, 59, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (354, 4, 59, 6);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (355, 2, 60, 1);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (356, 3, 60, 2);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (357, 2, 60, 3);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (358, 5, 60, 4);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (359, 6, 60, 5);
INSERT INTO `hla` (`id`, `allele`, `patient_id`, `protein_class_id`) VALUES (360, 6, 60, 6);

COMMIT;


-- -----------------------------------------------------
-- Data for table `auth_user`
-- -----------------------------------------------------
START TRANSACTION;
USE `organmatcherdb`;
INSERT INTO `auth_user` (`id`, `first_name`, `last_name`, `username`, `role`, `password`, `enabled`) VALUES (1, 'admin', 'admin', 'admin', 'admin', '$2a$10$KS0mxYpEE26liNlRiQfMTekZ9NXhepkqhYWjIPMs9rSrOAhb39zo6', 1);
INSERT INTO `auth_user` (`id`, `first_name`, `last_name`, `username`, `role`, `password`, `enabled`) VALUES (2, 'John', 'Smith', 'rando', 'user', '$2a$10$NMhupucK.Zd5XuT56zkY/eftXpniTdnZgudRPLaUkU3Rg4K72MVdG', 1);
INSERT INTO `auth_user` (`id`, `first_name`, `last_name`, `username`, `role`, `password`, `enabled`) VALUES (3, 'Andrew', 'Wilkons', 'awo', 'user', '$2a$10$VQ7bHJrzhrhhwcGOChVaCuVJTDSSrfSxeIlilwK93WfSU0MP6m.vu', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `transplant_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `organmatcherdb`;
INSERT INTO `transplant_type` (`id`, `organ`) VALUES (1, 'bonemarrow');
INSERT INTO `transplant_type` (`id`, `organ`) VALUES (2, 'kidney');
INSERT INTO `transplant_type` (`id`, `organ`) VALUES (3, 'liver');

COMMIT;


-- -----------------------------------------------------
-- Data for table `transplant_request`
-- -----------------------------------------------------
START TRANSACTION;
USE `organmatcherdb`;
INSERT INTO `transplant_request` (`id`, `approval_status`, `created_at`, `recipient_id`, `donor_id`, `organ_type_id`, `notes`) VALUES (1, NULL, DEFAULT, 57, NULL, 1, 'Aenean cursus, dolor et aliquet aliquet, justo nisi dictum eros, ac varius justo mi malesuada odio. Vestibulum est nibh, fermentum in sagittis quis, sagittis quis tellus. Aliquam commodo, purus ut mattis suscipit, nulla elit gravida augue, et viverra sem ex vitae nibh. Pellentesque blandit rutrum elit, et venenatis est pellentesque.');
INSERT INTO `transplant_request` (`id`, `approval_status`, `created_at`, `recipient_id`, `donor_id`, `organ_type_id`, `notes`) VALUES (2, NULL, DEFAULT, 29, NULL, 2, 'Phasellus interdum id risus pharetra finibus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed leo est, ultrices nec est in, mattis varius dui. Nam consequat et lorem vitae venenatis. Sed vel diam auctor, pharetra sapien ac, consequat ex. Mauris vel tortor turpis. Quisque ultrices lacus nec eros ultrices, vitae.');
INSERT INTO `transplant_request` (`id`, `approval_status`, `created_at`, `recipient_id`, `donor_id`, `organ_type_id`, `notes`) VALUES (3, NULL, DEFAULT, 1, NULL, 3, 'Phasellus interdum id risus pharetra finibus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed leo est, ultrices nec est in, mattis varius dui. Nam consequat et lorem vitae venenatis. Sed vel diam auctor, pharetra sapien ac, consequat ex. Mauris vel tortor turpis. Quisque ultrices lacus nec eros ultrices, vitae.');
INSERT INTO `transplant_request` (`id`, `approval_status`, `created_at`, `recipient_id`, `donor_id`, `organ_type_id`, `notes`) VALUES (4, NULL, DEFAULT, 53, NULL, 3, 'Maecenas orci erat, faucibus et imperdiet at, porta tempor nulla. Fusce faucibus elit ut neque elementum semper. Duis feugiat accumsan urna vel aliquet. Suspendisse aliquam, urna ut dictum mollis, eros libero facilisis sem, eu tempor nunc nisl sit amet lectus. Etiam in nibh vehicula, dignissim dui pellentesque, bibendum arcu. Nullam.');
INSERT INTO `transplant_request` (`id`, `approval_status`, `created_at`, `recipient_id`, `donor_id`, `organ_type_id`, `notes`) VALUES (5, NULL, DEFAULT, 33, NULL, 2, 'Phasellus at urna iaculis, fermentum neque nec, ullamcorper magna. Integer volutpat facilisis venenatis. Pellentesque vel risus et arcu molestie venenatis sed id arcu. Donec nibh libero, porta vel tempus eget, consequat id nisi. Phasellus egestas tortor rutrum ante porttitor malesuada. Pellentesque ullamcorper, sapien non imperdiet luctus, mauris risus ultricies diam.');
INSERT INTO `transplant_request` (`id`, `approval_status`, `created_at`, `recipient_id`, `donor_id`, `organ_type_id`, `notes`) VALUES (6, NULL, DEFAULT, 19, NULL, 1, 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Mauris eleifend purus in ante mollis, vitae auctor metus laoreet. Nunc aliquet nunc ut erat sagittis feugiat. Sed quis laoreet libero. Morbi tortor risus, facilisis vel purus in, efficitur placerat nibh. Mauris ut lectus dui. Vestibulum eget.');

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


-- -----------------------------------------------------
-- Data for table `donor_role`
-- -----------------------------------------------------
START TRANSACTION;
USE `organmatcherdb`;
INSERT INTO `donor_role` (`patient_id`, `transplant_type_id`) VALUES (16, 1);
INSERT INTO `donor_role` (`patient_id`, `transplant_type_id`) VALUES (48, 2);
INSERT INTO `donor_role` (`patient_id`, `transplant_type_id`) VALUES (51, 3);
INSERT INTO `donor_role` (`patient_id`, `transplant_type_id`) VALUES (3, 3);
INSERT INTO `donor_role` (`patient_id`, `transplant_type_id`) VALUES (52, 2);
INSERT INTO `donor_role` (`patient_id`, `transplant_type_id`) VALUES (56, 1);
INSERT INTO `donor_role` (`patient_id`, `transplant_type_id`) VALUES (10, 1);
INSERT INTO `donor_role` (`patient_id`, `transplant_type_id`) VALUES (45, 2);
INSERT INTO `donor_role` (`patient_id`, `transplant_type_id`) VALUES (17, 3);
INSERT INTO `donor_role` (`patient_id`, `transplant_type_id`) VALUES (13, 3);
INSERT INTO `donor_role` (`patient_id`, `transplant_type_id`) VALUES (26, 2);
INSERT INTO `donor_role` (`patient_id`, `transplant_type_id`) VALUES (49, 1);
INSERT INTO `donor_role` (`patient_id`, `transplant_type_id`) VALUES (59, 1);
INSERT INTO `donor_role` (`patient_id`, `transplant_type_id`) VALUES (30, 2);
INSERT INTO `donor_role` (`patient_id`, `transplant_type_id`) VALUES (41, 3);
INSERT INTO `donor_role` (`patient_id`, `transplant_type_id`) VALUES (39, 3);
INSERT INTO `donor_role` (`patient_id`, `transplant_type_id`) VALUES (25, 2);
INSERT INTO `donor_role` (`patient_id`, `transplant_type_id`) VALUES (40, 1);
INSERT INTO `donor_role` (`patient_id`, `transplant_type_id`) VALUES (16, 3);
INSERT INTO `donor_role` (`patient_id`, `transplant_type_id`) VALUES (51, 2);
INSERT INTO `donor_role` (`patient_id`, `transplant_type_id`) VALUES (52, 1);
INSERT INTO `donor_role` (`patient_id`, `transplant_type_id`) VALUES (10, 3);
INSERT INTO `donor_role` (`patient_id`, `transplant_type_id`) VALUES (17, 2);
INSERT INTO `donor_role` (`patient_id`, `transplant_type_id`) VALUES (26, 1);
INSERT INTO `donor_role` (`patient_id`, `transplant_type_id`) VALUES (59, 3);
INSERT INTO `donor_role` (`patient_id`, `transplant_type_id`) VALUES (41, 2);
INSERT INTO `donor_role` (`patient_id`, `transplant_type_id`) VALUES (25, 1);

COMMIT;

