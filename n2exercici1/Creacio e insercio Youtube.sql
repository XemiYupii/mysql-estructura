-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Youtube
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Youtube
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Youtube` DEFAULT CHARACTER SET utf8 ;
USE `Youtube` ;

-- -----------------------------------------------------
-- Table `Youtube`.`Usuaris`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`Usuaris` (
  `usuari_id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `nom_usuari` VARCHAR(45) NOT NULL,
  `data_naixement` DATE NOT NULL,
  `sexe` ENUM('H', 'D') NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `codi_postal` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`usuari_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `nom_usuari_UNIQUE` (`nom_usuari` ASC) VISIBLE)
ENGINE = InnoDB;

INSERT INTO Usuaris VALUES (1,'gemma@gmail.com','gemma86','xemi_yupii','1986-06-14','D','Catalunya',08014),
			   (2,'toni@gmail.com','toni27','jassik','1974-07-26','H','Catalunya',08014),
			   (3,'jordi@gmail.com','barça','jordi_mario','2016-02-12','H','Catalunya',08014),
			   (4,'julia@gmail.com','ponis','juju','2019-07-26','D','Catalunya',08014);

-- -----------------------------------------------------
-- Table `Youtube`.`Videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`Videos` (
  `video_id` INT NOT NULL AUTO_INCREMENT,
  `titol` VARCHAR(45) NOT NULL,
  `descripcio` VARCHAR(500) NOT NULL,
  `grandaria` INT UNSIGNED NOT NULL,
  `nom_arxiu` VARCHAR(45) NOT NULL,
  `durada` TIME NOT NULL,
  `thumbnail` VARCHAR(200) NOT NULL,
  `reproduccions` INT UNSIGNED NOT NULL,
  `likes` INT UNSIGNED NOT NULL,
  `dislikes` INT UNSIGNED NOT NULL,
  `estat` ENUM('public', 'ocult', 'privat') NOT NULL,
  `data_hora` TIMESTAMP NOT NULL,
  `Usuaris_usuari_id` INT NOT NULL,
  PRIMARY KEY (`video_id`),
  INDEX `fk_Videos_Usuaris_idx` (`Usuaris_usuari_id` ASC) VISIBLE,
  CONSTRAINT `fk_Videos_Usuaris`
    FOREIGN KEY (`Usuaris_usuari_id`)
    REFERENCES `Youtube`.`Usuaris` (`usuari_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO Videos VALUES (1,'Viatge a Menorca','text',100,'menorca.mpg','00:31:15','text',24,16,1,'privat','2022-08-23 15:00:00',1),
			  (2,'Partit Basquet Barça','text',200,'barça_madrid.mpg','01:12:35','text',105,80,21,'public','2023-01-19 18:48:02',2);

-- -----------------------------------------------------
-- Table `Youtube`.`Etiquetes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`Etiquetes` (
  `etiqueta_id` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`etiqueta_id`))
ENGINE = InnoDB;

INSERT INTO Etiquetes VALUES (1,'viatges'),
			     (2,'menorca'),
			     (3,'familia'),
                             (4,'basquet'),
                             (5,'barça'),
                             (6,'win');

-- -----------------------------------------------------
-- Table `Youtube`.`Videos_has_Etiquetes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`Videos_has_Etiquetes` (
  `Etiquetes_etiqueta_id` INT NOT NULL,
  `Videos_video_id` INT NOT NULL,
  PRIMARY KEY (`Etiquetes_etiqueta_id`, `Videos_video_id`),
  INDEX `fk_Videos_has_Etiquetes_Etiquetes1_idx` (`Etiquetes_etiqueta_id` ASC) VISIBLE,
  INDEX `fk_Videos_has_Etiquetes_Videos1_idx` (`Videos_video_id` ASC) VISIBLE,
  CONSTRAINT `fk_Videos_has_Etiquetes_Videos1`
    FOREIGN KEY (`Videos_video_id`)
    REFERENCES `Youtube`.`Videos` (`video_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Videos_has_Etiquetes_Etiquetes1`
    FOREIGN KEY (`Etiquetes_etiqueta_id`)
    REFERENCES `Youtube`.`Etiquetes` (`etiqueta_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO Videos_has_Etiquetes VALUES (1,1),
					(2,1),
                                        (3,1),
                                        (4,2),
                                        (5,2),
                                        (6,2);

-- -----------------------------------------------------
-- Table `Youtube`.`Canals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`Canals` (
  `canal_id` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `descripcio` VARCHAR(200) NOT NULL,
  `data_creacio` DATE NOT NULL,
  `Usuaris_usuari_id` INT NOT NULL,
  PRIMARY KEY (`canal_id`),
  INDEX `fk_Canals_Usuaris1_idx` (`Usuaris_usuari_id` ASC) VISIBLE,
  CONSTRAINT `fk_Canals_Usuaris1`
    FOREIGN KEY (`Usuaris_usuari_id`)
    REFERENCES `Youtube`.`Usuaris` (`usuari_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO Canals VALUES (1,'Viatges','text','2022-02-15',1),
			  (2,'Partits Basquet','text','2021-04-29',2);

-- -----------------------------------------------------
-- Table `Youtube`.`Subscripcions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`Subscripcions` (
  `Usuaris_usuari_id` INT NOT NULL,
  `Canals_canal_id` INT NOT NULL,
  PRIMARY KEY (`Usuaris_usuari_id`, `Canals_canal_id`),
  INDEX `fk_Usuaris_has_Canals_Canals1_idx` (`Canals_canal_id` ASC) VISIBLE,
  INDEX `fk_Usuaris_has_Canals_Usuaris1_idx` (`Usuaris_usuari_id` ASC) VISIBLE,
  CONSTRAINT `fk_Usuaris_has_Canals_Usuaris1`
    FOREIGN KEY (`Usuaris_usuari_id`)
    REFERENCES `Youtube`.`Usuaris` (`usuari_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuaris_has_Canals_Canals1`
    FOREIGN KEY (`Canals_canal_id`)
    REFERENCES `Youtube`.`Canals` (`canal_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO Subscripcions VALUES (1,1),
				 (1,2),
                                 (2,1),
                                 (2,2),
                                 (3,1),
                                 (3,2),
                                 (4,1),
                                 (4,2);

-- -----------------------------------------------------
-- Table `Youtube`.`Reaccions_Videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`Reaccions_Videos` (
  `Usuaris_usuari_id` INT NOT NULL,
  `Videos_video_id` INT NOT NULL,
  `tipus` ENUM('like', 'dislike') NOT NULL,
  `data_hora` TIMESTAMP NOT NULL,
  PRIMARY KEY (`Usuaris_usuari_id`, `Videos_video_id`),
  INDEX `fk_Usuaris_has_Videos_Videos1_idx` (`Videos_video_id` ASC) VISIBLE,
  INDEX `fk_Usuaris_has_Videos_Usuaris1_idx` (`Usuaris_usuari_id` ASC) VISIBLE,
  CONSTRAINT `fk_Usuaris_has_Videos_Usuaris1`
    FOREIGN KEY (`Usuaris_usuari_id`)
    REFERENCES `Youtube`.`Usuaris` (`usuari_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuaris_has_Videos_Videos1`
    FOREIGN KEY (`Videos_video_id`)
    REFERENCES `Youtube`.`Videos` (`video_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO Reaccions_Videos VALUES (1,2,'like','2023-03-20 10:51:00'),
				    (3,1,'like','2023-02-12 11:47:23'),
                                    (4,1,'like','2023-01-09 15:00:06');

-- -----------------------------------------------------
-- Table `Youtube`.`Playlists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`Playlists` (
  `playlist_id` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `data_creacio` DATE NOT NULL,
  `estat` ENUM('publica', 'privada') NOT NULL,
  `Usuaris_usuari_id` INT NOT NULL,
  PRIMARY KEY (`playlist_id`),
  INDEX `fk_Playlists_Usuaris1_idx` (`Usuaris_usuari_id` ASC) VISIBLE,
  CONSTRAINT `fk_Playlists_Usuaris1`
    FOREIGN KEY (`Usuaris_usuari_id`)
    REFERENCES `Youtube`.`Usuaris` (`usuari_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO Playlists VALUES (1,'viatges 2022','2023-02-12','privada',1),
			     (2,'partits Barça','2022-12-07','publica',2);

-- -----------------------------------------------------
-- Table `Youtube`.`Videos_has_Playlists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`Videos_has_Playlists` (
  `Videos_video_id` INT NOT NULL,
  `Playlists_playlist_id` INT NOT NULL,
  PRIMARY KEY (`Videos_video_id`, `Playlists_playlist_id`),
  INDEX `fk_Videos_has_Playlists_Playlists1_idx` (`Playlists_playlist_id` ASC) VISIBLE,
  INDEX `fk_Videos_has_Playlists_Videos1_idx` (`Videos_video_id` ASC) VISIBLE,
  CONSTRAINT `fk_Videos_has_Playlists_Videos1`
    FOREIGN KEY (`Videos_video_id`)
    REFERENCES `Youtube`.`Videos` (`video_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Videos_has_Playlists_Playlists1`
    FOREIGN KEY (`Playlists_playlist_id`)
    REFERENCES `Youtube`.`Playlists` (`playlist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO Videos_has_Playlists VALUES (1,1),
					(2,2);

-- -----------------------------------------------------
-- Table `Youtube`.`Comentaris`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`Comentaris` (
  `comentari_id` INT NOT NULL,
  `text` VARCHAR(500) NOT NULL,
  `data_hora` TIMESTAMP NOT NULL,
  `Usuaris_usuari_id` INT NOT NULL,
  `Videos_video_id` INT NOT NULL,
  PRIMARY KEY (`comentari_id`),
  INDEX `fk_Comentaris_Usuaris1_idx` (`Usuaris_usuari_id` ASC) VISIBLE,
  INDEX `fk_Comentaris_Videos1_idx` (`Videos_video_id` ASC) VISIBLE,
  CONSTRAINT `fk_Comentaris_Usuaris1`
    FOREIGN KEY (`Usuaris_usuari_id`)
    REFERENCES `Youtube`.`Usuaris` (`usuari_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comentaris_Videos1`
    FOREIGN KEY (`Videos_video_id`)
    REFERENCES `Youtube`.`Videos` (`video_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO Comentaris VALUES (1,'text','2023-02-01 08:32:00',1,2),
			      (2,'text','2023-01-09 10:26:35',2,1),
                              (3,'text','2023-03-12 17:51:23',3,2),
                              (4,'text','2023-01-02 21:32:11',3,1),
                              (5,'text','2023-02-07 00:12:12',4,1);

-- -----------------------------------------------------
-- Table `Youtube`.`Reaccions_Comentaris`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`Reaccions_Comentaris` (
  `Usuaris_usuari_id` INT NOT NULL,
  `Comentaris_comentari_id` INT NOT NULL,
  `tipus` ENUM('like', 'dislike') NOT NULL,
  `data_hora` TIMESTAMP NOT NULL,
  PRIMARY KEY (`Usuaris_usuari_id`, `Comentaris_comentari_id`),
  INDEX `fk_Usuaris_has_Comentaris_Comentaris1_idx` (`Comentaris_comentari_id` ASC) VISIBLE,
  INDEX `fk_Usuaris_has_Comentaris_Usuaris1_idx` (`Usuaris_usuari_id` ASC) VISIBLE,
  CONSTRAINT `fk_Usuaris_has_Comentaris_Usuaris1`
    FOREIGN KEY (`Usuaris_usuari_id`)
    REFERENCES `Youtube`.`Usuaris` (`usuari_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuaris_has_Comentaris_Comentaris1`
    FOREIGN KEY (`Comentaris_comentari_id`)
    REFERENCES `Youtube`.`Comentaris` (`comentari_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO Reaccions_Comentaris VALUES (1,5,'like','2023-03-15 15:23:32'),
					(1,3,'like','2023-03-15 15:25:21'),
                                        (4,2,'dislike','2023-03-14 11:34:43');

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
