-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- Généré le: Ven 01 Avril 2016 à 16:07
-- Version du serveur: 5.5.46-0ubuntu0.14.04.2
-- Version de PHP: 5.6.16-4+deb.sury.org~trusty+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `guildmaster`
--

-- --------------------------------------------------------

--
-- Structure de la table `acceptedquest`
--

CREATE TABLE IF NOT EXISTS `acceptedquest` (
  `idUser` int(11) NOT NULL,
  `idQuest` int(11) NOT NULL,
  PRIMARY KEY (`idUser`,`idQuest`),
  KEY `fk_guild_has_quest_quest1_idx` (`idQuest`),
  KEY `fk_guild_has_quest_guild1_idx` (`idUser`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `armor`
--

CREATE TABLE IF NOT EXISTS `armor` (
  `protection` int(11) DEFAULT NULL,
  `idEquipment` int(11) NOT NULL,
  PRIMARY KEY (`idEquipment`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `crew`
--

CREATE TABLE IF NOT EXISTS `crew` (
  `idCrew` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) DEFAULT NULL,
  `surname` varchar(25) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `talent` varchar(25) DEFAULT NULL,
  `fee` int(11) DEFAULT NULL,
  `idUser` int(11) DEFAULT NULL,
  PRIMARY KEY (`idCrew`),
  KEY `fk_crew_guild1_idx` (`idUser`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=45 ;

--
-- Contenu de la table `crew`
--

INSERT INTO `crew` (`idCrew`, `name`, `surname`, `level`, `talent`, `fee`, `idUser`) VALUES
(2, 'jean', 'eugene', 1, 'none', 100, NULL),
(3, 'pierre', 'paul', 1, 'none', 100, NULL),
(31, 'pierre', 'paul', 1, 'none', 100, 15),
(37, 'jean', 'eugene', 1, 'none', 100, 15),
(38, 'jean', 'eugene', 1, 'none', 100, 15),
(39, 'jean', 'eugene', 1, 'none', 100, 15),
(40, 'jean', 'eugene', 1, 'none', 100, 15),
(41, 'jean', 'eugene', 1, 'none', 100, 15),
(42, 'jean', 'eugene', 1, 'none', 100, 15),
(43, 'jean', 'eugene', 1, 'none', 100, 15),
(44, 'jean', 'eugene', 1, 'none', 100, 15);

-- --------------------------------------------------------

--
-- Structure de la table `equip`
--

CREATE TABLE IF NOT EXISTS `equip` (
  `idEquipment` int(11) NOT NULL,
  `idCrew` int(11) NOT NULL,
  PRIMARY KEY (`idEquipment`,`idCrew`),
  KEY `FK_equip_id_Crew` (`idCrew`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `equipment`
--

CREATE TABLE IF NOT EXISTS `equipment` (
  `idEquipment` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `rarity` varchar(25) DEFAULT NULL,
  `description` text,
  `minStr` int(11) DEFAULT NULL,
  `minDex` int(11) DEFAULT NULL,
  `minEnd` int(11) DEFAULT NULL,
  `minInt` int(11) DEFAULT NULL,
  `minLuk` int(11) DEFAULT NULL,
  `bonusStr` int(11) DEFAULT NULL,
  `bonusDex` int(11) DEFAULT NULL,
  `bonusEnd` int(11) DEFAULT NULL,
  `bonusInt` int(11) DEFAULT NULL,
  `bonusLuk` int(11) DEFAULT NULL,
  PRIMARY KEY (`idEquipment`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `guild`
--

CREATE TABLE IF NOT EXISTS `guild` (
  `name` varchar(25) DEFAULT NULL,
  `rank` int(11) DEFAULT NULL,
  `prestige` int(11) DEFAULT NULL,
  `gold` int(11) DEFAULT NULL,
  `idUser` int(11) NOT NULL,
  PRIMARY KEY (`idUser`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `guild`
--

INSERT INTO `guild` (`name`, `rank`, `prestige`, `gold`, `idUser`) VALUES
('BestGuildEver', 1, 0, 0, 1),
('La super guilde de Jean o', 2, 0, 0, 2),
('wololo', 3, 0, 0, 3),
('test', 15, 0, 100, 15),
('azeae', 16, 0, 0, 16);

-- --------------------------------------------------------

--
-- Structure de la table `heroes`
--

CREATE TABLE IF NOT EXISTS `heroes` (
  `classe` varchar(25) DEFAULT NULL,
  `prestige` int(11) DEFAULT NULL,
  `str` int(11) DEFAULT NULL,
  `dex` int(11) DEFAULT NULL,
  `end` int(11) DEFAULT NULL,
  `intel` int(11) DEFAULT NULL,
  `luk` int(11) DEFAULT NULL,
  `handRight` int(11) DEFAULT NULL,
  `handLeft` int(11) DEFAULT NULL,
  `torso` int(11) DEFAULT NULL,
  `head` int(11) DEFAULT NULL,
  `legs` int(11) DEFAULT NULL,
  `feet` int(11) DEFAULT NULL,
  `idCrew` int(11) NOT NULL,
  `idSquad` int(11) DEFAULT NULL,
  PRIMARY KEY (`idCrew`),
  UNIQUE KEY `idCrew_UNIQUE` (`idCrew`),
  KEY `FK_Heros_id_Squad` (`idSquad`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `heroes`
--

INSERT INTO `heroes` (`classe`, `prestige`, `str`, `dex`, `end`, `intel`, `luk`, `handRight`, `handLeft`, `torso`, `head`, `legs`, `feet`, `idCrew`, `idSquad`) VALUES
('aventurier', 0, 5, 5, 5, 5, 5, NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `inventory`
--

CREATE TABLE IF NOT EXISTS `inventory` (
  `idInventory` int(11) NOT NULL AUTO_INCREMENT,
  `idEquipment` int(11) NOT NULL,
  `quantity` varchar(45) DEFAULT NULL,
  `idUser` int(11) NOT NULL,
  PRIMARY KEY (`idInventory`,`idEquipment`),
  KEY `fk_equipement_has_inventory_equipement1_idx` (`idEquipment`),
  KEY `fk_inventory_user1_idx` (`idUser`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `quest`
--

CREATE TABLE IF NOT EXISTS `quest` (
  `idQuest` int(11) NOT NULL,
  `summary` text,
  `difficulty` int(11) DEFAULT NULL,
  `reward` int(11) DEFAULT NULL,
  `dateBegin` date DEFAULT NULL,
  `dateEnd` date DEFAULT NULL,
  `fight` text,
  `idSquad` int(11) NOT NULL,
  PRIMARY KEY (`idQuest`),
  KEY `FK_Quest_id_Squad` (`idSquad`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `squad`
--

CREATE TABLE IF NOT EXISTS `squad` (
  `idsquad` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) DEFAULT NULL,
  `experience` int(11) DEFAULT NULL,
  PRIMARY KEY (`idsquad`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `idUser` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(255) NOT NULL,
  `login` varchar(25) DEFAULT NULL,
  `pass` varchar(25) DEFAULT NULL,
  `email` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`idUser`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=17 ;

--
-- Contenu de la table `user`
--

INSERT INTO `user` (`idUser`, `role`, `login`, `pass`, `email`) VALUES
(1, 'admin', 'Banedon', 'root', 'root@root.com'),
(2, 'en attente', 'Jean-Test', 'jesuisjean', 'jean@test.test'),
(3, 'admin', 'zeis', 'root', 'zaeaze@kjghekt.zaee'),
(15, 'user', 'test', 'test', 'test@testAZEAZEZQDSQDEZQD'),
(16, 'user', 'test2', 'azeaze', 'testazeze@qsdd.dfdf');

-- --------------------------------------------------------

--
-- Structure de la table `weapon`
--

CREATE TABLE IF NOT EXISTS `weapon` (
  `minDamage` int(11) DEFAULT NULL,
  `maxDamage` int(11) DEFAULT NULL,
  `distance` tinyint(1) DEFAULT NULL,
  `idEquipment` int(11) NOT NULL,
  PRIMARY KEY (`idEquipment`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `worker`
--

CREATE TABLE IF NOT EXISTS `worker` (
  `job` varchar(25) DEFAULT NULL,
  `idCrew` int(11) NOT NULL,
  PRIMARY KEY (`idCrew`),
  UNIQUE KEY `idCrew_UNIQUE` (`idCrew`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `worker`
--

INSERT INTO `worker` (`job`, `idCrew`) VALUES
('mineur', 3),
('mineur', 31);

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `acceptedquest`
--
ALTER TABLE `acceptedquest`
  ADD CONSTRAINT `fk_guild_has_quest_guild1` FOREIGN KEY (`idUser`) REFERENCES `guild` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_guild_has_quest_quest1` FOREIGN KEY (`idQuest`) REFERENCES `quest` (`idQuest`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `armor`
--
ALTER TABLE `armor`
  ADD CONSTRAINT `FK_Armor_id` FOREIGN KEY (`idEquipment`) REFERENCES `equipment` (`idEquipment`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Contraintes pour la table `crew`
--
ALTER TABLE `crew`
  ADD CONSTRAINT `fk_crew_guild1` FOREIGN KEY (`idUser`) REFERENCES `guild` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `equip`
--
ALTER TABLE `equip`
  ADD CONSTRAINT `FK_equip_id` FOREIGN KEY (`idEquipment`) REFERENCES `equipment` (`idEquipment`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_equip_id_Crew` FOREIGN KEY (`idCrew`) REFERENCES `crew` (`idCrew`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Contraintes pour la table `guild`
--
ALTER TABLE `guild`
  ADD CONSTRAINT `fk_guild_user1` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `fk_equipement_has_inventory_equipement1` FOREIGN KEY (`idEquipment`) REFERENCES `equipment` (`idEquipment`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_inventory_user1` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `quest`
--
ALTER TABLE `quest`
  ADD CONSTRAINT `FK_Quest_id_Squad` FOREIGN KEY (`idSquad`) REFERENCES `squad` (`idsquad`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `weapon`
--
ALTER TABLE `weapon`
  ADD CONSTRAINT `FK_Weapon_id` FOREIGN KEY (`idEquipment`) REFERENCES `equipment` (`idEquipment`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Contraintes pour la table `worker`
--
ALTER TABLE `worker`
  ADD CONSTRAINT `fk_worker_crew1` FOREIGN KEY (`idCrew`) REFERENCES `crew` (`idCrew`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
