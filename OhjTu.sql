/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

DROP DATABASE IF EXISTS `ohjtu`;
CREATE DATABASE IF NOT EXISTS `ohjtu` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `ohjtu`;

DROP TABLE IF EXISTS `asiakkaat`;
CREATE TABLE IF NOT EXISTS `asiakkaat` (
  `Asiakas_ID` varchar(50) NOT NULL,
  `Etunimi` varchar(50) NOT NULL,
  `Sukunimi` varchar(50) NOT NULL,
  `Osoite` varchar(50) NOT NULL,
  PRIMARY KEY (`Asiakas_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40000 ALTER TABLE `asiakkaat` DISABLE KEYS */;
INSERT INTO `asiakkaat` (`Asiakas_ID`, `Etunimi`, `Sukunimi`, `Osoite`) VALUES
	('BEKS', 'Pekka', 'Pouta', 'Nippeli');
/*!40000 ALTER TABLE `asiakkaat` ENABLE KEYS */;

DROP TABLE IF EXISTS `laskut`;
CREATE TABLE IF NOT EXISTS `laskut` (
  `Lasku_ID` varchar(50) NOT NULL,
  `Erapaiva` date NOT NULL,
  `Asiakas_ID` varchar(50) NOT NULL,
  `Summa` int(11) NOT NULL,
  PRIMARY KEY (`Lasku_ID`),
  KEY `Asiakas_ID` (`Asiakas_ID`),
  CONSTRAINT `laskut_ibfk_1` FOREIGN KEY (`Asiakas_ID`) REFERENCES `asiakkaat` (`Asiakas_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40000 ALTER TABLE `laskut` DISABLE KEYS */;
/*!40000 ALTER TABLE `laskut` ENABLE KEYS */;

DROP TABLE IF EXISTS `majoitus`;
CREATE TABLE IF NOT EXISTS `majoitus` (
  `Majoitus_ID` varchar(50) NOT NULL,
  `Majoituksen_Nimi` varchar(50) NOT NULL,
  `VrkHinta` int(11) NOT NULL,
  `HloKapasiteetti` int(11) NOT NULL,
  `Toimipiste_ID` varchar(50) NOT NULL,
  PRIMARY KEY (`Majoitus_ID`),
  KEY `Toimipiste_ID` (`Toimipiste_ID`),
  CONSTRAINT `majoitus_ibfk_1` FOREIGN KEY (`Toimipiste_ID`) REFERENCES `toimipiste` (`Toimipiste_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40000 ALTER TABLE `majoitus` DISABLE KEYS */;
INSERT INTO `majoitus` (`Majoitus_ID`, `Majoituksen_Nimi`, `VrkHinta`, `HloKapasiteetti`, `Toimipiste_ID`) VALUES
	('HUKKA', 'Hukka Talo', 70, 5, 'Joensuu');
/*!40000 ALTER TABLE `majoitus` ENABLE KEYS */;

DROP TABLE IF EXISTS `majoitusvaraukset`;
CREATE TABLE IF NOT EXISTS `majoitusvaraukset` (
  `HloMaara` int(11) NOT NULL,
  `Kesto` int(11) NOT NULL,
  `Varaus_ID` varchar(50) NOT NULL,
  `Asiakas_ID` varchar(50) NOT NULL,
  `Majoitus_ID` varchar(50) NOT NULL,
  PRIMARY KEY (`Varaus_ID`),
  UNIQUE KEY `Asiakas_ID` (`Asiakas_ID`,`Majoitus_ID`),
  KEY `Majoitus_ID` (`Majoitus_ID`),
  CONSTRAINT `majoitusvaraukset_ibfk_1` FOREIGN KEY (`Asiakas_ID`) REFERENCES `asiakkaat` (`Asiakas_ID`),
  CONSTRAINT `majoitusvaraukset_ibfk_2` FOREIGN KEY (`Majoitus_ID`) REFERENCES `majoitus` (`Majoitus_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40000 ALTER TABLE `majoitusvaraukset` DISABLE KEYS */;
INSERT INTO `majoitusvaraukset` (`HloMaara`, `Kesto`, `Varaus_ID`, `Asiakas_ID`, `Majoitus_ID`) VALUES
	(4, 3, '1', 'BEKS', 'HUKKA');
/*!40000 ALTER TABLE `majoitusvaraukset` ENABLE KEYS */;

DROP TABLE IF EXISTS `palvelut`;
CREATE TABLE IF NOT EXISTS `palvelut` (
  `Palvelu_ID` varchar(50) NOT NULL,
  `Palvelun_Nimi` varchar(50) NOT NULL,
  `Hinta` int(11) NOT NULL,
  PRIMARY KEY (`Palvelu_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40000 ALTER TABLE `palvelut` DISABLE KEYS */;
INSERT INTO `palvelut` (`Palvelu_ID`, `Palvelun_Nimi`, `Hinta`) VALUES
	('SUKSET', 'Suksien varaus', 10);
/*!40000 ALTER TABLE `palvelut` ENABLE KEYS */;

DROP TABLE IF EXISTS `palveluvaraukset`;
CREATE TABLE IF NOT EXISTS `palveluvaraukset` (
  `Varaus_ID` varchar(50) NOT NULL,
  `Hlomaara` int(11) NOT NULL,
  `Paiva` date NOT NULL,
  `Palvelu_ID` varchar(50) NOT NULL,
  `Asiakas_ID` varchar(50) NOT NULL,
  PRIMARY KEY (`Varaus_ID`),
  UNIQUE KEY `Palvelu_ID` (`Palvelu_ID`,`Asiakas_ID`),
  KEY `Asiakas_ID` (`Asiakas_ID`),
  CONSTRAINT `palveluvaraukset_ibfk_1` FOREIGN KEY (`Palvelu_ID`) REFERENCES `palvelut` (`Palvelu_ID`),
  CONSTRAINT `palveluvaraukset_ibfk_2` FOREIGN KEY (`Asiakas_ID`) REFERENCES `asiakkaat` (`Asiakas_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40000 ALTER TABLE `palveluvaraukset` DISABLE KEYS */;
INSERT INTO `palveluvaraukset` (`Varaus_ID`, `Hlomaara`, `Paiva`, `Palvelu_ID`, `Asiakas_ID`) VALUES
	('1', 1, '2020-04-13', 'SUKSET', 'BEKS');
/*!40000 ALTER TABLE `palveluvaraukset` ENABLE KEYS */;

DROP TABLE IF EXISTS `toimipiste`;
CREATE TABLE IF NOT EXISTS `toimipiste` (
  `Toimipiste_ID` varchar(50) NOT NULL,
  `Toimipiste_Nimi` varchar(50) NOT NULL,
  `Sijainti` varchar(50) NOT NULL,
  PRIMARY KEY (`Toimipiste_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40000 ALTER TABLE `toimipiste` DISABLE KEYS */;
INSERT INTO `toimipiste` (`Toimipiste_ID`, `Toimipiste_Nimi`, `Sijainti`) VALUES
	('Joensuu', 'Joensuun Toimipiste', 'Joensuu');
/*!40000 ALTER TABLE `toimipiste` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
