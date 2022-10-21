UPDATE `udaje` SET `separate_settings` = '01' WHERE `id_druh` = '5';

ALTER TABLE `hlavne_menu_cast`
DROP `nazov`;

DROP TABLE IF EXISTS `admin_menu`;
CREATE TABLE `admin_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
  `odkaz` varchar(50) COLLATE utf8_bin NOT NULL COMMENT 'Odkaz',
  `nazov` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'Názov položky',
  `id_user_roles` int(11) NOT NULL DEFAULT 4 COMMENT 'Id min úrovne registrácie',
  `avatar` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT 'Odkaz na avatar aj s relatívnou cestou od adresára www',
  `view` tinyint(4) NOT NULL DEFAULT 1 COMMENT 'Ak 1 položka sa zobrazí',
  PRIMARY KEY (`id`),
  KEY `id_registracia` (`id_user_roles`),
  CONSTRAINT `admin_menu_ibfk_2` FOREIGN KEY (`id_user_roles`) REFERENCES `user_roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Administračné menu';

INSERT INTO `admin_menu` (`id`, `odkaz`, `nazov`, `id_user_roles`, `avatar`, `view`) VALUES
(1,	'Homepage:',	'Úvod',	3,	'Matrilineare_icon_set/png/Places user home.png',	1),
(2,	'Lang:',	'Editácia jazykov',	5,	'Matrilineare_icon_set/png/Apps gwibber.png',	1),
(3,	'Slider:',	'Editácia slider-u',	4,	'Matrilineare_icon_set/png/Places folder pictures.png',	1),
(4,	'User:',	'Editácia užívateľov',	5,	'Matrilineare_icon_set/png/Places folder publicshare.png',	1),
(5,	'Verzie:',	'Verzie webu',	4,	'Matrilineare_icon_set/png/Apps terminator.png',	1),
(6,	'Udaje:',	'Údaje webu',	4,	'Matrilineare_icon_set/png/Categories preferences desktop.png',	1);

ALTER TABLE `dokumenty`
CHANGE `nazov` `name` varchar(50) COLLATE 'utf8mb3_bin' NOT NULL COMMENT 'Názov titulku pre daný dokument' AFTER `znacka`,
CHANGE `spec_nazov` `web_name` varchar(50) COLLATE 'utf8mb3_bin' NOT NULL COMMENT 'Špecifický názov dokumentu pre URL' AFTER `pripona`,
CHANGE `popis` `description` varchar(255) COLLATE 'utf8mb3_bin' NULL COMMENT 'Popis dokumentu' AFTER `web_name`,
CHANGE `subor` `main_file` varchar(255) COLLATE 'utf8mb3_bin' NOT NULL COMMENT 'Názov súboru s relatívnou cestou' AFTER `description`,
CHANGE `thumb` `thumb_file` varchar(255) COLLATE 'utf8mb3_bin' NULL COMMENT 'Názov súboru thumb pre obrázky a iné ' AFTER `main_file`,
CHANGE `zmena` `change` datetime NOT NULL COMMENT 'Dátum uloženia alebo opravy - časová pečiatka' AFTER `thumb_file`;

/** added 18.10.2022 **/
UPDATE `faktury` SET
`datum_ukoncenia` = NULL
WHERE `datum_ukoncenia` LIKE '0000-00-00';

/** added 21.10.2022 **/
INSERT INTO `user_resource` (`name`)
VALUES ('Api:Verzie');

INSERT INTO `user_permission` (`id_user_roles`, `id_user_resource`, `actions`)
VALUES ('3', '34', NULL);