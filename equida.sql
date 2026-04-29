-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3307
-- Généré le : mer. 29 avr. 2026 à 08:59
-- Version du serveur : 11.3.2-MariaDB
-- Version de PHP : 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `equida`
--

-- --------------------------------------------------------

--
-- Structure de la table `acheteur`
--

DROP TABLE IF EXISTS `acheteur`;
CREATE TABLE IF NOT EXISTS `acheteur` (
  `id` int(11) NOT NULL,
  `formation` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `acheteur`
--

INSERT INTO `acheteur` (`id`, `formation`) VALUES
(1, 'École vétérinaire'),
(2, 'Commerce international'),
(3, 'Gestion des haras'),
(4, 'Finance équine'),
(5, 'Marketing équin');

-- --------------------------------------------------------

--
-- Structure de la table `categvente`
--

DROP TABLE IF EXISTS `categvente`;
CREATE TABLE IF NOT EXISTS `categvente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `categvente`
--

INSERT INTO `categvente` (`id`, `libelle`) VALUES
(1, 'Enchères publiques'),
(2, 'Vente privée'),
(3, 'Vente online'),
(4, 'Vente sur invitation'),
(5, 'Vente flash');

-- --------------------------------------------------------

--
-- Structure de la table `cheval`
--

DROP TABLE IF EXISTS `cheval`;
CREATE TABLE IF NOT EXISTS `cheval` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) DEFAULT NULL,
  `sexe` char(1) DEFAULT NULL,
  `date_naissance` date DEFAULT NULL,
  `codeSire` varchar(50) DEFAULT NULL,
  `taille` varchar(50) DEFAULT NULL,
  `poids` varchar(50) DEFAULT NULL,
  `vendeur` int(11) DEFAULT NULL,
  `race_id` int(11) DEFAULT NULL,
  `pere_id` int(11) DEFAULT NULL,
  `mere_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `vendeur` (`vendeur`),
  KEY `race_id` (`race_id`),
  KEY `fk_pere` (`pere_id`),
  KEY `fk_mere` (`mere_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `cheval`
--

INSERT INTO `cheval` (`id`, `nom`, `sexe`, `date_naissance`, `codeSire`, `taille`, `poids`, `vendeur`, `race_id`, `pere_id`, `mere_id`) VALUES
(1, 'Éclair', 'M', '2022-03-15', '', '', '', 1, 1, 2, 3),
(2, 'Foudre', 'F', '2021-05-20', '', '', '', 2, 2, 4, 3),
(3, 'Vent', 'M', '2020-01-01', '', '', '', 3, 3, 4, 1),
(4, 'Neige', 'F', '2019-07-07', '', '', '', 4, 4, 5, 2),
(5, 'Soleil', 'M', '2023-02-22', '', '', '', 5, 5, 2, 1),
(6, 'test', NULL, '2025-10-09', NULL, NULL, NULL, NULL, 4, NULL, NULL),
(7, 'test', NULL, '2025-10-09', NULL, NULL, NULL, NULL, 4, NULL, NULL),
(8, 'test', NULL, '2025-10-08', NULL, NULL, NULL, NULL, 4, NULL, NULL),
(9, 'test2', NULL, '2025-10-08', NULL, NULL, NULL, NULL, 4, NULL, NULL),
(10, 'test2', NULL, '2025-10-08', NULL, NULL, NULL, NULL, 4, NULL, NULL),
(11, 'test2', NULL, '2025-10-08', NULL, NULL, NULL, NULL, 4, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `chevalcourse`
--

DROP TABLE IF EXISTS `chevalcourse`;
CREATE TABLE IF NOT EXISTS `chevalcourse` (
  `cheval_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `position` int(11) NOT NULL,
  `temps` time(6) DEFAULT NULL,
  PRIMARY KEY (`cheval_id`,`course_id`),
  KEY `course_id` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `chevalcourse`
--

INSERT INTO `chevalcourse` (`cheval_id`, `course_id`, `position`, `temps`) VALUES
(1, 1, 1, '09:50:35.000000'),
(2, 2, 3, '09:50:35.000000'),
(3, 3, 4, '09:50:35.000000'),
(4, 4, 5, '09:50:35.000000'),
(5, 5, 2, '09:50:35.000000');

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

DROP TABLE IF EXISTS `client`;
CREATE TABLE IF NOT EXISTS `client` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titre` varchar(10) DEFAULT NULL,
  `nom` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `adressePartie1` varchar(255) DEFAULT NULL,
  `adressePartie2` varchar(255) DEFAULT NULL,
  `copos` varchar(10) DEFAULT NULL,
  `ville` varchar(100) DEFAULT NULL,
  `pays` char(3) DEFAULT NULL,
  `adresseMessagerie` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pays` (`pays`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `client`
--

INSERT INTO `client` (`id`, `titre`, `nom`, `prenom`, `adressePartie1`, `adressePartie2`, `copos`, `ville`, `pays`, `adresseMessagerie`) VALUES
(1, 'M.', 'Dupont', 'Jean', '12 rue A', '', '75000', 'Paris', 'FRA', 'jean.dupont@example.com'),
(2, 'Mme', 'Martin', 'Claire', '5 rue B', '', '69000', 'Lyon', 'FRA', 'claire.martin@example.com'),
(3, 'Dr', 'Smith', 'John', '77 Main St', 'Apt 3', '10001', 'New York', 'USA', 'john.smith@example.com'),
(4, 'M.', 'Müller', 'Hans', 'Berliner Str. 10', '', '10115', 'Berlin', 'GER', 'hans.muller@example.com'),
(5, 'Mme', 'Rossi', 'Giulia', 'Via Roma 22', '', '00100', 'Rome', 'ITA', 'giulia.rossi@example.com');

-- --------------------------------------------------------

--
-- Structure de la table `course`
--

DROP TABLE IF EXISTS `course`;
CREATE TABLE IF NOT EXISTS `course` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) DEFAULT NULL,
  `lieu` varchar(100) DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `course`
--

INSERT INTO `course` (`id`, `nom`, `lieu`, `date`) VALUES
(1, 'Grand Prix', 'Chantilly', '2025-09-01'),
(2, 'Derby', 'Longchamp', '2025-09-15'),
(3, 'Sprint', 'Deauville', '2025-10-01'),
(4, 'Endurance', 'Vichy', '2025-10-20'),
(5, 'Flash Cup', 'Marseille', '2025-11-05');

-- --------------------------------------------------------

--
-- Structure de la table `enchere`
--

DROP TABLE IF EXISTS `enchere`;
CREATE TABLE IF NOT EXISTS `enchere` (
  `numero` int(11) NOT NULL AUTO_INCREMENT,
  `montant` decimal(10,2) DEFAULT NULL,
  `acheteur_id` int(11) DEFAULT NULL,
  `lot_numLot` int(11) DEFAULT NULL,
  PRIMARY KEY (`numero`),
  KEY `acheteur_id` (`acheteur_id`),
  KEY `lot_numLot` (`lot_numLot`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `enchere`
--

INSERT INTO `enchere` (`numero`, `montant`, `acheteur_id`, `lot_numLot`) VALUES
(1, 5500.00, 1, 1),
(2, 7600.00, 2, 2),
(3, 6700.00, 3, 3),
(4, 8200.00, 4, 4),
(5, 9100.00, 5, 5);

-- --------------------------------------------------------

--
-- Structure de la table `lieu`
--

DROP TABLE IF EXISTS `lieu`;
CREATE TABLE IF NOT EXISTS `lieu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ville` varchar(100) DEFAULT NULL,
  `nbBoxes` int(11) DEFAULT NULL,
  `commentaires` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `lieu`
--

INSERT INTO `lieu` (`id`, `ville`, `nbBoxes`, `commentaires`) VALUES
(1, 'Paris', 20, 'Grand centre'),
(2, 'Lyon', 15, 'Accès facile'),
(3, 'Bordeaux', 25, 'Boxes spacieux'),
(4, 'Toulouse', 10, 'Petit mais pratique'),
(5, 'Nice', 12, 'Proche de la mer');

-- --------------------------------------------------------

--
-- Structure de la table `lot`
--

DROP TABLE IF EXISTS `lot`;
CREATE TABLE IF NOT EXISTS `lot` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prixDepart` decimal(10,2) DEFAULT NULL,
  `numSire` varchar(50) DEFAULT NULL,
  `vente_id` int(11) DEFAULT NULL,
  `cheval_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `vente_id` (`vente_id`),
  KEY `cheval_id` (`cheval_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `lot`
--

INSERT INTO `lot` (`id`, `prixDepart`, `numSire`, `vente_id`, `cheval_id`) VALUES
(1, 5000.00, 'S1234', 1, 1),
(2, 7500.00, 'S2345', 1, 2),
(3, 6500.00, 'S3456', 2, 3),
(4, 8000.00, 'S4567', 3, 4),
(5, 9000.00, 'S5678', 4, 5);

-- --------------------------------------------------------

--
-- Structure de la table `pays`
--

DROP TABLE IF EXISTS `pays`;
CREATE TABLE IF NOT EXISTS `pays` (
  `code` char(3) NOT NULL,
  `nom` varchar(100) NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `pays`
--

INSERT INTO `pays` (`code`, `nom`) VALUES
('ESP', 'Spain'),
('FRA', 'France'),
('GER', 'Germany'),
('ITA', 'Italy'),
('USA', 'United States');

-- --------------------------------------------------------

--
-- Structure de la table `race`
--

DROP TABLE IF EXISTS `race`;
CREATE TABLE IF NOT EXISTS `race` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` text DEFAULT NULL,
  `libelle` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `race`
--

INSERT INTO `race` (`id`, `nom`, `libelle`) VALUES
(1, 'Race rapide', 'Pur-sang'),
(2, 'Bonne endurance', 'Arabe'),
(3, 'Petit gabarit', 'Poney'),
(4, 'Cheval de trait', 'Percheron'),
(5, 'Mixte', 'Croisé');

-- --------------------------------------------------------

--
-- Structure de la table `vendeur`
--

DROP TABLE IF EXISTS `vendeur`;
CREATE TABLE IF NOT EXISTS `vendeur` (
  `id` int(11) NOT NULL,
  `nom` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `vendeur`
--

INSERT INTO `vendeur` (`id`, `nom`) VALUES
(1, 'Lucas'),
(2, 'Marie'),
(3, 'Marc'),
(4, 'Tom'),
(5, 'June');

-- --------------------------------------------------------

--
-- Structure de la table `vente`
--

DROP TABLE IF EXISTS `vente`;
CREATE TABLE IF NOT EXISTS `vente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `dateDebutVente` date DEFAULT NULL,
  `dateFinVente` date DEFAULT NULL,
  `dateDebutInscription` date DEFAULT NULL,
  `dateEnvoiMessage` date DEFAULT NULL,
  `objetMessage` varchar(255) DEFAULT NULL,
  `corpsMessage` text DEFAULT NULL,
  `lieu_id` int(11) DEFAULT NULL,
  `categvente_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lieu_id` (`lieu_id`),
  KEY `categvente_id` (`categvente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `vente`
--

INSERT INTO `vente` (`id`, `nom`, `dateDebutVente`, `dateFinVente`, `dateDebutInscription`, `dateEnvoiMessage`, `objetMessage`, `corpsMessage`, `lieu_id`, `categvente_id`) VALUES
(1, 'Vente Automne', '2025-10-01', '2025-10-05', '2025-09-01', '2025-09-15', 'Infos Vente Automne', 'Détails de la vente.', 1, 1),
(2, 'Vente Online', '2025-11-10', '2025-11-15', '2025-10-01', '2025-10-20', 'Infos Vente Online', 'En ligne uniquement.', 2, 3),
(3, 'Vente Privée', '2025-12-01', '2025-12-03', '2025-11-01', '2025-11-10', 'Privée', 'Sur invitation.', 3, 2),
(4, 'Vente Hiver', '2026-01-10', '2026-01-15', '2025-12-01', '2025-12-20', 'Infos Hiver', 'Détails ici.', 4, 1),
(5, 'Vente Flash', '2026-02-01', '2026-02-01', '2026-01-01', '2026-01-20', 'Flash info', 'Seulement un jour.', 5, 5),
(6, 'test', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(7, 'test2', '2025-10-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(8, 'test3', '2025-10-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10, 'test4', '2025-10-12', NULL, NULL, NULL, NULL, NULL, 4, NULL);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `acheteur`
--
ALTER TABLE `acheteur`
  ADD CONSTRAINT `acheteur_ibfk_1` FOREIGN KEY (`id`) REFERENCES `client` (`id`);

--
-- Contraintes pour la table `cheval`
--
ALTER TABLE `cheval`
  ADD CONSTRAINT `cheval_ibfk_1` FOREIGN KEY (`vendeur`) REFERENCES `vendeur` (`id`),
  ADD CONSTRAINT `cheval_ibfk_2` FOREIGN KEY (`race_id`) REFERENCES `race` (`id`),
  ADD CONSTRAINT `fk_mere` FOREIGN KEY (`mere_id`) REFERENCES `cheval` (`id`),
  ADD CONSTRAINT `fk_pere` FOREIGN KEY (`pere_id`) REFERENCES `cheval` (`id`);

--
-- Contraintes pour la table `chevalcourse`
--
ALTER TABLE `chevalcourse`
  ADD CONSTRAINT `chevalcourse_ibfk_1` FOREIGN KEY (`cheval_id`) REFERENCES `cheval` (`id`),
  ADD CONSTRAINT `chevalcourse_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`);

--
-- Contraintes pour la table `client`
--
ALTER TABLE `client`
  ADD CONSTRAINT `client_ibfk_1` FOREIGN KEY (`pays`) REFERENCES `pays` (`code`);

--
-- Contraintes pour la table `enchere`
--
ALTER TABLE `enchere`
  ADD CONSTRAINT `enchere_ibfk_1` FOREIGN KEY (`acheteur_id`) REFERENCES `acheteur` (`id`),
  ADD CONSTRAINT `enchere_ibfk_2` FOREIGN KEY (`lot_numLot`) REFERENCES `lot` (`id`);

--
-- Contraintes pour la table `lot`
--
ALTER TABLE `lot`
  ADD CONSTRAINT `fk_lot_cheval` FOREIGN KEY (`cheval_id`) REFERENCES `cheval` (`id`),
  ADD CONSTRAINT `lot_ibfk_1` FOREIGN KEY (`vente_id`) REFERENCES `vente` (`id`),
  ADD CONSTRAINT `lot_ibfk_2` FOREIGN KEY (`cheval_id`) REFERENCES `cheval` (`id`);

--
-- Contraintes pour la table `vendeur`
--
ALTER TABLE `vendeur`
  ADD CONSTRAINT `vendeur_ibfk_1` FOREIGN KEY (`id`) REFERENCES `client` (`id`);

--
-- Contraintes pour la table `vente`
--
ALTER TABLE `vente`
  ADD CONSTRAINT `vente_ibfk_1` FOREIGN KEY (`lieu_id`) REFERENCES `lieu` (`id`),
  ADD CONSTRAINT `vente_ibfk_2` FOREIGN KEY (`categvente_id`) REFERENCES `categvente` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
