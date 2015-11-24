SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `guildmaster` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `guildmaster` ;

-- -----------------------------------------------------
-- Table `guildmaster`.`equipement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `guildmaster`.`equipement` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NULL DEFAULT NULL,
  `price` INT(11) NULL DEFAULT NULL,
  `rarity` INT(11) NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `minStr` INT(11) NULL DEFAULT NULL,
  `minDex` INT(11) NULL DEFAULT NULL,
  `minEnd` INT(11) NULL DEFAULT NULL,
  `minInt` INT(11) NULL DEFAULT NULL,
  `minLuk` INT(11) NULL DEFAULT NULL,
  `bonusStr` INT(11) NULL DEFAULT NULL,
  `bonusDex` INT(11) NULL DEFAULT NULL,
  `bonusEnd` INT(11) NULL DEFAULT NULL,
  `bonusInt` INT(11) NULL DEFAULT NULL,
  `bonusLuk` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `guildmaster`.`armor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `guildmaster`.`armor` (
  `protection` INT(11) NULL DEFAULT NULL,
  `id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_Armor_id`
    FOREIGN KEY (`id`)
    REFERENCES `guildmaster`.`equipement` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `guildmaster`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `guildmaster`.`user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `role` VARCHAR(255) NOT NULL,
  `login` VARCHAR(25) NULL DEFAULT NULL,
  `pass` VARCHAR(25) NULL DEFAULT NULL,
  `email` VARCHAR(25) NULL DEFAULT NULL,
  `id_Guild` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_User_id_Guild` (`id_Guild` ASC),
  CONSTRAINT `FK_User_id_Guild`
    FOREIGN KEY (`id_Guild`)
    REFERENCES `guildmaster`.`guild` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `guildmaster`.`guild`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `guildmaster`.`guild` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NULL DEFAULT NULL,
  `rank` INT(11) NULL DEFAULT NULL,
  `prestige` INT(11) NULL DEFAULT NULL,
  `gold` INT(11) NULL DEFAULT NULL,
  `id_User` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_Guild_id_User` (`id_User` ASC),
  CONSTRAINT `FK_Guild_id_User`
    FOREIGN KEY (`id_User`)
    REFERENCES `guildmaster`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `guildmaster`.`crew`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `guildmaster`.`crew` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NULL DEFAULT NULL,
  `surname` VARCHAR(25) NULL DEFAULT NULL,
  `level` INT(11) NULL DEFAULT NULL,
  `talent` VARCHAR(25) NULL DEFAULT NULL,
  `fee` INT(11) NULL DEFAULT NULL,
  `id_Guild` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_Crew_id_Guild` (`id_Guild` ASC),
  CONSTRAINT `FK_Crew_id_Guild`
    FOREIGN KEY (`id_Guild`)
    REFERENCES `guildmaster`.`guild` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `guildmaster`.`equip`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `guildmaster`.`equip` (
  `id` INT(11) NOT NULL,
  `id_Crew` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `id_Crew`),
  INDEX `FK_equip_id_Crew` (`id_Crew` ASC),
  CONSTRAINT `FK_equip_id_Crew`
    FOREIGN KEY (`id_Crew`)
    REFERENCES `guildmaster`.`crew` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_equip_id`
    FOREIGN KEY (`id`)
    REFERENCES `guildmaster`.`equipement` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `guildmaster`.`squad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `guildmaster`.`squad` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NULL DEFAULT NULL,
  `experience` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `guildmaster`.`heroes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `guildmaster`.`heroes` (
  `class` VARCHAR(25) NULL DEFAULT NULL,
  `prestige` INT(11) NULL DEFAULT NULL,
  `str` INT(11) NULL DEFAULT NULL,
  `dex` INT(11) NULL DEFAULT NULL,
  `end` INT(11) NULL DEFAULT NULL,
  `intel` INT(11) NULL DEFAULT NULL,
  `luk` INT(11) NULL DEFAULT NULL,
  `handRight` INT(11) NULL DEFAULT NULL,
  `handLeft` INT(11) NULL DEFAULT NULL,
  `Torso` INT(11) NULL DEFAULT NULL,
  `Head` INT(11) NULL DEFAULT NULL,
  `Legs` INT(11) NULL DEFAULT NULL,
  `Feet` INT(11) NULL DEFAULT NULL,
  `id` INT(11) NOT NULL,
  `id_Squad` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_Heros_id_Squad` (`id_Squad` ASC),
  CONSTRAINT `FK_Heros_id_Squad`
    FOREIGN KEY (`id_Squad`)
    REFERENCES `guildmaster`.`squad` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Heros_id`
    FOREIGN KEY (`id`)
    REFERENCES `guildmaster`.`crew` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `guildmaster`.`quest`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `guildmaster`.`quest` (
  `id` INT(11) NOT NULL,
  `summary` TEXT NULL DEFAULT NULL,
  `difficulty` INT(11) NULL DEFAULT NULL,
  `reward` INT(11) NULL DEFAULT NULL,
  `dateBegin` DATE NULL DEFAULT NULL,
  `dateEnd` DATE NULL DEFAULT NULL,
  `fight` TEXT NULL DEFAULT NULL,
  `id_Guild` INT(11) NULL DEFAULT NULL,
  `id_Squad` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_Quest_id_Guild` (`id_Guild` ASC),
  INDEX `FK_Quest_id_Squad` (`id_Squad` ASC),
  CONSTRAINT `FK_Quest_id_Squad`
    FOREIGN KEY (`id_Squad`)
    REFERENCES `guildmaster`.`squad` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Quest_id_Guild`
    FOREIGN KEY (`id_Guild`)
    REFERENCES `guildmaster`.`guild` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `guildmaster`.`weapon`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `guildmaster`.`weapon` (
  `damage` INT(11) NULL DEFAULT NULL,
  `distance` TINYINT(1) NULL DEFAULT NULL,
  `id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_Weapon_id`
    FOREIGN KEY (`id`)
    REFERENCES `guildmaster`.`equipement` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `guildmaster`.`worker`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `guildmaster`.`worker` (
  `job` VARCHAR(25) NULL DEFAULT NULL,
  `id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_Worker_id`
    FOREIGN KEY (`id`)
    REFERENCES `guildmaster`.`crew` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `guildmaster`.`inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `guildmaster`.`inventory` (
  `idInventory` INT NOT NULL,
  `equipement_id` INT(11) NOT NULL,
  `quantity` VARCHAR(45) NULL,
  `guild_id` INT(11) NOT NULL,
  PRIMARY KEY (`idInventory`, `equipement_id`),
  INDEX `fk_equipement_has_inventory_equipement1_idx` (`equipement_id` ASC),
  INDEX `fk_equipement_has_inventory_guild1_idx` (`guild_id` ASC),
  CONSTRAINT `fk_equipement_has_inventory_equipement1`
    FOREIGN KEY (`equipement_id`)
    REFERENCES `guildmaster`.`equipement` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_equipement_has_inventory_guild1`
    FOREIGN KEY (`guild_id`)
    REFERENCES `guildmaster`.`guild` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
