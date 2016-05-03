-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 03, 2016 at 05:13 PM
-- Server version: 5.5.49-0ubuntu0.14.04.1
-- PHP Version: 5.6.20-1+deb.sury.org~trusty+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `guildmaster`
--

-- --------------------------------------------------------

--
-- Table structure for table `armor`
--

CREATE TABLE IF NOT EXISTS `armor` (
  `protection` int(11) NOT NULL,
  `idEquipment` int(11) NOT NULL,
  PRIMARY KEY (`idEquipment`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `armor`
--

INSERT INTO `armor` (`protection`, `idEquipment`) VALUES
(5, 1),
(2, 2),
(5, 5),
(5, 10);

-- --------------------------------------------------------

--
-- Table structure for table `crew`
--

CREATE TABLE IF NOT EXISTS `crew` (
  `idCrew` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL COMMENT '		',
  `surname` varchar(45) DEFAULT NULL,
  `fee` int(11) DEFAULT NULL,
  `idUser` int(11) DEFAULT NULL,
  `talent` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idCrew`),
  KEY `fk_crew_user1_idx` (`idUser`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=31 ;

--
-- Dumping data for table `crew`
--

INSERT INTO `crew` (`idCrew`, `name`, `surname`, `fee`, `idUser`, `talent`) VALUES
(1, 'jean', 'eugene', 100, NULL, 'none'),
(2, 'paul', 'jacques', 100, NULL, 'none'),
(3, 'paul', 'jacques', 100, 2, 'none'),
(26, 'paul', 'jacques', 100, 2, 'none'),
(27, 'jean', 'eugene', 100, 2, 'none'),
(28, 'jean', 'eugene', 100, 2, 'none'),
(29, 'jean', 'eugene', 100, 2, 'none'),
(30, 'jean', 'eugene', 100, 2, 'none');

-- --------------------------------------------------------

--
-- Table structure for table `equipment`
--

CREATE TABLE IF NOT EXISTS `equipment` (
  `idEquipment` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `price` varchar(45) DEFAULT '0',
  `rarity` varchar(45) DEFAULT 'Commun',
  `minStr` int(11) DEFAULT '0',
  `minDex` int(11) DEFAULT '0',
  `minInt` int(11) DEFAULT '0',
  `minLuk` int(11) DEFAULT '0',
  `minEnd` int(11) NOT NULL DEFAULT '0',
  `bonusStr` int(11) DEFAULT '0',
  `bonusDex` int(11) DEFAULT '0',
  `bonusInt` int(11) DEFAULT '0',
  `bonusEnd` int(11) DEFAULT '0',
  `bonusLuk` int(11) DEFAULT '0',
  `description` text NOT NULL,
  `slot` varchar(255) NOT NULL,
  `buyable` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idEquipment`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Dumping data for table `equipment`
--

INSERT INTO `equipment` (`idEquipment`, `name`, `price`, `rarity`, `minStr`, `minDex`, `minInt`, `minLuk`, `minEnd`, `bonusStr`, `bonusDex`, `bonusInt`, `bonusEnd`, `bonusLuk`, `description`, `slot`, `buyable`) VALUES
(1, 'Armure de cuir', '50', 'Commun', 1, 1, 1, 1, 1, 0, 2, 0, 1, 1, 'aze', 'torso', 1),
(2, 'Casque en cuir', '20', 'Commun', 1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 'aze', 'head', 1),
(4, 'Hache de fer', '0', 'Commun', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 'hand', 1),
(5, 'Casque viking', '0', 'commun', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 'head', 1),
(10, 'jambiere de viking', '35', 'commun', 5, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 'legs', 1),
(11, 'epee courte', '45', 'commun', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 'hand', 1);

-- --------------------------------------------------------

--
-- Table structure for table `guild`
--

CREATE TABLE IF NOT EXISTS `guild` (
  `name` varchar(45) NOT NULL,
  `rank` int(11) DEFAULT NULL,
  `prestige` int(11) DEFAULT NULL,
  `gold` int(11) DEFAULT NULL,
  `idUser` int(11) NOT NULL,
  PRIMARY KEY (`idUser`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `guild`
--

INSERT INTO `guild` (`name`, `rank`, `prestige`, `gold`, `idUser`) VALUES
('rootGuild', 1, 1, 100, 1),
('test', 2, 0, 10340, 2);

-- --------------------------------------------------------

--
-- Table structure for table `heroes`
--

CREATE TABLE IF NOT EXISTS `heroes` (
  `classe` varchar(45) NOT NULL,
  `experience` int(11) NOT NULL,
  `prestige` int(11) DEFAULT NULL,
  `str` int(11) DEFAULT NULL,
  `dex` int(11) DEFAULT NULL,
  `end` int(11) DEFAULT NULL,
  `intel` int(11) DEFAULT NULL,
  `luk` int(11) DEFAULT NULL,
  `idCrew` int(11) NOT NULL,
  `idSquad` int(11) DEFAULT NULL,
  `niveau` int(11) NOT NULL,
  `attrPoints` int(11) NOT NULL,
  PRIMARY KEY (`idCrew`),
  KEY `fk_heroes_squad1_idx` (`idSquad`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `heroes`
--

INSERT INTO `heroes` (`classe`, `experience`, `prestige`, `str`, `dex`, `end`, `intel`, `luk`, `idCrew`, `idSquad`, `niveau`, `attrPoints`) VALUES
('aventurier', 0, 1, 5, 5, 5, 5, 5, 1, NULL, 1, 0),
('aventurier', 625, 1, 5, 5, 10, 5, 5, 27, 7, 6, 5),
('aventurier', 625, 1, 5, 5, 5, 5, 5, 28, 7, 6, 10),
('aventurier', 625, 1, 5, 5, 5, 5, 5, 29, 7, 6, 10),
('aventurier', 625, 1, 5, 5, 5, 5, 5, 30, 7, 6, 10);

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE IF NOT EXISTS `inventory` (
  `idInventory` int(11) NOT NULL AUTO_INCREMENT,
  `idEquipment` int(11) NOT NULL,
  `idUser` int(11) NOT NULL,
  `idCrew` int(11) DEFAULT NULL,
  `handSpecial` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idInventory`),
  KEY `fk_inventory_equipment1_idx` (`idEquipment`),
  KEY `fk_inventory_user1_idx` (`idUser`),
  KEY `fk_inventory_crew1_idx` (`idCrew`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`idInventory`, `idEquipment`, `idUser`, `idCrew`, `handSpecial`) VALUES
(1, 1, 2, 27, NULL),
(2, 2, 2, 27, NULL),
(3, 1, 2, NULL, NULL),
(4, 2, 2, NULL, NULL),
(5, 2, 2, NULL, NULL),
(6, 4, 2, 27, 'handLeft'),
(7, 5, 2, NULL, NULL),
(8, 4, 2, 27, 'handRight');

-- --------------------------------------------------------

--
-- Table structure for table `quest`
--

CREATE TABLE IF NOT EXISTS `quest` (
  `idQuest` int(11) NOT NULL AUTO_INCREMENT,
  `summary` text,
  `difficulty` int(11) DEFAULT NULL,
  `reward` int(11) DEFAULT NULL,
  `duree` int(11) DEFAULT NULL,
  `name` varchar(45) NOT NULL,
  `experience` int(11) NOT NULL,
  `gold` int(11) NOT NULL,
  `procStr` float NOT NULL DEFAULT '1',
  `procEnd` float NOT NULL DEFAULT '1',
  `procDex` float NOT NULL DEFAULT '1',
  `procLuk` float NOT NULL DEFAULT '1',
  `procInt` float NOT NULL DEFAULT '1',
  PRIMARY KEY (`idQuest`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `quest`
--

INSERT INTO `quest` (`idQuest`, `summary`, `difficulty`, `reward`, `duree`, `name`, `experience`, `gold`, `procStr`, `procEnd`, `procDex`, `procLuk`, `procInt`) VALUES
(5, 'quete facile meme seul', 50, NULL, 15, 'quete facile', 40, 50, 1.5, 1.5, 1.5, 1.5, 1.5),
(6, 'quete impossible meme en groupe', 500000, NULL, 10, 'quete impossible', 50000, 100000, 0.5, 0.5, 0.5, 0.5, 0.5),
(7, 'demande une grande force pour gagner le tournoi', 150, NULL, 60, 'bras de fer', 20, 150, 5, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `squad`
--

CREATE TABLE IF NOT EXISTS `squad` (
  `idSquad` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `reussiteQuete` tinyint(1) DEFAULT NULL,
  `idUser` int(11) NOT NULL,
  `idQuest` int(11) DEFAULT NULL,
  `dateFinQuete` datetime DEFAULT NULL,
  PRIMARY KEY (`idSquad`),
  KEY `fk_squad_user1_idx` (`idUser`),
  KEY `fk_squad_quest1_idx` (`idQuest`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `squad`
--

INSERT INTO `squad` (`idSquad`, `name`, `reussiteQuete`, `idUser`, `idQuest`, `dateFinQuete`) VALUES
(7, 'test squad', NULL, 2, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `idUser` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(45) DEFAULT NULL,
  `login` varchar(45) DEFAULT NULL,
  `pass` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idUser`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`idUser`, `role`, `login`, `pass`, `email`) VALUES
(1, 'admin', 'root', 'root', 'root@root.root'),
(2, 'user', 'test', 'test', 'testazeze@qsdd.dfdf');

-- --------------------------------------------------------

--
-- Table structure for table `weapon`
--

CREATE TABLE IF NOT EXISTS `weapon` (
  `minDamage` int(11) NOT NULL DEFAULT '0',
  `maxDamage` varchar(45) DEFAULT '1',
  `distance` tinyint(2) DEFAULT NULL,
  `idEquipment` int(11) NOT NULL,
  PRIMARY KEY (`idEquipment`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `weapon`
--

INSERT INTO `weapon` (`minDamage`, `maxDamage`, `distance`, `idEquipment`) VALUES
(5, '20', 0, 4),
(1, '2', 1, 11);

-- --------------------------------------------------------

--
-- Table structure for table `worker`
--

CREATE TABLE IF NOT EXISTS `worker` (
  `job` varchar(45) NOT NULL,
  `idCrew` int(11) NOT NULL,
  PRIMARY KEY (`idCrew`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `worker`
--

INSERT INTO `worker` (`job`, `idCrew`) VALUES
('mineur', 2),
('mineur', 3),
('mineur', 26);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `armor`
--
ALTER TABLE `armor`
  ADD CONSTRAINT `fk_armor_equipment1` FOREIGN KEY (`idEquipment`) REFERENCES `equipment` (`idEquipment`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `crew`
--
ALTER TABLE `crew`
  ADD CONSTRAINT `fk_crew_user1` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `guild`
--
ALTER TABLE `guild`
  ADD CONSTRAINT `fk_guild_user` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `heroes`
--
ALTER TABLE `heroes`
  ADD CONSTRAINT `fk_heroes_crew1` FOREIGN KEY (`idCrew`) REFERENCES `crew` (`idCrew`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_heroes_squad1` FOREIGN KEY (`idSquad`) REFERENCES `squad` (`idSquad`) ON DELETE SET NULL ON UPDATE NO ACTION;

--
-- Constraints for table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `fk_inventory_crew1` FOREIGN KEY (`idCrew`) REFERENCES `crew` (`idCrew`) ON DELETE SET NULL ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_inventory_equipment1` FOREIGN KEY (`idEquipment`) REFERENCES `equipment` (`idEquipment`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_inventory_user1` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `squad`
--
ALTER TABLE `squad`
  ADD CONSTRAINT `fk_squad_quest1` FOREIGN KEY (`idQuest`) REFERENCES `quest` (`idQuest`) ON DELETE SET NULL ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_squad_user1` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `weapon`
--
ALTER TABLE `weapon`
  ADD CONSTRAINT `fk_weapon_equipment1` FOREIGN KEY (`idEquipment`) REFERENCES `equipment` (`idEquipment`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `worker`
--
ALTER TABLE `worker`
  ADD CONSTRAINT `fk_worker_crew1` FOREIGN KEY (`idCrew`) REFERENCES `crew` (`idCrew`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
