SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `guildmaster` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `guildmaster` ;

-- -----------------------------------------------------
-- Table `guildmaster`.`equipment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `guildmaster`.`equipment` (
  `idEquipment` INT(11) NOT NULL AUTO_INCREMENT,
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
  PRIMARY KEY (`idEquipment`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `guildmaster`.`armor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `guildmaster`.`armor` (
  `protection` INT(11) NULL DEFAULT NULL,
  `idEquipment` INT(11) NOT NULL,
  PRIMARY KEY (`idEquipment`),
  CONSTRAINT `FK_Armor_id`
    FOREIGN KEY (`idEquipment`)
    REFERENCES `guildmaster`.`equipment` (`idEquipment`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `guildmaster`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `guildmaster`.`user` (
  `idUser` INT(11) NOT NULL AUTO_INCREMENT,
  `role` VARCHAR(255) NOT NULL,
  `login` VARCHAR(25) NULL DEFAULT NULL,
  `pass` VARCHAR(25) NULL DEFAULT NULL,
  `email` VARCHAR(25) NULL DEFAULT NULL,
  PRIMARY KEY (`idUser`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `guildmaster`.`guild`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `guildmaster`.`guild` (
  `name` VARCHAR(25) NULL DEFAULT NULL,
  `rank` INT(11) NULL DEFAULT NULL,
  `prestige` INT(11) NULL DEFAULT NULL,
  `gold` INT(11) NULL DEFAULT NULL,
  `idUser` INT(11) NOT NULL,
  PRIMARY KEY (`idUser`),
  CONSTRAINT `fk_guild_user1`
    FOREIGN KEY (`idUser`)
    REFERENCES `guildmaster`.`user` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `guildmaster`.`crew`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `guildmaster`.`crew` (
  `idCrew` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NULL DEFAULT NULL,
  `surname` VARCHAR(25) NULL DEFAULT NULL,
  `level` INT(11) NULL DEFAULT NULL,
  `talent` VARCHAR(25) NULL DEFAULT NULL,
  `fee` INT(11) NULL DEFAULT NULL,
  `idUser` INT(11) NOT NULL,
  PRIMARY KEY (`idCrew`),
  INDEX `fk_crew_guild1_idx` (`idUser` ASC),
  CONSTRAINT `fk_crew_guild1`
    FOREIGN KEY (`idUser`)
    REFERENCES `guildmaster`.`guild` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `guildmaster`.`equip`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `guildmaster`.`equip` (
  `idEquipment` INT(11) NOT NULL,
  `idCrew` INT(11) NOT NULL,
  PRIMARY KEY (`idEquipment`, `idCrew`),
  INDEX `FK_equip_id_Crew` (`idCrew` ASC),
  CONSTRAINT `FK_equip_id_Crew`
    FOREIGN KEY (`idCrew`)
    REFERENCES `guildmaster`.`crew` (`idCrew`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_equip_id`
    FOREIGN KEY (`idEquipment`)
    REFERENCES `guildmaster`.`equipment` (`idEquipment`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `guildmaster`.`squad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `guildmaster`.`squad` (
  `idsquad` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NULL DEFAULT NULL,
  `experience` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idsquad`))
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
  `torso` INT(11) NULL DEFAULT NULL,
  `head` INT(11) NULL DEFAULT NULL,
  `legs` INT(11) NULL DEFAULT NULL,
  `feet` INT(11) NULL DEFAULT NULL,
  `idCrew` INT(11) NOT NULL,
  `idSquad` INT(11) NULL,
  PRIMARY KEY (`idCrew`),
  INDEX `FK_Heros_id_Squad` (`idSquad` ASC),
  CONSTRAINT `FK_Heros_id_Squad`
    FOREIGN KEY (`idSquad`)
    REFERENCES `guildmaster`.`squad` (`idsquad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Heros_id`
    FOREIGN KEY (`idCrew`)
    REFERENCES `guildmaster`.`crew` (`idCrew`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `guildmaster`.`quest`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `guildmaster`.`quest` (
  `idQuest` INT(11) NOT NULL,
  `summary` TEXT NULL DEFAULT NULL,
  `difficulty` INT(11) NULL DEFAULT NULL,
  `reward` INT(11) NULL DEFAULT NULL,
  `dateBegin` DATE NULL DEFAULT NULL,
  `dateEnd` DATE NULL DEFAULT NULL,
  `fight` TEXT NULL DEFAULT NULL,
  `idSquad` INT(11) NOT NULL,
  PRIMARY KEY (`idQuest`),
  INDEX `FK_Quest_id_Squad` (`idSquad` ASC),
  CONSTRAINT `FK_Quest_id_Squad`
    FOREIGN KEY (`idSquad`)
    REFERENCES `guildmaster`.`squad` (`idsquad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `guildmaster`.`weapon`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `guildmaster`.`weapon` (
  `minDamage` INT(11) NULL DEFAULT NULL,
  `maxDamage` VARCHAR(45) NULL,
  `distance` TINYINT(1) NULL DEFAULT NULL,
  `idEquipment` INT(11) NOT NULL,
  PRIMARY KEY (`idEquipment`),
  CONSTRAINT `FK_Weapon_id`
    FOREIGN KEY (`idEquipment`)
    REFERENCES `guildmaster`.`equipment` (`idEquipment`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `guildmaster`.`worker`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `guildmaster`.`worker` (
  `job` VARCHAR(25) NULL DEFAULT NULL,
  `idCrew` INT(11) NOT NULL,
  PRIMARY KEY (`idCrew`),
  CONSTRAINT `fk_worker_crew1`
    FOREIGN KEY (`idCrew`)
    REFERENCES `guildmaster`.`crew` (`idCrew`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `guildmaster`.`inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `guildmaster`.`inventory` (
  `idInventory` INT NOT NULL AUTO_INCREMENT,
  `idEquipment` INT(11) NOT NULL,
  `quantity` VARCHAR(45) NULL,
  `idUser` INT(11) NOT NULL,
  PRIMARY KEY (`idInventory`, `idEquipment`),
  INDEX `fk_equipement_has_inventory_equipement1_idx` (`idEquipment` ASC),
  INDEX `fk_inventory_user1_idx` (`idUser` ASC),
  CONSTRAINT `fk_equipement_has_inventory_equipement1`
    FOREIGN KEY (`idEquipment`)
    REFERENCES `guildmaster`.`equipment` (`idEquipment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inventory_user1`
    FOREIGN KEY (`idUser`)
    REFERENCES `guildmaster`.`user` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `guildmaster`.`acceptedQuest`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `guildmaster`.`acceptedQuest` (
  `idUser` INT(11) NOT NULL,
  `idQuest` INT(11) NOT NULL,
  PRIMARY KEY (`idUser`, `idQuest`),
  INDEX `fk_guild_has_quest_quest1_idx` (`idQuest` ASC),
  INDEX `fk_guild_has_quest_guild1_idx` (`idUser` ASC),
  CONSTRAINT `fk_guild_has_quest_guild1`
    FOREIGN KEY (`idUser`)
    REFERENCES `guildmaster`.`guild` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_guild_has_quest_quest1`
    FOREIGN KEY (`idQuest`)
    REFERENCES `guildmaster`.`quest` (`idQuest`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
