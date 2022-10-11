/* ---- added to master 26.09.2022 ----
DROP TABLE IF EXISTS `hlavne_menu_template`;
CREATE TABLE `hlavne_menu_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
  `name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT 'Názov vzhľadu',
  `description` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'Popis vzhľadu',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Vzhľad šablón pre položky menu';

INSERT INTO `hlavne_menu_template` (`id`, `name`, `description`) VALUES
(1,	'default',	'Základný vzhľad');

ALTER TABLE `dokumenty`
ADD `type` tinyint NULL DEFAULT '1' COMMENT 'Typ prílohy' AFTER `zobraz_v_texte`;

ALTER TABLE `hlavne_menu`
ADD `id_hlavne_menu_template` int NULL DEFAULT '1' COMMENT 'Vzhľad šablóny' AFTER `nazov_ul_sub`,
ADD FOREIGN KEY (`id_hlavne_menu_template`) REFERENCES `hlavne_menu_template` (`id`);

ALTER TABLE `hlavne_menu`
ADD `id_user_categories` int NULL COMMENT 'Opravnenie podľa kategórie',
ADD FOREIGN KEY (`id_user_categories`) REFERENCES `user_categories` (`id`);

ALTER TABLE `hlavne_menu_lang`
ADD `text` text COLLATE 'utf8_bin' NULL COMMENT 'Text článku v danom jazyku',
ADD `anotacia` varchar(255) COLLATE 'utf8_bin' NULL COMMENT 'Anotácia článku v danom jazyku' AFTER `text`;

INSERT INTO `user_resource` (`id`, `name`) VALUES
(21,	'Edit:Homepage'),
(22,	'Edit:User'),
(23,	'Edit:UserLog'),
(24,	'Edit:Clanky'),
(25,	'Admin:Products'),
(26,	'Front:Search'),
(27,	'Api:Menu'),
(28,	'Api:User'),
(29,	'Api:Dokumenty'),
(30,	'Api:Products'),
(31,	'Api:Texyla'),
(32,	'Api:Slider');

UPDATE `user_permission` SET `actions` = 'default' WHERE `id` = '3';

INSERT INTO `user_permission` (`id`, `id_user_roles`, `id_user_resource`, `actions`) VALUES
(31,	3,	21,	NULL),
(32,	1,	23,	'default,mailChange,passwordChange,activateNewEmail'),
(33,	4,	7,	'default,edit'),
(34,	4,	25,	NULL),
(35,	0,	26,	NULL),
(36,	0,	27,	'getsubmenu'),
(37,	4,	28,	NULL),
(38,	0,	29,	NULL),
(39,	4,	27,	NULL),
(40,	4,	30,	NULL),
(41,	0,	31,	NULL),
(42,	4,	32,	NULL);

ALTER TABLE `udaje`
ADD `id_user_main` int NULL COMMENT 'Id užívateľa, pre ktorého toto nastavenie platí.' AFTER `id_user_roles`,
ADD FOREIGN KEY (`id_user_main`) REFERENCES `user_main` (`id`);

** ---- end 26.09.2022 ------------*/

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

/** added 05.10.2022 **/
INSERT INTO `user_resource` (`name`)
VALUES ('Api:Faktury');

INSERT INTO `user_permission` (`id_user_roles`, `id_user_resource`, `actions`)
VALUES ('0', '33', 'default,item,getItems');

INSERT INTO `user_permission` (`id_user_roles`, `id_user_resource`, `actions`)
VALUES ('3', '33', 'add,edit,delete');

/** added 07.10.2022 **/
UPDATE `faktury` SET
`datum_ukoncenia` = NULL
WHERE `datum_ukoncenia` LIKE '0000-00-00';