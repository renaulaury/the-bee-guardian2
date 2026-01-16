-- --------------------------------------------------------
-- Hôte:                         127.0.0.1
-- Version du serveur:           8.0.30 - MySQL Community Server - GPL
-- SE du serveur:                Win64
-- HeidiSQL Version:             12.11.0.7065
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Listage de la structure de la base pour borne
CREATE DATABASE IF NOT EXISTS `borne` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `borne`;

-- Listage de la structure de table borne. appointments
CREATE TABLE IF NOT EXISTS `appointments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `start_at` datetime NOT NULL,
  `end_at` datetime NOT NULL,
  `real_start_at` datetime DEFAULT NULL,
  `real_end_at` datetime DEFAULT NULL,
  `reference` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'planned',
  `plant_id` bigint unsigned NOT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `appointments_reference_unique` (`reference`),
  KEY `appointments_plant_id_foreign` (`plant_id`),
  CONSTRAINT `appointments_plant_id_foreign` FOREIGN KEY (`plant_id`) REFERENCES `plants` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table borne.appointments : ~4 rows (environ)
REPLACE INTO `appointments` (`id`, `start_at`, `end_at`, `real_start_at`, `real_end_at`, `reference`, `status`, `plant_id`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
	(4, '2025-12-17 10:00:00', '2025-12-17 11:00:00', NULL, NULL, 'MR8M73', 'planned', 1, 51, NULL, '2025-12-16 11:34:11', '2025-12-16 11:34:11'),
	(5, '2025-12-17 10:00:00', '2025-12-17 11:00:00', NULL, NULL, 'U4DM4Z', 'planned', 1, 51, NULL, '2025-12-16 11:35:36', '2025-12-16 11:35:36'),
	(6, '2025-12-17 20:00:00', '2025-12-17 23:00:00', NULL, NULL, 'MGGXCF', 'planned', 1, 51, NULL, '2025-12-16 12:09:02', '2025-12-16 12:09:02'),
	(7, '2025-12-18 07:00:00', '2025-12-19 07:00:00', NULL, NULL, 'E8K8GS', 'planned', 1, 51, NULL, '2025-12-16 12:09:02', '2025-12-16 12:09:02');

-- Listage de la structure de table borne. appointment_person
CREATE TABLE IF NOT EXISTS `appointment_person` (
  `appointment_id` bigint unsigned NOT NULL,
  `person_id` bigint unsigned NOT NULL,
  `signature_pds_path` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`appointment_id`,`person_id`),
  KEY `appointment_person_person_id_foreign` (`person_id`),
  CONSTRAINT `appointment_person_appointment_id_foreign` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `appointment_person_person_id_foreign` FOREIGN KEY (`person_id`) REFERENCES `people` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table borne.appointment_person : ~4 rows (environ)
REPLACE INTO `appointment_person` (`appointment_id`, `person_id`, `signature_pds_path`, `created_at`, `updated_at`) VALUES
	(4, 7, NULL, '2025-12-16 11:34:11', '2025-12-16 11:34:11'),
	(5, 7, NULL, '2025-12-16 11:35:36', '2025-12-16 11:35:36'),
	(6, 8, NULL, '2025-12-16 12:09:02', '2025-12-16 12:09:02'),
	(7, 8, NULL, '2025-12-16 12:09:02', '2025-12-16 12:09:02');

-- Listage de la structure de table borne. assignments
CREATE TABLE IF NOT EXISTS `assignments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `appointment_id` bigint unsigned NOT NULL,
  `person_id` bigint unsigned NOT NULL,
  `signature_pdp_path` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'assigned',
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `assignments_appointment_id_person_id_unique` (`appointment_id`,`person_id`),
  KEY `assignments_person_id_foreign` (`person_id`),
  CONSTRAINT `assignments_appointment_id_foreign` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assignments_person_id_foreign` FOREIGN KEY (`person_id`) REFERENCES `people` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table borne.assignments : ~0 rows (environ)

-- Listage de la structure de table borne. cache
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table borne.cache : ~0 rows (environ)

-- Listage de la structure de table borne. cache_locks
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table borne.cache_locks : ~0 rows (environ)

-- Listage de la structure de table borne. companies
CREATE TABLE IF NOT EXISTS `companies` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `siret` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table borne.companies : ~11 rows (environ)
REPLACE INTO `companies` (`id`, `name`, `siret`, `is_active`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
	(1, 'Mars Wrigley', '494 887 854 00037', 1, NULL, NULL, '2025-12-09 14:18:02', NULL),
	(2, 'Bic', '552 008 443 00087', 1, NULL, NULL, '2025-12-09 14:18:03', NULL),
	(3, 'Unilever', '552 119 216 02139', 1, NULL, NULL, '2025-12-09 14:18:03', NULL),
	(4, 'Marionnaud', '388 764 029 00061', 1, NULL, NULL, '2025-12-09 14:18:04', NULL),
	(5, 'FM Logistic', '452 228 596 00030', 1, NULL, NULL, '2025-12-15 15:15:04', NULL),
	(6, 'Eaux Secours', '111 111 111 11111', 1, NULL, NULL, '2025-12-15 15:31:24', NULL),
	(7, 'Phase Cachée', '222 222 222 22222', 1, NULL, NULL, '2025-12-15 15:31:25', NULL),
	(8, 'O Bois Dormant', '333 333 333 33333', 1, NULL, NULL, '2025-12-15 15:31:48', NULL),
	(9, 'Clé de Sol', '444 444 444 44444', 1, NULL, NULL, '2025-12-15 15:32:22', NULL),
	(10, 'Vert de Terre', '555 555 555 55555', 1, NULL, NULL, '2025-12-15 15:32:36', NULL),
	(11, 'Mur et Merveilles', '666 666 666 66666', 1, NULL, NULL, '2025-12-15 15:32:54', NULL);

-- Listage de la structure de table borne. doctrine_migration_versions
CREATE TABLE IF NOT EXISTS `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Listage des données de la table borne.doctrine_migration_versions : ~2 rows (environ)
REPLACE INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
	('DoctrineMigrations\\Version20251212143609', '2025-12-12 14:36:30', 50),
	('DoctrineMigrations\\Version20251212144447', '2025-12-12 14:44:49', 17);

-- Listage de la structure de table borne. failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table borne.failed_jobs : ~0 rows (environ)

-- Listage de la structure de table borne. jobs
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table borne.jobs : ~0 rows (environ)

-- Listage de la structure de table borne. job_batches
CREATE TABLE IF NOT EXISTS `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table borne.job_batches : ~0 rows (environ)

-- Listage de la structure de table borne. languages
CREATE TABLE IF NOT EXISTS `languages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `languages_code_unique` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table borne.languages : ~0 rows (environ)

-- Listage de la structure de table borne. mdm_workers
CREATE TABLE IF NOT EXISTS `mdm_workers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payrollCode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `firstName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `familyName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prefFirstName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prefFamilyName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `patronymeName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birthName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `intFirstName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `intBirthName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `intName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `plant` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `costCenter` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `section` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `analyticalPlant` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `partner` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hrContractType` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hrCategory` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hrWorkerType` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hrContractStatus` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hrOrganisation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hrRole` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hrPosition` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `businessTitle` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `originalEntryDate` date DEFAULT NULL,
  `contractEntryDate` date DEFAULT NULL,
  `contractEndDate` date DEFAULT NULL,
  `physicalEndDate` date DEFAULT NULL,
  `firstDayOfWork` date DEFAULT NULL,
  `hrResourceHierarchic` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hrResourceFonctional` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `language` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `proEmail` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobilePhone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `externalPhone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `internalPhone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `badgeNumber` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `googleId` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  `isValidated` tinyint(1) NOT NULL DEFAULT '0',
  `desactiveAccount` tinyint(1) NOT NULL DEFAULT '0',
  `fullTimeEquivalentPercent` decimal(5,2) DEFAULT NULL,
  `cgCode` decimal(10,2) DEFAULT NULL,
  `dataFrom` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastUpdateDate` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `time_stamp` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table borne.mdm_workers : ~51 rows (environ)
REPLACE INTO `mdm_workers` (`id`, `code`, `payrollCode`, `firstName`, `familyName`, `prefFirstName`, `prefFamilyName`, `patronymeName`, `birthName`, `intFirstName`, `intBirthName`, `intName`, `company`, `plant`, `costCenter`, `section`, `analyticalPlant`, `partner`, `hrContractType`, `hrCategory`, `hrWorkerType`, `hrContractStatus`, `hrOrganisation`, `hrRole`, `hrPosition`, `businessTitle`, `originalEntryDate`, `contractEntryDate`, `contractEndDate`, `physicalEndDate`, `firstDayOfWork`, `hrResourceHierarchic`, `hrResourceFonctional`, `language`, `proEmail`, `mobilePhone`, `externalPhone`, `internalPhone`, `badgeNumber`, `googleId`, `isActive`, `isValidated`, `desactiveAccount`, `fullTimeEquivalentPercent`, `cgCode`, `dataFrom`, `lastUpdateDate`, `updated`, `time_stamp`, `created_at`, `updated_at`) VALUES
	(1, 'W000031115', 'test', 'RAPHAEL', 'TRZECIAK', 'RAPHAEL', 'TRZECIAK', '', 'TRZECIAK', 'RAPHAEL', 'TRZECIAK', 'TRZECIAK', 'FR02', 'FCE', 'HAN_FCE', 'HAN', 'FCE', '0050000166', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000014', 'Apprentice', 'TN0002', 'ALTERNANT', '2024-09-02', '2024-09-02', NULL, '0000-00-00', '2024-09-02', 'FRA0102369', 'NOT_EXISTS', 'FR', 'rtrzeciak@fmlogistic.com', '', '', 'nan', '367210', 'rtrzeciak@fmlogistic.com', 1, 0, 0, 1.00, 3.00, 'WD', '2025-01-15 14:02:48', '2025-01-15 14:02:48', '2025-06-26 14:12:27', NULL, NULL),
	(2, 'W000030420', '', 'LOUIS', 'BONHOMME', 'LOUIS', 'BONHOMME', '', 'BONHOMME', 'LOUIS', 'BONHOMME', 'BONHOMME', 'FR02', 'CPN', 'HAN_CPN', 'HAN', 'CPN', '0050000166', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000021', 'Apprentice', 'TN0002', 'Apprenti', '2024-07-01', '2024-07-01', NULL, '0000-00-00', '2024-07-01', 'FRA0108598', 'NOT_EXISTS', 'FR', 'lbonhomme@fmlogistic.com', '', '', 'nan', '372697', 'lbonhomme@fmlogistic.com', 1, 0, 0, 1.00, 3.00, 'WD', '2024-07-17 12:00:21', '2024-07-17 12:00:21', '2025-06-26 14:12:27', NULL, NULL),
	(3, 'W000031189', '', 'NINA', 'LEBLOND', 'NINA', 'LEBLOND', '', 'LEBLOND', 'NINA', 'LEBLOND', 'LEBLOND', 'FR02', 'LPO', 'CUM_FRCH', 'CUM', 'FRCH', 'NOT_EXISTS', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000028', 'Apprentice', 'TN0002', 'APPRENTI', '2024-09-20', '2024-09-20', NULL, '0000-00-00', '2024-09-20', 'FRA0105370', 'NOT_EXISTS', 'FR', 'nleblond@fmlogistic.com', '', '', 'nan', '371369', 'nleblond@fmlogistic.com', 1, 0, 0, 1.00, 3.00, 'WD', '2024-12-02 18:02:11', '2024-12-02 18:02:12', '2025-06-26 14:12:27', NULL, NULL),
	(4, 'W000028493', '', 'FLAVIO', 'CHIMENTI', 'FLAVIO', 'CHIMENTI', '', 'CHIMENTI', 'FLAVIO', 'CHIMENTI', 'CHIMENTI', 'FR02', 'LPO', 'STT_FRCH', 'STT', 'FRCH', 'NOT_EXISTS', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000051', 'Apprentice', 'TN0002', 'APPRENTI', '2023-10-09', '2023-10-09', NULL, '0000-00-00', '2023-10-09', 'FRA0211553', 'NOT_EXISTS', 'FR', 'fchimenti@fmlogistic.com', '+33 6 74 94 21 36', '+33 6 74 94 21 36', 'nan', '352776', 'fchimenti@fmlogistic.com', 1, 0, 0, 1.00, 3.00, 'WD', '2025-05-27 16:03:37', '2025-05-28 10:14:45', '2025-06-26 14:12:27', NULL, NULL),
	(5, 'W000031291', '', 'ALISON', 'DECORNIQUET', 'ALISON', 'DECORNIQUET', '', 'DECORNIQUET', 'ALISON', 'DECORNIQUET', 'DECORNIQUET', 'FR02', 'CPN', 'HAN_CPN', 'HAN', 'CPN', '0050000166', 'IN_INT1', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000079', 'Apprentice', 'TN0002', 'Trainees and interns', '2024-10-01', '2024-10-01', NULL, '0000-00-00', '2024-10-01', 'W000006380', 'NOT_EXISTS', 'FR', 'adecorniquet@fmlogistic.com', '', '', 'nan', '381943', 'adecorniquet@fmlogistic.com', 1, 0, 0, 1.00, 3.00, 'WD', '2024-10-07 12:02:54', '2024-10-07 12:02:54', '2025-06-26 14:12:27', NULL, NULL),
	(6, 'W000030965', '', 'PIERRE', 'MEUNIER', 'PIERRE', 'MEUNIER', '', 'MEUNIER', 'PIERRE', 'MEUNIER', 'MEUNIER', 'FR02', 'FON', 'HAN_FON', 'HAN', 'FON', '0050000044', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000080', 'Apprentice', 'TN0002', 'ALTERNANT LOGISTIQUE', '2024-09-02', '2024-09-02', '0000-00-00', '0000-00-00', '2024-09-02', 'W000001956', 'NOT_EXISTS', 'FR', 'pmeunier@fmlogistic.com', '', '', 'nan', '355417', 'pmeunier@fmlogistic.com', 0, 0, 0, 1.00, 3.00, 'WD', '2024-10-17 18:03:02', '2024-10-17 18:03:03', '2025-06-25 17:24:42', NULL, NULL),
	(7, 'W000028363', '', 'MYRIAM', 'CHARIAULT', 'MYRIAM', 'CHARIAULT', '', 'CHARIAULT', 'MYRIAM', 'CHARIAULT', 'CHARIAULT', 'FR02', 'ORS', 'HAN_ORS', 'HAN', 'ORS', '0050000513', 'PRO1', '31', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000085', 'Apprentice', 'TN0002', 'Trainees and interns', '2023-09-04', '2023-09-04', '0000-00-00', '0000-00-00', '2023-09-04', 'W000030357', 'NOT_EXISTS', 'FR', 'mchariault@fmlogistic.com', '+33 6 02 14 89 27', '+33 6 02 14 89 27', 'nan', '316113', 'mchariault@fmlogistic.com', 0, 0, 0, 1.00, 3.00, 'WD', '2025-03-11 18:00:12', '2025-05-02 16:26:50', '2025-06-25 17:24:42', NULL, NULL),
	(8, 'W000031444', '', 'MARGAUX', 'SENAMAUD', 'MARGAUX', 'SENAMAUD', '', 'SENAMAUD', 'MARGAUX', 'SENAMAUD', 'SENAMAUD', 'FR02', 'LPO', 'HRH_FRCH', 'HRH', 'FRCH', 'NOT_EXISTS', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000118', 'Apprentice', 'TN0002', 'APPRENTI', '2024-10-21', '2024-10-21', '0000-00-00', '0000-00-00', '2024-10-21', 'FRA0210366', 'NOT_EXISTS', 'FR', 'msenamaud@fmlogistic.com', '+33 7 85 65 99 98', '+33 7 85 65 99 98', 'nan', '371293', 'msenamaud@fmlogistic.com', 0, 0, 0, 1.00, 3.00, 'WD', '2024-12-24 14:02:54', '2024-12-30 10:43:19', '2025-06-25 17:24:42', NULL, NULL),
	(9, 'W000032113', '', 'CHLOE', 'GOSSET', 'CHLOE', 'GOSSET', '', 'GOSSET', 'CHLOE', 'GOSSET', 'GOSSET', 'FR02', 'LPO', 'HRH_FRCH', 'HRH', 'FRCH', 'NOT_EXISTS', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000118', 'Apprentice', 'TN0002', 'APPRENTIE ASSISTANTE RH', '2025-02-03', '2025-02-03', '0000-00-00', '0000-00-00', '2025-02-03', 'FRA0210366', 'NOT_EXISTS', 'FR', 'cgosset@fmlogistic.com', '+33 6 61 73 01 93', '+33 6 61 73 01 93', 'nan', '371344', 'cgosset@fmlogistic.com', 0, 0, 0, 1.00, 3.00, 'WD', '2025-04-02 18:00:52', '2025-05-02 16:26:58', '2025-06-25 17:24:42', NULL, NULL),
	(10, 'W000030966', '', 'JOSHUA', 'MANDRILLON', 'JOSHUA', 'MANDRILLON', '', 'MANDRILLON', 'JOSHUA', 'MANDRILLON', 'MANDRILLON', 'FR02', 'CPN', 'TQH_CPN', 'TQH', 'CPN', 'NOT_EXISTS', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000123', 'Apprentice', 'TN0002', 'ALTERNANT', '2024-09-02', '2024-09-02', '0000-00-00', '0000-00-00', '2024-09-02', 'W000013265', 'NOT_EXISTS', 'FR', 'jmandrillon@fmlogistic.com', '', '', 'nan', '381896', 'jmandrillon@fmlogistic.com', 0, 0, 0, 1.00, 3.00, 'WD', '2024-09-03 00:01:45', '2024-09-03 00:01:47', '2025-06-25 17:24:42', NULL, NULL),
	(11, 'W000028362', '', 'GEOFFREY', 'VILLETTE', 'GEOFFREY', 'VILLETTE', '', 'VILLETTE', 'GEOFFREY', 'VILLETTE', 'VILLETTE', 'FR02', 'CPN', 'MAH_CPN', 'MAH', 'CPN', 'NOT_EXISTS', 'IN_INT1', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000124', 'Apprentice', 'TN0002', 'Trainees and interns', '2023-09-04', '2023-09-04', '0000-00-00', '0000-00-00', '2023-09-04', 'FRA0209297', 'NOT_EXISTS', 'FR', 'gvillette@fmlogistic.com', '', '', 'nan', '322490', 'gvillette@fmlogistic.com', 0, 0, 0, 1.00, 3.00, 'WD', '2023-09-05 11:17:15', '2023-09-05 11:17:15', '2025-06-25 17:24:42', NULL, NULL),
	(12, 'W000024108', '', 'PERRINE', 'COGNE', 'PERRINE', 'COGNE', '', 'COGNE', 'PERRINE', 'COGNE', 'COGNE', 'FR02', 'CPN', 'HRH_CPN', 'HRH', 'CPN', 'NOT_EXISTS', 'IN_INT1', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000125', 'Apprentice', 'TN0002', 'APPRENTI', '2022-08-08', '2022-08-08', '0000-00-00', '0000-00-00', '2022-08-08', 'W000025915', 'NOT_EXISTS', 'FR', 'pcogne@fmlogistic.com', '', '', 'nan', '372788', 'pcogne@fmlogistic.com', 0, 0, 0, 1.00, 3.00, 'WD', '2023-09-27 13:16:24', '2024-01-11 17:15:22', '2025-06-25 17:24:42', NULL, NULL),
	(13, 'W000027806', '', 'LOLA', 'CANDEL', 'LOLA', 'CANDEL', '', 'CANDEL', 'LOLA', 'CANDEL', 'CANDEL', 'FR02', 'CPN', 'ACC_CPN', 'ACC', 'CPN', 'NOT_EXISTS', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000126', 'Apprentice', 'TN0002', 'Trainees and interns', '2023-06-12', '2023-06-12', '0000-00-00', '0000-00-00', '2023-06-12', 'W000027935', 'NOT_EXISTS', 'FR', 'lcandel@fmlogistic.com', '', '+33 3 44 39 46 80', 'nan', '322571', 'lcandel@fmlogistic.com', 0, 0, 0, 1.00, 3.00, 'WD', '2024-12-03 16:03:19', '2024-12-03 16:03:20', '2025-06-25 17:24:42', NULL, NULL),
	(14, 'W000028452', '', 'ABDOULAYE', 'CAMARA', 'ABDOULAYE', 'CAMARA', '', 'CAMARA', 'ABDOULAYE', 'CAMARA', 'CAMARA', 'FR02', 'CPN2', 'TQH_CPN2', 'TQH', 'CPN2', 'NOT_EXISTS', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000127', 'Apprentice', 'TN0002', 'ALTERNANTS QHSE', '2023-09-25', '2023-09-25', '0000-00-00', '0000-00-00', '2023-09-25', 'W000020095', 'NOT_EXISTS', 'FR', 'abcamara@fmlogistic.com', '', '', 'nan', '391989', 'abcamara@fmlogistic.com', 0, 0, 0, 1.00, 3.00, 'WD', '2025-06-10 12:05:35', '2025-06-10 12:05:36', '2025-06-25 17:24:42', NULL, NULL),
	(15, 'W000031713', '', 'TIMEO', 'LEBAIL', 'TIMEO', 'LEBAIL', '', 'LEBAIL', 'TIMEO', 'LEBAIL', 'LEBAIL', 'FR02', 'RES', 'MAH_RES', 'MAH', 'RES', 'NOT_EXISTS', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000131', 'Apprentice', 'TN0002', 'CONTRAT APPRENTISSAGE', '2024-11-25', '2024-11-25', '0000-00-00', '0000-00-00', '2024-11-25', 'FRA0104763', 'NOT_EXISTS', 'FR', 'tlebail@fmlogistic.com', '', '', 'nan', '379697', 'tlebail@fmlogistic.com', 0, 0, 0, 1.00, 3.00, 'WD', '2024-11-26 00:03:32', '2024-11-26 00:03:33', '2025-06-25 17:24:42', NULL, NULL),
	(16, 'W000031176', '', 'ORIANA', 'ROUFID', 'ORIANA', 'ROUFID', '', 'ROUFID', 'ORIANA', 'ROUFID', 'ROUFID', 'FR02', 'FON', 'HRH_FON', 'HRH', 'FON', 'NOT_EXISTS', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000137', 'Apprentice', 'TN0002', 'ALTERNANT RH', '2024-09-13', '2024-09-13', '0000-00-00', '0000-00-00', '2024-09-13', 'FRA0106147', 'NOT_EXISTS', 'FR', 'oroufid@fmlogistic.com', '', '', 'nan', '355328', 'oroufid@fmlogistic.com', 0, 0, 0, 1.00, 3.00, 'WD', '2024-09-17 00:03:36', '2024-09-17 00:03:38', '2025-06-25 17:24:42', NULL, NULL),
	(17, 'W000030896', '', 'AMELIE', 'JOUIN', 'AMELIE', 'JOUIN', '', 'JOUIN', 'AMELIE', 'JOUIN', 'JOUIN', 'FR02', 'ORS', 'HRH_ORS', 'HRH', 'ORS', 'NOT_EXISTS', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000141', 'Apprentice', 'TN0002', 'ALTERNANT RH', '2024-09-02', '2024-09-02', '0000-00-00', '0000-00-00', '2024-09-02', 'FRA0207451', 'NOT_EXISTS', 'FR', 'ajouin@fmlogistic.com', '', '', 'nan', '316159', 'ajouin@fmlogistic.com', 0, 0, 0, 1.00, 3.00, 'WD', '2024-09-03 00:01:45', '2024-09-03 00:01:47', '2025-06-25 17:24:42', NULL, NULL),
	(18, 'W000030552', '', 'MATHIS', 'LABOU', 'MATHIS', 'LABOU', '', 'LABOU', 'MATHIS', 'LABOU', 'LABOU', 'FR02', 'ORS', 'TQH_ORS', 'TQH', 'ORS', 'NOT_EXISTS', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000143', 'Apprentice', 'TN0002', 'ALTERNANT QHSE', '2024-09-02', '2024-09-02', '0000-00-00', '0000-00-00', '2024-09-02', 'W000021087', 'NOT_EXISTS', 'FR', 'mlabou@fmlogistic.com', '', '', 'nan', '333805', 'mlabou@fmlogistic.com', 0, 0, 0, 1.00, 3.00, 'WD', '2024-09-03 10:00:31', '2024-09-03 10:00:32', '2025-06-25 17:24:42', NULL, NULL),
	(19, 'W000028635', '', 'ELOISE', 'BIENFAIT-LELONG', 'ELOISE', 'BIENFAIT-LELONG', '', 'BIENFAIT-LELONG', 'ELOISE', 'BIENFAIT-LELONG', 'BIENFAIT-LELONG', 'FR02', 'CPE', 'HRH_CPE', 'HRH', 'CPE', 'NOT_EXISTS', 'CAP', 'NOT_EXISTS', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000148', 'Apprentice', 'TN0002', 'Trainees and interns', '2023-10-02', '2023-10-02', '0000-00-00', '0000-00-00', '2023-10-02', 'FRA0105084', 'NOT_EXISTS', 'FR', 'ebienfaitlelong@fmlogistic.com', '', '', 'nan', '383550', 'ebienfaitlelong@fmlogistic.com', 0, 0, 0, 1.00, 1.00, 'WD', '2024-08-22 00:00:18', '2024-08-22 00:00:19', '2025-06-25 17:24:42', NULL, NULL),
	(20, 'W000013263', '', 'LOUCKA', 'LEBRUN', 'LOUCKA', 'LEBRUN', '', 'LEBRUN', 'LOUCKA', 'LEBRUN', 'LEBRUN', 'FR02', 'CPE', 'TQH_CPE', 'TQH', 'CPE', 'NOT_EXISTS', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000149', 'Apprentice', 'TN0002', 'APPRENTI', '2020-10-05', '2020-10-05', '0000-00-00', '0000-00-00', '2020-10-05', 'FRA0210322', 'NOT_EXISTS', 'FR', 'lolebrun@fmlogistic.com', '+33 6 07 23 20 61', '+33 6 07 23 20 61', 'nan', '373558', 'lolebrun@fmlogistic.com', 0, 0, 0, 1.00, 3.00, 'WD', '2023-06-02 19:17:11', '2024-08-06 11:56:41', '2025-06-25 17:24:42', NULL, NULL),
	(21, 'W000030887', '', 'CARLA', 'DE ALMEIDA', 'CARLA', 'DE ALMEIDA', '', 'DE ALMEIDA', 'CARLA', 'DE ALMEIDA', 'DE ALMEIDA', 'FR02', 'EPX', 'HRH_EPX', 'HRH', 'EPX', 'NOT_EXISTS', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000157', 'Apprentice', 'TN0002', 'ALTERNANT RH', '2024-09-09', '2024-09-09', '0000-00-00', '0000-00-00', '2024-09-09', 'W000032503', 'NOT_EXISTS', 'FR', 'cdealmeida@fmlogistic.com', '', '', 'nan', '385923', 'cdealmeida@fmlogistic.com', 0, 0, 0, 1.00, 3.00, 'WD', '2025-06-06 16:06:44', '2025-06-06 16:06:50', '2025-06-25 17:24:42', NULL, NULL),
	(22, 'W000031143', '', 'JULIA', 'DARMOIS', 'JULIA', 'DARMOIS', '', 'DARMOIS', 'JULIA', 'DARMOIS', 'DARMOIS', 'FR02', 'FLS', 'TQH_FLS', 'TQH', 'FLS', 'NOT_EXISTS', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000164', 'Apprentice', 'TN0002', 'CONTRAT APPRENTISSAGE', '2024-09-09', '2024-09-09', '0000-00-00', '0000-00-00', '2024-09-09', 'FRA0200533', 'NOT_EXISTS', 'FR', 'jdarmois@fmlogistic.com', '', '', 'nan', '386705', 'jdarmois@fmlogistic.com', 0, 0, 0, 1.00, 3.00, 'WD', '2024-11-25 18:03:37', '2024-11-25 18:03:37', '2025-06-25 17:24:42', NULL, NULL),
	(23, 'W000030814', '', 'JARED-REMI', 'MARTIN', 'JARED-REMI', 'MARTIN', '', 'MARTIN', 'JARED-REMI', 'MARTIN', 'MARTIN', 'FR02', 'FVN', 'HRH_FVN', 'HRH', 'FVN', 'NOT_EXISTS', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000168', 'Apprentice', 'TN0002', 'Alternant', '2024-09-16', '2024-09-16', '0000-00-00', '0000-00-00', '2024-09-16', 'W000031161', 'NOT_EXISTS', 'FR', 'jmartin@fmlogistic.com', '', '', 'nan', '344620', 'jmartin@fmlogistic.com', 0, 0, 0, 1.00, 3.00, 'WD', '2024-09-17 00:03:36', '2024-09-17 00:03:38', '2025-06-25 17:24:42', NULL, NULL),
	(24, 'W000030883', '', 'PAULINE', 'FERTE', 'PAULINE', 'FERTE', '', 'FERTE', 'PAULINE', 'FERTE', 'FERTE', 'FR02', 'LPO', 'TQH_LPO', 'TQH', 'LPO', 'NOT_EXISTS', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000177', 'Apprentice', 'QH0302', 'ALTERNANTS QHSE', '2024-09-02', '2024-09-02', '0000-00-00', '0000-00-00', '2024-09-02', 'W000025479', 'NOT_EXISTS', 'FR', 'pferte@fmlogistic.com', '+33 6 68 15 46 53', '+33 6 68 15 46 53', 'nan', '380100', 'pferte@fmlogistic.com', 0, 0, 0, 1.00, 3.00, 'WD', '2025-04-08 18:00:29', '2025-05-02 16:27:01', '2025-06-25 17:24:42', NULL, NULL),
	(25, 'W000031064', '', 'JULES', 'BOUILLARD', 'JULES', 'BOUILLARD', '', 'BOUILLARD', 'JULES', 'BOUILLARD', 'BOUILLARD', 'FR02', 'MAN', 'ACC_MAN', 'ACC', 'MAN', 'NOT_EXISTS', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000182', 'Apprentice', 'TN0002', 'APPRENTI CG', '2024-08-27', '2024-08-27', '0000-00-00', '0000-00-00', '2024-08-27', 'W000031892', 'NOT_EXISTS', 'FR', 'jubouillard@fmlogistic.com', '', '', 'nan', '382604', 'jubouillard@fmlogistic.com', 0, 0, 0, 1.00, 3.00, 'WD', '2025-06-02 00:05:01', '2025-06-11 15:50:52', '2025-06-25 17:24:42', NULL, NULL),
	(26, 'W000030792', '', 'ALEXANDRE', 'LIEBERT', 'ALEXANDRE', 'LIEBERT', '', 'LIEBERT', 'ALEXANDRE', 'LIEBERT', 'LIEBERT', 'FR02', 'MAN', 'HRH_MAN', 'HRH', 'MAN', 'NOT_EXISTS', 'CDD', '31', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000183', 'Fixed_term', 'HR0301', 'ASSISTANT RH', '2024-07-29', '2025-06-30', NULL, '0000-00-00', '2025-06-30', 'FRA0206787', 'NOT_EXISTS', 'FR', 'aliebert@fmlogistic.com', '+33 6 79 97 60 06', '', 'nan', '382597', 'aliebert@fmlogistic.com', 1, 0, 0, 1.00, 3.00, 'WD', '2025-07-02 20:02:37', '2025-07-02 20:02:38', '2025-07-04 09:40:20', NULL, NULL),
	(27, 'W000031031', '', 'RAYAN', 'TOUAITI', 'RAYAN', 'TOUAITI', '', 'TOUAITI', 'RAYAN', 'TOUAITI', 'TOUAITI', 'FR02', 'ORS', 'DIS_ORS', 'DIS', 'ORS', '0050000166', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000201', 'Apprentice', 'TN0002', 'ALTERNANT', '2024-09-03', '2024-09-03', '0000-00-00', '0000-00-00', '2024-09-03', 'W000029291', 'NOT_EXISTS', 'FR', 'rtouaiti@fmlogistic.com', '', '', 'nan', '316148', 'rtouaiti@fmlogistic.com', 0, 0, 0, 1.00, 3.00, 'WD', '2024-09-04 00:02:56', '2024-09-04 00:02:57', '2025-06-25 17:24:42', NULL, NULL),
	(28, 'W000031325', '', 'BRANDON', 'NICOLAOS', 'BRANDON', 'NICOLAOS', '', 'NICOLAOS', 'BRANDON', 'NICOLAOS', 'NICOLAOS', 'FR02', 'CPN', 'TRP_CPN', 'TRP', 'CPN', '0050000037', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000219', 'Apprentice', 'TN0002', 'Trainees and interns', '2024-10-02', '2024-10-02', '0000-00-00', '0000-00-00', '2024-10-02', 'W000032569', 'NOT_EXISTS', 'FR', 'bnicolaos@fmlogistic.com', '', '', 'nan', '381919', 'bnicolaos@fmlogistic.com', 0, 0, 0, 1.00, 3.00, 'WD', '2025-06-17 10:01:12', '2025-06-17 11:50:44', '2025-06-25 17:24:42', NULL, NULL),
	(29, 'W000031092', '', 'LEA', 'DEMAZEUX', 'LEA', 'DEMAZEUX', '', 'DEMAZEUX', 'LEA', 'DEMAZEUX', 'DEMAZEUX', 'FR02', 'CPN2', 'COC_CPN2', 'COC', 'CPN2', '0050000166', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000227', 'Apprentice', 'TN0002', 'ALTERNANT', '2024-09-16', '2024-09-16', '0000-00-00', '0000-00-00', '2024-09-16', 'FRA0105211', 'NOT_EXISTS', 'FR', 'ldemazeux@fmlogistic.com', '', '', 'nan', '379538', 'ldemazeux@fmlogistic.com', 0, 0, 0, 1.00, 3.00, 'WD', '2024-10-28 18:00:24', '2024-10-28 18:00:24', '2025-06-25 17:24:42', NULL, NULL),
	(30, 'W000030949', '', 'MADDY', 'NOBLE', 'MADDY', 'NOBLE', '', 'NOBLE', 'MADDY', 'NOBLE', 'NOBLE', 'FR02', 'PHG', 'FOF_FRCH', 'FOF', 'FRCH', 'NOT_EXISTS', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000276', 'Apprentice', 'TN0002', 'APPRENTI', '2024-09-16', '2024-09-16', '0000-00-00', '0000-00-00', '2024-09-16', 'FRA0091597', 'NOT_EXISTS', 'FR', 'mnoble@fmlogistic.com', '+33 6 74 52 82 77', '+33 6 74 52 82 77', 'nan', '386434', 'mnoble@fmlogistic.com', 0, 0, 0, 1.00, 3.00, 'WD', '2024-10-10 12:03:33', '2024-10-14 13:40:05', '2025-06-25 17:24:42', NULL, NULL),
	(31, 'W000030951', '', 'MATHILDE', 'PERRILLAT', 'MATHILDE', 'PERRILLAT', '', 'PERRILLAT', 'MATHILDE', 'PERRILLAT', 'PERRILLAT', 'FR02', 'PHG', 'FOF_FRCH', 'FOF', 'FRCH', 'NOT_EXISTS', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000276', 'Apprentice', 'TN0002', 'APPRENTI', '2024-09-02', '2024-09-02', '0000-00-00', '0000-00-00', '2024-09-02', 'FRA0091597', 'NOT_EXISTS', 'FR', 'mperrillat@fmlogistic.com', '+33 6 87 69 63 22', '+33 6 87 69 63 22', 'nan', '386432', 'mperrillat@fmlogistic.com', 0, 0, 0, 1.00, 3.00, 'WD', '2024-10-10 12:03:33', '2024-10-14 13:40:05', '2025-06-25 17:24:42', NULL, NULL),
	(32, 'W000022456', '', 'EMILIE', 'BIER', 'EMILIE', 'BIER', '', 'BIER', 'EMILIE', 'BIER', 'BIER', 'FR02', 'PHG', 'HRH_FRCH', 'HRH', 'FRCH', 'NOT_EXISTS', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000277', 'Apprentice', 'TN0002', 'APPRENTIE', '2022-04-04', '2023-09-11', '0000-00-00', '0000-00-00', '2023-09-11', 'FRA0103220', 'NOT_EXISTS', 'FR', 'ebier@fmlogistic.com', '+33 6 74 52 82 77', '+33 3 87 23 19 59', 'nan', '379045', 'ebier@fmlogistic.com', 0, 0, 0, 1.00, 3.00, 'WD', '2024-03-04 12:02:51', '2024-03-04 12:02:51', '2025-06-25 17:24:42', NULL, NULL),
	(33, 'W000030942', '', 'SEBASTIEN', 'AJAX', 'SEBASTIEN', 'AJAX', '', 'AJAX', 'SEBASTIEN', 'AJAX', 'AJAX', 'FR02', 'PHG', 'HRH_FRCH', 'HRH', 'FRCH', 'NOT_EXISTS', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000277', 'Apprentice', 'TN0002', 'APPRENTI', '2024-09-02', '2024-09-02', '0000-00-00', '0000-00-00', '2024-09-02', 'FRA0103220', 'NOT_EXISTS', 'FR', 'sajax@fmlogistic.com', '', '', 'nan', '386430', 'sajax@fmlogistic.com', 0, 0, 0, 1.00, 3.00, 'WD', '2024-10-25 14:03:07', '2024-10-25 14:03:09', '2025-06-25 17:24:42', NULL, NULL),
	(34, 'W000030943', '', 'EMILIE', 'GANGLOFF', 'EMILIE', 'GANGLOFF', '', 'GANGLOFF', 'EMILIE', 'GANGLOFF', 'GANGLOFF', 'FR02', 'PHG', 'HRH_FRCH', 'HRH', 'FRCH', 'NOT_EXISTS', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000277', 'Apprentice', 'TN0002', 'APPRENTI', '2024-09-02', '2024-09-02', '0000-00-00', '0000-00-00', '2024-09-02', 'FRA0103220', 'NOT_EXISTS', 'FR', 'egangloff@fmlogistic.com', '', '', 'nan', '386431', 'egangloff@fmlogistic.com', 0, 0, 0, 1.00, 3.00, 'WD', '2024-10-10 12:03:33', '2024-10-10 12:03:35', '2025-06-25 17:24:42', NULL, NULL),
	(35, 'W000030915', '', 'CEDRIC', 'LAGIER', 'CEDRIC', 'LAGIER', '', 'LAGIER', 'CEDRIC', 'LAGIER', 'LAGIER', 'FR02', 'LHE', 'HAN_LHE', 'HAN', 'LHE', '0050000567', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000302', 'Apprentice', 'TN0002', 'Alternant CPL', '2024-09-02', '2024-09-16', '0000-00-00', '0000-00-00', '2024-09-16', 'FRA0008958', 'NOT_EXISTS', 'FR', '', '', '', 'nan', '378584', 'clagier@fmlogistic.com', 0, 0, 0, 1.00, 1.00, 'WD', '2024-11-20 00:03:01', '2024-11-20 00:03:01', '2025-06-25 17:24:42', NULL, NULL),
	(36, 'W000031207', '', 'PIERRE', 'BURBAN', 'PIERRE', 'BURBAN', '', 'BURBAN', 'PIERRE', 'BURBAN', 'BURBAN', 'FR02', 'LHE', 'HAN_LHE', 'HAN', 'LHE', '0050000567', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000303', 'Apprentice', 'TN0002', 'ALTERNANT GDS', '2024-09-17', '2024-09-17', '0000-00-00', '0000-00-00', '2024-09-17', 'FRA0200468', 'NOT_EXISTS', 'FR', 'pburban@fmlogistic.com', '', '', 'nan', '378553', 'pburban@fmlogistic.com', 0, 0, 0, 1.00, 3.00, 'WD', '2024-11-20 00:03:01', '2024-11-20 00:03:01', '2025-06-25 17:24:42', NULL, NULL),
	(37, 'W000031326', '', 'ADEM', 'GUENINE', 'ADEM', 'GUENINE', '', 'GUENINE', 'ADEM', 'GUENINE', 'GUENINE', 'FR02', 'CPN', 'SCM_CPN', 'SCM', 'CPN', '0050000166', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000318', 'Apprentice', 'TN0002', 'Trainees and interns', '2024-10-02', '2024-10-02', '0000-00-00', '0000-00-00', '2024-10-02', 'FRA0109345', 'NOT_EXISTS', 'FR', 'aguenine@fmlogistic.com', '', '+33 7 66 59 81 89', 'nan', '381918', 'aguenine@fmlogistic.com', 0, 0, 0, 1.00, 3.00, 'WD', '2025-04-16 18:01:05', '2025-04-16 18:01:09', '2025-06-25 17:24:42', NULL, NULL),
	(38, 'W000028360', '', 'JULIUS', 'BOITEZ', 'JULIUS', 'BOITEZ', '', 'BOITEZ', 'JULIUS', 'BOITEZ', 'BOITEZ', 'FR02', 'CPN', 'SCM_CPN', 'SCM', 'CPN', '0050000166', 'IN_INT1', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000319', 'Apprentice', 'TN0002', 'Trainees and interns', '2023-08-21', '2023-08-21', '0000-00-00', '0000-00-00', '2023-08-21', 'W000010776', 'NOT_EXISTS', 'FR', 'juboitez@fmlogistic.com', '', '', 'nan', '304552', 'juboitez@fmlogistic.com', 0, 0, 0, 1.00, 3.00, 'WD', '2025-04-16 18:01:05', '2025-04-16 18:01:09', '2025-06-25 17:24:42', NULL, NULL),
	(39, 'W000031922', '', 'BEHAR', 'DEMIRI', 'BEHAR', 'DEMIRI', '', 'DEMIRI', 'BEHAR', 'DEMIRI', 'DEMIRI', 'FR02', 'LHE', 'HAN_LHE', 'HAN', 'LHE', '0050000887', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000372', 'Apprentice', 'TN0002', 'ALTERNANT', '2024-12-23', '2024-12-23', '0000-00-00', '0000-00-00', '2024-12-23', 'FRA0101492', 'NOT_EXISTS', 'FR', 'bedemiri@fmlogistic.com', '', '', 'nan', '378576', 'bedemiri@fmlogistic.com', 0, 0, 0, 1.00, 1.00, 'WD', '2025-02-18 12:02:34', '2025-02-18 12:02:35', '2025-06-25 17:24:42', NULL, NULL),
	(40, 'W000031303', '', 'Ilias', 'BOUNOUADER', 'Ilias', 'BOUNOUADER', '', 'BOUNOUADER', 'Ilias', 'BOUNOUADER', 'BOUNOUADER', 'FR02', 'CPN2', 'COC_CPN2', 'COC', 'CPN2', '0050000166', 'CAP', '41', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000377', 'Apprentice', 'TN0002', 'ALTERNANTS ET STAGIAIRES', '2024-09-30', '2024-09-30', '0000-00-00', '0000-00-00', '2024-09-30', 'W000023128', 'NOT_EXISTS', 'FR', 'ibounouader@fmlogistic.com', '', '', 'nan', '360695', 'ibounouader@fmlogistic.com', 0, 0, 0, 1.00, 1.00, 'WD', '2025-05-12 12:01:43', '2025-05-12 12:01:43', '2025-06-25 17:24:42', NULL, NULL),
	(41, 'W000031010', '', 'TRISTAN', 'SIMONY', 'TRISTAN', 'SIMONY', '', 'SIMONY', 'TRISTAN', 'SIMONY', 'SIMONY', 'FR02', 'LPO', 'HAN_LPO', 'HAN', 'LPO', '0050000038', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000419', 'Apprentice', 'TN0002', 'ALTERNANTS', '2024-09-02', '2024-09-02', '0000-00-00', '0000-00-00', '2024-09-02', 'W000031694', 'NOT_EXISTS', 'FR', 'tsimony@fmlogistic.com', '', '', 'nan', '378391', 'tsimony@fmlogistic.com', 0, 0, 0, 1.00, 3.00, 'WD', '2025-01-27 12:01:59', '2025-01-27 12:02:02', '2025-06-25 17:24:42', NULL, NULL),
	(42, 'W000031505', '', 'Maxim', 'DREYFUS', 'Maxim', 'DREYFUS', '', 'DREYFUS', 'Maxim', 'DREYFUS', 'DREYFUS', 'FR02', 'FPE', 'HAN_FPE', 'HAN', 'FPE', '0050000090', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000435', 'Apprentice', 'TN0002', 'Alternant', '2024-11-04', '2024-11-04', '0000-00-00', '0000-00-00', '2024-11-04', 'FRA0208862', 'NOT_EXISTS', 'FR', 'mdreyfus@fmlogistic.com', '', '', 'nan', '383821', 'mdreyfus@fmlogistic.com', 0, 0, 0, 1.00, 1.00, 'WD', '2025-02-10 16:01:48', '2025-02-10 16:01:51', '2025-06-25 17:24:42', NULL, NULL),
	(43, 'W000028353', '', 'CONSTANT', 'NIVILL', 'CONSTANT', 'NIVILL', '', 'NIVILL', 'CONSTANT', 'NIVILL', 'NIVILL', 'FR02', 'FON', 'COC_FON', 'COC', 'FON', '0050000069', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000439', 'Apprentice', 'TN0002', 'APPRENTI QLIO', '2023-09-01', '2023-09-01', '0000-00-00', '0000-00-00', '2023-09-01', 'FRA0208894', 'NOT_EXISTS', 'FR', 'cnivill@fmlogistic.com', '', '', 'nan', '378495', 'cnivill@fmlogistic.com', 0, 0, 0, 1.00, 3.00, 'WD', '2024-02-20 16:03:17', '2024-02-20 16:03:17', '2025-06-25 17:24:42', NULL, NULL),
	(44, 'W000017339', '', 'RYAN', 'SALI', 'RYAN', 'SALI', '', 'SALI', 'RYAN', 'SALI', 'SALI', 'FR02', 'CPN2', 'HAN_CPN2', 'HAN', 'CPN2', '0050000029', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000480', 'Apprentice', 'TN0002', 'APPRENTI LOGISTIQUE', '2021-06-16', '2023-09-25', '0000-00-00', '0000-00-00', '2023-09-25', 'FRA0108252', 'NOT_EXISTS', 'FR', '', '', '', 'nan', '379619', 'rsali@fmlogistic.com', 0, 0, 0, 1.00, 1.00, 'WD', '2024-11-26 16:03:17', '2024-11-26 16:03:18', '2025-06-25 17:24:42', NULL, NULL),
	(45, 'W000025862', '', 'MARYLOU', 'AMFRY', 'MARYLOU', 'AMFRY', '', 'AMFRY', 'MARYLOU', 'AMFRY', 'AMFRY', 'FR02', 'CPN2', 'HAN_CPN2', 'HAN', 'CPN2', '0050000029', 'IN_INT1', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000480', 'Apprentice', 'TN0002', 'ALTERNANT', '2022-11-21', '2024-09-02', '0000-00-00', '0000-00-00', '2024-09-02', 'FRA0108252', 'NOT_EXISTS', 'FR', '', '', '', 'nan', '379576', 'mamfry@fmlogistic.com', 0, 0, 0, 1.00, 1.00, 'WD', '2024-11-28 16:03:31', '2024-11-28 16:03:32', '2025-06-25 17:24:42', NULL, NULL),
	(46, 'W000030986', '', 'CORENTIN', 'GIRARD MABIL', 'CORENTIN', 'GIRARD MABIL', '', 'GIRARD MABIL', 'CORENTIN', 'GIRARD MABIL', 'GIRARD MABIL', 'FR02', 'CPN2', 'COC_CPN2', 'COC', 'CPN2', '0050000166', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000485', 'Apprentice', 'TN0002', 'ALTERNANT', '2024-09-02', '2024-09-02', '0000-00-00', '0000-00-00', '2024-09-02', 'FRA0211582', 'NOT_EXISTS', 'FR', 'cgirardmabil@fmlogistic.com', '+33 6 47 17 20 22', '+33 6 47 17 20 22', 'nan', '379525', 'cgirardmabil@fmlogistic.com', 0, 0, 0, 1.00, 3.00, 'WD', '2025-05-06 10:01:34', '2025-05-15 11:00:03', '2025-06-25 17:24:42', NULL, NULL),
	(47, 'W000031072', '', 'RAFAEL', 'MARCOS GONCALVES INES', 'RAFAEL', 'MARCOS GONCALVES INES', '', 'MARCOS GONCALVES INES', 'RAFAEL', 'MARCOS GONCALVES INES', 'MARCOS GONCALVES INES', 'FR02', 'CPN2', 'HAN_CPN2', 'HAN', 'CPN2', '0050000013', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000584', 'Apprentice', 'TN0002', 'CONTRAT D\'APPRENTISSAGE', '2024-08-29', '2024-09-16', '0000-00-00', '0000-00-00', '2024-09-16', 'FRA0104971', 'NOT_EXISTS', 'FR', '', '', '', 'nan', '379564', 'rmarcos@fmlogistic.com', 0, 0, 0, 1.00, 1.00, 'WD', '2025-03-18 13:36:03', '2025-02-27 10:02:21', '2025-06-25 17:24:42', NULL, NULL),
	(48, 'W000031298', '', 'TOM', 'CASTEL', 'TOM', 'CASTEL', '', 'CASTEL', 'TOM', 'CASTEL', 'CASTEL', 'FR02', 'RES', 'HAN_RES', 'HAN', 'RES', '0050000077', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000592', 'Apprentice', 'TN0002', 'CONTRAT D APPRENTISSAGE', '2024-09-30', '2024-09-30', '0000-00-00', '0000-00-00', '2024-09-30', 'FRA0108409', 'NOT_EXISTS', 'FR', 'tcastel@fmlogistic.com', '', '', 'nan', '379702', 'tcastel@fmlogistic.com', 0, 0, 0, 1.00, 3.00, 'WD', '2025-06-04 10:03:48', '2025-06-04 11:58:28', '2025-06-25 17:24:42', NULL, NULL),
	(49, 'W000030813', '', 'GABRIEL', 'MODIANO DE CAMONDO', 'GABRIEL', 'MODIANO DE CAMONDO', '', 'MODIANO DE CAMONDO', 'GABRIEL', 'MODIANO DE CAMONDO', 'MODIANO DE CAMONDO', 'FR02', 'LPO', 'HAN_LPO', 'HAN', 'LPO', '0050000175', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000608', 'Apprentice', 'TN0002', 'CONTRAT APPRENTISSAGE', '2024-09-02', '2024-09-02', '0000-00-00', '0000-00-00', '2024-09-02', 'W000004246', 'NOT_EXISTS', 'FR', 'gmodianodecamondo@fmlogistic.com', '', '', 'nan', '380124', 'gmodianodecamondo@fmlogistic.com', 0, 0, 0, 1.00, 3.00, 'WD', '2025-05-06 16:01:45', '2025-05-06 16:01:45', '2025-06-25 17:24:42', NULL, NULL),
	(50, 'W000032568', '', 'MAXIME', 'CASTETS', 'MAXIME', 'CASTETS', '', 'CASTETS', 'MAXIME', 'CASTETS', 'CASTETS', 'FR02', 'ENT', 'HAN_ENT', 'HAN', 'ENT', '0050000174', 'CAP', '50', 'Employee', 'Employee_Contract_Status_Open', 'FM_FRA_00000618', 'Apprentice', 'TN0002', 'alternant', '2025-04-01', '2025-04-01', '0000-00-00', '0000-00-00', '2025-04-01', 'FRA0106394', 'NOT_EXISTS', 'FR', '', '', '', 'nan', '389002', 'mcastets@fmlogistic.com', 0, 0, 0, 1.00, 1.00, 'WD', '2025-04-17 12:00:19', '2025-04-17 12:00:23', '2025-06-25 17:24:42', NULL, NULL),
	(51, NULL, NULL, 'Laury', 'RENAU', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'FR02', 'PHG', NULL, NULL, 'PHG', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-08', '2025-08-04', NULL, NULL, NULL, NULL, NULL, 'FR', 'lrenau@fmlogistic.com', '+33 0786725856', NULL, NULL, NULL, 'lrenau@gmlogistic.com', 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- Listage de la structure de table borne. messenger_messages
CREATE TABLE IF NOT EXISTS `messenger_messages` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `headers` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue_name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `available_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `delivered_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  KEY `IDX_75EA56E016BA31DB` (`delivered_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table borne.messenger_messages : ~0 rows (environ)

-- Listage de la structure de table borne. migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table borne.migrations : ~11 rows (environ)
REPLACE INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '0001_01_01_000001_create_cache_table', 1),
	(2, '0001_01_01_000002_create_jobs_table', 1),
	(3, '2025_12_03_142511_create_type_people_table', 1),
	(4, '2025_12_03_142651_create_companies_table', 1),
	(5, '2025_12_03_144331_create_languages_table', 1),
	(6, '2025_12_03_144332_create_people_table', 1),
	(7, '2025_12_03_144654_create_plants_table', 1),
	(8, '2025_12_03_145140_create_appointments_table', 1),
	(9, '2025_12_03_145619_create_assignments_table', 1),
	(10, '2025_12_03_151039_create_mdm_workers_table', 1),
	(11, '2025_12_04_000000_create_users_table', 1),
	(12, '2025_12_15_095957_add_title_to_appointments_table', 2),
	(13, '2025_12_16_103501_create_appointment_person_table', 3);

-- Listage de la structure de table borne. people
CREATE TABLE IF NOT EXISTS `people` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `last_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile_phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type_people_id` bigint unsigned NOT NULL,
  `company_id` bigint unsigned DEFAULT NULL,
  `language_id` bigint unsigned DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `people_type_people_id_foreign` (`type_people_id`),
  KEY `people_company_id_foreign` (`company_id`),
  KEY `people_language_id_foreign` (`language_id`),
  CONSTRAINT `people_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`),
  CONSTRAINT `people_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`),
  CONSTRAINT `people_type_people_id_foreign` FOREIGN KEY (`type_people_id`) REFERENCES `type_people` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table borne.people : ~14 rows (environ)
REPLACE INTO `people` (`id`, `last_name`, `first_name`, `email`, `mobile_phone`, `type_people_id`, `company_id`, `language_id`, `is_active`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
	(1, 'Renau', 'Laury', 'lrenau@fmlogistic.com', NULL, 1, 5, NULL, 1, NULL, NULL, '2025-12-08 14:35:43', '2025-12-08 14:35:43'),
	(2, 'Bricole', 'Justin', 'jbricole@oboisdormant.com', NULL, 3, 8, NULL, 1, NULL, NULL, '2025-12-15 15:34:40', NULL),
	(3, 'Terrieur', 'Alex', 'aterrieur@vertdeterre.com', NULL, 3, 10, NULL, 1, NULL, NULL, '2025-12-15 15:34:41', NULL),
	(4, 'Terrieur', 'Alain', 'alterrieur@vertdeterre.com', NULL, 3, 10, NULL, 1, NULL, NULL, '2025-12-15 15:36:33', NULL),
	(5, 'Istance', 'Thérèse', 'tistance@phasecachee.com', NULL, 3, 7, NULL, 1, NULL, NULL, '2025-12-15 15:36:34', NULL),
	(6, 'Yé', 'Barry', 'bye@cledesol.com', NULL, 3, 9, NULL, 1, NULL, NULL, '2025-12-15 15:41:21', NULL),
	(7, 'Ouché', 'Debb', 'dbouche@eauxsecours.com', NULL, 3, 6, NULL, 1, NULL, NULL, '2025-12-15 15:37:29', NULL),
	(8, 'Ichrom', 'Paul', 'pichrome@muretmerveilles.com', NULL, 3, 11, NULL, 1, NULL, NULL, '2025-12-15 15:39:22', NULL),
	(15, 'Twalet', 'Aude', 'atwalet@marionnaud.com', NULL, 2, 4, NULL, 1, NULL, NULL, '2025-12-15 15:43:42', NULL),
	(16, 'Débarre', 'Yves', 'ydebarre@mars.com', NULL, 2, 1, NULL, 1, NULL, NULL, '2025-12-15 15:44:52', NULL),
	(17, 'Turé', 'Gérard', 'gture@bic.com', NULL, 2, 2, NULL, 1, NULL, NULL, '2025-12-15 15:45:24', NULL),
	(18, 'Ousse', 'Sam', 'sousse@bic.com', NULL, 2, 2, NULL, 1, NULL, NULL, '2025-12-15 15:46:08', NULL),
	(19, 'Killage', 'Emma', 'ekillage@marionnaud.com', NULL, 2, 4, NULL, 1, NULL, NULL, '2025-12-15 15:46:53', NULL),
	(22, 'Zett', 'Mélanie', 'mzette@mars.com', NULL, 2, 1, NULL, 1, NULL, NULL, '2025-12-15 15:47:31', NULL);

-- Listage de la structure de table borne. plants
CREATE TABLE IF NOT EXISTS `plants` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trigram` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `timezone` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'UTC',
  `pds_path` text COLLATE utf8mb4_unicode_ci,
  `pdp_path` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `plants_name_unique` (`name`),
  UNIQUE KEY `plants_trigram_unique` (`trigram`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table borne.plants : ~0 rows (environ)
REPLACE INTO `plants` (`id`, `name`, `trigram`, `timezone`, `pds_path`, `pdp_path`, `is_active`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
	(1, 'Phalsbourg', 'PHG', 'UTC', NULL, NULL, 1, NULL, NULL, NULL, NULL),
	(2, 'Château Thierry', 'CPE', 'UTC', NULL, NULL, 1, NULL, NULL, NULL, NULL);

-- Listage de la structure de table borne. type_people
CREATE TABLE IF NOT EXISTS `type_people` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `type_people_type_unique` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table borne.type_people : ~3 rows (environ)
REPLACE INTO `type_people` (`id`, `type`, `is_active`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
	(1, 'Collaborateur', 1, NULL, NULL, '2025-12-08 15:33:57', '2025-12-08 15:33:58'),
	(2, 'Visiteur', 1, NULL, NULL, '2025-12-15 09:42:55', NULL),
	(3, 'Intervenant', 1, NULL, NULL, '2025-12-15 09:42:56', NULL);

-- Listage de la structure de table borne. users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `person_id` bigint unsigned NOT NULL,
  `mdm_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_person_id_unique` (`person_id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_mdm_id_unique` (`mdm_id`),
  CONSTRAINT `users_person_id_foreign` FOREIGN KEY (`person_id`) REFERENCES `people` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table borne.users : ~0 rows (environ)
REPLACE INTO `users` (`id`, `person_id`, `mdm_id`, `email`, `remember_token`, `created_at`, `updated_at`, `is_active`) VALUES
	(1, 1, '112681443855182214094', 'lrenau@fmlogistic.com', NULL, '2025-12-08 14:43:27', '2025-12-15 11:44:52', 1);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
