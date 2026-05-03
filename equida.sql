-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3307
-- Généré le : dim. 03 mai 2026 à 22:26
-- Version du serveur : 11.5.2-MariaDB
-- Version de PHP : 8.4.0

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
(21, 'Gestion des haras'),
(22, 'Finance équine'),
(23, 'Marketing équin'),
(24, 'École vétérinaire'),
(25, 'Commerce international'),
(26, 'Droit équin'),
(27, 'Élevage et sélection'),
(28, 'Gestion sportive'),
(29, 'Agronomie'),
(30, 'Médecine vétérinaire'),
(31, 'Économie agricole'),
(32, 'Zootechnie'),
(33, 'Commerce du cheval'),
(34, 'Management sportif'),
(35, 'Nutrition équine'),
(36, 'Biomécanique'),
(37, 'Génétique équine'),
(38, 'Psychologie animale'),
(39, 'Réhabilitation équine'),
(40, 'Ostéopathie équine'),
(41, 'Maréchalerie'),
(42, 'Éthologie'),
(43, 'Podologie équine'),
(44, 'Kinésithérapie équine'),
(45, 'Acupuncture équine'),
(46, 'Chiropractie équine'),
(47, 'Homéopathie'),
(48, 'Phytothérapie'),
(49, 'Aromathérapie équine'),
(50, 'Bien-être animal');

-- --------------------------------------------------------

--
-- Structure de la table `categvente`
--

DROP TABLE IF EXISTS `categvente`;
CREATE TABLE IF NOT EXISTS `categvente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `categvente`
--

INSERT INTO `categvente` (`id`, `libelle`) VALUES
(1, 'Enchères publiques'),
(2, 'Vente privée'),
(3, 'Vente online'),
(4, 'Vente sur invitation'),
(5, 'Vente flash'),
(6, 'Vente de prestige'),
(7, 'Vente de yearlings'),
(8, 'Vente de chevaux de sport'),
(9, 'Vente de poulinières'),
(10, 'Vente de reproducteurs');

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
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `cheval`
--

INSERT INTO `cheval` (`id`, `nom`, `sexe`, `date_naissance`, `codeSire`, `taille`, `poids`, `vendeur`, `race_id`, `pere_id`, `mere_id`) VALUES
(1, 'Éclair du Nord', 'M', '2018-03-15', '1A2B3C', '168', '520', 1, 1, 17, 10),
(2, 'Tempête Dorée', 'F', '2019-05-20', '2B3C4D', '162', '480', 2, 2, NULL, NULL),
(3, 'Vent d Ouest', 'M', '2020-01-10', '3C4D5E', '170', '550', 3, 3, NULL, NULL),
(4, 'Neige Éternelle', 'F', '2017-07-07', '4D5E6F', '160', '460', 4, 4, NULL, NULL),
(5, 'Soleil Levant', 'M', '2021-02-22', '5E6F7G', '165', '510', 5, 5, NULL, NULL),
(6, 'Aurore Boréale', 'F', '2016-11-30', '6F7G8H', '163', '475', 6, 6, NULL, NULL),
(7, 'Tonnerre Noir', 'M', '2019-08-14', '7G8H9I', '172', '560', 7, 1, NULL, NULL),
(8, 'Cascade Bleue', 'F', '2020-04-05', '8H9I1J', '161', '470', 8, 2, NULL, NULL),
(9, 'Mistral Fougueux', 'M', '2018-12-20', '9I1J2K', '169', '535', 9, 3, NULL, NULL),
(10, 'Prairie Sauvage', 'F', '2022-06-18', '1J2K3L', '158', '455', 10, 4, NULL, NULL),
(11, 'Foudre Blanche', 'M', '2017-09-25', '2K3L4M', '171', '545', 11, 5, NULL, NULL),
(12, 'Rivière d Argent', 'F', '2021-03-12', '3L4M5N', '164', '485', 12, 6, NULL, NULL),
(13, 'Orage Printanier', 'M', '2019-07-08', '4M5N6O', '167', '525', 13, 7, NULL, NULL),
(14, 'Brume Matinale', 'F', '2020-10-30', '5N6O7P', '159', '462', 14, 8, NULL, NULL),
(15, 'Cyclone Express', 'M', '2018-05-17', '6O7P8Q', '173', '570', 15, 9, NULL, NULL),
(16, 'Étoile Filante', 'F', '2022-01-28', '7P8Q9R', '162', '478', 16, 10, NULL, NULL),
(17, 'Vallon Fleuri', 'M', '2017-11-14', '8Q9R1S', '166', '515', 17, 11, NULL, NULL),
(18, 'Perle Rare', 'F', '2021-08-06', '9R1S2T', '160', '468', 18, 12, NULL, NULL),
(19, 'Galop d Or', 'M', '2020-02-19', '1S2T3U', '168', '530', 19, 13, NULL, NULL),
(20, 'Horizon Lointain', 'F', '2019-12-03', '2T3U4V', '163', '482', 20, 14, NULL, NULL),
(21, 'Comète Rapide', 'M', '2018-06-22', '3U4V5W', '170', '548', 1, 15, NULL, NULL),
(22, 'Dune de Sable', 'F', '2022-04-15', '4V5W6X', '161', '472', 2, 16, NULL, NULL),
(23, 'Flèche d Argent', 'M', '2019-10-09', '5W6X7Y', '174', '565', 3, 17, NULL, NULL),
(24, 'Mousson Tropicale', 'F', '2020-07-27', '6X7Y8Z', '159', '458', 4, 18, NULL, NULL),
(25, 'Falaise Dorée', 'M', '2017-03-31', '7Y8Z9A', '167', '528', 5, 19, NULL, NULL),
(26, 'Marée Haute', 'F', '2021-11-16', '8Z9A1B', '162', '475', 6, 20, NULL, NULL),
(27, 'Zéphyr d Été', 'M', '2018-09-04', '9A1B2C', '169', '538', 7, 1, NULL, NULL),
(28, 'Lune de Miel', 'F', '2022-02-11', '1B2C3D', '160', '465', 8, 2, NULL, NULL),
(29, 'Rapide comme l Éclair', 'M', '2019-04-26', '2C3D4E', '171', '552', 9, 3, NULL, NULL),
(30, 'Grâce Naturelle', 'F', '2020-08-13', '3D4E5F', '163', '480', 10, 4, NULL, NULL),
(31, 'Titan des Plaines', 'M', '2018-01-20', '4E5F6G', '172', '558', 11, 5, 1, 2),
(32, 'Magnolia en Fleurs', 'F', '2021-06-14', '5F6G7H', '161', '470', 12, 6, 3, 4),
(33, 'Conquistador', 'M', '2019-03-08', '6G7H8I', '173', '562', 13, 7, 5, 6),
(34, 'Belle Époque', 'F', '2020-11-22', '7H8I9J', '162', '477', 14, 8, 7, 8),
(35, 'Diamant Noir', 'M', '2017-07-16', '8I9J1K', '170', '545', 15, 9, 9, 10),
(36, 'Aurore Printanière', 'F', '2022-03-29', '9J1K2L', '160', '468', 16, 10, 11, 12),
(37, 'Phénix Ardent', 'M', '2018-10-05', '1K2L3M', '168', '532', 17, 11, 13, 14),
(38, 'Sérénité Pure', 'F', '2021-01-18', '2L3M4N', '163', '483', 18, 12, 15, 16),
(39, 'Victoire Éclatante', 'M', '2019-08-31', '3M4N5O', '169', '540', 19, 13, 17, 18),
(40, 'Jade Impériale', 'F', '2020-05-07', '4N5O6P', '161', '472', 20, 14, 19, 20),
(41, 'Roi des Steppes', 'M', '2017-12-23', '5O6P7Q', '174', '568', 1, 15, 21, 22),
(42, 'Mélodie du Vent', 'F', '2022-07-10', '6P7Q8R', '159', '460', 2, 16, 23, 24),
(43, 'Atlas Fougueux', 'M', '2018-04-17', '7Q8R9S', '171', '550', 3, 17, 25, 26),
(44, 'Camomille Douce', 'F', '2021-09-28', '8R9S1T', '160', '466', 4, 18, 27, 28),
(45, 'Intrépide', 'M', '2019-02-14', '9S1T2U', '167', '525', 5, 19, 29, 30),
(46, 'Lumière du Jour', 'F', '2020-06-30', '1T2U3V', '162', '478', 6, 20, 1, 2),
(47, 'Maestro', 'M', '2017-10-08', '2U3V4W', '170', '543', 7, 1, 3, 4),
(48, 'Nuit Étoilée', 'F', '2022-08-21', '3V4W5X', '161', '471', 8, 2, 5, 6),
(49, 'Océan Profond', 'M', '2018-07-15', '4W5X6Y', '172', '555', 9, 3, 7, 8),
(50, 'Plaisir d Amour', 'F', '2021-04-02', '5X6Y7Z', '163', '481', 10, 4, 9, 10),
(51, 'Quantum', 'M', '2019-11-19', '6Y7Z8A', '168', '535', 11, 5, 11, 12),
(52, 'Renaissance', 'F', '2020-09-06', '7Z8A9B', '160', '467', 12, 6, 13, 14),
(53, 'Sagesse Dorée', 'M', '2017-05-24', '8A9B1C', '171', '548', 13, 7, 15, 16),
(54, 'Tendresse', 'F', '2022-06-12', '9B1C2D', '159', '463', 14, 8, 17, 18),
(55, 'Univers', 'M', '2018-08-28', '1C2D3E', '169', '537', 15, 9, 19, 20),
(56, 'Valse Viennoise', 'F', '2021-02-15', '2D3E4F', '162', '476', 16, 10, 21, 22),
(57, 'Windsor', 'M', '2019-06-03', '3E4F5G', '173', '560', 17, 11, 23, 24),
(58, 'Xanadu', 'F', '2020-12-17', '4F5G6H', '161', '469', 18, 12, 25, 26),
(59, 'Yankee', 'M', '2017-04-09', '5G6H7I', '170', '544', 19, 13, 27, 28),
(60, 'Zara', 'F', '2022-05-26', '6H7I8J', '160', '465', 20, 14, 29, 30);

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
(1, 1, 1, '01:45:32.000000'),
(2, 1, 3, '01:46:10.000000'),
(3, 1, 5, '01:46:55.000000'),
(4, 2, 2, '01:52:18.000000'),
(5, 2, 1, '01:51:45.000000'),
(6, 2, 4, '01:53:02.000000'),
(7, 3, 1, '04:12:33.000000'),
(8, 3, 2, '04:13:10.000000'),
(9, 3, 6, '04:15:22.000000'),
(10, 4, 3, '01:15:44.000000'),
(11, 4, 1, '01:14:58.000000'),
(12, 4, 2, '01:15:20.000000'),
(13, 5, 2, '02:28:15.000000'),
(14, 5, 4, '02:29:01.000000'),
(15, 5, 1, '02:27:48.000000'),
(16, 6, 1, '01:48:22.000000'),
(17, 6, 3, '01:49:05.000000'),
(18, 6, 5, '01:49:55.000000'),
(19, 7, 2, '01:12:38.000000'),
(20, 7, 1, '01:12:15.000000'),
(21, 7, 4, '01:13:02.000000'),
(22, 8, 1, '01:35:44.000000'),
(23, 8, 2, '01:36:10.000000'),
(24, 8, 3, '01:36:45.000000'),
(25, 9, 3, '02:05:22.000000'),
(26, 9, 1, '02:04:58.000000'),
(27, 9, 2, '02:05:10.000000'),
(28, 10, 1, '02:32:18.000000'),
(29, 10, 4, '02:33:05.000000'),
(30, 10, 2, '02:32:45.000000'),
(31, 11, 2, '02:15:30.000000'),
(32, 11, 1, '02:15:02.000000'),
(33, 11, 3, '02:15:58.000000'),
(34, 12, 1, '01:42:15.000000'),
(35, 12, 3, '01:43:00.000000'),
(36, 12, 2, '01:42:40.000000'),
(37, 13, 2, '01:55:22.000000'),
(38, 13, 1, '01:54:58.000000'),
(39, 13, 4, '01:56:05.000000'),
(40, 14, 1, '03:22:15.000000'),
(41, 14, 2, '03:23:00.000000'),
(42, 14, 3, '03:23:45.000000'),
(43, 15, 3, '01:10:22.000000'),
(44, 15, 1, '01:09:58.000000'),
(45, 15, 2, '01:10:10.000000'),
(46, 16, 1, '01:48:15.000000'),
(47, 16, 2, '01:48:50.000000'),
(48, 16, 4, '01:49:35.000000'),
(49, 17, 2, '01:52:22.000000'),
(50, 17, 1, '01:51:58.000000'),
(51, 17, 3, '01:52:45.000000'),
(52, 18, 1, '01:44:15.000000'),
(53, 18, 3, '01:45:00.000000'),
(54, 18, 2, '01:44:40.000000'),
(55, 19, 2, '01:58:22.000000'),
(56, 19, 1, '01:57:58.000000'),
(57, 19, 4, '01:59:05.000000'),
(58, 20, 1, '01:38:15.000000'),
(59, 20, 2, '01:38:50.000000'),
(60, 20, 3, '01:39:25.000000');

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
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `client`
--

INSERT INTO `client` (`id`, `titre`, `nom`, `prenom`, `adressePartie1`, `adressePartie2`, `copos`, `ville`, `pays`, `adresseMessagerie`) VALUES
(1, 'M.', 'Dupont', 'Jean', '12 rue de la Paix', '', '75001', 'Paris', 'FRA', 'jean.dupont@mail.fr'),
(2, 'Mme', 'Martin', 'Claire', '5 avenue Victor Hugo', 'Apt 12', '69002', 'Lyon', 'FRA', 'claire.martin@mail.fr'),
(3, 'M.', 'Smith', 'John', '10 Baker Street', '', 'EC1A 1BB', 'Londres', 'GBR', 'john.smith@mail.co.uk'),
(4, 'Dr', 'Müller', 'Hans', 'Berliner Str. 10', '', '10115', 'Berlin', 'GER', 'hans.muller@mail.de'),
(5, 'Mme', 'Rossi', 'Giulia', 'Via Roma 22', '', '00100', 'Rome', 'ITA', 'giulia.rossi@mail.it'),
(6, 'M.', 'Garcia', 'Carlos', 'Calle Mayor 5', '', '28001', 'Madrid', 'ESP', 'carlos.garcia@mail.es'),
(7, 'Mme', 'Dubois', 'Marie', '8 rue du Moulin', '', '33000', 'Bordeaux', 'FRA', 'marie.dubois@mail.fr'),
(8, 'M.', 'Laurent', 'Pierre', '45 avenue des Fleurs', '', '13001', 'Marseille', 'FRA', 'pierre.laurent@mail.fr'),
(9, 'Mme', 'Bernard', 'Sophie', '3 place Bellecour', '', '69001', 'Lyon', 'FRA', 'sophie.bernard@mail.fr'),
(10, 'M.', 'Thomas', 'Luc', '78 boulevard Haussmann', '', '75008', 'Paris', 'FRA', 'luc.thomas@mail.fr'),
(11, 'M.', 'Wilson', 'James', '25 Oxford Street', '', 'W1D 2HX', 'Londres', 'GBR', 'james.wilson@mail.co.uk'),
(12, 'Mme', 'O Brien', 'Siobhan', '14 Grafton Street', '', 'D02', 'Dublin', 'IRL', 'siobhan.obrien@mail.ie'),
(13, 'M.', 'Johnson', 'Robert', '500 5th Avenue', 'Apt 30', '10110', 'New York', 'USA', 'robert.johnson@mail.com'),
(14, 'Mme', 'Tanaka', 'Yuki', '1-2-3 Shibuya', '', '150-0002', 'Tokyo', 'JPN', 'yuki.tanaka@mail.jp'),
(15, 'M.', 'Al Maktoum', 'Rashid', 'Sheikh Zayed Road', 'Floor 12', '00000', 'Dubaï', 'UAE', 'rashid.almaktoum@mail.ae'),
(16, 'Mme', 'Petit', 'Anne', '12 rue des Lilas', '', '31000', 'Toulouse', 'FRA', 'anne.petit@mail.fr'),
(17, 'M.', 'Moreau', 'François', '67 rue Victor Hugo', '', '44000', 'Nantes', 'FRA', 'francois.moreau@mail.fr'),
(18, 'Mme', 'Simon', 'Élise', '9 place du Général', '', '67000', 'Strasbourg', 'FRA', 'elise.simon@mail.fr'),
(19, 'M.', 'Michel', 'Benoît', '34 avenue de la Gare', '', '34000', 'Montpellier', 'FRA', 'benoit.michel@mail.fr'),
(20, 'Mme', 'Leroy', 'Camille', '56 rue de la Mer', '', '06000', 'Nice', 'FRA', 'camille.leroy@mail.fr'),
(21, 'M.', 'Roux', 'Julien', '23 avenue du Général', '', '35000', 'Rennes', 'FRA', 'julien.roux@mail.fr'),
(22, 'Mme', 'David', 'Isabelle', '89 rue Caponière', '', '14000', 'Caen', 'FRA', 'isabelle.david@mail.fr'),
(23, 'M.', 'Bertrand', 'Antoine', '45 quai de la Bourse', '', '76000', 'Rouen', 'FRA', 'antoine.bertrand@mail.fr'),
(24, 'Mme', 'Morin', 'Chloé', '12 avenue de la Plage', '', '64200', 'Biarritz', 'FRA', 'chloe.morin@mail.fr'),
(25, 'M.', 'Fournier', 'Maxime', '78 rue du Commerce', '', '75015', 'Paris', 'FRA', 'maxime.fournier@mail.fr'),
(26, 'Mme', 'Girard', 'Lucie', '34 boulevard de la Liberté', '', '59000', 'Lille', 'FRA', 'lucie.girard@mail.fr'),
(27, 'M.', 'Bonnet', 'Alexis', '23 rue Sainte-Catherine', '', '33000', 'Bordeaux', 'FRA', 'alexis.bonnet@mail.fr'),
(28, 'Mme', 'Fontaine', 'Emma', '56 avenue Foch', '', '57000', 'Metz', 'FRA', 'emma.fontaine@mail.fr'),
(29, 'M.', 'Chevalier', 'Hugo', '9 rue de la Liberté', '', '21000', 'Dijon', 'FRA', 'hugo.chevalier@mail.fr'),
(30, 'Mme', 'Robin', 'Léa', '45 allées Jean Jaurès', '', '31000', 'Toulouse', 'FRA', 'lea.robin@mail.fr'),
(31, 'M.', 'Wolf', 'Stefan', 'Hauptstraße 45', '', '80331', 'Munich', 'GER', 'stefan.wolf@mail.de'),
(32, 'Mme', 'Ferrari', 'Laura', 'Via Garibaldi 8', '', '20121', 'Milan', 'ITA', 'laura.ferrari@mail.it'),
(33, 'M.', 'González', 'Miguel', 'Gran Vía 30', '', '08007', 'Barcelone', 'ESP', 'miguel.gonzalez@mail.es'),
(34, 'Mme', 'Vandenberg', 'Nathalie', 'Rue de la Loi 10', '', '1000', 'Bruxelles', 'BEL', 'nathalie.vandenberg@mail.be'),
(35, 'M.', 'Fischer', 'Klaus', 'Bahnhofstrasse 12', '', '8001', 'Zurich', 'CHE', 'klaus.fischer@mail.ch'),
(36, 'Mme', 'Brown', 'Emily', '42 King Street', '', 'SW1A 1AA', 'Londres', 'GBR', 'emily.brown@mail.co.uk'),
(37, 'M.', 'Murphy', 'Patrick', 'O Connell Street 5', '', 'D01', 'Dublin', 'IRL', 'patrick.murphy@mail.ie'),
(38, 'Mme', 'Davis', 'Jennifer', '123 Main Street', 'Suite 5', '90001', 'Los Angeles', 'USA', 'jennifer.davis@mail.com'),
(39, 'M.', 'Suzuki', 'Kenji', '2-5-1 Ginza', '', '104-0061', 'Tokyo', 'JPN', 'kenji.suzuki@mail.jp'),
(40, 'Mme', 'Al Nahyan', 'Fatima', 'Corniche Road', '', '00000', 'Abu Dhabi', 'UAE', 'fatima.alnahyan@mail.ae'),
(41, 'M.', 'Martinez', 'Ricardo', 'Av. Corrientes 1234', '', 'C1043', 'Buenos Aires', 'ARG', 'ricardo.martinez@mail.ar'),
(42, 'Mme', 'Silva', 'Ana', 'Rua Augusta 200', '', '01310', 'São Paulo', 'BRA', 'ana.silva@mail.br'),
(43, 'M.', 'Tremblay', 'Michel', '1000 rue Sherbrooke', '', 'H3A 1G4', 'Montréal', 'CAN', 'michel.tremblay@mail.ca'),
(44, 'Mme', 'Lefevre', 'Pauline', '12 rue des Arts', '', '75004', 'Paris', 'FRA', 'pauline.lefevre@mail.fr'),
(45, 'M.', 'Mercier', 'Théo', '34 place des Vosges', '', '75003', 'Paris', 'FRA', 'theo.mercier@mail.fr'),
(46, 'Mme', 'Dupuis', 'Marion', '67 rue de la Croix', '', '69003', 'Lyon', 'FRA', 'marion.dupuis@mail.fr'),
(47, 'M.', 'Blanc', 'Sébastien', '90 avenue du Prado', '', '13008', 'Marseille', 'FRA', 'sebastien.blanc@mail.fr'),
(48, 'Mme', 'Guerin', 'Anaïs', '23 place Stanislas', '', '54000', 'Nancy', 'FRA', 'anais.guerin@mail.fr'),
(49, 'M.', 'Caron', 'Nicolas', '45 rue du Palais', '', '51100', 'Reims', 'FRA', 'nicolas.caron@mail.fr'),
(50, 'Mme', 'Renard', 'Justine', '78 quai des Chartrons', '', '33000', 'Bordeaux', 'FRA', 'justine.renard@mail.fr');

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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `course`
--

INSERT INTO `course` (`id`, `nom`, `lieu`, `date`) VALUES
(1, 'Grand Prix de Paris', 'Longchamp', '2024-10-06'),
(2, 'Prix de Diane', 'Chantilly', '2024-06-09'),
(3, 'Grand Steeple-Chase', 'Auteuil', '2024-05-19'),
(4, 'Prix d Amérique', 'Vincennes', '2024-01-28'),
(5, 'Qatar Prix de l Arc de Triomphe', 'Longchamp', '2024-10-05'),
(6, 'Grand Prix de Deauville', 'Deauville', '2024-08-25'),
(7, 'Prix Morny', 'Deauville', '2024-08-18'),
(8, 'Prix Jean Prat', 'Chantilly', '2024-07-07'),
(9, 'Grand Prix de Saint-Cloud', 'Saint-Cloud', '2024-06-30'),
(10, 'Prix du Jockey Club', 'Chantilly', '2024-06-02'),
(11, 'Prix Vermeille', 'Longchamp', '2024-09-14'),
(12, 'Prix Marcel Boussac', 'Longchamp', '2024-10-06'),
(13, 'Grand Prix de Lyon', 'Lyon', '2024-09-01'),
(14, 'Prix du Cadran', 'Longchamp', '2024-10-05'),
(15, 'Prix de la Forêt', 'Longchamp', '2024-10-06'),
(16, 'Grand Prix de Bordeaux', 'Bordeaux', '2024-07-14'),
(17, 'Prix de Normandie', 'Caen', '2024-08-15'),
(18, 'Prix des Champions', 'Marseille', '2024-09-22'),
(19, 'Grand Prix de l Ouest', 'Rennes', '2024-10-13'),
(20, 'Prix des Étoiles', 'Nice', '2024-11-03');

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
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `enchere`
--

INSERT INTO `enchere` (`numero`, `montant`, `acheteur_id`, `lot_numLot`) VALUES
(1, 17500.00, 21, 1),
(2, 25000.00, 22, 2),
(3, 21000.00, 23, 3),
(4, 40000.00, 24, 4),
(5, 32000.00, 25, 5),
(6, 14500.00, 26, 6),
(7, 52000.00, 27, 7),
(8, 37500.00, 28, 8),
(9, 22000.00, 29, 9),
(10, 29000.00, 30, 10),
(11, 63000.00, 31, 11),
(12, 47500.00, 32, 12),
(13, 44000.00, 33, 13),
(14, 19000.00, 34, 14),
(15, 85000.00, 35, 15),
(16, 32000.00, 36, 16),
(17, 38500.00, 37, 17),
(18, 24500.00, 38, 18),
(19, 55000.00, 39, 19),
(20, 42500.00, 40, 20),
(21, 75000.00, 21, 21),
(22, 33500.00, 22, 22),
(23, 51000.00, 23, 23),
(24, 21000.00, 24, 24),
(25, 60000.00, 25, 25),
(26, 102000.00, 26, 26),
(27, 85000.00, 27, 27),
(28, 71000.00, 28, 28),
(29, 110000.00, 29, 29),
(30, 145000.00, 30, 30),
(31, 28000.00, 31, 31),
(32, 36000.00, 32, 32),
(33, 31500.00, 33, 33),
(34, 22000.00, 34, 34),
(35, 49000.00, 35, 35),
(36, 16500.00, 36, 36),
(37, 27000.00, 37, 37),
(38, 20000.00, 38, 38),
(39, 44000.00, 39, 39),
(40, 34000.00, 40, 40),
(41, 65000.00, 21, 41),
(42, 55500.00, 22, 42),
(43, 78000.00, 23, 43),
(44, 41000.00, 24, 44),
(45, 92000.00, 25, 45),
(46, 130000.00, 26, 46),
(47, 100000.00, 27, 47),
(48, 110000.00, 28, 48),
(49, 92000.00, 29, 49),
(50, 125000.00, 30, 50),
(51, 26000.00, 31, 51),
(52, 40000.00, 32, 52),
(53, 30500.00, 33, 53),
(54, 21000.00, 34, 54),
(55, 48000.00, 35, 55),
(56, 180000.00, 36, 56),
(57, 148000.00, 37, 57),
(58, 115000.00, 38, 58),
(59, 160000.00, 39, 59),
(60, 138000.00, 40, 60);

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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `lieu`
--

INSERT INTO `lieu` (`id`, `ville`, `nbBoxes`, `commentaires`) VALUES
(1, 'Paris', 80, 'Centre névralgique, accès facile depuis le périphérique'),
(2, 'Deauville', 120, 'Hippodrome de renommée internationale'),
(3, 'Chantilly', 200, 'Capitale du cheval, infrastructures premium'),
(4, 'Lyon', 60, 'Centre moderne, parking gratuit'),
(5, 'Bordeaux', 75, 'Cadre verdoyant, proche vignobles'),
(6, 'Marseille', 50, 'Ambiance méditerranéenne, vue mer'),
(7, 'Toulouse', 65, 'Accès autoroute, boxes climatisés'),
(8, 'Nantes', 55, 'Proche Loire, facilités de transport'),
(9, 'Strasbourg', 70, 'Carrefour européen, idéal pour acheteurs étrangers'),
(10, 'Montpellier', 45, 'Climat favorable, sol souple'),
(11, 'Nice', 90, 'Prestige et luxe, clientèle internationale'),
(12, 'Rennes', 60, 'Spécialiste chevaux de trait'),
(13, 'Caen', 110, 'Tradition équestre normande'),
(14, 'Rouen', 55, 'Haras réputé, box spacieux'),
(15, 'Biarritz', 80, 'Ventes de prestige, accès facile depuis Espagne');

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
  KEY `cheval_id` (`cheval_id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `lot`
--

INSERT INTO `lot` (`id`, `prixDepart`, `numSire`, `vente_id`, `cheval_id`) VALUES
(1, 15000.00, 'S001', 1, 1),
(2, 22000.00, 'S002', 1, 2),
(3, 18000.00, 'S003', 1, 3),
(4, 35000.00, 'S004', 1, 4),
(5, 28000.00, 'S005', 1, 5),
(6, 12000.00, 'S006', 2, 6),
(7, 45000.00, 'S007', 2, 7),
(8, 32000.00, 'S008', 2, 8),
(9, 19000.00, 'S009', 2, 9),
(10, 25000.00, 'S010', 2, 10),
(11, 55000.00, 'S011', 3, 11),
(12, 41000.00, 'S012', 3, 12),
(13, 38000.00, 'S013', 3, 13),
(14, 16000.00, 'S014', 3, 14),
(15, 72000.00, 'S015', 3, 15),
(16, 28000.00, 'S016', 4, 16),
(17, 33000.00, 'S017', 4, 17),
(18, 21000.00, 'S018', 4, 18),
(19, 48000.00, 'S019', 4, 19),
(20, 37000.00, 'S020', 4, 20),
(21, 65000.00, 'S021', 5, 21),
(22, 29000.00, 'S022', 5, 22),
(23, 44000.00, 'S023', 5, 23),
(24, 18000.00, 'S024', 5, 24),
(25, 52000.00, 'S025', 5, 25),
(26, 88000.00, 'S026', 6, 26),
(27, 73000.00, 'S027', 6, 27),
(28, 61000.00, 'S028', 6, 28),
(29, 95000.00, 'S029', 6, 29),
(30, 120000.00, 'S030', 6, 30),
(31, 24000.00, 'S031', 7, 31),
(32, 31000.00, 'S032', 7, 32),
(33, 27000.00, 'S033', 7, 33),
(34, 19000.00, 'S034', 7, 34),
(35, 42000.00, 'S035', 7, 35),
(36, 14000.00, 'S036', 8, 36),
(37, 23000.00, 'S037', 8, 37),
(38, 17000.00, 'S038', 8, 38),
(39, 38000.00, 'S039', 8, 39),
(40, 29000.00, 'S040', 8, 40),
(41, 56000.00, 'S041', 9, 41),
(42, 48000.00, 'S042', 9, 42),
(43, 67000.00, 'S043', 9, 43),
(44, 35000.00, 'S044', 9, 44),
(45, 79000.00, 'S045', 9, 45),
(46, 110000.00, 'S046', 10, 46),
(47, 85000.00, 'S047', 10, 47),
(48, 93000.00, 'S048', 10, 48),
(49, 78000.00, 'S049', 10, 49),
(50, 105000.00, 'S050', 10, 50),
(51, 22000.00, 'S051', 11, 51),
(52, 34000.00, 'S052', 11, 52),
(53, 26000.00, 'S053', 11, 53),
(54, 18000.00, 'S054', 11, 54),
(55, 41000.00, 'S055', 11, 55),
(56, 150000.00, 'S056', 12, 56),
(57, 125000.00, 'S057', 12, 57),
(58, 98000.00, 'S058', 12, 58),
(59, 135000.00, 'S059', 12, 59),
(60, 115000.00, 'S060', 12, 60);

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
('ARG', 'Argentine'),
('AUS', 'Australie'),
('BEL', 'Belgique'),
('BRA', 'Brésil'),
('CAN', 'Canada'),
('CHE', 'Suisse'),
('ESP', 'Espagne'),
('FRA', 'France'),
('GBR', 'Royaume-Uni'),
('GER', 'Allemagne'),
('IRL', 'Irlande'),
('ITA', 'Italie'),
('JPN', 'Japon'),
('UAE', 'Émirats Arabes Unis'),
('USA', 'États-Unis');

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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `race`
--

INSERT INTO `race` (`id`, `nom`, `libelle`) VALUES
(1, 'Pur-sang anglais', 'PSA'),
(2, 'Pur-sang arabe', 'PSA'),
(3, 'Anglo-arabe', 'AA'),
(4, 'Selle français', 'SF'),
(5, 'Quarter Horse', 'QH'),
(6, 'Appaloosa', 'APP'),
(7, 'Paint Horse', 'PH'),
(8, 'Lusitanien', 'LUS'),
(9, 'Andalou', 'AND'),
(10, 'Hanovrien', 'HAN'),
(11, 'Oldenbourg', 'OLD'),
(12, 'Holsteiner', 'HOL'),
(13, 'Trakehner', 'TRA'),
(14, 'KWPN', 'KWPN'),
(15, 'Frison', 'FRI'),
(16, 'Percheron', 'PER'),
(17, 'Boulonnais', 'BOU'),
(18, 'Clydesdale', 'CLY'),
(19, 'Camargue', 'CAM'),
(20, 'Lipizzan', 'LIP');

-- --------------------------------------------------------

--
-- Structure de la table `vendeur`
--

DROP TABLE IF EXISTS `vendeur`;
CREATE TABLE IF NOT EXISTS `vendeur` (
  `id` int(11) NOT NULL,
  `nom` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `vendeur`
--

INSERT INTO `vendeur` (`id`, `nom`) VALUES
(1, 'Haras Dupont'),
(2, 'Écuries Martin'),
(3, 'Smith Racing'),
(4, 'Müller Gestüt'),
(5, 'Rossi Stables'),
(6, 'Garcia Caballos'),
(7, 'Haras Dubois'),
(8, 'Écuries Laurent'),
(9, 'Haras Bernard'),
(10, 'Écuries Thomas'),
(11, 'Wilson Bloodstock'),
(12, 'O Brien Racing'),
(13, 'Johnson Farm'),
(14, 'Tanaka Stable'),
(15, 'Al Maktoum Racing'),
(16, 'Haras Petit'),
(17, 'Écuries Moreau'),
(18, 'Simon Équitation'),
(19, 'Michel Horses'),
(20, 'Haras Leroy');

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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `vente`
--

INSERT INTO `vente` (`id`, `nom`, `dateDebutVente`, `dateFinVente`, `dateDebutInscription`, `dateEnvoiMessage`, `objetMessage`, `corpsMessage`, `lieu_id`, `categvente_id`) VALUES
(1, 'Vente de Printemps Deauville', '2024-04-15', '2024-04-17', '2024-02-01', '2024-03-01', 'Inscription Vente Printemps', 'Bienvenue à la vente de printemps de Deauville.', 2, 1),
(2, 'Vente Estivale Chantilly', '2024-07-20', '2024-07-22', '2024-05-01', '2024-06-01', 'Inscription Vente Été', 'Vente estivale des yearlings à Chantilly.', 3, 7),
(3, 'Vente Automne Paris', '2024-10-08', '2024-10-10', '2024-08-01', '2024-09-01', 'Inscription Vente Automne', 'Grande vente d automne à Paris.', 1, 1),
(4, 'Vente Privée Bordeaux', '2024-09-14', '2024-09-14', '2024-07-01', '2024-08-15', 'Invitation Vente Privée', 'Vente exclusive sur invitation.', 5, 2),
(5, 'Vente Online Novembre', '2024-11-01', '2024-11-07', '2024-09-15', '2024-10-15', 'Accès Vente Online', 'Participez à notre vente en ligne.', 3, 3),
(6, 'Vente de Prestige Nice', '2024-12-01', '2024-12-03', '2024-09-01', '2024-11-01', 'Invitation Prestige', 'Vente de prestige sur invitation.', 11, 6),
(7, 'Vente des Reproductrices', '2024-05-20', '2024-05-21', '2024-03-01', '2024-04-01', 'Inscription Reproductrices', 'Vente spéciale poulinières et reproductrices.', 3, 9),
(8, 'Vente Flash Lyon', '2024-06-15', '2024-06-15', '2024-05-15', '2024-06-01', 'Vente Flash', 'Vente flash : opportunités exceptionnelles.', 4, 5),
(9, 'Vente Sport Caen', '2024-08-10', '2024-08-12', '2024-06-01', '2024-07-01', 'Inscription Sport', 'Chevaux de sport confirmés.', 13, 8),
(10, 'Vente Yearlings Deauville', '2024-08-19', '2024-08-23', '2024-05-01', '2024-07-01', 'Inscription Yearlings', 'La plus grande vente de yearlings.', 2, 7),
(11, 'Vente Hiver Strasbourg', '2025-01-15', '2025-01-17', '2024-11-01', '2024-12-01', 'Inscription Hiver', 'Première vente de l année.', 9, 1),
(12, 'Vente Biarritz Prestige', '2024-11-15', '2024-11-17', '2024-09-01', '2024-10-01', 'Invitation Biarritz', 'Vente internationale de prestige.', 15, 6),
(13, 'Vente Rennaise', '2024-09-28', '2024-09-29', '2024-07-15', '2024-08-15', 'Inscription Rennes', 'Spécialité chevaux de trait et poneys.', 12, 1),
(14, 'Vente de Noël Toulouse', '2024-12-14', '2024-12-15', '2024-10-01', '2024-11-15', 'Vente de Noël', 'Dernière vente de l année.', 7, 4),
(15, 'Vente Printanière Montpellier', '2025-03-22', '2025-03-23', '2025-01-15', '2025-02-15', 'Inscription Montpellier', 'Vente de début de saison.', 10, 1);

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
