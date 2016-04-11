-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- Généré le: Lun 11 Avril 2016 à 13:53
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
-- Structure de la table `acceptedQuest`
--

CREATE TABLE IF NOT EXISTS `acceptedQuest` (
  `idQuest` int(11) NOT NULL,
  `idUser` int(11) NOT NULL,
  `dateFin` varchar(45) DEFAULT NULL,
  `idSquad` int(11) NOT NULL,
  PRIMARY KEY (`idQuest`,`idUser`),
  KEY `fk_quest_has_guild_guild1_idx` (`idUser`),
  KEY `fk_quest_has_guild_quest1_idx` (`idQuest`),
  KEY `fk_acceptedQuest_squad1_idx` (`idSquad`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `armor`
--

CREATE TABLE IF NOT EXISTS `armor` (
  `protection` int(11) NOT NULL,
  `idEquipment` int(11) NOT NULL,
  PRIMARY KEY (`idEquipment`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `crew`
--

CREATE TABLE IF NOT EXISTS `crew` (
  `idCrew` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL COMMENT '		',
  `surname` varchar(45) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `fee` int(11) DEFAULT NULL,
  `idUser` int(11) DEFAULT NULL,
  `talent` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idCrew`),
  KEY `fk_crew_user1_idx` (`idUser`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Contenu de la table `crew`
--

INSERT INTO `crew` (`idCrew`, `name`, `surname`, `level`, `fee`, `idUser`, `talent`) VALUES
(1, 'jean', 'eugene', 1, 100, NULL, 'none'),
(2, 'paul', 'jacques', 1, 100, NULL, 'none'),
(3, 'jean', 'eugene', 1, 100, 2, 'none'),
(4, 'paul', 'jacques', 1, 100, 2, 'none'),
(5, 'paul', 'jacques', 1, 100, 2, 'none'),
(6, 'paul', 'jacques', 1, 100, 2, 'none'),
(7, 'paul', 'jacques', 1, 100, 2, 'none'),
(8, 'paul', 'jacques', 1, 100, 2, 'none');

-- --------------------------------------------------------

--
-- Structure de la table `equip`
--

CREATE TABLE IF NOT EXISTS `equip` (
  `idEquipment` int(11) NOT NULL,
  `idCrew` int(11) NOT NULL,
  PRIMARY KEY (`idEquipment`,`idCrew`),
  KEY `fk_equipment_has_crew_crew1_idx` (`idCrew`),
  KEY `fk_equipment_has_crew_equipment1_idx` (`idEquipment`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  `bonusStr` int(11) DEFAULT NULL,
  `bonusDex` int(11) DEFAULT NULL,
  `bonusInt` int(11) DEFAULT NULL,
  `bonusEnd` int(11) DEFAULT NULL,
  `bonusLuk` int(11) DEFAULT NULL,
  PRIMARY KEY (`idEquipment`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
('', 1, 1, 100, 1),
('test', 2, 0, 100, 2);

-- --------------------------------------------------------

--
-- Structure de la table `heroes`
--

CREATE TABLE IF NOT EXISTS `heroes` (
  `classe` varchar(45) NOT NULL,
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
  KEY `fk_heroes_squad1_idx` (`idSquad`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `heroes`
--

INSERT INTO `heroes` (`classe`, `prestige`, `str`, `dex`, `end`, `intel`, `luk`, `handRight`, `handLeft`, `torso`, `head`, `legs`, `feet`, `idCrew`, `idSquad`) VALUES
('aventurier', 1, 5, 5, 5, 5, 5, NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL),
('aventurier', 1, 5, 5, 5, 5, 5, NULL, NULL, NULL, NULL, NULL, NULL, 6, NULL),
('aventurier', 1, 5, 5, 5, 5, 5, NULL, NULL, NULL, NULL, NULL, NULL, 7, 3),
('aventurier', 1, 5, 5, 5, 5, 5, NULL, NULL, NULL, NULL, NULL, NULL, 8, 3);

-- --------------------------------------------------------

--
-- Structure de la table `inventory`
--

CREATE TABLE IF NOT EXISTS `inventory` (
  `idInventory` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` varchar(45) DEFAULT NULL,
  `idUser` int(11) NOT NULL,
  `idEquipment` int(11) NOT NULL,
  PRIMARY KEY (`idInventory`,`idEquipment`),
  KEY `fk_inventory_user1_idx` (`idUser`),
  KEY `fk_inventory_equipment1_idx` (`idEquipment`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `quest`
--

CREATE TABLE IF NOT EXISTS `quest` (
  `idQuest` int(11) NOT NULL AUTO_INCREMENT,
  `summary` text,
  `difficulty` int(11) DEFAULT NULL,
  `reward` int(11) DEFAULT NULL,
  `length` time DEFAULT NULL,
  `name` varchar(45) NOT NULL,
  `experience` int(11) NOT NULL,
  PRIMARY KEY (`idQuest`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Contenu de la table `quest`
--

INSERT INTO `quest` (`idQuest`, `summary`, `difficulty`, `reward`, `length`, `name`, `experience`) VALUES
(1, 'blablabla', 50, NULL, '00:00:10', 'wololo', 5);

-- --------------------------------------------------------

--
-- Structure de la table `squad`
--

CREATE TABLE IF NOT EXISTS `squad` (
  `idSquad` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `experience` varchar(45) DEFAULT NULL,
  `idUser` int(11) NOT NULL,
  PRIMARY KEY (`idSquad`),
  KEY `fk_squad_user1_idx` (`idUser`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Contenu de la table `squad`
--

INSERT INTO `squad` (`idSquad`, `name`, `experience`, `idUser`) VALUES
(3, 'test squad', '0', 2);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Contenu de la table `user`
--

INSERT INTO `user` (`idUser`, `role`, `login`, `pass`, `email`) VALUES
(1, 'admin', 'root', 'root', 'root@root.root'),
(2, 'user', 'test', 'test', 'test@test.cpù');

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
('mineur', 1),
('mineur', 3);

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `acceptedQuest`
--
ALTER TABLE `acceptedQuest`
  ADD CONSTRAINT `fk_quest_has_guild_quest1` FOREIGN KEY (`idQuest`) REFERENCES `quest` (`idQuest`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_quest_has_guild_guild1` FOREIGN KEY (`idUser`) REFERENCES `guild` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_acceptedQuest_squad1` FOREIGN KEY (`idSquad`) REFERENCES `squad` (`idSquad`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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
-- Contraintes pour la table `equip`
--
ALTER TABLE `equip`
  ADD CONSTRAINT `fk_equipment_has_crew_equipment1` FOREIGN KEY (`idEquipment`) REFERENCES `equipment` (`idEquipment`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_equipment_has_crew_crew1` FOREIGN KEY (`idCrew`) REFERENCES `crew` (`idCrew`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `guild`
--
ALTER TABLE `guild`
  ADD CONSTRAINT `fk_guild_user` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Contraintes pour la table `heroes`
--
ALTER TABLE `heroes`
  ADD CONSTRAINT `fk_heroes_squad1` FOREIGN KEY (`idSquad`) REFERENCES `squad` (`idSquad`) ON DELETE SET NULL ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_heroes_crew1` FOREIGN KEY (`idCrew`) REFERENCES `crew` (`idCrew`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Contraintes pour la table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `fk_inventory_equipment1` FOREIGN KEY (`idEquipment`) REFERENCES `equipment` (`idEquipment`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_inventory_user1` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Contraintes pour la table `squad`
--
ALTER TABLE `squad`
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
