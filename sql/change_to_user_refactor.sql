SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `user_main`;
CREATE TABLE `user_main` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
  `id_registracia` int(11) NOT NULL DEFAULT '0' COMMENT 'Úroveň registrácie',
  `id_user_profiles` int(11) DEFAULT NULL COMMENT 'Užívateľský profil',
  `username` varchar(50) COLLATE utf8_bin NOT NULL COMMENT 'Užívateľské meno',
  `password` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'Heslo',
  `meno` varchar(50) COLLATE utf8_bin NOT NULL COMMENT 'Meno',
  `priezvisko` varchar(50) COLLATE utf8_bin NOT NULL COMMENT 'Priezvisko',
  `email` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'Email',
  `activated` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Aktivácia',
  `banned` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Zazázaný',
  `ban_reason` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'Dôvod zákazu',
  `new_password_key` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT 'Kľúč nového hesla',
  `new_password_requested` datetime DEFAULT NULL COMMENT 'Čas požiadavky na nové heslo',
  `new_email` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT 'Nový email',
  `new_email_key` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT 'Kľúč nového emailu',
  `last_ip` varchar(40) COLLATE utf8_bin NOT NULL COMMENT 'Posledná IP',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Vytvorenie užívateľa',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Posledná zmena',
  PRIMARY KEY (`id`),
  KEY `id_registracia` (`id_registracia`),
  KEY `id_user_profiles` (`id_user_profiles`),
  CONSTRAINT `user_main_ibfk_1` FOREIGN KEY (`id_registracia`) REFERENCES `registracia` (`id`),
  CONSTRAINT `user_main_ibfk_2` FOREIGN KEY (`id_user_profiles`) REFERENCES `user_profiles` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hlavné údaje užívateľa';

INSERT INTO `user_main` (`id`, `id_registracia`, `id_user_profiles`,  `username`, `password`, `meno`, `priezvisko`, `email`, `activated`, `banned`, `ban_reason`, `new_password_key`, `new_password_requested`, `new_email`, `new_email_key`, `last_ip`, `created`, `modified`) VALUES
(1,	5, 1, 'petov',	'$2a$08$pWTgI.3Vkx.1GsoyX.ov7O7/YyN3P/pispAAgYQJdUG6V7LFt8oNq', 'Peter', 'Vojtech',	'petak23@gmail.com',	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	'217.12.48.22',	'2012-03-15 06:02:30',	'2014-12-08 06:48:37');

ALTER TABLE `dokumenty`
DROP FOREIGN KEY `dokumenty_ibfk_2`,
CHANGE `id_user_profiles` `id_user_main` int(11) NOT NULL DEFAULT '1' COMMENT 'Id užívateľa' AFTER `id_hlavne_menu`,
ADD FOREIGN KEY (`id_user_main`) REFERENCES `user_main` (`id`),
COMMENT='Prílohy k článkom';

ALTER TABLE `verzie`
DROP FOREIGN KEY `verzie_ibfk_1`,
CHANGE `id_user_profiles` `id_user_main` int(11) NOT NULL DEFAULT '1' COMMENT 'Id užívateľa' AFTER `id`,
CHANGE `cislo` `cislo` varchar(10) COLLATE 'utf8_bin' NOT NULL DEFAULT '' COMMENT 'Číslo verzie' AFTER `id_user_main`,
CHANGE `subory` `subory` varchar(255) COLLATE 'utf8_bin' NULL COMMENT 'Zmenené súbory' AFTER `cislo`,
CHANGE `text` `text` text COLLATE 'utf8_bin' NULL COMMENT 'Popis zmien' AFTER `subory`,
CHANGE `datum` `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Dátum a čas zmeny' AFTER `text`,
COMMENT='Verzie webu';

-- DROP TABLE IF EXISTS `clanok_komentar`;
-- CREATE TABLE `clanok_komentar` (
--   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
--   `id_hlavne_menu` int(11) NOT NULL COMMENT 'Id hl. menu, ku ktorému patrí',
--   `id_user_main` int(11) NOT NULL COMMENT 'Id užívateľa',
--   `text` text COLLATE utf8_bin NOT NULL COMMENT 'Komentár',
--   `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Dátum vytvorenia alebo zmeny',
--   PRIMARY KEY (`id`),
--   KEY `id_hlavne_menu` (`id_hlavne_menu`),
--   KEY `id_user_profiles` (`id_user_main`),
--   CONSTRAINT `clanok_komentar_ibfk_1` FOREIGN KEY (`id_hlavne_menu`) REFERENCES `hlavne_menu` (`id`),
--   CONSTRAINT `clanok_komentar_ibfk_2` FOREIGN KEY (`id_user_main`) REFERENCES `user_main` (`id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Komentáre k článokom';

DROP TABLE IF EXISTS `user_prihlasenie`;
CREATE TABLE `user_prihlasenie` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
  `id_user_main` int(11) NOT NULL COMMENT 'Id užívateľa',
  `log_in_datetime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Dátum a čas prihlásenia',
  PRIMARY KEY (`id`),
  KEY `id_user_profiles` (`id_user_main`),
  CONSTRAINT `user_prihlasenie_ibfk_1` FOREIGN KEY (`id_user_main`) REFERENCES `user_main` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Evidencia prihlásenia užívateľov';

ALTER TABLE `verzie`
ADD FOREIGN KEY (`id_user_main`) REFERENCES `user_main` (`id`);

-- DROP TABLE IF EXISTS `oznam_komentar`;
-- CREATE TABLE `oznam_komentar` (
--   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
--   `id_oznam` int(11) NOT NULL COMMENT 'Id oznamu, ku ktorému patrí',
--   `id_user_main` int(11) NOT NULL COMMENT 'Id užívateľa',
--   `text` text COLLATE utf8_bin NOT NULL COMMENT 'Komentár',
--   `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Časová značka',
--   PRIMARY KEY (`id`),
--   KEY `id_oznam` (`id_oznam`),
--   KEY `id_user_profiles` (`id_user_main`),
--   CONSTRAINT `oznam_komentar_ibfk_1` FOREIGN KEY (`id_oznam`) REFERENCES `oznam` (`id`),
--   CONSTRAINT `oznam_komentar_ibfk_2` FOREIGN KEY (`id_user_main`) REFERENCES `user_main` (`id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Komentáre k oznamom';

UPDATE `hlavne_menu` SET
`id_user_profiles` = '1',
`modified` = now()
WHERE ((`id` = '1') OR (`id` = '2') OR (`id` = '3') OR (`id` = '4') OR (`id` = '5') OR (`id` = '6') OR (`id` = '7') OR (`id` = '8') OR (`id` = '9') OR (`id` = '10'));

ALTER TABLE `hlavne_menu`
DROP FOREIGN KEY `hlavne_menu_ibfk_7`,
CHANGE `id_user_profiles` `id_user_main` int(11) NOT NULL DEFAULT '1' COMMENT 'Id užívateľa' AFTER `id_nadradenej`,
ADD FOREIGN KEY (`id_user_main`) REFERENCES `user_main` (`id`);

ALTER TABLE `oznam`
DROP FOREIGN KEY `oznam_ibfk_1`,
CHANGE `id_user_profiles` `id_user_main` int(11) NOT NULL DEFAULT '1' COMMENT 'Id užívateľa' AFTER `id`,
ADD FOREIGN KEY (`id_user_main`) REFERENCES `user_main` (`id`);

-- DROP TABLE IF EXISTS `debata`;
-- CREATE TABLE `debata` (
--   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
--   `id_user_main` int(11) NOT NULL DEFAULT '1' COMMENT 'Id užívateľa',
--   `text` text COLLATE utf8_bin NOT NULL COMMENT 'Text príspevku',
--   `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Časová pečiatka uloženia príspevku',
--   PRIMARY KEY (`id`),
--   KEY `kedy` (`timestamp`),
--   KEY `id_user_profiles` (`id_user_main`),
--   CONSTRAINT `debata_ibfk_1` FOREIGN KEY (`id_user_main`) REFERENCES `user_main` (`id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;



