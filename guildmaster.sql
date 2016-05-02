-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 02, 2016 at 05:19 PM
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
  `slot` varchar(45) NOT NULL,
  PRIMARY KEY (`idEquipment`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `armor`
--

INSERT INTO `armor` (`protection`, `idEquipment`, `slot`) VALUES
(2, 2, 'head'),
(1, 6, 'legs');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=69 ;

--
-- Dumping data for table `crew`
--

INSERT INTO `crew` (`idCrew`, `name`, `surname`, `fee`, `idUser`, `talent`) VALUES
(1, 'jean', 'eugene', 100, NULL, 'none'),
(2, 'paul', 'jacques', 100, NULL, 'none'),
(27, 'paul', 'jacques', 100, 6, 'none'),
(28, 'jean', 'eugene', 100, 6, 'none'),
(29, 'jean', 'eugene', 100, 6, 'none'),
(64, 'jean', 'eugene', 100, 6, 'none'),
(65, 'jean', 'eugene', 100, 1, 'none'),
(66, 'paul', 'jacques', 100, 1, 'none'),
(67, 'jean', 'eugene', 100, 1, 'none'),
(68, 'jean', 'eugene', 100, 1, 'none');

-- --------------------------------------------------------

--
-- Table structure for table `equipment`
--

CREATE TABLE IF NOT EXISTS `equipment` (
  `idEquipment` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `price` varchar(45) NOT NULL,
  `rarity` varchar(45) NOT NULL,
  `minStr` int(11) NOT NULL,
  `minDex` int(11) NOT NULL,
  `minInt` int(11) NOT NULL,
  `minLuk` int(11) NOT NULL,
  `minEnd` int(11) NOT NULL,
  `bonusStr` int(11) NOT NULL,
  `bonusDex` int(11) NOT NULL,
  `bonusInt` int(11) NOT NULL,
  `bonusEnd` int(11) NOT NULL,
  `bonusLuk` int(11) NOT NULL,
  `description` text NOT NULL,
  `buyable` int(11) DEFAULT NULL,
  PRIMARY KEY (`idEquipment`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `equipment`
--

INSERT INTO `equipment` (`idEquipment`, `name`, `price`, `rarity`, `minStr`, `minDex`, `minInt`, `minLuk`, `minEnd`, `bonusStr`, `bonusDex`, `bonusInt`, `bonusEnd`, `bonusLuk`, `description`, `buyable`) VALUES
(2, 'casque en cuir', '20', '1', 1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 'aze', 0),
(3, 'epee courte', '150', '1', 1, 1, 1, 1, 1, 5, 2, 0, 0, 0, 'azeaze', 1),
(6, 'jambieres en cuir', '150', '1', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1),
(7, 'dague', '250', '', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1),
(8, 'dague', '250', '', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1),
(9, 'dague', '250', '', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1),
(10, 'dague', '250', '1', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1);

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
('rootGuild', 1, 1, 99450, 1),
('test', 6, 0, 18170, 6),
('azeaze', 7, 0, 1000, 7);

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
('aventurier', 915, 1, 5, 5, 5, 5, 5, 28, 7, 10, 0),
('aventurier', 915, 1, 5, 5, 5, 5, 5, 29, 7, 10, 0),
('aventurier', 0, 1, 5, 5, 5, 5, 5, 64, NULL, 1, 0),
('aventurier', 0, 1, 5, 5, 5, 5, 5, 65, 8, 1, 0),
('aventurier', 0, 1, 5, 5, 5, 5, 5, 67, 8, 1, 0),
('aventurier', 0, 1, 5, 5, 5, 5, 5, 68, NULL, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE IF NOT EXISTS `inventory` (
  `idInventory` int(11) NOT NULL AUTO_INCREMENT,
  `idEquipment` int(11) NOT NULL,
  `idUser` int(11) NOT NULL,
  `idCrew` int(11) DEFAULT NULL,
  `slot` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idInventory`),
  KEY `fk_inventory_equipment1_idx` (`idEquipment`),
  KEY `fk_inventory_user1_idx` (`idUser`),
  KEY `fk_inventory_crew1_idx` (`idCrew`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=15 ;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`idInventory`, `idEquipment`, `idUser`, `idCrew`, `slot`) VALUES
(8, 2, 6, NULL, 'head'),
(10, 3, 1, NULL, NULL),
(14, 3, 1, NULL, NULL);

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
  `name` varchar(45) DEFAULT NULL,
  `experience` int(11) DEFAULT NULL,
  `gold` int(11) DEFAULT NULL,
  `procStr` float NOT NULL DEFAULT '1',
  `procInt` float NOT NULL DEFAULT '1',
  `procDex` float NOT NULL DEFAULT '1',
  `procLuk` float NOT NULL DEFAULT '1',
  `procEnd` float NOT NULL DEFAULT '1',
  PRIMARY KEY (`idQuest`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `quest`
--

INSERT INTO `quest` (`idQuest`, `summary`, `difficulty`, `reward`, `duree`, `name`, `experience`, `gold`, `procStr`, `procInt`, `procDex`, `procLuk`, `procEnd`) VALUES
(1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce quis dui tellus. Duis vulputate mi sed sodales porttitor. Aenean vestibulum ex lectus, nec vulputate nisi faucibus vitae. Fusce ullamcorper vitae ligula et molestie. Proin commodo convallis mattis. Vestibulum scelerisque sit amet ligula ut hendrerit. In ullamcorper, neque ac dapibus fringilla, ex erat facilisis diam, a feugiat lorem justo quis nisi.', 1, NULL, 1, 'test facile', 100, 100, 1, 1, 1, 1, 1),
(2, 'test', 150000, NULL, 10, 'test impossible', 1000, 10000, 1, 1, 1, 1, 1),
(3, 'erere', 75, NULL, 5, 'test proc', 10, 10, 2, 1.5, 1.5, 1.5, 2);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `squad`
--

INSERT INTO `squad` (`idSquad`, `name`, `reussiteQuete`, `idUser`, `idQuest`, `dateFinQuete`) VALUES
(7, 'squad 1', 1, 6, 3, '2016-04-28 16:08:03'),
(8, 'rootSquad', NULL, 1, NULL, NULL);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`idUser`, `role`, `login`, `pass`, `email`) VALUES
(1, 'admin', 'root', 'root', 'root@root.root'),
(6, 'user', 'test', 'test', 'test@test.cpù'),
(7, 'user', 'azeaze', 'azeaze', 'azezaeaez@æzee.err');

-- --------------------------------------------------------

--
-- Table structure for table `weapon`
--

CREATE TABLE IF NOT EXISTS `weapon` (
  `minDamage` int(11) NOT NULL,
  `maxDamage` int(45) NOT NULL,
  `distance` int(11) NOT NULL,
  `idEquipment` int(11) NOT NULL,
  PRIMARY KEY (`idEquipment`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `weapon`
--

INSERT INTO `weapon` (`minDamage`, `maxDamage`, `distance`, `idEquipment`) VALUES
(1, 3, 2, 3),
(1, 5, 1, 10);

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
('mineur', 27),
('mineur', 66);

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
  ADD CONSTRAINT `fk_crew_user1` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`) ON DELETE CASCADE ON UPDATE NO ACTION;

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
  ADD CONSTRAINT `fk_worker_crew1` FOREIGN KEY (`idCrew`) REFERENCES `crew` (`idCrew`) ON DELETE CASCADE ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
