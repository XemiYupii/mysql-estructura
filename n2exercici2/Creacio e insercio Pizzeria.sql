-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `Pizzeria` ;

-- -----------------------------------------------------
-- Table `Pizzeria`.`Provincies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Provincies` (
  `id_provincia` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_provincia`))
ENGINE = InnoDB;

INSERT INTO `Provincies` VALUES (1,'Barcelona'),
								(2,'Granada'),
								(3,'Navarra'),
								(4,'Cuenca'),
								(5,'Almeria');


-- -----------------------------------------------------
-- Table `Pizzeria`.`Localitats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Localitats` (
  `id_localitat` INT NOT NULL AUTO_INCREMENT,
  `Provincies_id_provincia` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_localitat`),
  INDEX `fk_Localitats_Provincies_idx` (`Provincies_id_provincia` ASC) VISIBLE,
  CONSTRAINT `fk_Localitats_Provincies`
    FOREIGN KEY (`Provincies_id_provincia`)
    REFERENCES `Pizzeria`.`Provincies` (`id_provincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `Localitats` VALUES (1,1,'Calella'),
								(2,2,'Nivar'),
								(3,3,'Caparroso'),
								(4,4,'Huete'),
								(5,5,'Tijola');


-- -----------------------------------------------------
-- Table `Pizzeria`.`Clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Clients` (
  `id_client` INT NOT NULL AUTO_INCREMENT,
  `Localitats_id_localitat` INT NOT NULL,
  `nom` VARCHAR(30) NOT NULL,
  `cognoms` VARCHAR(100) NOT NULL,
  `adreça` VARCHAR(500) NOT NULL,
  `telefon` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_client`),
  UNIQUE INDEX `telefon_UNIQUE` (`telefon` ASC) VISIBLE,
  INDEX `fk_Clients_Localitats1_idx` (`Localitats_id_localitat` ASC) VISIBLE,
  CONSTRAINT `fk_Clients_Localitats1`
    FOREIGN KEY (`Localitats_id_localitat`)
    REFERENCES `Pizzeria`.`Localitats` (`id_localitat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `Clients` VALUES (1,1,'Gemma','Zamora','sants',6495867),
							(2,1,'Toni','Torrent','india',67305839),
							(3,1,'Jordi','Torrent','poni',67294750),
							(4,3,'Julia','Torrent','ceuta',638501003),
							(5,4,'Xavi','Sosa','via julia',638596837);


-- -----------------------------------------------------
-- Table `Pizzeria`.`Botigues`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Botigues` (
  `id_botiga` INT NOT NULL AUTO_INCREMENT,
  `Localitats_id_localitat` INT NOT NULL,
  `adreça` VARCHAR(500) NOT NULL,
  `codi_postal` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_botiga`),
  INDEX `fk_Botigues_Localitats1_idx` (`Localitats_id_localitat` ASC) VISIBLE,
  CONSTRAINT `fk_Botigues_Localitats1`
    FOREIGN KEY (`Localitats_id_localitat`)
    REFERENCES `Pizzeria`.`Localitats` (`id_localitat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `Botigues` VALUES (1,1,'mirador',8395),
							(2,3,'santana',3847),
							(3,4,'carrer casp',8374);


-- -----------------------------------------------------
-- Table `Pizzeria`.`Comandes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Comandes` (
  `id_comanda` INT NOT NULL AUTO_INCREMENT,
  `Clients_id_client` INT NOT NULL,
  `Botigues_id_botiga` INT NOT NULL,
  `data_hora` TIMESTAMP NOT NULL DEFAULT NOW(),
  `tipus` ENUM("botiga", "domicili") NOT NULL,
  `preu_total` FLOAT(6) NOT NULL,
  PRIMARY KEY (`id_comanda`),
  INDEX `fk_Comandes_Clients1_idx` (`Clients_id_client` ASC) VISIBLE,
  INDEX `fk_Comandes_Botigues1_idx` (`Botigues_id_botiga` ASC) VISIBLE,
  CONSTRAINT `fk_Comandes_Clients1`
    FOREIGN KEY (`Clients_id_client`)
    REFERENCES `Pizzeria`.`Clients` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comandes_Botigues1`
    FOREIGN KEY (`Botigues_id_botiga`)
    REFERENCES `Pizzeria`.`Botigues` (`id_botiga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `Comandes` VALUES (1,1,1,'2023-06-14 20:16:35','domicili',25.99),
(2,2,1,'2023-01-05 13:34:00','botiga',43.65),
(3,5,3,'2022-07-25 19:46:00','domicili',45.5);


-- -----------------------------------------------------
-- Table `Pizzeria`.`Empleats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Empleats` (
  `id_empleat` INT NOT NULL AUTO_INCREMENT,
  `Botigues_id_botiga` INT NOT NULL,
  `nom` VARCHAR(30) NOT NULL,
  `cognoms` VARCHAR(100) NOT NULL,
  `nif` VARCHAR(9) NOT NULL,
  `telefon` INT UNSIGNED NOT NULL,
  `rol` ENUM("cuiner", "repartidor") NOT NULL,
  PRIMARY KEY (`id_empleat`),
  UNIQUE INDEX `nif_UNIQUE` (`nif` ASC) VISIBLE,
  INDEX `fk_Empleats_Botigues1_idx` (`Botigues_id_botiga` ASC) VISIBLE,
  CONSTRAINT `fk_Empleats_Botigues1`
    FOREIGN KEY (`Botigues_id_botiga`)
    REFERENCES `Pizzeria`.`Botigues` (`id_botiga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `Empleats` VALUES (1,1,'Santi','Garcia','64920470R',639571094,'cuiner'),
(2,1,'Maria','Perez','48205884T',620044882,'repartidor'),
(3,2,'Sandra','Gomez','83749173G',639947591,'repartidor');


-- -----------------------------------------------------
-- Table `Pizzeria`.`Entrega_domicilis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Entrega_domicilis` (
  `id_domicilis` INT NOT NULL AUTO_INCREMENT,
  `Empleats_id_empleat` INT NOT NULL,
  `Comandes_id_comanda` INT NOT NULL,
  `data_hora_entrega` TIMESTAMP NOT NULL DEFAULT NOW(),
  PRIMARY KEY (`id_domicilis`),
  INDEX `fk_Domicilis_Empleats1_idx` (`Empleats_id_empleat` ASC) VISIBLE,
  INDEX `fk_Entrega_domicilis_Comandes1_idx` (`Comandes_id_comanda` ASC) VISIBLE,
  CONSTRAINT `fk_Domicilis_Empleats1`
    FOREIGN KEY (`Empleats_id_empleat`)
    REFERENCES `Pizzeria`.`Empleats` (`id_empleat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Entrega_domicilis_Comandes1`
    FOREIGN KEY (`Comandes_id_comanda`)
    REFERENCES `Pizzeria`.`Comandes` (`id_comanda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `Entrega_domicilis` VALUES (1,2,1,'2023-06-14 21:58:10');


-- -----------------------------------------------------
-- Table `Pizzeria`.`Categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Categories` (
  `id_categoria` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_categoria`))
ENGINE = InnoDB;

INSERT INTO `Categories` VALUES (1,'Begudes'),
								(2,'Hamburgueses'),
								(3,'Pizzes');



-- -----------------------------------------------------
-- Table `Pizzeria`.`Productes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Productes` (
  `id_producte` INT NOT NULL AUTO_INCREMENT,
  `Categories_id_categoria` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `descripcio` VARCHAR(500) NOT NULL,
  `imatge` VARCHAR(100) NOT NULL,
  `preu` FLOAT(6) UNSIGNED NOT NULL,
  PRIMARY KEY (`id_producte`),
  INDEX `fk_Productes_Categories1_idx` (`Categories_id_categoria` ASC) VISIBLE,
  CONSTRAINT `fk_Productes_Categories1`
    FOREIGN KEY (`Categories_id_categoria`)
    REFERENCES `Pizzeria`.`Categories` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `Productes` VALUES (1,1,'CocaCola','refresc','http://....',1.25),
								(2,1,'Fanta','refresc','http://....',1.25),
								(3,1,'Nestea','refresc','http://....',1.25),
								(4,1,'Aigua','refresc','http://....',0.75),
								(5,2,'Burguer Queso','Hamburguesa de ...','http://....',5.75),
								(6,2,'Burguer Bacon','Hamburguesa de ...','http://....',5.75),
								(7,2,'Burguer Triple Bacon','Hamburguesa de ...','http://....',7.75),
								(8,2,'Burguer Queso/Bacon','Hamburguesa de ...','http://....',8.75),
								(9,3,'Napolitana','Pizza de ...','http://....',10.75),
								(10,3,'4 Quesos','Pizza de ...','http://....',11.75),
								(11,3,'Margarita','Pizza de ...','http://....',9.75),
								(12,3,'Calzone','Pizza de ...','http://....',14.99);


-- -----------------------------------------------------
-- Table `Pizzeria`.`Productes_has_Comandes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Productes_has_Comandes` (
  `Productes_id_producte` INT NOT NULL,
  `Comandes_id_comanda` INT NOT NULL,
  `quantitat_productes` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Productes_id_producte`, `Comandes_id_comanda`),
  INDEX `fk_Productes_has_Comandes_Comandes1_idx` (`Comandes_id_comanda` ASC) VISIBLE,
  INDEX `fk_Productes_has_Comandes_Productes1_idx` (`Productes_id_producte` ASC) VISIBLE,
  CONSTRAINT `fk_Productes_has_Comandes_Productes1`
    FOREIGN KEY (`Productes_id_producte`)
    REFERENCES `Pizzeria`.`Productes` (`id_producte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Productes_has_Comandes_Comandes1`
    FOREIGN KEY (`Comandes_id_comanda`)
    REFERENCES `Pizzeria`.`Comandes` (`id_comanda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `Productes_has_comandes` VALUES (1,1,2),
											(3,2,2),
											(4,2,1),
											(4,3,2),
											(5,2,1),
											(7,1,1),
											(8,2,1),
											(11,2,2),
											(12,1,1);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
