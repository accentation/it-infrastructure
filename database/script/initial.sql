-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema banking
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `banking` ;

-- -----------------------------------------------------
-- Schema banking
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `banking` DEFAULT CHARACTER SET utf8 ;
USE `banking` ;

-- -----------------------------------------------------
-- Table `banking`.`office`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banking`.`office` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(2048) NOT NULL,
  `phone` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 10;


-- -----------------------------------------------------
-- Table `banking`.`account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banking`.`account` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `office_id` INT(11) NOT NULL,
  `iban` VARCHAR(255) NOT NULL,
  `created_datetime` DATETIME NOT NULL COMMENT 'UTC',
  `deleted_datetime` DATETIME NULL COMMENT 'UTC',
  `balance` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_account_office_idx` (`office_id` ASC),
  UNIQUE INDEX `iban_UNIQUE` (`iban` ASC),
  CONSTRAINT `fk_account_office`
    FOREIGN KEY (`office_id`)
    REFERENCES `banking`.`office` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 10;


-- -----------------------------------------------------
-- Table `banking`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banking`.`client` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `created_datetime` DATETIME NOT NULL COMMENT 'UTC',
  `deleted_datetime` DATETIME NULL COMMENT 'UTC',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 10;


-- -----------------------------------------------------
-- Table `banking`.`account_client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banking`.`account_client` (
  `account_id` INT(11) NOT NULL,
  `client_id` INT(11) NOT NULL,
  `type` INT(1) NOT NULL COMMENT '\'client rol\': 1 Owner, 2 Co-Owner, 3 Authorized',
  PRIMARY KEY (`account_id`, `client_id`),
  INDEX `fk_account_has_client_client1_idx` (`client_id` ASC),
  INDEX `fk_account_has_client_account1_idx` (`account_id` ASC),
  UNIQUE INDEX `account_UNIQUE` (`account_id` ASC, `client_id` ASC, `type` ASC),
  CONSTRAINT `fk_account_has_client_account1`
    FOREIGN KEY (`account_id`)
    REFERENCES `banking`.`account` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_account_has_client_client1`
    FOREIGN KEY (`client_id`)
    REFERENCES `banking`.`client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `banking`.`transaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banking`.`transaction` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `account_id` INT(11) NOT NULL,
  `datetime` DATETIME NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `type` INT(3) NOT NULL,
  `amount` BIGINT NOT NULL COMMENT 'cents',
  PRIMARY KEY (`id`, `account_id`),
  INDEX `fk_transaction_account1_idx` (`account_id` ASC),
  CONSTRAINT `fk_transaction_account1`
    FOREIGN KEY (`account_id`)
    REFERENCES `banking`.`account` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 100;


-- -----------------------------------------------------
-- Data for table `banking`.`office`
-- -----------------------------------------------------
START TRANSACTION;
USE `banking`;
INSERT INTO `banking`.`office` (`id`, `address`, `phone`) VALUES (1, 'calle Alcala 208 Madrid Spain', '678678678');
INSERT INTO `banking`.`office` (`id`, `address`, `phone`) VALUES (2, 'calle Zurbano 12 Madrid Spain', '643123123');
INSERT INTO `banking`.`office` (`id`, `address`, `phone`) VALUES (3, 'calle Real 12 Madrid Spain', '612098765');

COMMIT;


-- -----------------------------------------------------
-- Data for table `banking`.`account`
-- -----------------------------------------------------
START TRANSACTION;
USE `banking`;
INSERT INTO `banking`.`account` (`id`, `office_id`, `iban`, `created_datetime`, `deleted_datetime`, `balance`) VALUES (1, 1, 'ES91 2100 0418 4502 0005 1332', NOW(), NULL, 1280000000);
INSERT INTO `banking`.`account` (`id`, `office_id`, `iban`, `created_datetime`, `deleted_datetime`, `balance`) VALUES (2, 1, 'ES91 2100 0418 4502 0005 1123', NOW(), NULL, 2781928465);
INSERT INTO `banking`.`account` (`id`, `office_id`, `iban`, `created_datetime`, `deleted_datetime`, `balance`) VALUES (3, 1, 'ES91 2100 0418 0987 1205 1167', NOW(), NULL, 9272563834);
INSERT INTO `banking`.`account` (`id`, `office_id`, `iban`, `created_datetime`, `deleted_datetime`, `balance`) VALUES (4, 3, 'ES91 9876 7651 0092 0123 1000', NOW(), NULL, 3547458390);
INSERT INTO `banking`.`account` (`id`, `office_id`, `iban`, `created_datetime`, `deleted_datetime`, `balance`) VALUES (5, 2, 'ES91 3245 7651 0092 0123 1000', NOW(), NULL, 1230001234);

COMMIT;


-- -----------------------------------------------------
-- Data for table `banking`.`client`
-- -----------------------------------------------------
START TRANSACTION;
USE `banking`;
INSERT INTO `banking`.`client` (`id`, `name`, `surname`, `created_datetime`, `deleted_datetime`) VALUES (1, 'Zinedine', 'Zidane', NOW(), NULL);
INSERT INTO `banking`.`client` (`id`, `name`, `surname`, `created_datetime`, `deleted_datetime`) VALUES (2, 'Sergio', 'Noventa y Tres', NOW(), NULL);
INSERT INTO `banking`.`client` (`id`, `name`, `surname`, `created_datetime`, `deleted_datetime`) VALUES (3, 'Ignacio', 'Ladrón Gonzalez', NOW(), NULL);
INSERT INTO `banking`.`client` (`id`, `name`, `surname`, `created_datetime`, `deleted_datetime`) VALUES (4, 'Arturito', 'Accenture', NOW(), NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `banking`.`account_client`
-- -----------------------------------------------------
START TRANSACTION;
USE `banking`;
INSERT INTO `banking`.`account_client` (`account_id`, `client_id`, `type`) VALUES (1, 1, 1);
INSERT INTO `banking`.`account_client` (`account_id`, `client_id`, `type`) VALUES (2, 2, 1);
INSERT INTO `banking`.`account_client` (`account_id`, `client_id`, `type`) VALUES (3, 3, 1);
INSERT INTO `banking`.`account_client` (`account_id`, `client_id`, `type`) VALUES (4, 4, 1);
INSERT INTO `banking`.`account_client` (`account_id`, `client_id`, `type`) VALUES (5, 1, 1);
INSERT INTO `banking`.`account_client` (`account_id`, `client_id`, `type`) VALUES (3, 4, 3);

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
