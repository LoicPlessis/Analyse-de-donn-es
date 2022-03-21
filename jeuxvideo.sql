-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8081
-- Generation Time: Mar 18, 2022 at 03:44 PM
-- Server version: 5.7.24
-- PHP Version: 7.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `jeuxvideo`
--

-- --------------------------------------------------------

--
-- Table structure for table `console`
--

CREATE TABLE `console` (
  `id_console` int(11) NOT NULL,
  `nom_console` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `console_jeux`
--

CREATE TABLE `console_jeux` (
  `id_console` int(11) NOT NULL,
  `id_jeux` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `editeur`
--

CREATE TABLE `editeur` (
  `id_editeur` int(11) NOT NULL,
  `nom_editeur` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `genre`
--

CREATE TABLE `genre` (
  `id_genre` int(11) NOT NULL,
  `nom_genre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `genre`
--

-- --------------------------------------------------------

--
-- Table structure for table `jeux`
--

CREATE TABLE `jeux` (
  `id_jeux` int(11) NOT NULL,
  `nom_jeu` varchar(50) NOT NULL,
  `annee` year(4) NOT NULL,
  `ventes` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `console`
--
ALTER TABLE `console`
  ADD PRIMARY KEY (`id_console`);

--
-- Indexes for table `console_jeux`
--
ALTER TABLE `console_jeux`
  ADD KEY `id_console` (`id_console`),
  ADD KEY `id_jeux` (`id_jeux`);

--
-- Indexes for table `editeur`
--
ALTER TABLE `editeur`
  ADD PRIMARY KEY (`id_editeur`);

-- --
-- -- Indexes for table `genre`
-- --
ALTER TABLE `genre`
  ADD PRIMARY KEY (`id_genre`);

--
-- Indexes for table `jeux`
--
ALTER TABLE `jeux`
  ADD PRIMARY KEY (`id_jeux`),
  -- ADD KEY `id_editeur` (`id_editeur`),
  -- ADD KEY `id_genre` (`id_genre`);

-- Création d'une

CREATE VIEW Best_Games AS
SELECT ventes, nom_jeu, annee
FROM jeux
WHERE ventes > 20 ;
SELECT * FROM Best_Games;
--
-- Procédure stockée
--

DELIMITER //
CREATE PROCEDURE proc
(IN var CHAR(50))
BEGIN
SELECT *
FROM jeux
WHERE annee =var;
END //
DELIMITER ;

--
-- Constraints for table `console_jeux`
--
-- ALTER TABLE `console_jeux`
--   ADD CONSTRAINT `console_jeux_ibfk_1` FOREIGN KEY (`id_console`) REFERENCES `console` (`id_console`),
--   ADD CONSTRAINT `console_jeux_ibfk_2` FOREIGN KEY (`id_jeux`) REFERENCES `jeux` (`id_jeux`);

--
-- Constraints for table `jeux`
--
-- ALTER TABLE `jeux`
--   ADD CONSTRAINT `jeux_ibfk_1` FOREIGN KEY (`id_editeur`) REFERENCES `editeur` (`id_editeur`),
--   ADD CONSTRAINT `jeux_ibfk_2` FOREIGN KEY (`id_genre`) REFERENCES `genre` (`id_genre`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
