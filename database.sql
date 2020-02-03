CREATE DATABASE `digistorm` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `digistorm`;

CREATE TABLE `countries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `iso` char(45) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `personal_details` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `date_of_birth` date NOT NULL,
  `country_birth_id` int(10) unsigned NOT NULL,
  `country_residence_id` int(10) unsigned NOT NULL,
  `email` varchar(150) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_prde_country_birth_id` (`country_birth_id`),
  KEY `fk_prde_country_residence_id` (`country_residence_id`),
  KEY `idx_prde_name` (`name`) USING BTREE,
  KEY `idx_prde_lastname` (`lastname`) USING BTREE,
  KEY `idx_prde_date_of_birth` (`date_of_birth`) USING BTREE,
  CONSTRAINT `fk_prde_country_birth_id` FOREIGN KEY (`country_birth_id`) REFERENCES `countries` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_prde_country_residence_id` FOREIGN KEY (`country_residence_id`) REFERENCES `countries` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# With ENUM for type field. I would prefer with address_types table
CREATE TABLE `addresses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('RESIDENTIAL','POSTAL','WORK') NOT NULL,
  `street_info` varchar(255) NOT NULL,
  `suburb` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `country_id` int(10) unsigned NOT NULL,
  `presonal_detail_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ad_country_id` (`country_id`),
  KEY `fk_ad_presonal_detail_id` (`presonal_detail_id`),
  CONSTRAINT `fk_ad_country_id` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ad_presonal_detail_id` FOREIGN KEY (`presonal_detail_id`) REFERENCES `personal_details` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `hobbies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `personal_details_hobbies` (
  `presonal_detail_id` int(10) unsigned NOT NULL,
  `hobby_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`presonal_detail_id`,`hobby_id`),
  KEY `fk_pedead_hobby_id` (`hobby_id`),
  KEY `fk_pedead_presonal_detail_id` (`presonal_detail_id`),
  CONSTRAINT `fk_pedead_hobby_id` FOREIGN KEY (`hobby_id`) REFERENCES `hobbies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_pedead_presonal_detail_id` FOREIGN KEY (`presonal_detail_id`) REFERENCES `personal_details` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;







