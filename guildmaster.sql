-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- Généré le: Mar 19 Avril 2016 à 17:09
-- Version du serveur: 5.5.47-0ubuntu0.14.04.1
-- Version de PHP: 5.6.20-1+deb.sury.org~trusty+1

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
-- Structure de la table `armor`
--

CREATE TABLE IF NOT EXISTS `armor` (
  `protection` int(11) NOT NULL,
  `idEquipment` int(11) NOT NULL,
  `slot` varchar(45) NOT NULL,
  PRIMARY KEY (`idEquipment`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `armor`
--

INSERT INTO `armor` (`protection`, `idEquipment`, `slot`) VALUES
(5, 1, 'torso'),
(2, 2, 'head');

-- --------------------------------------------------------

--
-- Structure de la table `crew`
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=27 ;

--
-- Contenu de la table `crew`
--

INSERT INTO `crew` (`idCrew`, `name`, `surname`, `fee`, `idUser`, `talent`) VALUES
(1, 'jean', 'eugene', 100, NULL, 'none'),
(2, 'paul', 'jacques', 100, NULL, 'none'),
(3, 'paul', 'jacques', 100, 2, 'none'),
(16, 'jean', 'eugene', 100, 2, 'none'),
(17, 'jean', 'eugene', 100, 2, 'none'),
(18, 'jean', 'eugene', 100, 2, 'none'),
(19, 'jean', 'eugene', 100, 2, 'none'),
(20, 'jean', 'eugene', 100, 2, 'none'),
(21, 'jean', 'eugene', 100, 2, 'none'),
(22, 'jean', 'eugene', 100, 2, 'none'),
(23, 'jean', 'eugene', 100, 2, 'none'),
(24, 'jean', 'eugene', 100, 2, 'none'),
(25, 'jean', 'eugene', 100, 2, 'none'),
(26, 'paul', 'jacques', 100, 2, 'none');

-- --------------------------------------------------------

--
-- Structure de la table `equipment`
--

CREATE TABLE IF NOT EXISTS `equipment` (
  `idEquipment` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `price` varchar(45) DEFAULT NULL,
  `rarity` varchar(45) DEFAULT NULL,
  `minStr` int(11) DEFAULT NULL,
  `minDex` int(11) DEFAULT NULL,
  `minInt` int(11) DEFAULT NULL,
  `minLuk` int(11) DEFAULT NULL,
  `minEnd` int(11) NOT NULL,
  `bonusStr` int(11) DEFAULT NULL,
  `bonusDex` int(11) DEFAULT NULL,
  `bonusInt` int(11) DEFAULT NULL,
  `bonusEnd` int(11) DEFAULT NULL,
  `bonusLuk` int(11) DEFAULT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`idEquipment`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Contenu de la table `equipment`
--

INSERT INTO `equipment` (`idEquipment`, `name`, `price`, `rarity`, `minStr`, `minDex`, `minInt`, `minLuk`, `minEnd`, `bonusStr`, `bonusDex`, `bonusInt`, `bonusEnd`, `bonusLuk`, `description`) VALUES
(1, 'armure de cuir', '50', '1', 1, 1, 1, 1, 1, 0, 2, 0, 1, 1, 'aze'),
(2, 'casque en cuir', '20', '1', 1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 'aze');

-- --------------------------------------------------------

--
-- Structure de la table `guild`
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
-- Contenu de la table `guild`
--

INSERT INTO `guild` (`name`, `rank`, `prestige`, `gold`, `idUser`) VALUES
('rootGuild', 1, 1, 100, 1),
('test', 2, 0, 710, 2),
('squalala', 3, 0, 100, 3);

-- --------------------------------------------------------

--
-- Structure de la table `heroes`
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
  PRIMARY KEY (`idCrew`),
  KEY `fk_heroes_squad1_idx` (`idSquad`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `heroes`
--

INSERT INTO `heroes` (`classe`, `experience`, `prestige`, `str`, `dex`, `end`, `intel`, `luk`, `idCrew`, `idSquad`, `niveau`) VALUES
('aventurier', 0, 1, 5, 5, 5, 5, 5, 1, NULL, 1),
('aventurier', 0, 1, 5, 5, 5, 5, 5, 16, 5, 1),
('aventurier', 0, 1, 5, 5, 5, 5, 5, 17, 6, 1),
('aventurier', 275, 1, 5, 5, 5, 5, 5, 18, 4, 4),
('aventurier', 275, 1, 5, 5, 5, 5, 5, 19, 4, 4),
('aventurier', 0, 1, 5, 5, 5, 5, 5, 20, 5, 1),
('aventurier', 0, 1, 5, 5, 5, 5, 5, 21, 5, 1),
('aventurier', 0, 1, 5, 5, 5, 5, 5, 22, 6, 1),
('aventurier', 0, 1, 5, 5, 5, 5, 5, 23, NULL, 1),
('aventurier', 0, 1, 5, 5, 5, 5, 5, 24, NULL, 1),
('aventurier', 0, 1, 5, 5, 5, 5, 5, 25, NULL, 1);

-- --------------------------------------------------------

--
-- Structure de la table `inventory`
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Contenu de la table `inventory`
--

INSERT INTO `inventory` (`idInventory`, `idEquipment`, `idUser`, `idCrew`, `slot`) VALUES
(1, 1, 2, 18, 'torso'),
(2, 2, 2, 18, 'head'),
(3, 1, 2, 16, 'torso'),
(4, 2, 2, 16, 'head'),
(5, 2, 2, NULL, 'head');

-- --------------------------------------------------------

--
-- Structure de la table `quest`
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
  PRIMARY KEY (`idQuest`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Contenu de la table `quest`
--

INSERT INTO `quest` (`idQuest`, `summary`, `difficulty`, `reward`, `duree`, `name`, `experience`, `gold`) VALUES
(2, 'blablabla', 50, NULL, 1, 'wololo', 1000, 10),
(3, 'blabla', 15000, NULL, 20, 'plop', 200, 100);

-- --------------------------------------------------------

--
-- Structure de la table `squad`
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Contenu de la table `squad`
--

INSERT INTO `squad` (`idSquad`, `name`, `reussiteQuete`, `idUser`, `idQuest`, `dateFinQuete`) VALUES
(4, 'test', NULL, 2, NULL, NULL),
(5, 'test 2', NULL, 2, NULL, NULL),
(6, 'testsquad', NULL, 2, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `user`
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
-- Contenu de la table `user`
--

INSERT INTO `user` (`idUser`, `role`, `login`, `pass`, `email`) VALUES
(1, 'admin', 'root', 'root', 'root@root.root'),
(2, 'user', 'test', 'test', 'testazeze@qsdd.dfdf'),
(3, 'user', 'test3', 'test', 'test@test.cpù');

-- --------------------------------------------------------

--
-- Structure de la table `weapon`
--

CREATE TABLE IF NOT EXISTS `weapon` (
  `minDamage` int(11) NOT NULL,
  `maxDamage` varchar(45) DEFAULT NULL,
  `distance` int(11) DEFAULT NULL,
  `idEquipment` int(11) NOT NULL,
  PRIMARY KEY (`idEquipment`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `worker`
--

CREATE TABLE IF NOT EXISTS `worker` (
  `job` varchar(45) NOT NULL,
  `idCrew` int(11) NOT NULL,
  PRIMARY KEY (`idCrew`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `worker`
--

INSERT INTO `worker` (`job`, `idCrew`) VALUES
('mineur', 2),
('mineur', 3),
('mineur', 26);

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `armor`
--
ALTER TABLE `armor`
  ADD CONSTRAINT `fk_armor_equipment1` FOREIGN KEY (`idEquipment`) REFERENCES `equipment` (`idEquipment`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Contraintes pour la table `crew`
--
ALTER TABLE `crew`
  ADD CONSTRAINT `fk_crew_user1` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `guild`
--
ALTER TABLE `guild`
  ADD CONSTRAINT `fk_guild_user` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `heroes`
--
ALTER TABLE `heroes`
  ADD CONSTRAINT `fk_heroes_crew1` FOREIGN KEY (`idCrew`) REFERENCES `crew` (`idCrew`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_heroes_squad1` FOREIGN KEY (`idSquad`) REFERENCES `squad` (`idSquad`) ON DELETE SET NULL ON UPDATE NO ACTION;

--
-- Contraintes pour la table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `fk_inventory_crew1` FOREIGN KEY (`idCrew`) REFERENCES `crew` (`idCrew`) ON DELETE SET NULL ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_inventory_equipment1` FOREIGN KEY (`idEquipment`) REFERENCES `equipment` (`idEquipment`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_inventory_user1` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Contraintes pour la table `squad`
--
ALTER TABLE `squad`
  ADD CONSTRAINT `fk_squad_quest1` FOREIGN KEY (`idQuest`) REFERENCES `quest` (`idQuest`) ON DELETE SET NULL ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_squad_user1` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Contraintes pour la table `weapon`
--
ALTER TABLE `weapon`
  ADD CONSTRAINT `fk_weapon_equipment1` FOREIGN KEY (`idEquipment`) REFERENCES `equipment` (`idEquipment`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Contraintes pour la table `worker`
--
ALTER TABLE `worker`
  ADD CONSTRAINT `fk_worker_crew1` FOREIGN KEY (`idCrew`) REFERENCES `crew` (`idCrew`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
