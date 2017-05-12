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
  `dni` VARCHAR(45) NOT NULL,
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
INSERT INTO `banking`.`client` (`id`, `name`, `surname`, `dni`, `created_datetime`, `deleted_datetime`) VALUES (1, 'Zinedine', 'Zidane', '3127361823A', NOW(), NULL);
INSERT INTO `banking`.`client` (`id`, `name`, `surname`, `created_datetime`, `deleted_datetime`) VALUES (2, 'Sergio', 'Noventa y Tres', '45646464A', NOW(), NULL);
INSERT INTO `banking`.`client` (`id`, `name`, `surname`, `created_datetime`, `deleted_datetime`) VALUES (3, 'Ignacio', 'Ladrón Gonzalez','66666666A', NOW(), NULL);
INSERT INTO `banking`.`client` (`id`, `name`, `surname`, `created_datetime`, `deleted_datetime`) VALUES (4, 'Arturito', 'Accenture', '999999A', NOW(), NULL);

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

-- -----------------------------------------------------
-- Data for table `banking`.`transaction`
-- -----------------------------------------------------
START TRANSACTION;
USE `banking`;
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2015-07-04 06:17:32","Recibo",2,-8127);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2016-11-26 20:54:12","Nomina",3,7919);
insert into banking.transaction(account_id,datetime,description,type,amount) values (1,"2017-09-07 12:53:43","Recibo",3,-4804);
insert into banking.transaction(account_id,datetime,description,type,amount) values (5,"2015-06-12 05:41:42","Recibo",1,-1881);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2016-10-04 03:57:53","Pago a cuenta",2,-1023);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2017-02-25 05:00:40","Impuesto",2,-852);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2015-02-11 18:07:55","Recibo",2,-8461);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2017-08-24 10:32:09","Recibo",2,-2397);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2016-03-23 21:47:30","Pago a cuenta",1,-4514);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2016-04-13 02:04:24","Devolución",2,1603);
insert into banking.transaction(account_id,datetime,description,type,amount) values (1,"2017-11-24 05:31:42","Nomina",1,7804);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2016-02-08 10:39:23","Recibo",2,-4312);
insert into banking.transaction(account_id,datetime,description,type,amount) values (5,"2016-08-03 12:48:39","Impuesto",2,-320);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2016-05-22 21:57:05","Recibo",2,-6178);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2017-02-26 07:11:32","Nomina",3,8770);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2017-02-10 04:18:25","Ingreso a cuenta",1,7907);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2015-10-05 11:47:36","Nomina",2,224);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2017-07-14 02:21:45","Recibo",2,-9248);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2017-01-23 02:32:23","Impuesto",2,-7740);
insert into banking.transaction(account_id,datetime,description,type,amount) values (5,"2016-10-20 04:47:02","Ingreso a cuenta",3,5569);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2017-08-27 14:35:19","Recibo",2,-2925);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2016-09-12 08:03:02","Ingreso a cuenta",3,6615);
insert into banking.transaction(account_id,datetime,description,type,amount) values (1,"2017-03-06 20:59:35","Nomina",2,3421);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2017-06-13 20:51:25","Impuesto",3,-3050);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2015-11-22 10:21:57","Nomina",2,4039);
insert into banking.transaction(account_id,datetime,description,type,amount) values (1,"2016-07-11 18:28:36","Recibo",2,-2297);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2016-01-15 09:45:30","Pago a cuenta",1,-5830);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2015-06-01 04:30:47","Ingreso a cuenta",1,8217);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2015-05-10 13:28:17","Recibo",2,-7619);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2017-10-11 05:46:33","Impuesto",2,-947);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2015-10-22 22:48:42","Impuesto",2,-2073);
insert into banking.transaction(account_id,datetime,description,type,amount) values (5,"2016-04-04 07:38:05","Pago a cuenta",2,-9074);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2016-04-20 15:38:46","Nomina",3,8469);
insert into banking.transaction(account_id,datetime,description,type,amount) values (1,"2016-12-11 21:52:51","Impuesto",1,-2333);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2016-11-17 10:17:23","Nomina",2,8101);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2016-07-16 18:59:21","Ingreso a cuenta",2,4867);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2015-02-03 19:34:15","Ingreso a cuenta",3,240);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2015-05-12 16:37:17","Ingreso a cuenta",1,1162);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2016-10-25 17:21:34","Nomina",2,8915);
insert into banking.transaction(account_id,datetime,description,type,amount) values (1,"2016-06-15 13:36:24","Recibo",3,-2224);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2015-06-22 05:02:46","Recibo",2,-542);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2015-10-17 07:39:10","Devolución",3,7144);
insert into banking.transaction(account_id,datetime,description,type,amount) values (5,"2016-05-21 02:41:58","Impuesto",3,-7697);
insert into banking.transaction(account_id,datetime,description,type,amount) values (5,"2017-12-07 15:35:38","Recibo",3,-6976);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2016-09-27 12:36:31","Ingreso a cuenta",2,1222);
insert into banking.transaction(account_id,datetime,description,type,amount) values (1,"2017-03-19 11:42:58","Pago a cuenta",1,-8918);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2016-08-16 06:05:55","Nomina",1,4573);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2016-06-16 01:52:56","Recibo",1,-1508);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2015-05-25 20:12:44","Ingreso a cuenta",2,114);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2016-09-24 11:57:31","Recibo",1,-1776);
insert into banking.transaction(account_id,datetime,description,type,amount) values (1,"2017-12-01 17:47:21","Pago a cuenta",1,-4061);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2016-02-19 23:43:38","Nomina",1,4847);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2016-02-17 00:10:01","Impuesto",2,-9383);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2016-03-21 16:18:06","Nomina",3,4522);
insert into banking.transaction(account_id,datetime,description,type,amount) values (1,"2016-12-05 07:54:17","Nomina",1,9064);
insert into banking.transaction(account_id,datetime,description,type,amount) values (5,"2017-05-27 04:29:10","Recibo",2,-3196);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2015-07-13 20:37:12","Devolución",1,1735);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2015-03-19 06:54:54","Ingreso a cuenta",1,3882);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2016-10-15 11:06:29","Pago a cuenta",2,-2240);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2015-08-14 07:21:54","Impuesto",2,-5194);
insert into banking.transaction(account_id,datetime,description,type,amount) values (5,"2016-06-14 13:51:26","Impuesto",2,-7074);
insert into banking.transaction(account_id,datetime,description,type,amount) values (1,"2015-06-05 02:01:11","Ingreso a cuenta",3,8835);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2016-04-25 05:36:40","Recibo",2,-2137);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2016-04-05 04:19:43","Impuesto",2,-3794);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2016-07-23 06:57:23","Recibo",2,-4981);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2016-11-17 03:06:02","Devolución",2,4365);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2017-04-11 02:50:09","Nomina",3,6270);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2017-08-15 04:39:33","Nomina",1,1175);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2016-08-06 19:09:17","Recibo",3,-6007);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2017-12-01 09:40:19","Pago a cuenta",3,-8058);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2016-11-10 07:54:35","Impuesto",1,-8614);
insert into banking.transaction(account_id,datetime,description,type,amount) values (1,"2016-08-07 05:30:56","Devolución",1,5137);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2015-10-07 12:51:28","Pago a cuenta",2,-679);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2015-06-16 16:35:40","Nomina",1,1898);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2017-07-22 15:49:53","Pago a cuenta",2,-8138);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2015-03-26 03:16:07","Recibo",2,-8755);
insert into banking.transaction(account_id,datetime,description,type,amount) values (1,"2016-03-14 16:13:48","Nomina",2,5514);
insert into banking.transaction(account_id,datetime,description,type,amount) values (1,"2016-07-20 01:31:56","Nomina",2,1105);
insert into banking.transaction(account_id,datetime,description,type,amount) values (1,"2015-02-03 01:22:43","Recibo",1,-1585);
insert into banking.transaction(account_id,datetime,description,type,amount) values (5,"2017-08-22 04:20:22","Pago a cuenta",3,-4820);
insert into banking.transaction(account_id,datetime,description,type,amount) values (5,"2016-07-28 19:46:44","Nomina",1,6602);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2015-09-09 04:32:57","Ingreso a cuenta",2,1445);
insert into banking.transaction(account_id,datetime,description,type,amount) values (5,"2015-06-21 14:50:34","Ingreso a cuenta",1,8776);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2016-03-09 05:52:10","Nomina",2,7502);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2016-04-26 17:57:37","Devolución",2,9066);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2015-06-06 07:03:10","Nomina",3,1014);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2016-10-17 20:02:46","Pago a cuenta",1,-3736);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2016-11-22 23:44:22","Pago a cuenta",3,-1388);
insert into banking.transaction(account_id,datetime,description,type,amount) values (1,"2015-07-04 20:21:02","Nomina",3,9377);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2016-07-12 00:20:48","Nomina",1,6309);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2017-11-16 15:45:49","Pago a cuenta",2,-6032);
insert into banking.transaction(account_id,datetime,description,type,amount) values (1,"2017-11-15 20:13:24","Pago a cuenta",2,-4707);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2017-06-10 22:52:39","Recibo",2,-8139);
insert into banking.transaction(account_id,datetime,description,type,amount) values (1,"2017-06-20 12:27:34","Nomina",3,8750);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2015-08-19 06:07:33","Devolución",2,4319);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2016-05-16 15:58:37","Devolución",1,630);
insert into banking.transaction(account_id,datetime,description,type,amount) values (5,"2016-04-17 12:39:14","Ingreso a cuenta",3,6840);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2017-08-17 10:04:03","Impuesto",2,-647);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2016-10-12 15:23:29","Nomina",3,4252);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2016-11-23 23:08:07","Recibo",2,-3610);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2016-11-04 01:49:21","Pago a cuenta",2,-7524);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2016-12-15 12:12:24","Pago a cuenta",2,-5977);
insert into banking.transaction(account_id,datetime,description,type,amount) values (1,"2016-06-01 03:17:16","Pago a cuenta",2,-4780);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2016-05-24 03:34:16","Recibo",2,-8526);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2016-09-14 10:53:56","Recibo",1,-450);
insert into banking.transaction(account_id,datetime,description,type,amount) values (1,"2015-02-20 03:56:10","Ingreso a cuenta",2,4901);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2015-06-20 22:11:15","Recibo",3,-7001);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2016-02-06 18:35:56","Nomina",1,5947);
insert into banking.transaction(account_id,datetime,description,type,amount) values (5,"2017-08-24 11:03:47","Ingreso a cuenta",1,8327);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2017-08-08 03:11:56","Nomina",3,7268);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2016-01-12 04:24:03","Devolución",2,2315);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2015-06-27 02:29:29","Ingreso a cuenta",2,3149);
insert into banking.transaction(account_id,datetime,description,type,amount) values (5,"2016-01-24 22:18:01","Impuesto",1,-3513);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2015-11-09 07:45:36","Nomina",3,7090);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2016-01-19 14:00:23","Recibo",3,-9244);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2015-04-18 10:46:55","Devolución",1,5825);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2016-05-10 14:52:48","Recibo",2,-6528);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2016-08-18 19:47:12","Nomina",2,7649);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2015-09-03 20:44:24","Ingreso a cuenta",2,2407);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2016-08-26 13:19:26","Nomina",3,7112);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2016-01-24 12:56:35","Nomina",1,9456);
insert into banking.transaction(account_id,datetime,description,type,amount) values (1,"2017-02-13 23:15:06","Devolución",3,1688);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2017-04-12 21:19:43","Devolución",2,7842);
insert into banking.transaction(account_id,datetime,description,type,amount) values (1,"2016-07-27 19:41:33","Recibo",2,-4693);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2015-04-06 20:06:32","Ingreso a cuenta",2,7576);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2016-02-08 18:58:40","Recibo",3,-8320);
insert into banking.transaction(account_id,datetime,description,type,amount) values (5,"2017-11-20 09:54:30","Ingreso a cuenta",1,9444);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2015-05-25 18:20:53","Recibo",2,-984);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2017-02-15 11:55:45","Recibo",3,-9459);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2016-06-26 02:58:45","Devolución",3,5518);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2016-04-15 21:28:02","Ingreso a cuenta",2,3402);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2017-01-25 17:09:25","Ingreso a cuenta",2,9043);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2015-01-03 18:42:34","Nomina",2,5730);
insert into banking.transaction(account_id,datetime,description,type,amount) values (1,"2015-08-02 10:08:51","Pago a cuenta",1,-6284);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2016-02-03 22:51:30","Devolución",1,8921);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2016-06-23 20:30:07","Recibo",2,-2045);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2017-12-16 00:00:13","Recibo",2,-3974);
insert into banking.transaction(account_id,datetime,description,type,amount) values (5,"2017-09-05 05:30:01","Recibo",2,-4844);
insert into banking.transaction(account_id,datetime,description,type,amount) values (5,"2017-06-18 12:20:18","Nomina",1,6577);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2016-07-03 21:19:56","Nomina",2,2498);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2016-12-07 18:49:02","Nomina",2,8648);
insert into banking.transaction(account_id,datetime,description,type,amount) values (5,"2015-09-22 06:02:44","Ingreso a cuenta",1,502);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2015-04-16 16:31:23","Recibo",3,-2655);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2016-03-02 00:11:20","Impuesto",3,-902);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2015-10-15 06:54:52","Nomina",2,7497);
insert into banking.transaction(account_id,datetime,description,type,amount) values (5,"2016-11-20 03:21:30","Recibo",1,-7736);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2016-05-04 19:55:51","Nomina",3,768);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2016-08-27 19:09:49","Ingreso a cuenta",2,8654);
insert into banking.transaction(account_id,datetime,description,type,amount) values (1,"2017-07-13 18:24:01","Nomina",2,4054);
insert into banking.transaction(account_id,datetime,description,type,amount) values (1,"2016-07-25 16:28:46","Impuesto",2,-8341);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2015-09-20 12:33:04","Recibo",1,-8899);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2015-10-23 17:14:06","Nomina",1,5050);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2015-08-05 13:59:57","Recibo",1,-9632);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2016-12-17 04:33:04","Recibo",3,-6172);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2017-09-05 10:04:01","Pago a cuenta",3,-9127);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2017-11-27 18:37:06","Ingreso a cuenta",2,6205);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2016-03-25 07:37:39","Pago a cuenta",3,-628);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2017-04-19 00:33:42","Recibo",1,-2116);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2016-11-14 01:16:53","Ingreso a cuenta",2,6972);
insert into banking.transaction(account_id,datetime,description,type,amount) values (5,"2015-04-04 01:24:27","Impuesto",2,-1596);
insert into banking.transaction(account_id,datetime,description,type,amount) values (1,"2015-07-19 15:14:02","Ingreso a cuenta",2,1927);
insert into banking.transaction(account_id,datetime,description,type,amount) values (5,"2016-12-05 19:54:46","Nomina",2,8489);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2016-09-02 14:11:38","Recibo",2,-6865);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2015-07-03 14:12:55","Recibo",2,-6667);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2016-08-27 04:16:01","Nomina",2,347);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2016-10-23 01:36:22","Devolución",2,8719);
insert into banking.transaction(account_id,datetime,description,type,amount) values (1,"2016-04-02 14:33:41","Recibo",2,-3113);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2016-05-21 06:20:45","Nomina",2,8343);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2017-12-16 03:10:52","Nomina",3,138);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2016-05-25 16:41:05","Nomina",3,6507);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2015-08-03 18:34:15","Recibo",2,-138);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2017-02-22 18:54:26","Recibo",3,-3549);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2016-05-20 23:42:25","Pago a cuenta",1,-4246);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2016-03-21 17:35:29","Nomina",2,2122);
insert into banking.transaction(account_id,datetime,description,type,amount) values (5,"2016-11-05 16:36:22","Nomina",3,6170);
insert into banking.transaction(account_id,datetime,description,type,amount) values (1,"2017-05-15 20:19:25","Recibo",3,-1081);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2015-02-11 05:16:36","Ingreso a cuenta",2,985);
insert into banking.transaction(account_id,datetime,description,type,amount) values (5,"2016-04-07 19:49:07","Pago a cuenta",1,-1717);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2017-03-20 04:25:05","Nomina",3,5852);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2017-01-11 19:43:42","Ingreso a cuenta",1,4256);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2016-02-05 14:56:56","Pago a cuenta",3,-7747);
insert into banking.transaction(account_id,datetime,description,type,amount) values (5,"2016-12-08 17:28:25","Pago a cuenta",2,-3360);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2017-08-19 14:12:51","Impuesto",2,-1985);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2016-07-23 21:04:29","Recibo",2,-2225);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2017-11-01 00:15:58","Pago a cuenta",1,-288);
insert into banking.transaction(account_id,datetime,description,type,amount) values (5,"2016-12-16 19:50:29","Nomina",3,4806);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2016-09-15 05:39:27","Recibo",3,-2336);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2016-06-06 16:43:26","Recibo",3,-6462);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2017-05-06 16:28:40","Ingreso a cuenta",2,8111);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2016-12-14 10:58:47","Recibo",1,-1776);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2016-12-14 02:16:17","Nomina",2,9170);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2015-04-20 18:23:13","Impuesto",2,-9173);
insert into banking.transaction(account_id,datetime,description,type,amount) values (4,"2015-09-17 11:01:41","Nomina",1,3806);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2015-06-25 13:26:28","Recibo",2,-1866);
insert into banking.transaction(account_id,datetime,description,type,amount) values (5,"2017-04-16 20:39:27","Recibo",2,-2172);
insert into banking.transaction(account_id,datetime,description,type,amount) values (2,"2016-04-05 02:42:30","Impuesto",3,-7074);
insert into banking.transaction(account_id,datetime,description,type,amount) values (3,"2016-06-08 20:53:01","Nomina",1,2975);
insert into banking.transaction(account_id,datetime,description,type,amount) values (5,"2016-03-03 02:53:15","Recibo",1,-6067);
insert into banking.transaction(account_id,datetime,description,type,amount) values (5,"2016-10-16 04:23:49","Nomina",3,990);
insert into banking.transaction(account_id,datetime,description,type,amount) values (1,"2017-02-21 09:28:22","Recibo",2,-1410);

COMMIT;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
