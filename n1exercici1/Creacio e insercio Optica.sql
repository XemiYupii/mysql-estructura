-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Cul_Ampolla
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Cul_Ampolla
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Cul_Ampolla` DEFAULT CHARACTER SET utf8 ;
USE `Cul_Ampolla` ;

-- -----------------------------------------------------
-- Table `Cul_Ampolla`.`Adreces_Proveidors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_Ampolla`.`Adreces_Proveidors` (
  `id_adreça` INT NOT NULL AUTO_INCREMENT,
  `carrer` VARCHAR(20) NOT NULL,
  `numero` INT UNSIGNED NOT NULL,
  `pis` VARCHAR(10) NULL DEFAULT NULL,
  `porta` INT UNSIGNED NULL DEFAULT NULL,
  `ciutat` VARCHAR(20) NOT NULL,
  `codi_postal` INT UNSIGNED NOT NULL,
  `pais` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_adreça`))
ENGINE = InnoDB;

INSERT INTO `Adreces_Proveidors` VALUES (1, "juliana", 76, NULL, NULL, "Madrid", 08383, "Espanya");
INSERT INTO `Adreces_Proveidors` VALUES (2, "via ferrer", 911, NULL, NULL, "Barcelona", 08014, "Catalunya");
INSERT INTO `Adreces_Proveidors` VALUES (3, "carrer Santana", 74, NULL, NULL, "Barcelona", 08014, "Catalunya");
INSERT INTO `Adreces_Proveidors` VALUES (4, "carrer Mallorca", 232, NULL, NULL, "Barcelona", 08034, "Catalunya");

-- -----------------------------------------------------
-- Table `Cul_Ampolla`.`Proveidors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_Ampolla`.`Proveidors` (
  `id_proveidor` INT NOT NULL AUTO_INCREMENT,
  `Adreces_Proveidors_id_adreça` INT NOT NULL,
  `nom` VARCHAR(40) NOT NULL,
  `telefon` INT UNSIGNED NOT NULL,
  `fax` INT UNSIGNED NOT NULL,
  `nif` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`id_proveidor`),
  UNIQUE INDEX `nif_UNIQUE` (`nif` ASC) VISIBLE,
  INDEX `fk_Proveidors_Adreces_Proveidors1_idx` (`Adreces_Proveidors_id_adreça` ASC) VISIBLE,
  CONSTRAINT `fk_Proveidors_Adreces_Proveidors1`
    FOREIGN KEY (`Adreces_Proveidors_id_adreça`)
    REFERENCES `Cul_Ampolla`.`Adreces_Proveidors` (`id_adreça`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `Proveidors` VALUES (1,1,'mimi SL',934859374,938475022,'48561940R'),
								(2,2,'company SL',938405729,937495820,'48596728S'),
								(3,3,'santana SL',938495868,948596839,'37490228F'),
								(4,4,'panda SL',937495820,748506829,'48599440H');

-- -----------------------------------------------------
-- Table `Cul_Ampolla`.`Marques`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_Ampolla`.`Marques` (
  `id_marca` INT NOT NULL AUTO_INCREMENT,
  `Proveidors_id_proveidor` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_marca`),
  INDEX `fk_Marques_Proveidors1_idx` (`Proveidors_id_proveidor` ASC) VISIBLE,
  CONSTRAINT `fk_Marques_Proveidors1`
    FOREIGN KEY (`Proveidors_id_proveidor`)
    REFERENCES `Cul_Ampolla`.`Proveidors` (`id_proveidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `Marques` VALUES (1,1,'Nike'),
								(2,1,'Rayband'),
								(3,2,'Tous'),
								(4,3,'Zara'),
								(5,3,'Christian Dior'),
								(6,4,'MK'),
								(7,4,'Channel');

-- -----------------------------------------------------
-- Table `Cul_Ampolla`.`Ulleres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_Ampolla`.`Ulleres` (
  `id_ullera` INT NOT NULL AUTO_INCREMENT,
  `Marques_id_marca` INT NOT NULL,
  `marca` VARCHAR(20) NOT NULL,
  `graduacio_vidre_dret` FLOAT(10) NOT NULL,
  `graduacio_vidre_esquerre` FLOAT(10) NOT NULL,
  `tipus_montura` ENUM("flotant", "pasta", "metal·lica") NOT NULL,
  `color_montura` VARCHAR(20) NOT NULL,
  `color_vidre_dret` VARCHAR(20) NOT NULL,
  `color_vidre_esquerre` VARCHAR(20) NOT NULL,
  `preu` FLOAT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id_ullera`),
  INDEX `fk_Ulleres_Marques1_idx` (`Marques_id_marca` ASC) VISIBLE,
  CONSTRAINT `fk_Ulleres_Marques1`
    FOREIGN KEY (`Marques_id_marca`)
    REFERENCES `Cul_Ampolla`.`Marques` (`id_marca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `Ulleres` VALUES (1,1,'Nike',1.23,2.34,'flotant','groc','vermell','blau',76.35),
							(2,2,'Rayband',1.74,3,'flotant','rosa','lila','lila',85.99),
							(3,3,'Tous',0,3.12,'pasta','verd','lila','rosa',120.5),
							(4,4,'Zara',2.5,0,'metal·lica','marro','blanc','blanc',23.99),
							(5,5,'Christian Dior',1.25,2,'metal·lica','blanc','lila','rosa',170.5),
							(6,6,'MK',2.5,4,'pasta','vermell','blau','blau',130.5),
							(7,7,'Channel',1.75,2.5,'pasta','tronja','groc','blau',199.99);

-- -----------------------------------------------------
-- Table `Cul_Ampolla`.`Adreces_Clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_Ampolla`.`Adreces_Clients` (
  `id_adreça` INT NOT NULL AUTO_INCREMENT,
  `carrer` VARCHAR(20) NOT NULL,
  `numero` INT UNSIGNED NOT NULL,
  `pis` VARCHAR(10) NULL DEFAULT NULL,
  `porta` INT UNSIGNED NULL DEFAULT NULL,
  `ciutat` VARCHAR(20) NOT NULL,
  `codi_postal` INT UNSIGNED NOT NULL,
  `pais` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_adreça`))
ENGINE = InnoDB;

INSERT INTO `Adreces_Clients` VALUES (1,'carrer hola',244,'1',2,'Barcelona',8014,'Catalunya'),
									(2,'carrer adeu',45,NULL,NULL,'Barcelona',8054,'Catalunya'),
									(3,'carrer miranda',96,NULL,NULL,'Sabadell',8324,'Catalunya'),
									(4,'carrer catala',43,NULL,NULL,'Tortosa',2124,'Catalunya');

-- -----------------------------------------------------
-- Table `Cul_Ampolla`.`Clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_Ampolla`.`Clients` (
  `id_client` INT NOT NULL AUTO_INCREMENT,
  `Adreces_Clients_id_adreça` INT NOT NULL,
  `Clients_id_client` INT NULL,
  `nom` VARCHAR(40) NOT NULL,
  `telefon` INT UNSIGNED NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `data_registre` DATE NOT NULL,
  PRIMARY KEY (`id_client`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_Clients_Adreces_Clients1_idx` (`Adreces_Clients_id_adreça` ASC) VISIBLE,
  INDEX `fk_Clients_Clients1_idx` (`Clients_id_client` ASC) VISIBLE,
  CONSTRAINT `fk_Clients_Adreces_Clients1`
    FOREIGN KEY (`Adreces_Clients_id_adreça`)
    REFERENCES `Cul_Ampolla`.`Adreces_Clients` (`id_adreça`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Clients_Clients1`
    FOREIGN KEY (`Clients_id_client`)
    REFERENCES `Cul_Ampolla`.`Clients` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `Clients` VALUES (1,1,NULL,'Gemma',649572947,'hola@gmail.com','2023-06-14'),
							(7,2,1,'Toni',649572200,'adeu@gmail.com','2023-11-30'),
							(8,3,1,'Jordi',649588592,'barça@gmail.com','2023-02-16'),
							(9,4,7,'Julia',649576811,'poni@gmail.com','2023-07-23');

-- -----------------------------------------------------
-- Table `Cul_Ampolla`.`Empleats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_Ampolla`.`Empleats` (
  `id_empleat` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`id_empleat`))
ENGINE = InnoDB;

INSERT INTO `Empleats` VALUES (1,'Maria'),
							(2,'Dani'),
							(3,'Paco'),
							(4,'Cristina');

-- -----------------------------------------------------
-- Table `Cul_Ampolla`.`Factures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_Ampolla`.`Factures` (
  `id_factura` INT NOT NULL AUTO_INCREMENT,
  `Clients_id_client` INT NOT NULL,
  `Empleats_id_empleat` INT NOT NULL,
  `data_venda` DATE NOT NULL,
  PRIMARY KEY (`id_factura`),
  INDEX `fk_Factures_Clients1_idx` (`Clients_id_client` ASC) VISIBLE,
  INDEX `fk_Factures_Empleats1_idx` (`Empleats_id_empleat` ASC) VISIBLE,
  CONSTRAINT `fk_Factures_Clients1`
    FOREIGN KEY (`Clients_id_client`)
    REFERENCES `Cul_Ampolla`.`Clients` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Factures_Empleats1`
    FOREIGN KEY (`Empleats_id_empleat`)
    REFERENCES `Cul_Ampolla`.`Empleats` (`id_empleat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `Factures` VALUES (1,1,2,'2023-07-15'),
							(2,1,3,'2023-08-01'),
							(3,1,3,'2023-12-01'),
							(4,7,2,'2023-12-23'),
							(5,8,4,'2023-09-03'),
							(6,8,1,'2023-09-30'),
							(7,9,4,'2023-09-29'),
							(8,9,1,'2023-12-09');

-- -----------------------------------------------------
-- Table `Cul_Ampolla`.`Ulleres_has_Factures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_Ampolla`.`Ulleres_has_Factures` (
  `Ulleres_id_ullera` INT NOT NULL,
  `Factures_id_factura` INT NOT NULL,
  `preu_total` FLOAT(10) UNSIGNED NOT NULL,
  `quantitat` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Ulleres_id_ullera`, `Factures_id_factura`),
  INDEX `fk_Ulleres_has_Factures_Factures1_idx` (`Factures_id_factura` ASC) VISIBLE,
  INDEX `fk_Ulleres_has_Factures_Ulleres1_idx` (`Ulleres_id_ullera` ASC) VISIBLE,
  CONSTRAINT `fk_Ulleres_has_Factures_Ulleres1`
    FOREIGN KEY (`Ulleres_id_ullera`)
    REFERENCES `Cul_Ampolla`.`Ulleres` (`id_ullera`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ulleres_has_Factures_Factures1`
    FOREIGN KEY (`Factures_id_factura`)
    REFERENCES `Cul_Ampolla`.`Factures` (`id_factura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `Ulleres_has_Factures` VALUES (1,1,90,1),
										(2,7,101.75,1),
										(3,3,149.99,1),
										(4,8,50.99,1),
										(5,5,205,1),
										(6,4,159.99,1),
										(7,2,230.5,1),
										(7,6,265.5,1);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;