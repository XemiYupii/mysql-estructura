-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Spotify
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Spotify
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Spotify` DEFAULT CHARACTER SET utf8 ;
USE `Spotify` ;

-- -----------------------------------------------------
-- Table `Spotify`.`Usuaris`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Usuaris` (
  `usuari_id` INT NOT NULL AUTO_INCREMENT,
  `tipus` ENUM('free', 'premium') NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `nom_usuari` VARCHAR(100) NOT NULL,
  `data_naixement` DATE NOT NULL,
  `sexe` ENUM('H', 'D') NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `codi_postal` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`usuari_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `nom_usuari_UNIQUE` (`nom_usuari` ASC) VISIBLE)
ENGINE = InnoDB;

INSERT INTO Usuaris VALUES (1,'premium','gemma86@gmail.com','gemma140686','Xemi_Yupii','1986-06-14','D','Catalunya',08014),
						   (2,'free','toni74@gmail.com','jassik27','tonikvicius','1974-07-26','H','Catalunya',08014),
                           (3,'premium','jordi2016@gmail.com','forçabarça','jordi_barça','2016-02-12','H','Catalunya',08014);

-- -----------------------------------------------------
-- Table `Spotify`.`Comptes_PayPal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Comptes_PayPal` (
  `compte_id` INT NOT NULL AUTO_INCREMENT,
  `nom_usuari` VARCHAR(45) NOT NULL,
  `Usuaris_usuari_id` INT NOT NULL,
  PRIMARY KEY (`compte_id`),
  UNIQUE INDEX `nom_usuari_UNIQUE` (`nom_usuari` ASC) VISIBLE,
  INDEX `fk_Comptes_PayPal_Usuaris1_idx` (`Usuaris_usuari_id` ASC) VISIBLE,
  CONSTRAINT `fk_Comptes_PayPal_Usuaris1`
    FOREIGN KEY (`Usuaris_usuari_id`)
    REFERENCES `Spotify`.`Usuaris` (`usuari_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO Comptes_Paypal VALUES (1,'Xemi_Yupii',1);

-- -----------------------------------------------------
-- Table `Spotify`.`Targetes_Credit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Targetes_Credit` (
  `tarja_id` INT NOT NULL AUTO_INCREMENT,
  `numero` INT UNSIGNED NOT NULL,
  `caducitat(MM/YY)` VARCHAR(5) NOT NULL,
  `CVV o CVC` SMALLINT(4) UNSIGNED NOT NULL,
  `Usuaris_usuari_id` INT NOT NULL,
  PRIMARY KEY (`tarja_id`),
  INDEX `fk_Targetes_Credit_Usuaris1_idx` (`Usuaris_usuari_id` ASC) VISIBLE,
  CONSTRAINT `fk_Targetes_Credit_Usuaris1`
    FOREIGN KEY (`Usuaris_usuari_id`)
    REFERENCES `Spotify`.`Usuaris` (`usuari_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO Targetes_Credit VALUES (1,123456789,'06/24',123,1),
								   (2,987654321,'07/27',321,3);

-- -----------------------------------------------------
-- Table `Spotify`.`Subscripcions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Subscripcions` (
  `subscripcio_id` INT NOT NULL AUTO_INCREMENT,
  `inici` DATE NOT NULL,
  `renovacio` DATE NULL,
  `Usuaris_usuari_id` INT NOT NULL,
  `metode_pagament` ENUM('credit', 'PayPal') NOT NULL,
  `Comptes_PayPal_compte_id` INT NULL,
  `Targetes_Credit_tarja_id` INT NULL,
  PRIMARY KEY (`subscripcio_id`),
  INDEX `fk_Subscripcions_Usuaris_idx` (`Usuaris_usuari_id` ASC) VISIBLE,
  INDEX `fk_Subscripcions_Comptes_PayPal1_idx` (`Comptes_PayPal_compte_id` ASC) VISIBLE,
  INDEX `fk_Subscripcions_Targetes_Credit1_idx` (`Targetes_Credit_tarja_id` ASC) VISIBLE,
  CONSTRAINT `fk_Subscripcions_Usuaris`
    FOREIGN KEY (`Usuaris_usuari_id`)
    REFERENCES `Spotify`.`Usuaris` (`usuari_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Subscripcions_Comptes_PayPal1`
    FOREIGN KEY (`Comptes_PayPal_compte_id`)
    REFERENCES `Spotify`.`Comptes_PayPal` (`compte_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Subscripcions_Targetes_Credit1`
    FOREIGN KEY (`Targetes_Credit_tarja_id`)
    REFERENCES `Spotify`.`Targetes_Credit` (`tarja_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO Subscripcions VALUES (1,'2022-05-14','2022-06-14',1,'PayPal',1,null),
								 (2,'2023-01-27','2023-02-27',3,'credit',null,2);

-- -----------------------------------------------------
-- Table `Spotify`.`Pagaments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Pagaments` (
  `Subscripcions_subscripcio_id` INT NOT NULL,
  `Usuaris_usuari_id` INT NOT NULL,
  `data` DATE NOT NULL,
  `preu_total` DOUBLE NOT NULL,
  `numero_ordre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Subscripcions_subscripcio_id`, `Usuaris_usuari_id`),
  INDEX `fk_Subscripcions_has_Usuaris_Usuaris1_idx` (`Usuaris_usuari_id` ASC) VISIBLE,
  INDEX `fk_Subscripcions_has_Usuaris_Subscripcions1_idx` (`Subscripcions_subscripcio_id` ASC) VISIBLE,
  UNIQUE INDEX `numero_ordre_UNIQUE` (`numero_ordre` ASC) VISIBLE,
  CONSTRAINT `fk_Subscripcions_has_Usuaris_Subscripcions1`
    FOREIGN KEY (`Subscripcions_subscripcio_id`)
    REFERENCES `Spotify`.`Subscripcions` (`subscripcio_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Subscripcions_has_Usuaris_Usuaris1`
    FOREIGN KEY (`Usuaris_usuari_id`)
    REFERENCES `Spotify`.`Usuaris` (`usuari_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO Pagaments VALUES (1,1,'2022-05-14',9.99,'abc1'),
							 (2,'2023-01-27',9.99,'abc2',3);

-- -----------------------------------------------------
-- Table `Spotify`.`Playlists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Playlists` (
  `playlists_id` INT NOT NULL AUTO_INCREMENT,
  `titol` VARCHAR(45) NOT NULL,
  `numero_cançons` INT UNSIGNED NOT NULL,
  `data_creacio` DATE NOT NULL,
  `tipus` ENUM('activa', 'eliminada') NOT NULL,
  `data_eliminacio` DATE NULL,
  `Usuaris_usuari_id` INT NOT NULL,
  PRIMARY KEY (`playlists_id`),
  INDEX `fk_Playlists_Usuaris1_idx` (`Usuaris_usuari_id` ASC) VISIBLE,
  CONSTRAINT `fk_Playlists_Usuaris1`
    FOREIGN KEY (`Usuaris_usuari_id`)
    REFERENCES `Spotify`.`Usuaris` (`usuari_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO Playlists VALUES (1,'favoritas',68,'2023-01-27','activa',null,1),
							 (2,'top',102,'2023-02-14','activa',null,2);

-- -----------------------------------------------------
-- Table `Spotify`.`Artistes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Artistes` (
  `artista_id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `imatge` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`artista_id`))
ENGINE = InnoDB;

INSERT INTO Artistes VALUES (1,'Spice Girls','iamge.jpg'),
							(2,'Pet Shop Boys','image.jpg'),
                            (3,'The Strokes','image.jpg'),
                            (4,'La casa azul','image.jpg'),
                            (5,'Alejandro Sanz','image.jpg'),
                            (6,'Britney Spears','image.jpg'),
                            (7,'Depeche Mode','image.jpg'),
                            (8,'Franz Ferdinand','image.jpg'),
                            (9,'Papa Topo','image.jpg'),
                            (10,'Jarabe de Palo','image.jpg');

-- -----------------------------------------------------
-- Table `Spotify`.`Albums`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Albums` (
  `album_id` INT NOT NULL AUTO_INCREMENT,
  `titol` VARCHAR(45) NOT NULL,
  `any_publicacio` YEAR NOT NULL,
  `imatge_portada` VARCHAR(200) NOT NULL,
  `Artistes_artista_id` INT NOT NULL,
  PRIMARY KEY (`album_id`),
  INDEX `fk_Albums_Artistes1_idx` (`Artistes_artista_id` ASC) VISIBLE,
  CONSTRAINT `fk_Albums_Artistes1`
    FOREIGN KEY (`Artistes_artista_id`)
    REFERENCES `Spotify`.`Artistes` (`artista_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO Albums VALUES (1,'Spice',1996,'image.jpg',1),
						  (2,'Spiceworld',1997,'image.jpg',1),
                          (3,'Monkey Business',2020,'image.jpg',2),
                          (4,'Room on fire',2003,'image.jpg',3),
                          (5,'La gran esfera',2019,'image.jpg',4),
                          (6,'Paraiso express',2009,'image.jpg',5);

-- -----------------------------------------------------
-- Table `Spotify`.`Cançons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Cançons` (
  `cançons_id` INT NOT NULL AUTO_INCREMENT,
  `titol` VARCHAR(45) NOT NULL,
  `durada` TIME NOT NULL,
  `reproduccions` INT UNSIGNED NOT NULL,
  `Albums_album_id` INT NOT NULL,
  PRIMARY KEY (`cançons_id`),
  INDEX `fk_Cançons_Albums1_idx` (`Albums_album_id` ASC) VISIBLE,
  CONSTRAINT `fk_Cançons_Albums1`
    FOREIGN KEY (`Albums_album_id`)
    REFERENCES `Spotify`.`Albums` (`album_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO Cançons VALUES(1,'Wannabe','00:02:53',11,1),
						  (2,'Stop','00:03:24',37,2),
                          (3,'West end girls','00:04:45',100000,3),
                          (4,'Last nite','00:03:13',384847,4),
                          (5,'La revolucion sexual','00:04:34',337558,5),
                          (6,'La tortura','00:03:33',84733848,6);

-- -----------------------------------------------------
-- Table `Spotify`.`Afegir_Cançons_Playlists_Actives`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Afegir_Cançons_Playlists_Actives` (
  `Usuaris_usuari_id` INT NOT NULL,
  `Playlists_playlists_id` INT NOT NULL,
  `data` DATE NOT NULL,
  `Cançons_cançons_id` INT NOT NULL,
  INDEX `fk_Usuaris_has_Playlists_Playlists1_idx` (`Playlists_playlists_id` ASC) VISIBLE,
  INDEX `fk_Usuaris_has_Playlists_Usuaris1_idx` (`Usuaris_usuari_id` ASC) VISIBLE,
  INDEX `fk_Afegir_Cançons_Playlists_Actives_Cançons1_idx` (`Cançons_cançons_id` ASC) VISIBLE,
  UNIQUE INDEX `Cançons_cançons_id_UNIQUE` (`Cançons_cançons_id` ASC) VISIBLE,
  CONSTRAINT `fk_Usuaris_has_Playlists_Usuaris1`
    FOREIGN KEY (`Usuaris_usuari_id`)
    REFERENCES `Spotify`.`Usuaris` (`usuari_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuaris_has_Playlists_Playlists1`
    FOREIGN KEY (`Playlists_playlists_id`)
    REFERENCES `Spotify`.`Playlists` (`playlists_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Afegir_Cançons_Playlists_Actives_Cançons1`
    FOREIGN KEY (`Cançons_cançons_id`)
    REFERENCES `Spotify`.`Cançons` (`cançons_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO Afegir_Cançons_Playlists_Actives VALUES(1,1,'2023-01-03',1),
												   (1,1,'2023-01-03',2),
												   (1,1,'2023-01-03',4),
                                                   (1,1,'2023-01-03',5),
                                                   (2,2,'2023-01-24',3),
                                                   (1,1,'2023-01-08',6);

-- -----------------------------------------------------
-- Table `Spotify`.`Artistes_Artistes_Relacionats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Artistes_Artistes_Relacionats` (
  `Artistes_artista_id` INT NOT NULL,
  `Artistes_artista_id1` INT NOT NULL,
  PRIMARY KEY (`Artistes_artista_id`, `Artistes_artista_id1`),
  INDEX `fk_Artistes_has_Artistes_Artistes2_idx` (`Artistes_artista_id1` ASC) VISIBLE,
  INDEX `fk_Artistes_has_Artistes_Artistes1_idx` (`Artistes_artista_id` ASC) VISIBLE,
  CONSTRAINT `fk_Artistes_has_Artistes_Artistes1`
    FOREIGN KEY (`Artistes_artista_id`)
    REFERENCES `Spotify`.`Artistes` (`artista_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Artistes_has_Artistes_Artistes2`
    FOREIGN KEY (`Artistes_artista_id1`)
    REFERENCES `Spotify`.`Artistes` (`artista_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO Artistes_Artistes_Relacionats VALUES (1,6),
												 (2,7),
                                                 (3,8),
                                                 (4,9),
                                                 (5,10);

-- -----------------------------------------------------
-- Table `Spotify`.`Preferits`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Preferits` (
  `Usuaris_usuari_id` INT NOT NULL,
  `Artistes_artista_id` INT NOT NULL,
  `Albums_album_id` INT NOT NULL,
  `Cançons_cançons_id` INT NOT NULL,
  INDEX `fk_Preferits_Usuaris1_idx` (`Usuaris_usuari_id` ASC) VISIBLE,
  INDEX `fk_Preferits_Artistes1_idx` (`Artistes_artista_id` ASC) VISIBLE,
  INDEX `fk_Preferits_Albums1_idx` (`Albums_album_id` ASC) VISIBLE,
  INDEX `fk_Preferits_Cançons1_idx` (`Cançons_cançons_id` ASC) VISIBLE,
  CONSTRAINT `fk_Preferits_Usuaris1`
    FOREIGN KEY (`Usuaris_usuari_id`)
    REFERENCES `Spotify`.`Usuaris` (`usuari_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Preferits_Artistes1`
    FOREIGN KEY (`Artistes_artista_id`)
    REFERENCES `Spotify`.`Artistes` (`artista_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Preferits_Albums1`
    FOREIGN KEY (`Albums_album_id`)
    REFERENCES `Spotify`.`Albums` (`album_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Preferits_Cançons1`
    FOREIGN KEY (`Cançons_cançons_id`)
    REFERENCES `Spotify`.`Cançons` (`cançons_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO Preferits VALUES (1,1,2,6),
							 (1,8,3,4),
							 (2,3,1,5),
                             (2,9,4,1);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
