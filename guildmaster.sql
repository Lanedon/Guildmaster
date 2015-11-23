-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Nov 23, 2015 at 11:55 AM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

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
  `protection` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `crew`
--

CREATE TABLE IF NOT EXISTS `crew` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) DEFAULT NULL,
  `surname` varchar(25) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `talent` varchar(25) DEFAULT NULL,
  `fee` int(11) DEFAULT NULL,
  `id_Guild` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Crew_id_Guild` (`id_Guild`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `equip`
--

CREATE TABLE IF NOT EXISTS `equip` (
  `id` int(11) NOT NULL,
  `id_Crew` int(11) NOT NULL,
  PRIMARY KEY (`id`,`id_Crew`),
  KEY `FK_equip_id_Crew` (`id_Crew`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `equipement`
--

CREATE TABLE IF NOT EXISTS `equipement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `rarity` int(11) DEFAULT NULL,
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `guild`
--

CREATE TABLE IF NOT EXISTS `guild` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) DEFAULT NULL,
  `rank` int(11) DEFAULT NULL,
  `prestige` int(11) DEFAULT NULL,
  `gold` int(11) DEFAULT NULL,
  `id_User` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Guild_id_User` (`id_User`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `heros`
--

CREATE TABLE IF NOT EXISTS `heros` (
  `class` varchar(25) DEFAULT NULL,
  `prestige` int(11) DEFAULT NULL,
  `str` int(11) DEFAULT NULL,
  `dex` int(11) DEFAULT NULL,
  `end` int(11) DEFAULT NULL,
  `intel` int(11) DEFAULT NULL,
  `luk` int(11) DEFAULT NULL,
  `handRight` int(11) DEFAULT NULL,
  `handLeft` int(11) DEFAULT NULL,
  `Torso` int(11) DEFAULT NULL,
  `Head` int(11) DEFAULT NULL,
  `Legs` int(11) DEFAULT NULL,
  `Feet` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL,
  `id_Squad` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Heros_id_Squad` (`id_Squad`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `quest`
--

CREATE TABLE IF NOT EXISTS `quest` (
  `id` int(11) NOT NULL,
  `summary` text,
  `difficulty` int(11) DEFAULT NULL,
  `reward` int(11) DEFAULT NULL,
  `dateBegin` date DEFAULT NULL,
  `dateEnd` date DEFAULT NULL,
  `fight` text,
  `id_Guild` int(11) DEFAULT NULL,
  `id_Squad` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Quest_id_Guild` (`id_Guild`),
  KEY `FK_Quest_id_Squad` (`id_Squad`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `squad`
--

CREATE TABLE IF NOT EXISTS `squad` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) DEFAULT NULL,
  `experience` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(255) NOT NULL,
  `login` varchar(25) DEFAULT NULL,
  `pass` varchar(25) DEFAULT NULL,
  `email` varchar(25) DEFAULT NULL,
  `id_Guild` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_User_id_Guild` (`id_Guild`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `weapon`
--

CREATE TABLE IF NOT EXISTS `weapon` (
  `damage` int(11) DEFAULT NULL,
  `distance` tinyint(1) DEFAULT NULL,
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `worker`
--

CREATE TABLE IF NOT EXISTS `worker` (
  `job` varchar(25) DEFAULT NULL,
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `armor`
--
ALTER TABLE `armor`
  ADD CONSTRAINT `FK_Armor_id` FOREIGN KEY (`id`) REFERENCES `equipement` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `crew`
--
ALTER TABLE `crew`
  ADD CONSTRAINT `FK_Crew_id_Guild` FOREIGN KEY (`id_Guild`) REFERENCES `guild` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `equip`
--
ALTER TABLE `equip`
  ADD CONSTRAINT `FK_equip_id_Crew` FOREIGN KEY (`id_Crew`) REFERENCES `crew` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_equip_id` FOREIGN KEY (`id`) REFERENCES `equipement` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `guild`
--
ALTER TABLE `guild`
  ADD CONSTRAINT `FK_Guild_id_User` FOREIGN KEY (`id_User`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `heros`
--
ALTER TABLE `heros`
  ADD CONSTRAINT `FK_Heros_id_Squad` FOREIGN KEY (`id_Squad`) REFERENCES `squad` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_Heros_id` FOREIGN KEY (`id`) REFERENCES `crew` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `quest`
--
ALTER TABLE `quest`
  ADD CONSTRAINT `FK_Quest_id_Squad` FOREIGN KEY (`id_Squad`) REFERENCES `squad` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_Quest_id_Guild` FOREIGN KEY (`id_Guild`) REFERENCES `guild` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `FK_User_id_Guild` FOREIGN KEY (`id_Guild`) REFERENCES `guild` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `weapon`
--
ALTER TABLE `weapon`
  ADD CONSTRAINT `FK_Weapon_id` FOREIGN KEY (`id`) REFERENCES `equipement` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `worker`
--
ALTER TABLE `worker`
  ADD CONSTRAINT `FK_Worker_id` FOREIGN KEY (`id`) REFERENCES `crew` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
