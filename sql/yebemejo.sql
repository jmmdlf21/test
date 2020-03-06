-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema yebemejo
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema yebemejo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `yebemejo` DEFAULT CHARACTER SET utf8 ;
USE `yebemejo` ;

-- -----------------------------------------------------
-- Table `yebemejo`.`usagers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `yebemejo`.`usagers` (
  `usager_id` INT NOT NULL AUTO_INCREMENT,
  `usager_nom` VARCHAR(100) NULL,
  `usager_prenom` VARCHAR(100) NULL,
  `usager_couriel` VARCHAR(100) NULL,
  `usager_localite` VARCHAR(100) NULL,
  `usager_url` VARCHAR(100) NULL,
  `usager_utilisateur` VARCHAR(100) NULL,
  `usager_mdp` VARCHAR(100) NULL,
  `usager_actif` TINYINT(1) NULL,
  `usager_photo_url` NVARCHAR(2000) NULL,
  `usager_droit` TINYINT(2) NULL,
  PRIMARY KEY (`usager_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `yebemejo`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `yebemejo`.`categories` (
  `categorie_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `categorie_description` VARCHAR(100) NULL,
  PRIMARY KEY (`categorie_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `yebemejo`.`annonces`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `yebemejo`.`annonces` (
  `annonce_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `annonce_titre` VARCHAR(100) NULL,
  `annonce_description` VARCHAR(500) NULL,
  `annonce_prix` INT NULL,
  `categorie_id` INT UNSIGNED NULL,
  `usager_id` INT NULL,
  PRIMARY KEY (`annonce_id`),
  INDEX `fk_annonces_categories1_idx` (`categorie_id` ASC),
  INDEX `fk_annonces_usagers1_idx` (`usager_id` ASC),
  CONSTRAINT `fk_annonces_categories1`
    FOREIGN KEY (`categorie_id`)
    REFERENCES `yebemejo`.`categories` (`categorie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_annonces_usagers1`
    FOREIGN KEY (`usager_id`)
    REFERENCES `yebemejo`.`usagers` (`usager_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `yebemejo`.`images`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `yebemejo`.`images` (
  `image_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `image_url` VARCHAR(2000) NULL,
  `annonce_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`image_id`),
  INDEX `fk_images_annonces_idx` (`annonce_id` ASC),
  CONSTRAINT `fk_images_annonces`
    FOREIGN KEY (`annonce_id`)
    REFERENCES `yebemejo`.`annonces` (`annonce_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `yebemejo`.`sous_categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `yebemejo`.`sous_categories` (
  `sous_categorie_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `sous_categorie_description` VARCHAR(100) NULL,
  PRIMARY KEY (`sous_categorie_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `yebemejo`.`categories_sous_categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `yebemejo`.`categories_sous_categories` (
  `categorie_id` INT UNSIGNED NOT NULL,
  `sous_categorie_id` INT UNSIGNED NOT NULL,
  INDEX `fk_cat_scat_categories1_idx` (`categorie_id` ASC),
  INDEX `fk_cat_scat_scategories1_idx` (`sous_categorie_id` ASC),
  PRIMARY KEY (`categorie_id`, `sous_categorie_id`),
  CONSTRAINT `fk_cat_scat_categories1`
    FOREIGN KEY (`categorie_id`)
    REFERENCES `yebemejo`.`categories` (`categorie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cat_scat_scategories1`
    FOREIGN KEY (`sous_categorie_id`)
    REFERENCES `yebemejo`.`sous_categories` (`sous_categorie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `yebemejo`.`messages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `yebemejo`.`messages` (
  `message_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `message_contenu` VARCHAR(2000) NULL,
  `message_expediteur_id` INT NOT NULL,
  `message_destinataire_id` INT NOT NULL,
  PRIMARY KEY (`message_id`),
  INDEX `fk_messages_usagers1_idx` (`message_expediteur_id` ASC),
  CONSTRAINT `fk_messages_usagers1`
    FOREIGN KEY (`message_expediteur_id`)
    REFERENCES `yebemejo`.`usagers` (`usager_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `yebemejo`.`favoris`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `yebemejo`.`favoris` (
  `usager_id` INT NOT NULL,
  `annonce_id` INT UNSIGNED NOT NULL,
  INDEX `fk_favorits_usagers1_idx` (`usager_id` ASC),
  INDEX `fk_favorits_annonces1_idx` (`annonce_id` ASC),
  PRIMARY KEY (`usager_id`, `annonce_id`),
  CONSTRAINT `fk_favorits_usagers1`
    FOREIGN KEY (`usager_id`)
    REFERENCES `yebemejo`.`usagers` (`usager_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_favorits_annonces1`
    FOREIGN KEY (`annonce_id`)
    REFERENCES `yebemejo`.`annonces` (`annonce_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `yebemejo`.`consultations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `yebemejo`.`consultations` (
  `consultation_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `annonce_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`consultation_id`),
  INDEX `fk_consultations_annonces1_idx` (`annonce_id` ASC),
  CONSTRAINT `fk_consultations_annonces1`
    FOREIGN KEY (`annonce_id`)
    REFERENCES `yebemejo`.`annonces` (`annonce_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



-- ---------------------------------------------------------------------------
-- Inserts
-- ---------------------------------------------------------------------------

-- Le id -1 est reservé aux administrateurs

INSERT INTO usagers(usager_id, usager_nom, usager_prenom, usager_couriel, usager_localite, usager_url, usager_utilisateur, usager_mdp, usager_actif, usager_photo_url, usager_droit) VALUES 
(-1, "Administration", NULL, "admin@gmail.com", NULL, NULL, NULL, NULL, 1, NULL, 1),
(1, "Doe", "John", "johndoe@gmail.com", "H1V 2E5", NULL, "jdoe", "jdoe", 1, "https://www2.pictures.zimbio.com/gi/59th+GRAMMY+Awards+Red+Carpet+ZOapWhcPTOMx.jpg", 3),
(2, "Sue", "Mary", "marysue@hotmail.com", "H1X 2A2", "www.themarysue.com", "msue", "msue", 1, NULL, 3),
(3, "Wonka", "Willy", "willywonka@yahoo.com", "H1V 3P1", NULL, "wwonka", "wwonka", 1, NULL, 3),
(4, "Master", "Master", "master@gmail.com", "H1H 1H1", NULL, "master", "master", 1, NULL, 1),
(5, "Commander", "Commander", "commander@gmail.com", "H1H 1H1", NULL, "commander", "commander", 1, NULL, 2),
(6, "Lector", "Hannibal", "cannibal@gmail.com", "H2H 2H2", NULL, "hlector", "hlector", 0, NULL, 3);

INSERT INTO categories(categorie_description) VALUES 
("Équipement électronique"),
("Véhicules"),
("Animaux"),
("Vêtements et accessoires"),
("Jeux et jouets"),
("A donner");

INSERT INTO annonces(annonce_titre, annonce_description, annonce_prix, categorie_id, usager_id) VALUES 
("Laptop à Vendre", "Laptop MacBook Pro en bon état", 1500, 1, 1),
("Auto a vendre", "Voiture Honda Civic 2017, peu de kilometrage", 22000, 2, 2),
("Chat a donner", "Beaux chat Siamois de 4 mois", 0, 3, 3);

INSERT INTO images(image_url, annonce_id) VALUES 
("https://i.ytimg.com/vi/_Y4FMebp76k/maxresdefault.jpg", 1),
("https://i.ytimg.com/vi/oPst8g0U1c8/hqdefault.jpg", 2),
("http://www.pets4homes.co.uk/images/classifieds/2016/08/17/1362604/large/beautiful-blue-point-siamese-kitten-57c30d2788999.jpg", 3);

INSERT INTO sous_categories(sous_categorie_description) VALUES 
("Ordinateurs"),
("Jeux Vidéo"),
("Électroménagers"),
("Céllulaires"),
("Autos"),
("Bateaux"),
("Motos"),
("Chiens"),
("Chats"),
("Oiseaux"),
("Homme"),
("Femme"),
("Enfant"),
("Jeux de société"),
("Jouets");


INSERT INTO categories_sous_categories(categorie_id, sous_categorie_id) VALUES 
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(2, 5),
(2, 6),
(2, 7),
(3, 8),
(3, 9),
(3, 10),
(4, 11),
(4, 12),
(4, 13),
(5, 2),
(5, 14),
(5, 15);

INSERT INTO messages(message_contenu, message_expediteur_id, message_destinataire_id) VALUES 
("Combien de kilometrage a la voiture?", 1, 2),
("Est-ce que le chat est degriffé?", 2, 3),
("Ca viens-tu avec une souris?", 3, 1),
("Je veux rapporter une annonce innapropiée", 3, -1);

INSERT INTO favoris(usager_id, annonce_id) VALUES 
(1, 3),
(2, 1),
(3, 2);

INSERT INTO consultations(annonce_id) VALUES 
(1),
(2),
(2),
(3),
(3),
(3);