DROP TABLE IF EXISTS `user_categories`;
CREATE TABLE `user_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A] Index',
  `name` varchar(60) COLLATE utf8_bin NOT NULL COMMENT 'Názov',
  `shortcut` varchar(6) COLLATE utf8_bin NOT NULL COMMENT 'Skratka',
  `main_category` enum('V','R','O','B') COLLATE utf8_bin NOT NULL DEFAULT 'R' COMMENT 'Hlavný druh kategórie(V-Vedenie; R-rodičia; O-ostatné',
  `move_to_shortcut` varchar(6) COLLATE utf8_bin DEFAULT NULL COMMENT 'Pri posune sa premenuje na skratku.',
  `poradie` int(11) NOT NULL DEFAULT 1 COMMENT 'Poradie položiek',
  `child_enable` tinyint(4) NOT NULL DEFAULT 1 COMMENT 'Povolenie zadať dieťa pre danú kategóriu',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Kategorie užívateľov';

DROP TABLE IF EXISTS `user_in_categories`;
CREATE TABLE `user_in_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A] Index',
  `id_user_main` int(11) NOT NULL COMMENT 'Id užívateľa',
  `id_user_categories` int(11) NOT NULL COMMENT 'Id_kategórie',
  `child` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT 'Meno a Priezvisko dieťaťa',
  PRIMARY KEY (`id`),
  KEY `id_user_main` (`id_user_main`),
  KEY `id_user_categories` (`id_user_categories`),
  CONSTRAINT `user_in_categories_ibfk_1` FOREIGN KEY (`id_user_main`) REFERENCES `user_main` (`id`),
  CONSTRAINT `user_in_categories_ibfk_2` FOREIGN KEY (`id_user_categories`) REFERENCES `user_categories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

ALTER TABLE `udaje`
ADD `separate_settings` tinyint NOT NULL DEFAULT '0' COMMENT 'Ak 1 tak má položka vlastnú časť nastavení';

INSERT INTO `udaje` (`id_user_roles`, `id_druh`, `id_udaje_typ`, `nazov`, `text`, `comment`, `separate_settings`) VALUES
(5,	NULL,	1,	'google-analytics',	'UA-52835371-1',	'Id pre google-analytics. Ak sa reťazec nezačína na \"UA-\" nie je akceptovaný.',	0);

ALTER TABLE `hlavne_menu_cast`
CHANGE `nazov` `view_name` varchar(50) COLLATE 'utf8_bin' NOT NULL DEFAULT 'Časť' COMMENT 'Názov časti' AFTER `id`;

