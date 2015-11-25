SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`equipment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`equipment` (
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
-- Table `mydb`.`armor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`armor` (
  `protection` INT(11) NULL DEFAULT NULL,
  `idEquipment` INT(11) NOT NULL,
  PRIMARY KEY (`idEquipment`),
  CONSTRAINT `FK_Armor_id`
    FOREIGN KEY (`idEquipment`)
    REFERENCES `mydb`.`equipment` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user` (
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
-- Table `mydb`.`guild`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`guild` (
  `name` VARCHAR(25) NULL DEFAULT NULL,
  `rank` INT(11) NULL DEFAULT NULL,
  `prestige` INT(11) NULL DEFAULT NULL,
  `gold` INT(11) NULL DEFAULT NULL,
  `idUser` INT(11) NOT NULL,
  PRIMARY KEY (`idUser`),
  CONSTRAINT `fk_guild_user1`
    FOREIGN KEY (`idUser`)
    REFERENCES `mydb`.`user` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`crew`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`crew` (
  `guildmaster` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NULL DEFAULT NULL,
  `surname` VARCHAR(25) NULL DEFAULT NULL,
  `level` INT(11) NULL DEFAULT NULL,
  `talent` VARCHAR(25) NULL DEFAULT NULL,
  `fee` INT(11) NULL DEFAULT NULL,
  `idUser` INT(11) NOT NULL,
  PRIMARY KEY (`guildmaster`),
  INDEX `fk_crew_guild1_idx` (`idUser` ASC),
  CONSTRAINT `fk_crew_guild1`
    FOREIGN KEY (`idUser`)
    REFERENCES `mydb`.`guild` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`equip`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`equip` (
  `idEquipment` INT(11) NOT NULL,
  `guildmaster` INT(11) NOT NULL,
  PRIMARY KEY (`idEquipment`, `guildmaster`),
  INDEX `FK_equip_id_Crew` (`guildmaster` ASC),
  CONSTRAINT `FK_equip_id_Crew`
    FOREIGN KEY (`guildmaster`)
    REFERENCES `mydb`.`crew` (`guildmaster`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_equip_id`
    FOREIGN KEY (`idEquipment`)
    REFERENCES `mydb`.`equipment` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`squad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`squad` (
  `idsquad` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NULL DEFAULT NULL,
  `experience` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idsquad`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`heroes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`heroes` (
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
  `guildmaster` INT(11) NOT NULL,
  `idSquad` INT(11) NULL,
  PRIMARY KEY (`guildmaster`),
  INDEX `FK_Heros_id_Squad` (`idSquad` ASC),
  CONSTRAINT `FK_Heros_id_Squad`
    FOREIGN KEY (`idSquad`)
    REFERENCES `mydb`.`squad` (`idsquad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Heros_id`
    FOREIGN KEY (`guildmaster`)
    REFERENCES `mydb`.`crew` (`guildmaster`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`quest`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`quest` (
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
    REFERENCES `mydb`.`squad` (`idsquad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`weapon`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`weapon` (
  `damage` INT(11) NULL DEFAULT NULL,
  `distance` TINYINT(1) NULL DEFAULT NULL,
  `idEquipment` INT(11) NOT NULL,
  PRIMARY KEY (`idEquipment`),
  CONSTRAINT `FK_Weapon_id`
    FOREIGN KEY (`idEquipment`)
    REFERENCES `mydb`.`equipment` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`worker`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`worker` (
  `job` VARCHAR(25) NULL DEFAULT NULL,
  `guildmaster` INT(11) NOT NULL,
  PRIMARY KEY (`guildmaster`),
  CONSTRAINT `FK_Worker_id`
    FOREIGN KEY (`guildmaster`)
    REFERENCES `mydb`.`crew` (`guildmaster`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`inventory` (
  `idInventory` INT NOT NULL,
  `idEquipment` INT(11) NOT NULL,
  `quantity` VARCHAR(45) NULL,
  `guild_id` INT(11) NOT NULL,
  PRIMARY KEY (`idInventory`, `idEquipment`),
  INDEX `fk_equipement_has_inventory_equipement1_idx` (`idEquipment` ASC),
  CONSTRAINT `fk_equipement_has_inventory_equipement1`
    FOREIGN KEY (`idEquipment`)
    REFERENCES `mydb`.`equipment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`acceptedQuest`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`acceptedQuest` (
  `idUser` INT(11) NOT NULL,
  `idQuest` INT(11) NOT NULL,
  PRIMARY KEY (`idUser`, `idQuest`),
  INDEX `fk_guild_has_quest_quest1_idx` (`idQuest` ASC),
  INDEX `fk_guild_has_quest_guild1_idx` (`idUser` ASC),
  CONSTRAINT `fk_guild_has_quest_guild1`
    FOREIGN KEY (`idUser`)
    REFERENCES `mydb`.`guild` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_guild_has_quest_quest1`
    FOREIGN KEY (`idQuest`)
    REFERENCES `mydb`.`quest` (`idQuest`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
