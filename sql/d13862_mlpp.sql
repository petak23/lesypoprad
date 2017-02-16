-- Adminer 4.2.5 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `admin_menu`;
CREATE TABLE `admin_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
  `odkaz` varchar(50) COLLATE utf8_bin NOT NULL COMMENT 'Odkaz',
  `nazov` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'Názov položky',
  `id_registracia` int(11) NOT NULL DEFAULT '4' COMMENT 'Min. úroveň registrácie',
  `avatar` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT 'Odkaz na avatar aj s relatívnou cestou od adresára www',
  PRIMARY KEY (`id`),
  KEY `id_registracia` (`id_registracia`),
  CONSTRAINT `admin_menu_ibfk_1` FOREIGN KEY (`id_registracia`) REFERENCES `registracia` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Administračné menu';

INSERT INTO `admin_menu` (`id`, `odkaz`, `nazov`, `id_registracia`, `avatar`) VALUES
(1,	'Homepage:',	'Úvod',	3,	'ikonky/AzulLustre_icons/Cerrada.png'),
(2,	'Lang:',	'Editácia jazykov',	4,	'ikonky/AzulLustre_icons/Webfolder.png'),
(3,	'Slider:',	'Editácia slider-u',	4,	'ikonky/AzulLustre_icons/Imagenes.png'),
(4,	'User:',	'Editácia členov',	5,	'ikonky/AzulLustre_icons/Fuentes.png'),
(5,	'Verzie:',	'Verzie webu',	4,	'ikonky/AzulLustre_icons/URL_historial.png'),
(6,	'Udaje:',	'Údaje webu',	4,	'ikonky/AzulLustre_icons/Admin.png'),
(7,	'Oznam:',	'Aktuality(oznamy)',	4,	'ikonky/AzulLustre_icons/Documentos_azul.png'),
(8,	'Pokladnicka:',	'Pokladnička',	5,	'ikonky/AzulLustre_icons/Favoritos.png');

DROP TABLE IF EXISTS `clanok`;
CREATE TABLE `clanok` (
  `id_clanok` int(11) NOT NULL AUTO_INCREMENT,
  `id_hlavne_menu` int(11) NOT NULL DEFAULT '1' COMMENT 'Ak podclanok>0 tak nie hl. menu ale id nadradeného článku',
  `podclanok` int(11) NOT NULL DEFAULT '0' COMMENT 'Ak viac ako 0 je to podčlánok. Viac info. v helpe',
  `datum` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `datum_platnosti` date DEFAULT NULL,
  `nazov` varchar(80) COLLATE utf8_bin DEFAULT NULL,
  `text` text COLLATE utf8_bin,
  `id_clena` int(11) NOT NULL DEFAULT '0',
  `id_typ` int(11) NOT NULL DEFAULT '1',
  `id_reg` int(11) NOT NULL DEFAULT '0',
  `id_ikonka` int(11) NOT NULL DEFAULT '1' COMMENT 'Ak -1 tak je prázdny článok; 0 bez ikonky; >0 s ikonkou',
  `mazanie` tinyint(4) NOT NULL DEFAULT '0',
  `zmazane` tinyint(4) NOT NULL,
  `pocitadlo` int(11) NOT NULL DEFAULT '0',
  `postscript` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT 'Názov php skriptu, ktorý sa spustí po zobrazení článku aj s relatívnou cestou',
  PRIMARY KEY (`id_clanok`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='V tabuľke sú uložené rôzne články';

INSERT INTO `clanok` (`id_clanok`, `id_hlavne_menu`, `podclanok`, `datum`, `datum_platnosti`, `nazov`, `text`, `id_clena`, `id_typ`, `id_reg`, `id_ikonka`, `mazanie`, `zmazane`, `pocitadlo`, `postscript`) VALUES
(1,	-1,	0,	'2011-07-04 05:47:47',	NULL,	'O nÃ¡s',	'<p>\r\n	<strong>SpoloÄnosÅ¥ Mestsk&eacute; lesy, s r.o. Poprad</strong> vznikla dÅˆa 25.7.1997, &nbsp;na z&aacute;klade uznesenia MZ Ä. 31/1997 zo dÅˆa 17.4.1997.</p>\r\n<p>\r\n	ZaloÅ¾en&aacute; bola zakladateÄ¾skou listinou vo forme not&aacute;rskej z&aacute;pisnice ako spoloÄnosÅ¥ so 100 % - tnou &uacute;ÄasÅ¥ou mesta Poprad. Celkov&aacute; v&yacute;mera lesov ktor&eacute; spoloÄnosÅ¥ spravuje je 838,97 ha. Jedn&aacute; sa o lesn&yacute; majetok v katastr&aacute;lnom &uacute;zem&iacute; Poprad, VeÄ¾k&aacute;, Spi&scaron;sk&eacute; Bystr&eacute;, Hranovnica, St&aacute;Å¾e pod Tatrami. PrevaÅ¾n&aacute; ÄasÅ¥ lesov vo v&yacute;mere 556,99 ha s&uacute; hospod&aacute;rske lesy. Lesy osobitn&eacute;ho urÄenia zaberaj&uacute; v&yacute;meru 146,84 ha a lesy ochrann&eacute; 114,5 ha.</p>\r\n<p>\r\n	Na uvedenom majetku &nbsp;je najsevernej&scaron;ie poloÅ¾en&yacute; autocht&oacute;nny v&yacute;skyt duba zimn&eacute;ho na Slovensku, ktor&eacute;ho porasty siahaj&uacute; do v&yacute;&scaron;ky &nbsp;900 m.n.m. &nbsp;Z tohto d&ocirc;vodu bola t&aacute;to lokalita vyhlasen&aacute; v roku 1966 za N&aacute;rodn&uacute; pr&iacute;rodn&uacute; rezerv&aacute;ciu. V severnej Äasti sa nach&aacute;dza poÄ¾ovn&iacute;cky zvern&iacute;k Kvetnica na v&yacute;mere 21 ha, s chovom mufl&oacute;nej a diviaÄej zveri. Na vrchu Z&aacute;mÄisko sa nach&aacute;dza archeologick&aacute; lokalita Z&aacute;mÄisko.</p>\r\n',	3,	0,	0,	0,	0,	0,	2505,	NULL),
(2,	-1,	0,	'2011-07-04 05:50:14',	NULL,	'Kontakt',	'<h3>\r\n	Mestsk&eacute; lesy, s.r.o. Poprad</h3>\r\n<p>\r\n	LevoÄsk&aacute; 3312/37</p>\r\n<p>\r\n	Poprad, 058 01</p>\r\n<p>\r\n	tel: 0527724160</p>\r\n<p>\r\n	e-mail.: lesypp@stonline.sk</p>\r\n<p>\r\n	&nbsp;</p>\r\n',	3,	0,	0,	0,	0,	0,	3997,	'mail_info.php'),
(21,	3,	0,	'2011-09-13 17:18:07',	NULL,	'TuristickÃ© chodnÃ­ky',	'<p>\r\n	Na&scaron;a spoloÄnosÅ¥ Mestsk&eacute; lesy, s r.o.Poprad, ktor&aacute; spravuje lesy mesta Poprad, V&aacute;m pon&uacute;ka moÅ¾nosÅ¥ absolvovaÅ¥ turistick&eacute; trasy v Pr&iacute;mestsk&yacute;ch rekreaÄn&yacute;ch lesoch mesta Poprad. Tieto sa nach&aacute;dzaj&uacute; juÅ¾ne od mesta Poprad, zo z&aacute;padu ohraniÄen&eacute; &scaron;t&aacute;tnou cestou na Spi&scaron;sk&eacute; Bystr&eacute; a z v&yacute;chodu hranicou od Z&aacute;hradkovej osady Dubina k ObaÄ¾ovaÄke. Chodn&iacute;ky s&uacute; troch kateg&oacute;ri&iacute;.</p>\r\n',	3,	0,	0,	0,	0,	1,	99,	NULL),
(20,	3,	0,	'2011-06-15 19:08:13',	NULL,	'TuristickÃ© chodnÃ­ky',	'<p class=\"uvod\">\r\n	Pon&uacute;kame v&aacute;m tri upraven&eacute; turistick&eacute; chodn&iacute;ky s r&ocirc;znou n&aacute;roÄnosÅ¥ou v oblasti na&scaron;ich mestsk&yacute;ch lesoch.</p>\r\n<h2>\r\n	Nadpis 2</h2>\r\n<h3>\r\n	nadpis3</h3>\r\n<h4>\r\n	nadpis4</h4>\r\n<h3>\r\n	Trasa Poprad - Kvetnica - Z&aacute;mÄisko a sp&auml;Å¥</h3>\r\n<p>\r\n	<img alt=\"lesnï¿½ chodnï¿½k\" class=\"vlavo\" src=\"/subdom/vyvoj/ML/Filemanager/subory/Obrazky/chodnik.jpg\" style=\"width: 250px; height: 187px;\" />Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis sit amet diam nec libero dictum ullamcorper. Nullam justo libero, pulvinar vitae egestas rhoncus, feugiat sit amet nunc. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec eget eros a ligula sodales tincidunt. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis sit amet diam nec libero dictum ullamcorper. Nullam justo libero, pulvinar vitae egestas rhoncus, feugiat sit amet nunc. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec eget eros a ligula sodales tincidunt. Cras velit arcu, commodo id dictum eget, tempor eu mi. Maecenas eget elit lorem, et posuere nisl. Aliquam sit amet risus sapien. Suspendisse lorem sapien, viverra vel ultricies placerat, pellentesque dictum justo. Mauris sodales ipsum sit amet est blandit ullamcorper. Sed tempor, magna vel porttitor tempor, massa metus vehicula augue, a iaculis mi libero id eros. Praesent dignissim consectetur fringilla.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis sit amet diam nec libero dictum ullamcorper. Nullam justo libero, pulvinar vitae egestas rhoncus, feugiat sit amet nunc. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec eget eros a ligula sodales tincidunt. Cras velit arcu, commodo id dictum eget, tempor eu mi. Maecenas eget elit lorem, et posuere nisl. Aliquam sit amet risus sapien.</p>\r\n<p>\r\n	Suspendisse lorem sapien, viverra vel ultricies placerat, pellentesque dictum justo. Mauris sodales ipsum sit amet est blandit ullamcorper. Sed tempor, magna vel porttitor tempor, massa metus vehicula augue, a iaculis mi libero id eros. Praesent dignissim consectetur fringilla.</p>\r\n',	2,	0,	0,	0,	0,	1,	137,	NULL),
(5,	20,	3,	'2011-06-15 19:09:31',	NULL,	'2. Kvetnica - Obora - Kvetnica (2h)',	'<p>\r\n	2. Kvetnica - Obora - Kvetnica (2h) <em>Popis turistic&eacute;ho chodn&iacute;ka Ä.1<img alt=\"ChodnÃ­k\" src=\"Obr/Nahlady/chodnik.jpg\" style=\"width: 250px; height: 187px; float: left\" /></em></p>\r\n',	1,	0,	0,	0,	0,	1,	22,	NULL),
(6,	20,	3,	'2011-06-15 19:10:18',	NULL,	'1. Poprad - Kvetnica - ZÃ¡mÄisko (2.45 h)',	'<p>\r\n	1. Poprad - Kvetnica - Z&aacute;mÄisko (2.45 h) <em>Tuto bude popis 2. chodn&iacute;ka</em></p>\r\n',	1,	0,	0,	0,	0,	1,	30,	NULL),
(7,	3,	0,	'2011-06-15 19:10:44',	NULL,	'CyklochodnÃ­ky',	'<br />\r\n',	1,	0,	0,	0,	0,	1,	84,	NULL),
(8,	7,	3,	'2011-06-15 19:11:27',	NULL,	'Trasa Ä.1',	'<div id=\"lipsum\">\r\n	<p>\r\n		Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi imperdiet faucibus nisl et condimentum. Donec in nunc eget dolor lacinia pretium. Aenean enim erat, iaculis nec luctus vel, condimentum eu dui. Phasellus nec nisi dui. Nulla dictum dolor est, vitae fermentum nulla. Curabitur augue mauris, commodo non tristique euismod, aliquet viverra arcu. Donec in justo enim, in pharetra lorem. In hac habitasse platea dictumst. Ut malesuada metus ut sapien dapibus sodales. Nunc egestas justo ut tortor sagittis tincidunt. Mauris eget tristique dolor. Nulla nunc turpis, eleifend in suscipit ut, egestas sed erat. Cras tincidunt velit nec lacus ullamcorper accumsan.</p>\r\n	<p>\r\n		Aliquam imperdiet aliquet aliquet. Maecenas elementum fringilla pharetra. Vestibulum nisl ligula, elementum rutrum consequat in, fermentum eget diam. Phasellus lorem mi, ullamcorper ac tempus sed, posuere vitae velit. Suspendisse tempu<img alt=\"\" src=\"/subdom/vyvoj/ML/Filemanager/subory/Obrazky/chodnik.jpg\" style=\"width: 250px; height: 187px; float: left; margin-left: 10px; margin-right: 10px;\" />s fermentum tempus. Mauris hendrerit mauris libero, eget eleifend turpis. Duis ultrices turpis sit amet purus pellentesque nec aliquam dolor tempor. Proin sit amet odio leo, ut sagittis tortor. Proin in mi vitae massa interdum fringilla. Praesent iaculis ultrices metus, ac mollis leo euismod sed. Etiam eros erat, ullamcorper ac mattis sed, ullamcorper sed sapien. Etiam diam ipsum, mattis a scelerisque id, dictum vulputate tortor. Nullam dictum nunc et nibh viverra dignissim. Nam non sem vitae augue fermentum posuere. Nam vel consequat arcu. Cras ornare nisi nec odio molestie eu porta sem auctor.</p>\r\n	<p>\r\n		In molestie nunc nec nunc ullamcorper tincidunt. Aliquam auctor tincidunt sem. Duis cursus, justo a viverra consectetur, lacus lorem cursus sapien, vel vehicula leo odio sed enim. Phasellus tempor fringilla massa, a vehicula lorem suscipit non. Aliquam erat volutpat. Integer magna sem, mollis ut tristique vitae, luctus sit amet eros. Ut ac turpis magna, at scelerisque lectus. Proin tortor lectus, consequat et tempus a, commodo at dui. Cras feugiat odio ac tellus porta rutrum.</p>\r\n	<p>\r\n		Aliquam interdum neque elementum felis tincidunt id congue arcu sodales. In vulputate, mauris vel adipiscing luctus, quam l<strong><img alt=\"\" src=\"/subdom/vyvoj/ML/Filemanager/subory/zvernikpreberanie_007.jpg\" style=\"width: 188px; height: 251px;\" /></strong>igula eleifend purus, sed porta mi lorem faucibus urna. Mauris fringilla odio sit amet urna pharetra eget varius purus consequat. Etiam consectetur lacinia elit feugiat convallis. Integer viverra ornare dui eu sollicitudin. Proin ullamcorper tempor dolor ac egestas. Phasellus ipsum tortor, fermentum vel rhoncus ut, congue nec nunc. Vivamus at urna quis mauris commodo commodo. Pellentesque rutrum quam vitae eros gravida eget malesuada arcu euismod. Nullam aliquet interdum metus, at vestibulum risus rhoncus ac. Maecenas ornare sapien aliquam enim fringilla ut malesuada sem pellentesque. Morbi lacinia turpis a lacus auctor varius. Duis turpis est, interdum nec euismod non, semper id risus.</p>\r\n	<p>\r\n		Suspendisse eget ligula massa. Nunc ac velit lectus, sagittis aliquam ante. Duis tortor mauris, semper vitae sagittis vitae, ornare vitae mi. Nulla faucibus nulla vel est ornare bibendum eu eget justo. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent vel ultrices augue. In luctus tortor in nibh lacinia tristique. Curabitur in urna eget arcu consectetur vulputate. Donec a nisl lacus. Nam id eros nisi.</p>\r\n</div>\r\n<p>\r\n	<strong>tuto bude nejak&yacute; popis</strong></p>\r\n',	2,	0,	0,	0,	0,	1,	23,	NULL),
(9,	5,	0,	'2011-06-16 09:38:29',	NULL,	'Zmluvy',	'<br />\r\n',	1,	0,	0,	0,	0,	1,	13,	NULL),
(11,	20,	3,	'2011-06-17 10:39:04',	NULL,	'3. Poprad - Obora (3h)',	'<p>\r\n	3. Poprad - Obora (3h) A e&scaron;te nejak&yacute; siahodlh&yacute; popis tejto cesty.<img alt=\"\" src=\"Obr/Nahlady/cesta.jpg\" style=\"width: 187px; height: 250px; float: right\" /></p>\r\n',	1,	0,	0,	0,	0,	1,	15,	NULL),
(15,	3,	0,	'2011-07-27 07:46:24',	NULL,	'Sprievodca',	'<p>\r\n	<strong>Popis tejto Äasti webu.</strong>&nbsp;Tu by mal byÅ¥ kr&aacute;tky &uacute;vodn&yacute; text Äo v tejto Äasti Ä¾udia n&aacute;jdu. A mal by sa zobrazovaÅ¥ vÅ¾dy po kliknut&iacute; na sprievodcu. Napr:.</p>\r\n<p>\r\n	Sprievodca V&aacute;m pon&uacute;ka inform&aacute;cie o celej oblasti mestsk&yacute;ch lesov, prin&aacute;&scaron;a podrobn&eacute; info o turistick&yacute;ch chodn&iacute;koch, n&aacute;uÄn&yacute;ch chodn&iacute;koch, cyklotras&aacute;ch vr&aacute;tane m&aacute;p chodn&iacute;kov a tr&aacute;s. TieÅ¾ inform&aacute;cie o konkr&eacute;tnych Äastiach mestsk&yacute;ch lesov.</p>\r\n<p>\r\n	(A nemala by sa zobrazovaÅ¥ poloÅ¾ka v submenu).</p>\r\n',	2,	0,	0,	0,	0,	1,	80,	NULL),
(17,	3,	0,	'2011-08-04 18:32:48',	NULL,	'PeÅ¡ie chodnÃ­ky',	'<p>\r\n	V tejto Äasti bud&uacute; pe&scaron;ie chodn&iacute;ky. ÄŒ</p>\r\n',	3,	0,	0,	0,	0,	1,	14,	NULL),
(3,	-1,	0,	'2011-08-07 09:10:49',	NULL,	'CertifikÃ¡t FSC',	'<p>\r\n	Certifik&aacute;t FSC</p>\r\n',	1,	0,	0,	0,	0,	0,	626,	NULL),
(29,	2,	0,	'2012-02-06 09:17:01',	NULL,	'AktuÃ¡lna ponuka sluÅ¾ieb',	'<p>\r\n	Na&scaron;ou hlavnou ÄinnosÅ¥ou v oblasti obchodu a sluÅ¾ieb je predaj dreva. Venujeme sa aj pestovaniu a predaju saden&iacute;c v pr&iacute;pade ich prebytku a ako doplnkov&eacute; sluÅ¾by vykon&aacute;vame sprievodcovsk&uacute; ÄinnosÅ¥ v mestsk&yacute;ch lesoch.<br />\r\n	<br />\r\n	<strong>Predaj dreva.</strong><br />\r\n	<br />\r\n	SpoloÄnosÅ¥ realizuje predaj dreva za trhov&eacute; ceny. O aktu&aacute;lnych cen&aacute;ch jednotliv&yacute;ch sortimentov dreva sa dozviete na kontaktom Ä&iacute;sle na&scaron;ej spoloÄnosti.<br />\r\n	<br />\r\n	<strong>Predaj saden&iacute;c.</strong><br />\r\n	<br />\r\n	SpoloÄnosÅ¥ uskutoÄÅˆuje predaj prebytkov&yacute;ch obaÄ¾ovan&yacute;ch saden&iacute;c jednotliv&yacute;ch druhov drev&iacute;n. O aktu&aacute;lnej ponuke saden&iacute;c sa dozviete na kontaktom Äisle na&scaron;ej spoloÄnosti.<br />\r\n	<br />\r\n	<strong>Ostatn&eacute; sluÅ¾by.</strong><br />\r\n	<br />\r\n	Sprievodcovsk&aacute; ÄinnosÅ¥ je zabezpeÄovan&aacute; najm&auml; pre &scaron;koly z mesta Poprad po dohode s riaditeÄ¾om spoloÄnosti. K dispoz&iacute;ci&iacute; s&uacute; aj sprievodcovsk&eacute; materi&aacute;ly z n&aacute;uÄn&eacute;ho chodn&iacute;ka Kvetnica.</p>\r\n<p>\r\n	&nbsp;</p>\r\n',	3,	0,	0,	0,	0,	0,	5620,	NULL),
(4,	1,	0,	'2011-08-24 12:09:39',	NULL,	'VÃ¡Å¾enÃ­ priatelia,',	'<p style=\"text-align: justify;\">\r\n	SpoloÄnosÅ¥ <strong>Mestsk&eacute; lesy, s r.o. Poprad</strong> vznikla dÅˆa 25.7.1997,&nbsp; na z&aacute;klade uznesenia MZ Ä. 31/1997 zo dÅˆa 17.4.1997. ZaloÅ¾en&aacute; bola zakladateÄ¾skou listinou vo forme not&aacute;rskej z&aacute;pisnice ako spoloÄnosÅ¥ so 100 % - tnou &uacute;ÄasÅ¥ou mesta Poprad. Celkov&aacute; v&yacute;mera lesov ktor&eacute; spoloÄnosÅ¥ spravuje je 838,97 ha. Jedn&aacute; sa o lesn&yacute; majetok v katastr&aacute;lnom &uacute;zem&iacute; Poprad, VeÄ¾k&aacute;, Spi&scaron;sk&eacute; Bystr&eacute;, Hranovnica, St&aacute;Å¾e pod Tatrami. PrevaÅ¾n&aacute; ÄasÅ¥ lesov vo v&yacute;mere 556,99 ha s&uacute; hospod&aacute;rske lesy. Lesy osobitn&eacute;ho urÄenia zaberaj&uacute; v&yacute;meru 146,84 ha a lesy ochrann&eacute; 114,5 ha. Na uvedenom majetku&nbsp; je najsevernej&scaron;ie poloÅ¾en&yacute; autocht&oacute;nny v&yacute;skyt duba zimn&eacute;ho na Slovensku, ktor&eacute;ho porasty siahaj&uacute; do v&yacute;&scaron;ky&nbsp; 900 m.n.m.&nbsp; Z tohto d&ocirc;vodu bola t&aacute;to lokalita vyhlasen&aacute; v roku 1966 za N&aacute;rodn&uacute; pr&iacute;rodn&uacute; rezerv&aacute;ciu. V severnej Äasti sa nach&aacute;dza poÄ¾ovn&iacute;cky zvern&iacute;k Kvetnica na v&yacute;mere 21 ha, s chovom mufl&oacute;nej a diviaÄej zveri. Na vrchu Z&aacute;mÄisko sa nach&aacute;dza archeologick&aacute; lokalita Z&aacute;mÄisko.</p>\r\n',	3,	0,	0,	0,	0,	0,	53164,	'bloky/oznam_akt.php'),
(22,	21,	3,	'2011-09-13 17:24:40',	NULL,	'ZelenÃ¡ turistickÃ¡ trasa',	'<ul>\r\n	<li style=\"margin-bottom: 0cm;\">\r\n		Å½elezniÄn&aacute;&nbsp;stanica-Juh-G&aacute;novce-Kvetnica-Z&aacute;mÄisko</li>\r\n	<li style=\"margin-bottom: 0cm;\">\r\n		<strong>DÄºÅ¾ka: 9,5km</strong></li>\r\n	<li style=\"margin-bottom: 0cm;\">\r\n		<strong>ÄŒas: 2 hod.30 mi</strong><strong>n</strong></li>\r\n</ul>\r\n<p style=\"margin-bottom: 0cm;\">\r\n	<strong>â€‹</strong><a href=\"http://vyvoj.anigraph.eu/subdom/vyvoj/ML/index.php?clanok=6&amp;id_clanok=1&amp;cast=4\"><img alt=\"\" class=\"vlavo\" src=\"/subdom/vyvoj/ML/Filemanager/subory/Obrazky/Zelena_cesta/cestapreslop_065.jpg\" style=\"width: 200px; height: 150px;\" /></a></p>\r\n<p style=\"margin-bottom: 0cm;\">\r\n	&nbsp;</p>\r\n<p style=\"margin-bottom: 0cm;\">\r\n	<iframe align=\"left\" frameborder=\"0\" height=\"420\" marginheight=\"0\" marginwidth=\"0\" scrolling=\"no\" src=\"http://maps.google.sk/maps/ms?msa=0&amp;msid=202604252025853562296.0004adda493424df6ffd6&amp;ie=UTF8&amp;t=h&amp;vpsrc=6&amp;ll=49.014033,20.276899&amp;spn=0.011822,0.023561&amp;z=15&amp;output=embed\" style=\"display: block; clear: left; border: 4px #ccc solid; margin-top: 3ex;\" width=\"550\"></iframe><br />\r\n	<small>ZobraziÅ¥ <a href=\"http://maps.google.sk/maps/ms?msa=0&amp;msid=202604252025853562296.0004adda493424df6ffd6&amp;ie=UTF8&amp;t=h&amp;vpsrc=6&amp;ll=49.014033,20.276899&amp;spn=0.011822,0.023561&amp;z=15&amp;source=embed\" style=\"color:#0000FF;text-align:left\">Okruh zdravia</a> na v&auml;Ä&scaron;ej mape</small></p>\r\n',	2,	0,	0,	0,	0,	1,	66,	NULL),
(23,	3,	0,	'2011-09-27 15:17:15',	NULL,	'ZelenÃ¡ turistickÃ¡ trasa',	'<p>\r\n	Zelen&aacute; turistick&aacute; znaÄka V&aacute;s povedie trasou od Å½elezniÄnej stanici Poprad cez s&iacute;dlisko Juh, G&aacute;novce, Kvetnicu a&nbsp;konÄ&iacute; na k&oacute;te Z&aacute;mÄisko. Trasa je dlh&aacute; 9,5 km a&nbsp;prejdete ju za 2 hod. 30 min.</p>\r\n',	3,	0,	0,	0,	0,	0,	2186,	NULL),
(24,	3,	0,	'2011-09-27 15:21:55',	NULL,	'Okruh zdravia',	'<p style=\"text-align: justify;\">\r\n	Okruh zdravia je oznaÄen&yacute; Å¾ltou znaÄkou v&nbsp;tvare kruhu, ktor&yacute; zaÄ&iacute;na v Kvetnickom lesoparku. Okruh je dlh&yacute; 4,8 km a&nbsp;prejdete ho za 1 hodinu a 15 min&uacute;t. V &uacute;dolnej Äasti nad b&yacute;val&yacute;m LieÄebn&yacute;m &uacute;stavom Kvetnica V&aacute;s cesta povedie zmie&scaron;an&yacute;mi prevaÅ¾ne jedÄ¾ov&yacute;mi lesmi s bukom, jaseÅˆom a smrekom k alt&aacute;nku a studniÄke, odkiaÄ¾ sa vyjde na lokalitu Pod Kr&iacute;Å¾ov&aacute;. Od tohto miesta prejdete vrcholov&yacute;m chodn&iacute;kom na r&aacute;czestie, od ktor&eacute;ho&nbsp; chodn&iacute;k prech&aacute;dza dubov&yacute;mi lesmi aÅ¾ na vyhliadku. Z tohto miesta je kr&aacute;sny v&yacute;hÄ¾ad na ÄasÅ¥ Slovensk&eacute;ho raja, Kr&aacute;Ä¾ohoÄ¾sk&uacute; ÄasÅ¥ N&iacute;zkych Tatier a na Horn&aacute;dsku kotlinu. Z vyhliadky sa okolo Hor&aacute;rne dostanete sp&auml;Å¥ do Lesoparku na Kvetnici.</p>\r\n<p>\r\n	<iframe frameborder=\"0\" height=\"350\" marginheight=\"0\" marginwidth=\"0\" scrolling=\"no\" src=\"http://maps.google.sk/maps/ms?hl=sk&amp;vpsrc=1&amp;ctz=-60&amp;ie=UTF8&amp;msa=0&amp;msid=203736417966808765708.0004b0c089820d0b64221&amp;t=h&amp;ll=49.01359,20.274666&amp;spn=0.008937,0.016268&amp;output=embed\" width=\"425\"></iframe><br />\r\n	<small>ZobraziÅ¥ <a href=\"http://maps.google.sk/maps/ms?hl=sk&amp;vpsrc=1&amp;ctz=-60&amp;ie=UTF8&amp;msa=0&amp;msid=203736417966808765708.0004b0c089820d0b64221&amp;t=h&amp;ll=49.01359,20.274666&amp;spn=0.008937,0.016268&amp;source=embed\" style=\"color: rgb(0, 0, 255); text-align: left;\">Okruh zdravia</a> na v&auml;Ä&scaron;ej mape</small> ZobraziÅ¥ Okruh zdravia na v&auml;Ä&scaron;ej mape</p>\r\n',	3,	0,	0,	0,	0,	0,	7262,	NULL),
(25,	3,	0,	'2011-09-27 15:23:55',	NULL,	'NÃ¡uÄnÃ½ chodnÃ­k Kvetnica',	'<p style=\"text-align: justify;\">\r\n	N&aacute;uÄn&yacute; chodn&iacute;k Kvetnica je zameran&yacute; hlavne na prezent&aacute;ciu&nbsp; lesn&yacute;ch vegetaÄn&yacute;ch stupÅˆov Slovenska na malom &uacute;zem&iacute; Mestsk&yacute;ch lesov Poprad, historickej lokality Z&aacute;mÄisko a N&aacute;rodne pr&iacute;rodnej rezerv&aacute;cie Hranovn&iacute;cka dubina.&nbsp; Trasa n&aacute;uÄn&eacute;ho chodn&iacute;ka je okruÅ¾n&aacute;, s 9 n&aacute;uÄn&yacute;mi zast&aacute;vkami a s&nbsp;informaÄn&yacute;mi panelmi. Chodn&iacute;k sa zaÄ&iacute;na v&nbsp; Lesoparku Kvetnica a prech&aacute;dza lokalitami Z&aacute;mÄisko, Hor&aacute;reÅˆ, Hranovn&iacute;cka dubina,&nbsp; Vysov&aacute;, Zvern&iacute;k Kvetnica, Pod Kr&iacute;Å¾ov&aacute;. Na chodn&iacute;k sa m&ocirc;Å¾ete dostaÅ¥ z&nbsp;troch v&yacute;chodiskov&yacute;ch bodov &ndash; Kvetnica, Vysov&aacute;, Podstr&aacute;Åˆ. Prev&yacute;&scaron;enie vo v&yacute;chodnej Äasti na Z&aacute;mÄisko je 300 m, v&nbsp;z&aacute;padnej Äasti na Kr&iacute;Å¾ov&uacute; 400 m. DÄºÅ¾ka chodn&iacute;ka je 13,6 km a&nbsp;prejdete ho za 3 hod. 45 min. Vstupy na trase s&uacute; Ä¾ahko a&nbsp;r&yacute;chlo dostupn&eacute; k&nbsp;zast&aacute;vkam MHD.</p>\r\n',	3,	0,	0,	0,	0,	0,	4228,	NULL),
(26,	3,	0,	'2011-09-27 15:35:32',	NULL,	'CyklistickÃ½ okruh',	'<p>\r\n	<img alt=\"\" src=\"/subdom/vyvoj/ML/Filemanager/subory/Obrazky/plucnik.jpg\" style=\"width: 226px; height: 170px;\" /><img alt=\"\" src=\"/subdom/vyvoj/ML/Filemanager/subory/Obrazky/oboraH.jpg\" style=\"width: 171px; height: 171px;\" /></p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	Tento V&yacute;s povedie lokalitou Zvern&iacute;k Kvetnica, Vysov&aacute;, Kolieska, Hor&aacute;reÅˆ Kvetnica.</p>\r\n',	3,	0,	0,	0,	0,	1,	20,	NULL),
(30,	4,	3,	'2012-02-06 11:47:47',	NULL,	'VÃ½voj lesnÃ©ho majetku a prÃ¡vnych vzÅ¥ahov',	'<p>\r\n	Lesy v okol&iacute; miest Poprad, Spi&scaron;sk&aacute; Sobota, VeÄ¾k&aacute;, Str&aacute;Å¾e pod Tatrami do 15. storoÄia patrili prevaÅ¾ne panovn&iacute;kovi, ktor&yacute; ich prenajal alebo daroval nemeck&yacute;m &scaron;olt&yacute;som alebo cirkvi.</p>\r\n<p>\r\n	V 15 - 17 storoÄ&iacute; nastalo ustaÄ¾ovanie chot&aacute;rov miest na z&aacute;klade rozhodnut&iacute; Spi&scaron;skej komory.</p>\r\n<p>\r\n	R. 1763 - prv&eacute; mapovanie lesov</p>\r\n<p>\r\n	Do r. 1844 bolo spravovanie mestsk&yacute;ch lesov (ML) mestskou radou</p>\r\n<p>\r\n	R. 1845 - 1918 spravovanie ML Okresnou lesnou spr&aacute;vou Spi&scaron;sk&aacute; Teplica</p>\r\n<p>\r\n	R. 1892 - 1911 platnosÅ¥ prv&eacute;ho lesn&eacute;ho hospod&aacute;rskeho pl&aacute;nu (LHP) spracovan&eacute;ho na z&aacute;klade Terezi&aacute;nskeho lesn&eacute;ho poriadku</p>\r\n<p>\r\n	9. j&uacute;na 1902 - uznesen&iacute;m mestskej rady bol usporiadan&yacute; majetkovo - pr&aacute;vne lesn&yacute; majetok mesta Poprad na v&yacute;mere 428,7 ha</p>\r\n<p>\r\n	R. 1930 - lesn&yacute; majetok vzr&aacute;stol o 372,82 ha (mesto zamenilo lieÄebn&uacute; osadu Kvetnica za lesy Ministerstva Å¾elezn&iacute;c v katastri Spi&scaron;sk&eacute; Bystr&eacute;).</p>\r\n<p>\r\n	1. janu&aacute;r 1946 - Velick&yacute; les (124 ha) a Str&aacute;Å¾ansk&yacute; les (1,5 ha) sa stali s&uacute;ÄasÅ¥ou majetku mesta Poprad.</p>\r\n<p>\r\n	3. november 1950 - spr&aacute;va lesn&eacute;ho majetku odÅˆat&aacute; n&aacute;rodn&eacute;mu v&yacute;boru a prech&aacute;dza pod n&aacute;rodn&yacute; podnik ÄŒeskoslovensk&eacute; &scaron;t&aacute;tne lesy - Krajsk&aacute; spr&aacute;va lesov Ko&scaron;ice - Lesn&yacute; z&aacute;vod Spi&scaron;sk&aacute; Teplica (od r. 1953 Lesn&yacute; z&aacute;vod Poprad) a spr&aacute;vu Tanapu.</p>\r\n<p>\r\n	1. okt&oacute;ber 1992 - na z&aacute;klade z&aacute;kona Ä. 306/91 Zb. Ms&Uacute; Poprad uplatnil n&aacute;rok na svoj majetok u Od&scaron;tepn&eacute;ho lesn&eacute;ho z&aacute;vodu Poprad a navrhol dohodu o bezplatnom pren&aacute;jme od 1.10.1992 do 30.6.1993</p>\r\n<p>\r\n	15. j&uacute;la 1993&nbsp; - na z&aacute;klade z&aacute;kona SNR Ä. 306/1992 Zb. Ms&Uacute; Poprad predloÅ¾il v&yacute;pisy z pozemkovej knihy, identifik&aacute;ciu a pozemkov&eacute; mapy a tak splnil z&aacute;konn&eacute; podmienky na fyzick&eacute; prevzatie majetku.</p>\r\n<p>\r\n	11.4.1994 bola prevzat&aacute; odborn&aacute; spr&aacute;va lesov mestom Poprad</p>\r\n<p>\r\n	&nbsp;</p>\r\n',	3,	0,	0,	0,	0,	0,	2212,	NULL),
(31,	4,	3,	'2012-02-06 11:52:52',	NULL,	'Projekt ozdravnÃ½ch opatrenÃ­',	'<p>\r\n	1. Projekt ozdravn&yacute;ch opatren&iacute; v lesoch obhospodarovan&yacute;ch spoloÄnosÅ¥ou Mestsk&eacute; lesy, s.r.o. Poprad na roky 2010 - 2012.</p>\r\n<p>\r\n	Projekt bol zameran&yacute; na ozdravn&eacute; opatrenia v&nbsp;lesoch po&scaron;koden&yacute;ch biotick&yacute;mi, abiotick&yacute;mi a&nbsp;antropog&eacute;nnymi &scaron;kodliv&yacute;mi ÄiniteÄ¾mi, ktor&eacute; obhospodaruj&uacute; Mestsk&eacute; lesy, s.r.o. Poprad (MLP) a bol rozdelen&yacute; do dvoch hlavn&yacute;ch Äast&iacute;:</p>\r\n<p style=\"margin-left: 36pt;\">\r\n	1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; realiz&aacute;cia ozdravn&yacute;ch opatren&iacute;, kde sa realizovali nasledovn&eacute; opatrenia:</p>\r\n<ol>\r\n	<li>\r\n		pr&iacute;prava pl&ocirc;ch na obnovu lesa na v&yacute;mere 9,93 ha</li>\r\n	<li>\r\n		umel&aacute; obnova lesn&yacute;ch porastov na ploche 26,28 ha</li>\r\n	<li>\r\n		ochrana mlad&yacute;ch lesn&yacute;ch porastov proti burine vyÅ¾&iacute;nan&iacute;m na v&yacute;mere 113,71 ha</li>\r\n	<li>\r\n		ochrana mlad&yacute;ch lesn&yacute;ch porastov proti &nbsp;zveri obaÄ¾ovan&iacute;m na ploche 112,61 ha</li>\r\n	<li>\r\n		preÄistky &ndash; prerez&aacute;vky na v&yacute;mere 14,06 ha.</li>\r\n</ol>\r\n<p style=\"margin-left: 36pt;\">\r\n	2.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spr&iacute;stupnenie lokal&iacute;t s&nbsp;ozdravn&yacute;mi opatreniami.</p>\r\n<p>\r\n	Pre realiz&aacute;ciu jednotliv&yacute;ch ozdravn&yacute;ch opatren&iacute; bolo potrebn&eacute; dorie&scaron;iÅ¥ spr&iacute;stupnenie porastov lesn&yacute;mi cestami (LC). V&nbsp;r&aacute;mci projektu ozdravn&yacute;ch opatren&iacute; sa vykonala prestavba (rekon&scaron;trukcia)&nbsp; existuj&uacute;cich lesn&yacute;ch ciest triedy 3L Vysov&aacute; a&nbsp;Zvern&iacute;k - Kvetnica &nbsp;na spevnen&eacute; odvozn&eacute; lesn&eacute; cesty triedy 2L. Realiz&aacute;cia LC Zvernik - Kvetnica bola v rokoch 2009 - 2010&nbsp; v celkovej dÄºÅ¾ke 2386 m, kolaudovan&aacute; 14.9.2010 a LC Vysov&aacute; bola vykonan&aacute; v rokoch 2010 j- 2011 v celkovej dÄºÅ¾ke 4165 m, kolaudovan&aacute; 19.9.2011.</p>\r\n<p>\r\n	Na projekt bola pridelen&aacute; Äiastka 644515,26 eur. UkonÄen&yacute; bol 17.1.2012</p>\r\n',	3,	0,	0,	0,	0,	0,	1820,	NULL),
(32,	5,	0,	'2012-02-06 14:11:04',	NULL,	'PripravovanÃ© vÃ½zvy',	'<p>\r\n	Moment&aacute;lne spoloÄnosÅ¥ nepod&aacute;va Å¾iadne v&yacute;zvy na verejn&eacute; obstar&aacute;vanie</p>\r\n',	3,	0,	0,	0,	0,	0,	5268,	NULL),
(33,	6,	0,	'2012-03-16 07:47:09',	NULL,	'DEMO Projekt ',	'<p>\r\n	DEMO</p>\r\n<p>\r\n	Odkaz na projekt: (a tu sa vloÅ¾&iacute; odkaz na projekt) <a href=\"/Filemanager/subory/Projekty/DEMO_projekt.pdf\">DEMO projekt</a></p>\r\n',	1,	0,	0,	0,	0,	0,	20,	NULL),
(34,	5,	0,	'2013-11-26 13:11:05',	NULL,	'Profil verejnÃ©ho obstarÃ¡vateÄ¾a',	'<p style=\"padding: 0px 0px 13px; margin: 0px; color: rgb(255, 255, 255); font-size: 13px; font-family: Arial, Helvetica, sans-serif; line-height: 18px; background-color: rgb(29, 76, 7); text-align: justify;\">\r\n	<span style=\"padding: 0px; margin: 0px;\"><strong style=\"padding: 0px; margin: 0px;\">Identifik&aacute;cia verejn&eacute;ho obstar&aacute;vateÄ¾a</strong></span></p>\r\n<table border=\"0\" style=\"padding: 0px; margin: 0px; border-collapse: collapse; border: 0px; width: 333px; color: rgb(255, 255, 255); font-family: Arial, Helvetica, sans-serif; font-size: 13px; line-height: 18px; background-color: rgb(29, 76, 7);\">\r\n	<tbody style=\"padding: 0px; margin: 0px;\">\r\n		<tr style=\"padding: 0px; margin: 0px;\">\r\n			<td style=\"padding: 0px; margin: 0px; vertical-align: top;\" width=\"142\">\r\n				<strong style=\"padding: 0px; margin: 0px;\">N&aacute;zov:</strong></td>\r\n			<td style=\"padding: 0px; margin: 0px; vertical-align: top;\" width=\"190\">\r\n				Mestsk&eacute; lesy, s.r.o. Poprad</td>\r\n		</tr>\r\n		<tr style=\"padding: 0px; margin: 0px;\">\r\n			<td style=\"padding: 0px; margin: 0px; vertical-align: top;\">\r\n				<strong style=\"padding: 0px; margin: 0px;\">&Scaron;tatut&aacute;rny z&aacute;stupca:</strong></td>\r\n			<td style=\"padding: 0px; margin: 0px; vertical-align: top;\">\r\n				Ing. R&oacute;bert Dula</td>\r\n		</tr>\r\n		<tr style=\"padding: 0px; margin: 0px;\">\r\n			<td style=\"padding: 0px; margin: 0px; vertical-align: top;\">\r\n				<strong style=\"padding: 0px; margin: 0px;\">S&iacute;dlo:</strong></td>\r\n			<td style=\"padding: 0px; margin: 0px; vertical-align: top;\">\r\n				LevoÄsk&aacute; 3312/37<br style=\"padding: 0px; margin: 0px;\" />\r\n				058 01 Poprad</td>\r\n		</tr>\r\n		<tr style=\"padding: 0px; margin: 0px;\">\r\n			<td style=\"padding: 0px; margin: 0px; vertical-align: top;\">\r\n				<strong style=\"padding: 0px; margin: 0px;\">IÄŒO:</strong></td>\r\n			<td style=\"padding: 0px; margin: 0px; vertical-align: top;\">\r\n				36448311</td>\r\n		</tr>\r\n		<tr style=\"padding: 0px; margin: 0px;\">\r\n			<td style=\"padding: 0px; margin: 0px; vertical-align: top;\">\r\n				<strong style=\"padding: 0px; margin: 0px;\">DIÄŒ:</strong></td>\r\n			<td style=\"padding: 0px; margin: 0px; vertical-align: top;\">\r\n				2020017175</td>\r\n		</tr>\r\n		<tr style=\"padding: 0px; margin: 0px;\">\r\n			<td style=\"padding: 0px; margin: 0px; vertical-align: top;\">\r\n				<strong style=\"padding: 0px; margin: 0px;\">IÄŒ DPH:</strong></td>\r\n			<td style=\"padding: 0px; margin: 0px; vertical-align: top;\">\r\n				SK2020017175</td>\r\n		</tr>\r\n		<tr style=\"padding: 0px; margin: 0px;\">\r\n			<td style=\"padding: 0px; margin: 0px; vertical-align: top;\">\r\n				<strong style=\"padding: 0px; margin: 0px;\">Tel.:</strong></td>\r\n			<td style=\"padding: 0px; margin: 0px; vertical-align: top;\">\r\n				052/7724160</td>\r\n		</tr>\r\n		<tr style=\"padding: 0px; margin: 0px;\">\r\n			<td style=\"padding: 0px; margin: 0px; vertical-align: top;\">\r\n				<strong style=\"padding: 0px; margin: 0px;\">Mobil:</strong></td>\r\n			<td style=\"padding: 0px; margin: 0px; vertical-align: top;\">\r\n				0910 890 440</td>\r\n		</tr>\r\n		<tr style=\"padding: 0px; margin: 0px;\">\r\n			<td style=\"padding: 0px; margin: 0px; vertical-align: top;\">\r\n				<strong style=\"padding: 0px; margin: 0px;\">mail:</strong></td>\r\n			<td style=\"padding: 0px; margin: 0px; vertical-align: top;\">\r\n				<a href=\"mailto:lesy@lml.sk\" style=\"padding: 0px; margin: 0px; color: rgb(255, 255, 255);\">lesypp@stonline.sk</a><br />\r\n				&nbsp;</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<p>\r\n	&nbsp;</p>\r\n',	3,	0,	0,	0,	0,	0,	907,	NULL),
(35,	6,	0,	'2014-01-27 19:15:22',	NULL,	'ZÃ¡kazky Â§ 9 ods. 9 zÃ¡kona Ä. 25/2006',	'',	3,	0,	0,	0,	0,	0,	943,	NULL),
(36,	5,	0,	'2014-01-27 19:17:40',	NULL,	'ZÃ¡kazky Â§ 9 ods. 9 zÃ¡kona Ä. 25/2006',	'',	3,	0,	0,	0,	0,	0,	1140,	NULL),
(37,	36,	3,	'2014-01-27 19:22:52',	NULL,	'zÃ¡kazka 1/2013',	'<p>\r\n	Pletivo Polynet, zverejnen&eacute; 15.8.2013</p>\r\n<p>\r\n	D&aacute;tum podpisu 20.8.2013</p>\r\n<p>\r\n	&nbsp;</p>\r\n',	3,	0,	0,	0,	0,	0,	560,	NULL),
(39,	36,	3,	'2014-01-27 20:44:21',	NULL,	'zÃ¡kazka 2/2014',	'<h3 align=\"center\">\r\n	Ozn&aacute;menie o&nbsp;zad&aacute;van&iacute; z&aacute;kazky</h3>\r\n<p>\r\n	v r&aacute;mci postupu verejn&eacute;ho obstar&aacute;vania podÄ¾a &sect; 9 ods. 9 z&aacute;kona Ä. 25/2006 Z. z. o verejnom obstar&aacute;van&iacute; a o zmene a doplnen&iacute; niektor&yacute;ch z&aacute;konov v znen&iacute; neskor&scaron;&iacute;ch predpisov.</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p style=\"margin-left:21.3pt;\">\r\n	1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Identifik&aacute;cia verejn&eacute;ho obstar&aacute;vateÄ¾a:</strong></p>\r\n<p>\r\n	N&aacute;zov: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Mestsk&eacute; lesy, s.r.o. Poprad&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n<p>\r\n	&Scaron;tatut&aacute;rny org&aacute;n:&nbsp;&nbsp; Ing. R&oacute;bert Dula</p>\r\n<p>\r\n	S&iacute;dlo: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LevoÄsk&aacute; 3312/37, 058 01 Poprad&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n<p>\r\n	IÄŒO:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 36448311</p>\r\n<p>\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DIÄŒ:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2020017175</p>\r\n<p>\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IÄŒ DPH:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SK 2020017175</p>\r\n<p>\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n<p>\r\n	Kontaktn&aacute; osoba pre verejn&eacute; obstar&aacute;vanie: Ing. Dula</p>\r\n<p>\r\n	Telef&oacute;n: 0910890440</p>\r\n<p>\r\n	Pracovn&yacute; kontakt pre vysvetlenie ozn&aacute;menia o&nbsp;zad&aacute;van&iacute; z&aacute;kazky:</p>\r\n<p>\r\n	lesypp@stonline.sk</p>\r\n<p style=\"margin-left:18.0pt;\">\r\n	2.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>N&aacute;zov predmetu z&aacute;kazky: Sadenice lesn&yacute;ch drev&iacute;n</strong></p>\r\n<p style=\"margin-left:18.0pt;\">\r\n	Z&aacute;kazka (zmluva) je na: dodanie tovaru</p>\r\n<p style=\"margin-left:18.0pt;\">\r\n	3.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Podrobn&yacute; opis predmetu z&aacute;kazky: </strong></p>\r\n<p style=\"margin-left:18.0pt;\">\r\n	&nbsp;</p>\r\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"width:100.0%;\" width=\"100%\">\r\n	<tbody>\r\n		<tr>\r\n			<td style=\"width:45px;\">\r\n				<p>\r\n					&nbsp;</p>\r\n			</td>\r\n			<td>\r\n				<p>\r\n					Verejn&yacute; obstar&aacute;vateÄ¾ m&aacute; z&aacute;ujem o&nbsp;tovar spÄºÅˆaj&uacute;ci nasleduj&uacute;ce poÅ¾iadavky:</p>\r\n				<p>\r\n					&nbsp;</p>\r\n				<p>\r\n					<u>PoÅ¾iadavky na semen&aacute;rsku oblasÅ¥&nbsp; a&nbsp;v&yacute;&scaron;kov&yacute; prenos :</u></p>\r\n				<p>\r\n					Semen&aacute;rska oblasÅ¥&nbsp;&nbsp; podÄ¾a vyhl&aacute;&scaron;ky Ä. 501/2010 Z. z.&nbsp; o&nbsp;produkcii lesn&eacute;ho reprodukÄn&eacute;ho materi&aacute;lu a&nbsp;jeho uv&aacute;dzan&iacute; na trh</p>\r\n				<p>\r\n					<strong>Buk lesn&yacute;</strong></p>\r\n				<p style=\"margin-left:36.0pt;\">\r\n					1-Stredoslovensk&aacute;&nbsp; :&nbsp;&nbsp; poÄet saden&iacute;c pre lesn&yacute; vegetaÄn&yacute; stupeÅˆ&nbsp; 4&nbsp; = &nbsp;6860 ks</p>\r\n				<p>\r\n					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; poÄet saden&iacute;c pre lesn&yacute; vegetaÄn&yacute; stupeÅˆ&nbsp; 5&nbsp; = 22390 ks</p>\r\n				<p>\r\n					<strong>Smrekovec opadav&yacute;</strong></p>\r\n				<p style=\"margin-left:36.0pt;\">\r\n					2-Podtatransk&aacute;&nbsp; :&nbsp;&nbsp; poÄet saden&iacute;c pre lesn&yacute; vegetaÄn&yacute; stupeÅˆ&nbsp; 4&nbsp; =&nbsp; 2820 ks</p>\r\n				<p>\r\n					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; poÄet saden&iacute;c pre lesn&yacute; vegetaÄn&yacute; stupeÅˆ&nbsp; 5&nbsp; = 12920 ks</p>\r\n				<p>\r\n					<strong>Borovica lesn&aacute;</strong></p>\r\n				<p style=\"margin-left:36.0pt;\">\r\n					1-Severoslovensk&aacute;&nbsp; :&nbsp;&nbsp; poÄet saden&iacute;c pre lesn&yacute; vegetaÄn&yacute; stupeÅˆ&nbsp; 4&nbsp; =&nbsp; 7090 ks</p>\r\n				<p>\r\n					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; poÄet saden&iacute;c pre lesn&yacute; vegetaÄn&yacute; stupeÅˆ&nbsp; 5&nbsp; = 20210 ks</p>\r\n				<p>\r\n					<strong>Dub zimn&yacute;</strong></p>\r\n				<p style=\"margin-left:36.0pt;\">\r\n					4-Mimo &uacute;zemie oblast&iacute;:&nbsp; poÄet saden&iacute;c pre lesn&yacute; vegetaÄn&yacute; stupeÅˆ&nbsp; 4&nbsp; =&nbsp; 2770 ks</p>\r\n				<p>\r\n					&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</p>\r\n				<p>\r\n					Vek saden&iacute;c = min. 1 rok</p>\r\n				<p>\r\n					<strong>Sp&ocirc;sob pestovania = krytokorenn&eacute;</strong><br />\r\n					&nbsp;</p>\r\n				<p>\r\n					<u>PoÅ¾iadavky na kvalitu sadbov&eacute;ho materi&aacute;lu:</u><br />\r\n					V&yacute;&scaron;ka nadzemnej Äasti sc 15+ cm, bo 10+ cm, bk 15+ cm, db 15+ cm.<br />\r\n					In&eacute; poÅ¾iadavky na kvalitu - v s&uacute;lade s technickou normou STN 482211 Pestovanie lesov. Semen&aacute;Äiky a&nbsp;sadenice lesn&yacute;ch drev&iacute;n.</p>\r\n			</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<p>\r\n	&nbsp;</p>\r\n<p style=\"margin-left:18.0pt;\">\r\n	4.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Predpokladan&aacute; hodnota z&aacute;kazky (bez DPH):&nbsp; 15 763 &euro;</strong></p>\r\n<p style=\"margin-left:18.0pt;\">\r\n	&nbsp;</p>\r\n<p style=\"margin-left:18.0pt;\">\r\n	5.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Z&aacute;kladn&eacute; zmluvn&eacute; podmienky: </strong></p>\r\n<p>\r\n	-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Miesto dodania tovaru: s&iacute;dlo pred&aacute;vaj&uacute;ceho,&nbsp; verejn&yacute; obstar&aacute;vateÄ¾ si zabezpeÄ&iacute; prepravu tovaru na vlastn&eacute; n&aacute;klady</p>\r\n<p>\r\n	-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Lehota na dodanie predmetu z&aacute;kazky:</p>\r\n<p>\r\n	Rok 2014: cca 15. apr&iacute;l 2014 pr&iacute;padne dohodou podÄ¾a priebehu jarn&eacute;ho poÄasia</p>\r\n<p>\r\n	&nbsp;bo 27300 ks, sc 15740 ks</p>\r\n<p>\r\n	Rok 2015: cca 15. apr&iacute;l 2015, pr&iacute;padne dohodou poÄ¾a priebehu jarn&eacute;ho poÄasia</p>\r\n<p>\r\n	Bk 29250 ks, db 2770 ks.</p>\r\n<p>\r\n	-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SplatnosÅ¥ fakt&uacute;r: 21 dn&iacute; od doruÄenia fakt&uacute;ry.</p>\r\n<p style=\"margin-left:18.0pt;\">\r\n	6.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Lehota na predkladanie dokladov a&nbsp; pon&uacute;k&nbsp; : do 31.1.2014,&nbsp; 11.00 h.</strong></p>\r\n<p>\r\n	&nbsp;</p>\r\n<p style=\"margin-left:18.0pt;\">\r\n	7.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Stanovenie ceny</strong></p>\r\n<p>\r\n	-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Cenu je potrebn&eacute; spracovaÅ¥ na z&aacute;klade poÅ¾adovan&eacute;ho rozsahu a poÅ¾adovanej kvality a&nbsp;Äal&scaron;&iacute;ch poÅ¾iadaviek uveden&yacute;ch podÄ¾a ozn&aacute;menia o&nbsp;zad&aacute;van&iacute; z&aacute;kazky (Äalej len &bdquo;ozn&aacute;menia&ldquo;). Cenu je potrebn&eacute; uv&aacute;dzaÅ¥ v eur&aacute;ch (&euro;) bez DPH.&nbsp; Ak uch&aacute;dzaÄ nie je platcom DPH, uvedie t&uacute;to skutoÄnosÅ¥ v&nbsp;ponuke.</p>\r\n<p style=\"margin-left:18.0pt;\">\r\n	8.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Postup vo verejnom obstar&aacute;van&iacute;: </strong>je jednoetapov&yacute;.</p>\r\n<p style=\"margin-left:18.0pt;\">\r\n	9.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Verejn&yacute; obstar&aacute;vateÄ¾ neprip&uacute;&scaron;Å¥a rozdelenie z&aacute;kazky, </strong>t.j. uch&aacute;dzaÄ predloÅ¾&iacute; ponuku na cel&yacute; predmet z&aacute;kazky.</p>\r\n<p style=\"margin-left:18.0pt;\">\r\n	10.&nbsp; <strong>Predkladanie dokladov a ponuky:</strong></p>\r\n<p>\r\n	a)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Pri jednoetapovom postupe:</strong></p>\r\n<p>\r\n	Ponuku je potrebn&eacute; doplniÅ¥ do K&uacute;pnej zmluvy &ndash; pr&iacute;loha Ä. 1. a&nbsp;<strong><u>poslaÅ¥ v&nbsp;troch rovnopisoch</u></strong>&nbsp; v&yacute;luÄne na adresu s&iacute;dla spoloÄnosti podÄ¾a bodu 1. v&nbsp;uzatvorenej ob&aacute;lke s&nbsp;uveden&iacute;m <strong>n&aacute;zvu z&aacute;kazky,</strong> s&nbsp;oznaÄen&iacute;m &ndash; <strong>NEOTV&Aacute;RAÅ¤</strong>&ldquo; na adresu s&iacute;dla spoloÄnosti uveden&uacute; v&nbsp;bode 1. Ponuky sa predkladaj&uacute; v&nbsp;slovenskom jazyku. Ponuku uch&aacute;dzaÄ za&scaron;le spolu s&nbsp; dokladmi, ak s&uacute; poÅ¾adovan&eacute;. Ponuky zaslan&eacute; po term&iacute;ne,&nbsp; v&nbsp;inom jazyku, alebo ak doklady nebud&uacute; predloÅ¾en&eacute; podÄ¾a poÅ¾iadaviek verejn&eacute;ho obstar&aacute;vateÄ¾a alebo uch&aacute;dzaÄ nebude spÄºÅˆaÅ¥ podmienky &uacute;Äasti alebo nebude spÄºÅˆaÅ¥ poÅ¾iadavky na predmet z&aacute;kazky podÄ¾a ozn&aacute;menia o&nbsp;zad&aacute;van&iacute; z&aacute;kazky, tak&eacute;to ponuky nebud&uacute; bran&eacute; do &uacute;vahy a&nbsp;nebud&uacute; vyhodnocovan&eacute;.</p>\r\n<p style=\"margin-left:18.0pt;\">\r\n	11.&nbsp; <strong>Podmienky &uacute;Äasti s&uacute; nasledovn&eacute; <em>(ak s&uacute; vyÅ¾adovan&eacute;)</em>:</strong></p>\r\n<p>\r\n	-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; V ponuke je potrebn&eacute; predloÅ¾iÅ¥:</p>\r\n<p>\r\n	<u>Doklady</u>:&nbsp;</p>\r\n<p style=\"margin-left:54.0pt;\">\r\n	1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; K&oacute;piu opr&aacute;vnenia na dodanie tovaru (v&yacute;pis z&nbsp;OR, Å¾ivnostensk&yacute; list)</p>\r\n<p style=\"margin-left:54.0pt;\">\r\n	2.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; K&oacute;piu osvedÄenia o odbornej sp&ocirc;sobilosti na ÄinnosÅ¥ s lesn&yacute;m reprodukÄn&yacute;m materi&aacute;lom podÄ¾a &sect; 17 z&aacute;k. Ä. 138/2010 Z. z.</p>\r\n<p style=\"margin-left:54.0pt;\">\r\n	3.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; K&oacute;piu listu o p&ocirc;vode reprodukÄn&eacute;ho materi&aacute;lu.</p>\r\n<p style=\"margin-left:54.0pt;\">\r\n	&nbsp;</p>\r\n<p style=\"margin-left:54.0pt;\">\r\n	12.&nbsp; <strong>Krit&eacute;ria</strong> na hodnotenie pon&uacute;k s&uacute;: 1. cena.</p>\r\n<p style=\"margin-left:18.0pt;\">\r\n	13.&nbsp; Sp&ocirc;sob hodnotenia krit&eacute;ri&aacute;&nbsp; je nasledovn&yacute;: &Uacute;spe&scaron;n&yacute;m uch&aacute;dzaÄom bude ten, kto bude maÅ¥ najniÅ¾&scaron;iu celkov&uacute; cenu za cel&yacute; predmet z&aacute;kazky a&nbsp;spln&iacute; v&scaron;etky&nbsp;&nbsp; poÅ¾iadavky uveden&eacute; v&nbsp;opise predmetu z&aacute;kazky.</p>\r\n<p style=\"margin-left:18.0pt;\">\r\n	14.&nbsp; <strong>Prijatie ponuky:</strong></p>\r\n<p style=\"margin-left:18.0pt;\">\r\n	S &uacute;spe&scaron;n&yacute; uch&aacute;dzaÄom bude uzatvoren&aacute; zmluva, ktor&aacute; je pr&iacute;lohou tohto ozn&aacute;menia. &nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p style=\"margin-left:18.0pt;\">\r\n	15.&nbsp; Verejn&yacute; obstar&aacute;vateÄ¾ m&ocirc;Å¾e pred podpisom zmluvy poÅ¾iadaÅ¥ &uacute;spe&scaron;n&eacute;ho uch&aacute;dzaÄa o predloÅ¾enie origin&aacute;lu alebo overenej k&oacute;pie opr&aacute;vnenia&nbsp; na dodanie tovaru, pr&iacute;padne Äal&scaron;&iacute;ch poÅ¾adovan&yacute;ch dokladov podÄ¾a ozn&aacute;menia, ak boli predloÅ¾en&eacute; iba fotok&oacute;pie dokladov.</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p style=\"margin-left:283.2pt;\">\r\n	...................................................</p>\r\n<p>\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ing. R&oacute;bert Dula</p>\r\n<p>\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; konateÄ¾</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	<em><u>Pr&iacute;lohy:</u> </em></p>\r\n<p style=\"margin-left:72.0pt;\">\r\n	1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; K&uacute;pna zmluva</p>\r\n<p style=\"margin-left:54.0pt;\">\r\n	&nbsp;</p>\r\n<p align=\"center\">\r\n	<strong>K&nbsp;&Uacute; P N A&nbsp;&nbsp; &nbsp;Z&nbsp;M L U&nbsp;V&nbsp;A</strong></p>\r\n<p align=\"center\">\r\n	ÄŒ.: &nbsp;</p>\r\n<p align=\"center\">\r\n	uzatvoren&aacute; podÄ¾a &sect; 409 a&nbsp;nasl. z&aacute;kona Ä. 513/91 Zb. &ndash; Obchodn&yacute; z&aacute;konn&iacute;k v&nbsp;znen&iacute; neskor&scaron;&iacute;ch predpisov</p>\r\n<p align=\"center\">\r\n	m e d z&nbsp;i</p>\r\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n	<tbody>\r\n		<tr>\r\n			<td style=\"width:319px;\">\r\n				<p style=\"margin-left:14.2pt;\">\r\n					KUPUJ&Uacute;CI</p>\r\n			</td>\r\n			<td style=\"width:295px;\">\r\n				<p style=\"margin-left:8.8pt;\">\r\n					&nbsp;</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width:319px;\">\r\n				<p style=\"margin-left:14.2pt;\">\r\n					Mestsk&eacute; lesy, s.r.o. Poprad</p>\r\n			</td>\r\n			<td style=\"width:295px;\">\r\n				<p style=\"margin-left:8.8pt;\">\r\n					&nbsp;</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width:319px;\">\r\n				<p style=\"margin-left:14.2pt;\">\r\n					LevoÄsk&aacute; 3312/37</p>\r\n			</td>\r\n			<td style=\"width:295px;\">\r\n				<p style=\"margin-left:8.8pt;\">\r\n					&nbsp;</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width:319px;\">\r\n				<p style=\"margin-left:14.2pt;\">\r\n					058 01 Poprad</p>\r\n			</td>\r\n			<td style=\"width:295px;\">\r\n				<p style=\"margin-left:8.8pt;\">\r\n					&nbsp;</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width:319px;\">\r\n				<p style=\"margin-left:14.2pt;\">\r\n					&nbsp;</p>\r\n			</td>\r\n			<td style=\"width:295px;\">\r\n				<p style=\"margin-left:8.8pt;\">\r\n					&nbsp;</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width:319px;\">\r\n				<p style=\"margin-left:14.2pt;\">\r\n					V zast&uacute;pen&iacute;: Ing. R&oacute;bert Dula</p>\r\n			</td>\r\n			<td style=\"width:295px;\">\r\n				<p style=\"margin-left:8.8pt;\">\r\n					&nbsp;</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width:319px;\">\r\n				<p style=\"margin-left:14.2pt;\">\r\n					KonateÄ¾ spoloÄnosti</p>\r\n			</td>\r\n			<td style=\"width:295px;\">\r\n				<p style=\"margin-left:8.8pt;\">\r\n					&nbsp;</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width:319px;\">\r\n				<p style=\"margin-left:14.2pt;\">\r\n					Osoba opr&aacute;vnen&aacute; konaÅ¥ vo veci z&aacute;kazky</p>\r\n			</td>\r\n			<td style=\"width:295px;\">\r\n				<p style=\"margin-left:8.8pt;\">\r\n					&nbsp;</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width:319px;\">\r\n				<p style=\"margin-left:14.2pt;\">\r\n					IÄŒO: 36&nbsp;448 311</p>\r\n			</td>\r\n			<td style=\"width:295px;\">\r\n				<p style=\"margin-left:8.8pt;\">\r\n					&nbsp;</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width:319px;\">\r\n				<p style=\"margin-left:14.2pt;\">\r\n					DIÄŒ: 2020017175</p>\r\n			</td>\r\n			<td style=\"width:295px;\">\r\n				<p style=\"margin-left:8.8pt;\">\r\n					&nbsp;</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width:319px;\">\r\n				<p style=\"margin-left:14.2pt;\">\r\n					IÄŒ DPH: SK2020017175</p>\r\n			</td>\r\n			<td style=\"width:295px;\">\r\n				<p style=\"margin-left:8.8pt;\">\r\n					&nbsp;</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width:319px;\">\r\n				<p style=\"margin-left:14.2pt;\">\r\n					ÄŒ. &uacute;.:&nbsp; 4310021809/3100</p>\r\n			</td>\r\n			<td style=\"width:295px;\">\r\n				<p style=\"margin-left:8.8pt;\">\r\n					&nbsp;</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width:319px;\">\r\n				<p style=\"margin-left:14.2pt;\">\r\n					PeÅˆ. &uacute;stav: Sberbank, a.s.</p>\r\n			</td>\r\n			<td style=\"width:295px;\">\r\n				<p style=\"margin-left:8.8pt;\">\r\n					&nbsp;</p>\r\n			</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n	<tbody>\r\n		<tr>\r\n			<td style=\"width:295px;\">\r\n				<p style=\"margin-left:8.8pt;\">\r\n					PRED&Aacute;VAJ&Uacute;CI</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width:295px;\">\r\n				<p style=\"margin-left:8.8pt;\">\r\n					Obchodn&eacute; meno :</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width:295px;\">\r\n				<p style=\"margin-left:8.8pt;\">\r\n					S&iacute;dlo:</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width:295px;\">\r\n				<p style=\"margin-left:8.8pt;\">\r\n					V&nbsp;zast&uacute;pen&iacute;:</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width:295px;\">\r\n				<p style=\"margin-left:8.8pt;\">\r\n					Kontaktn&yacute; e-mail</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width:295px;\">\r\n				<p>\r\n					&nbsp;</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width:295px;\">\r\n				<p style=\"margin-left:8.8pt;\">\r\n					IÄŒO:</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width:295px;\">\r\n				<p style=\"margin-left:8.8pt;\">\r\n					DIÄŒ:</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width:295px;\">\r\n				<p style=\"margin-left:8.8pt;\">\r\n					IÄŒ pre DPH:</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width:295px;\">\r\n				<p style=\"margin-left:8.8pt;\">\r\n					ÄŒ. &uacute;.:&nbsp;</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width:295px;\">\r\n				<p style=\"margin-left:8.8pt;\">\r\n					PeÅˆ. &uacute;stav:</p>\r\n			</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<p align=\"center\">\r\n	Za nasledovn&yacute;ch podmienok :</p>\r\n<p align=\"center\">\r\n	<strong>I.</strong></p>\r\n<p align=\"center\">\r\n	<strong>PREDMET ZMLUVY</strong></p>\r\n<p>\r\n	1.Pred&aacute;vaj&uacute;ci sa zav&auml;zuje na z&aacute;klade zmluvy dodaÅ¥ v&nbsp;niÅ¾&scaron;ie dohodnutom mnoÅ¾stve, kvalite a&nbsp;Äase &nbsp;&nbsp;predmet zmluvy a&nbsp;kupuj&uacute;ci sa zav&auml;zuje tento prevziaÅ¥ a&nbsp;uhradiÅ¥ k&uacute;pnu cenu.</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p style=\"margin-left:72.0pt;\">\r\n	<strong>2.&nbsp;&nbsp;&nbsp;&nbsp; </strong><strong>Dod&aacute;vka tovaru pre rok 2014</strong></p>\r\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"width:100.0%;\" width=\"100%\">\r\n	<tbody>\r\n		<tr>\r\n			<td style=\"width:12.02%;height:28px;\">\r\n				<p align=\"center\">\r\n					<strong>Druh dreviny</strong></p>\r\n				<p>\r\n					&nbsp;</p>\r\n			</td>\r\n			<td style=\"width:11.68%;height:28px;\">\r\n				<p align=\"center\">\r\n					<strong>MnoÅ¾stvo</strong></p>\r\n				<p align=\"center\">\r\n					<strong>( ks )</strong></p>\r\n			</td>\r\n			<td style=\"width:39.14%;height:28px;\">\r\n				<p align=\"center\">\r\n					<strong>Sp&ocirc;sob pestovania, v&yacute;&scaron;ka a&nbsp;in&eacute; rozmery</strong></p>\r\n			</td>\r\n			<td style=\"width:18.06%;height:28px;\">\r\n				<p>\r\n					<strong>P&ocirc;vod (sem. oblasÅ¥, v&yacute;&scaron;k. z&oacute;na)</strong></p>\r\n				<p align=\"center\" style=\"margin-left:5.05pt;\">\r\n					&nbsp;</p>\r\n			</td>\r\n			<td style=\"width:19.1%;height:28px;\">\r\n				<p>\r\n					<strong>Vek saden&iacute;c</strong></p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width:12.02%;\">\r\n				<p>\r\n					Smrekovec opadav&yacute;</p>\r\n				<p>\r\n					&nbsp;</p>\r\n			</td>\r\n			<td style=\"width:11.68%;\">\r\n				<p align=\"center\">\r\n					15740</p>\r\n			</td>\r\n			<td style=\"width:39.14%;\">\r\n				<p>\r\n					ObaÄ¾ovan&eacute;, v&yacute;&scaron;ka <u>nÄ &nbsp;15+ cm</u></p>\r\n			</td>\r\n			<td style=\"width:18.06%;\">\r\n				<p style=\"margin-left:5.05pt;\">\r\n					sem. oblasÅ¥ podtatransk&aacute;, v&yacute;&scaron;k. z&oacute;na 4 alebo 5</p>\r\n			</td>\r\n			<td style=\"width:19.1%;\">\r\n				<p style=\"margin-left:5.05pt;\">\r\n					min. 1 - rok</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width:12.02%;height:52px;\">\r\n				<p>\r\n					Borovica lesn&aacute;</p>\r\n				<p>\r\n					&nbsp;</p>\r\n			</td>\r\n			<td style=\"width:11.68%;height:52px;\">\r\n				<p align=\"center\">\r\n					27300</p>\r\n			</td>\r\n			<td style=\"width:39.14%;height:52px;\">\r\n				<p>\r\n					ObaÄ¾ovan&eacute;, v&yacute;&scaron;ka <u>nÄ &nbsp;10+</u> cm,</p>\r\n			</td>\r\n			<td style=\"width:18.06%;height:52px;\">\r\n				<p style=\"margin-left:5.05pt;\">\r\n					sem. oblasÅ¥ severoslovensk&aacute;, v&yacute;&scaron;k. z&oacute;na 4 alebo 5</p>\r\n			</td>\r\n			<td style=\"width:19.1%;height:52px;\">\r\n				<p style=\"margin-left:5.05pt;\">\r\n					min. 1 - rok</p>\r\n			</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<p>\r\n	<u>Vysvetlivky :</u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <u>nÄ</u>&nbsp; &ndash;&nbsp; nadzemn&aacute; ÄasÅ¥</p>\r\n<p>\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n<p style=\"margin-left:72.0pt;\">\r\n	<strong>3.&nbsp;&nbsp;&nbsp;&nbsp; </strong><strong>Dod&aacute;vka tovaru pre rok 2015</strong></p>\r\n<p>\r\n	&nbsp;</p>\r\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"width:100.0%;\" width=\"100%\">\r\n	<tbody>\r\n		<tr>\r\n			<td style=\"width:12.02%;height:28px;\">\r\n				<p align=\"center\">\r\n					<strong>Druh dreviny</strong></p>\r\n				<p>\r\n					&nbsp;</p>\r\n			</td>\r\n			<td style=\"width:11.7%;height:28px;\">\r\n				<p align=\"center\">\r\n					<strong>MnoÅ¾stvo</strong></p>\r\n				<p align=\"center\">\r\n					<strong>( ks )</strong></p>\r\n			</td>\r\n			<td style=\"width:39.16%;height:28px;\">\r\n				<p align=\"center\">\r\n					<strong>V&yacute;&scaron;ka a&nbsp;in&eacute; rozmery</strong></p>\r\n			</td>\r\n			<td style=\"width:18.0%;height:28px;\">\r\n				<p>\r\n					<strong>P&ocirc;vod (sem. oblasÅ¥, v&yacute;&scaron;k. z&oacute;na)</strong></p>\r\n				<p align=\"center\" style=\"margin-left:5.05pt;\">\r\n					&nbsp;</p>\r\n			</td>\r\n			<td style=\"width:19.12%;height:28px;\">\r\n				<p>\r\n					<strong>Vek saden&iacute;c</strong></p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width:12.02%;\">\r\n				<p>\r\n					Buk lesn&yacute;</p>\r\n			</td>\r\n			<td style=\"width:11.7%;\">\r\n				<p align=\"center\">\r\n					29250</p>\r\n			</td>\r\n			<td style=\"width:39.16%;\">\r\n				<p>\r\n					ObaÄ¾ovan&eacute;, v&yacute;&scaron;ka <u>nÄ 15+</u> cm,</p>\r\n			</td>\r\n			<td style=\"width:18.0%;\">\r\n				<p style=\"margin-left:5.05pt;\">\r\n					sem. oblasÅ¥ stredoslovensk&aacute;, v&yacute;&scaron;k. z&oacute;na 4 alebo 5</p>\r\n			</td>\r\n			<td style=\"width:19.12%;\">\r\n				<p style=\"margin-left:5.05pt;\">\r\n					min. 1 - rok</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width:12.02%;\">\r\n				<p>\r\n					Dub zimn&yacute;</p>\r\n			</td>\r\n			<td style=\"width:11.7%;\">\r\n				<p align=\"center\">\r\n					2770</p>\r\n			</td>\r\n			<td style=\"width:39.16%;\">\r\n				<p>\r\n					ObaÄ¾ovan&eacute;, v&yacute;&scaron;ka <u>nÄ 15+ cm</u></p>\r\n			</td>\r\n			<td style=\"width:18.0%;\">\r\n				<p style=\"margin-left:5.05pt;\">\r\n					sem. oblasÅ¥ mimo &uacute;zemia oblast&iacute;, v&yacute;&scaron;k. z&oacute;na 4</p>\r\n			</td>\r\n			<td style=\"width:19.12%;\">\r\n				<p style=\"margin-left:5.05pt;\">\r\n					min. 1 - rok</p>\r\n			</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	<u>Vysvetlivky :</u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <u>nÄ</u>&nbsp; &ndash;&nbsp; nadzemn&aacute; ÄasÅ¥</p>\r\n<p>\r\n	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p>\r\n<p>\r\n	4.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Pred&aacute;vaj&uacute;ci ako aj kupuj&uacute;ci nezodpoved&aacute; za to, Å¾e tovar nie je dodan&yacute; ako aj odobrat&yacute; z&nbsp;d&ocirc;vodu Å¾iveln&yacute;ch udalost&iacute;, poÅ¾iarov, z&aacute;plav, kalam&iacute;t, b&uacute;rok, &scaron;trajkov, pracovnopr&aacute;vnych sporov, obÄianskych nepokojov, obmedzen&iacute; alebo ak&yacute;chkoÄ¾vek in&yacute;ch okolnost&iacute;, ktor&eacute; s&uacute; &uacute;plne mimo jeho kontrolu&nbsp; (vy&scaron;&scaron;ia moc).</p>\r\n<p>\r\n	5.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kvalitat&iacute;vne a&nbsp;technick&eacute; podmienky: podÄ¾a STN 48 22 11</p>\r\n<p align=\"center\">\r\n	<strong>II.</strong></p>\r\n<p align=\"center\">\r\n	<strong>K&Uacute;PNA CENA</strong></p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Cena predmetu je urÄen&aacute; ako cena dohodou&nbsp; v&nbsp;s&uacute;lade so&nbsp; z&aacute;k. Ä. 18/1996 Zb. o&nbsp;cen&aacute;ch v&nbsp;platnom znen&iacute;.</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	2.&nbsp; Dohodnut&aacute; cena je cena spolu ................................................eur (slovom:....................................................................................) bez dane z&nbsp;pridanej hodnoty. DPH bude &uacute;Ätovan&aacute; v&nbsp;s&uacute;lade s&nbsp;platn&yacute;m pr&aacute;vnymi predpismi.</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	3.Dod&aacute;vka tovaru bude realizovan&aacute; v&nbsp;nasledovn&yacute;ch dohodnut&yacute;ch cenov&yacute;ch rel&aacute;ci&aacute;ch:&nbsp;&nbsp;</p>\r\n<p>\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"width:77.48%;\" width=\"77%\">\r\n	<tbody>\r\n		<tr>\r\n			<td style=\"width:15.5%;height:28px;\">\r\n				<p align=\"center\">\r\n					<strong>Druh dreviny</strong></p>\r\n				<p>\r\n					&nbsp;</p>\r\n			</td>\r\n			<td style=\"width:32.76%;height:28px;\">\r\n				<p align=\"center\">\r\n					<strong>MnoÅ¾stvo</strong></p>\r\n				<p align=\"center\">\r\n					<strong>( ks )</strong></p>\r\n			</td>\r\n			<td style=\"width:26.84%;height:28px;\">\r\n				<p>\r\n					<strong>Cena za ks bez DPH</strong></p>\r\n			</td>\r\n			<td style=\"width:24.88%;height:28px;\">\r\n				<p>\r\n					<strong>Cena spolu bez DPH:</strong></p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width:15.5%;\">\r\n				<p>\r\n					Buk lesn&yacute;</p>\r\n			</td>\r\n			<td style=\"width:32.76%;\">\r\n				<p align=\"center\">\r\n					29 250</p>\r\n				<p align=\"center\">\r\n					&nbsp;</p>\r\n			</td>\r\n			<td style=\"width:26.84%;\">\r\n				<p style=\"margin-left:5.05pt;\">\r\n					&nbsp;</p>\r\n			</td>\r\n			<td style=\"width:24.88%;\">\r\n				<p style=\"margin-left:5.05pt;\">\r\n					&nbsp;</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width:15.5%;\">\r\n				<p>\r\n					Smrekovec opadav&yacute;</p>\r\n				<p>\r\n					&nbsp;</p>\r\n			</td>\r\n			<td style=\"width:32.76%;\">\r\n				<p align=\"center\">\r\n					15 740</p>\r\n			</td>\r\n			<td style=\"width:26.84%;\">\r\n				<p style=\"margin-left:5.05pt;\">\r\n					&nbsp;</p>\r\n			</td>\r\n			<td style=\"width:24.88%;\">\r\n				<p style=\"margin-left:5.05pt;\">\r\n					&nbsp;</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width:15.5%;\">\r\n				<p>\r\n					Borovica lesn&aacute;</p>\r\n				<p>\r\n					&nbsp;</p>\r\n			</td>\r\n			<td style=\"width:32.76%;\">\r\n				<p align=\"center\">\r\n					27 300</p>\r\n			</td>\r\n			<td style=\"width:26.84%;\">\r\n				<p style=\"margin-left:5.05pt;\">\r\n					&nbsp;</p>\r\n			</td>\r\n			<td style=\"width:24.88%;\">\r\n				<p style=\"margin-left:5.05pt;\">\r\n					&nbsp;</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width:15.5%;height:23px;\">\r\n				<p>\r\n					Dub zimn&yacute;</p>\r\n			</td>\r\n			<td style=\"width:32.76%;height:23px;\">\r\n				<p align=\"center\">\r\n					2 770</p>\r\n			</td>\r\n			<td style=\"width:26.84%;height:23px;\">\r\n				<p style=\"margin-left:5.05pt;\">\r\n					&nbsp;</p>\r\n			</td>\r\n			<td style=\"width:24.88%;height:23px;\">\r\n				<p style=\"margin-left:5.05pt;\">\r\n					&nbsp;</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width:15.5%;\">\r\n				<p>\r\n					SPOLU</p>\r\n				<p>\r\n					&nbsp;</p>\r\n			</td>\r\n			<td style=\"width:32.76%;\">\r\n				<p align=\"center\">\r\n					75 060</p>\r\n			</td>\r\n			<td style=\"width:26.84%;\">\r\n				<p align=\"center\" style=\"margin-left:5.05pt;\">\r\n					&nbsp;</p>\r\n				<p align=\"center\" style=\"margin-left:5.05pt;\">\r\n					x</p>\r\n			</td>\r\n			<td style=\"width:24.88%;\">\r\n				<p style=\"margin-left:5.05pt;\">\r\n					&nbsp;</p>\r\n			</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<p>\r\n	&nbsp;</p>\r\n<p align=\"center\">\r\n	<strong>III.</strong></p>\r\n<p align=\"center\">\r\n	<strong>ÄŒAS PLNENIA</strong></p>\r\n<p>\r\n	&nbsp;</p>\r\n<p style=\"margin-left:18.0pt;\">\r\n	Zmluvn&eacute; strany sa dohodli, Å¾e pred&aacute;vaj&uacute;ci dod&aacute; kupuj&uacute;cemu sadenice uveden&eacute;:</p>\r\n<p>\r\n	-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;v&nbsp;Äl&aacute;nku I. Predmet zmluvy, bod 2.&nbsp; v&nbsp;Äase 15. apr&iacute;la 2014 pr&iacute;p. dohodou podÄ¾a priebehu jarn&eacute;ho poÄasia, a&nbsp;to v&nbsp;celosti a&nbsp;naraz,</p>\r\n<p>\r\n	-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v&nbsp;Äl&aacute;nku I. Predmet zmluvy, bod 3. v&nbsp;Äase 15. apr&iacute;la 2015 pr&iacute;p. dohodou podÄ¾a priebehu jarn&eacute;ho poÄasia, a&nbsp;to v&nbsp;celosti a&nbsp;naraz.</p>\r\n<p style=\"margin-left:18.0pt;\">\r\n	&nbsp;</p>\r\n<p style=\"margin-left:18.0pt;\">\r\n	Pred&aacute;vaj&uacute;ci vyzve kupuj&uacute;ceho na prevzatie tovaru e-mailom aspoÅˆ 3 dni vopred. Kupuj&uacute;ci ods&uacute;hlas&iacute; presn&yacute; term&iacute;n prevzatia saden&iacute;c e-mailom aspoÅˆ jeden deÅˆ vopred.</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p align=\"center\">\r\n	<strong>IV.</strong></p>\r\n<p align=\"center\">\r\n	<strong>MIESTO PLNENIA</strong></p>\r\n<p>\r\n	&nbsp;</p>\r\n<p style=\"margin-left:18.0pt;\">\r\n	Pred&aacute;vaj&uacute;ci si spln&iacute; z&aacute;v&auml;zok z&nbsp;tejto zmluvy odovzdan&iacute;m tovaru.</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p align=\"center\">\r\n	<strong>V.</strong></p>\r\n<p align=\"center\">\r\n	<strong>SP&ocirc;SOB &Uacute;HRADY K&Uacute;PNEJ CENY</strong></p>\r\n<p>\r\n	&nbsp;</p>\r\n<p style=\"margin-left:18.0pt;\">\r\n	K&uacute;pna cena urÄen&aacute; sp&ocirc;sobom uveden&yacute;m v&nbsp;bode II. zmluvy bude zo strany kupuj&uacute;ceho uhraden&aacute;: v&nbsp;lehote do 21 dn&iacute; od d&aacute;tumu doruÄenia fakt&uacute;ry, obsahuj&uacute;cej v&scaron;etky z&aacute;konom predp&iacute;san&eacute; n&aacute;leÅ¾itosti.</p>\r\n<p align=\"center\">\r\n	&nbsp;</p>\r\n<p align=\"center\">\r\n	<strong>VI.</strong></p>\r\n<p align=\"center\">\r\n	<strong>PREPRAVN&Eacute; DOKLADY</strong></p>\r\n<p style=\"margin-left:18.0pt;\">\r\n	Doklady, vzÅ¥ahuj&uacute;ce sa k&nbsp;predmetu plnenia bud&uacute; zo strany pred&aacute;vaj&uacute;ceho vyhotoven&eacute; a&nbsp;odovzdan&eacute; kupuj&uacute;cemu v&nbsp;deÅˆ odovzdania tovaru kupuj&uacute;cemu.</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p align=\"center\">\r\n	<strong>VII.</strong></p>\r\n<p align=\"center\">\r\n	<strong>VLASTN&Iacute;CKE PR&Aacute;VO</strong></p>\r\n<p>\r\n	1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Vlastn&iacute;cke pr&aacute;vo k&nbsp;dodan&eacute;mu tovaru nadobudne kupuj&uacute;ci aÅ¾ zaplaten&iacute;m vyfakturovanej k&uacute;pnej ceny.</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p style=\"margin-left:35.45pt;\">\r\n	2.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; K&uacute;pna cena sa povaÅ¾uje za zaplaten&uacute; momentom jej prip&iacute;sania na &uacute;Äet pred&aacute;vaj&uacute;ceho, resp. prijat&iacute;m&nbsp;&nbsp;&nbsp;&nbsp; hotovosti pred&aacute;vaj&uacute;cim od kupuj&uacute;ceho.</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p style=\"margin-left:35.45pt;\">\r\n	3.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NebezpeÄenstvo &scaron;kody na tovare prech&aacute;dza na kupuj&uacute;ceho potom, Äo mu tento bol odovzdan&yacute; priamo alebo v&nbsp;Äase, keÄ mu pred&aacute;vaj&uacute;ci umoÅ¾n&iacute; nakladaÅ¥ s&nbsp;tovarom a&nbsp;kupuj&uacute;ci poru&scaron;&iacute; zmluvu t&yacute;m, Å¾e tovar neprevezme.</p>\r\n<p align=\"center\">\r\n	<strong>VIII.</strong></p>\r\n<p align=\"center\">\r\n	<strong>ODST&Uacute;PENIE OD ZMLUVY</strong></p>\r\n<p>\r\n	Nesplnenie povinnosti pred&aacute;vaj&uacute;ceho uveden&yacute;ch v&nbsp;tejto zmluve zaklad&aacute; pr&aacute;vo kupuj&uacute;ceho odst&uacute;piÅ¥ od zmluvy, a&nbsp;to do 30 dn&iacute; odo dÅˆa, keÄ sa kupuj&uacute;ci o&nbsp;poru&scaron;en&iacute; dozvedel, inak pr&aacute;vo zanik&aacute;. Pred&aacute;vaj&uacute;ci zodpoved&aacute; kupuj&uacute;cemu za v&scaron;etku pr&iacute;padn&uacute; &scaron;kodu, ktor&aacute; mu poru&scaron;en&iacute;m povinnost&iacute; vznikne.&nbsp;</p>\r\n<p align=\"center\">\r\n	<strong>IX.</strong></p>\r\n<p align=\"center\">\r\n	<strong>AKOSÅ¤ A&nbsp; ZODPOVEDNOSÅ¤ ZA CHYBY</strong></p>\r\n<p style=\"margin-left:35.45pt;\">\r\n	1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Pred&aacute;vaj&uacute;ci prehlasuje, Å¾e tovar dodan&yacute; na z&aacute;klade tejto zmluvy bude vykazovaÅ¥ kvalitu dohodnut&uacute;&nbsp;&nbsp; v&nbsp;Äl. I. zmluvy.</p>\r\n<p>\r\n	2.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Pr&iacute;padn&eacute; chyby tovaru m&ocirc;Å¾e kupuj&uacute;ci reklamovaÅ¥ takto :</p>\r\n<p style=\"margin-left:35.45pt;\">\r\n	- chyby kvantitat&iacute;vne do 5-tich kalend&aacute;rnych dn&iacute; od prevzatia tovaru,</p>\r\n<p style=\"margin-left:35.45pt;\">\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - chyby vizu&aacute;lne a&nbsp;in&eacute; do 8 kalend&aacute;rnych dn&iacute; od prevzatia tovaru.&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n<p style=\"margin-left:35.45pt;\">\r\n	Neuplatnenie n&aacute;roku z&nbsp;titulu chybn&eacute;ho plnenia v&nbsp;dohodnut&yacute;ch lehot&aacute;ch m&aacute; za n&aacute;sledok z&aacute;nik pr&aacute;va z&nbsp;tohto titulu.</p>\r\n<p style=\"margin-left:35.45pt;\">\r\n	&nbsp;</p>\r\n<p>\r\n	3.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kupuj&uacute;ci svoje pr&aacute;vo z&nbsp;titulu chybn&eacute;ho plnenia si uplatÅˆuje p&iacute;somne a&nbsp;vo svojej Å¾iadosti uvedie :</p>\r\n<p style=\"margin-left:35.45pt;\">\r\n	-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; popis ch&yacute;b na dodanom tovare, d&aacute;tum dodania tovaru, Ä&iacute;slo k&uacute;pnej zmluvy, mnoÅ¾stvo chybn&eacute;ho tovaru a&nbsp;uplatÅˆovan&yacute; n&aacute;rok z&nbsp;titulu chybn&eacute;ho plnenia.</p>\r\n<p style=\"margin-left:35.45pt;\">\r\n	&nbsp;</p>\r\n<p style=\"margin-left:35.45pt;\">\r\n	4.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Pred&aacute;vaj&uacute;ci sa k&nbsp;p&iacute;somnej reklam&aacute;cii vyjadr&iacute;, resp. dostav&iacute; sa k&nbsp;reklamaÄn&eacute;mu konaniu v&nbsp;lehote do&nbsp;&nbsp; 5&nbsp;dn&iacute; odo dÅˆa doruÄenia reklam&aacute;cie.</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p style=\"margin-left:35.45pt;\">\r\n	5.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kupuj&uacute;ci je do doby dostavenia sa pred&aacute;vaj&uacute;ceho k&nbsp;reklamaÄn&eacute;mu konaniu povinn&yacute; tovar uskladniÅ¥ oddelene.</p>\r\n<p align=\"center\">\r\n	<strong>X.</strong></p>\r\n<p align=\"center\">\r\n	<strong>ÄŒIASTOÄŒN&Eacute; PLNENIE A SANKCIE</strong></p>\r\n<p style=\"margin-left:35.45pt;\">\r\n	1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Plnenie men&scaron;ieho mnoÅ¾stva zo strany pred&aacute;vaj&uacute;ceho ako bolo dohodnut&eacute; bude rie&scaron;en&eacute; poplatkom z ome&scaron;kania nasledovne: ak pred&aacute;vaj&uacute;ci nedod&aacute; tovar v&nbsp;poÅ¾adovanom mnoÅ¾stve, je povinn&yacute; zaplatiÅ¥ kupuj&uacute;cemu poplatok z ome&scaron;kania vo v&yacute;&scaron;ke 3,5 % z&nbsp;ceny nedodan&eacute;ho tovaru za kaÅ¾d&yacute; zaÄat&yacute; t&yacute;Å¾deÅˆ ome&scaron;kania.</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p style=\"margin-left:35.45pt;\">\r\n	2.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&uacute;Äasne si &uacute;Äastn&iacute;ci na zabezpeÄenie z&aacute;v&auml;zku dohodli pre pr&iacute;pad ome&scaron;kania pred&aacute;vaj&uacute;ceho s&nbsp;plnen&iacute;m povinnost&iacute; z&nbsp;tejto zmluvy zmluvn&uacute; pokutu vo v&yacute;&scaron;ke 0,1 % z&nbsp;ceny nedodan&eacute;ho tovaru za kaÅ¾d&yacute; zaÄat&yacute; t&yacute;Å¾deÅˆ me&scaron;kania. Pr&aacute;vo na n&aacute;hradu &scaron;kody t&yacute;m nie je dotknut&eacute;.</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p align=\"center\">\r\n	<strong>XI.</strong></p>\r\n<p align=\"center\">\r\n	<strong>PLATNOSÅ¤ A &Uacute;ÄŒINNOSÅ¤ K&Uacute;PNEJ ZMLUVY</strong></p>\r\n<p style=\"margin-left:35.45pt;\">\r\n	1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Zmeny podmienok zmluvne dohodnut&yacute;ch moÅ¾no upraviÅ¥ po dohode str&aacute;n dodatkom v&yacute;hradne p&iacute;somnou formou.</p>\r\n<p style=\"margin-left:35.45pt;\">\r\n	2.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; T&aacute;to zmluva nadob&uacute;da platnosÅ¥ a&nbsp;&uacute;ÄinnosÅ¥ dÅˆom jej podpisu oboma zmluvn&yacute;mi stranami.</p>\r\n<p style=\"margin-left:35.45pt;\">\r\n	3.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Pred&aacute;vaj&uacute;ci berie na vedomie, Å¾e kupuj&uacute;ci je povinnou osobou v&nbsp; zmysle &sect; 2 ods. 3 Z&aacute;kona Ä. 211/2000 o slobodnom pr&iacute;stupe k inform&aacute;ci&aacute;m v platnom znen&iacute;, s&uacute;hlas&iacute; so zverejnen&iacute;m a spr&iacute;stupnen&iacute;m obsahu zmluvy. T&aacute;to zmluva nadob&uacute;da &uacute;ÄinnosÅ¥ najsk&ocirc;r dÅˆom&nbsp; nasleduj&uacute;com po dni jej zverejnenia na webovej str&aacute;nke kupuj&uacute;ceho.</p>\r\n<p style=\"margin-left:53.25pt;\">\r\n	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p>\r\n<p align=\"center\">\r\n	<strong>XIII.</strong></p>\r\n<p align=\"center\">\r\n	<strong>RIE&Scaron;ENIE SPOROV</strong></p>\r\n<p style=\"margin-left:35.45pt;\">\r\n	1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; V&scaron;etky spory napadnut&eacute; zo zmluvy bud&uacute; rie&scaron;en&eacute; prostredn&iacute;ctvom pr&iacute;slu&scaron;n&eacute;ho s&uacute;du aÅ¾ po predch&aacute;dzaj&uacute;com ne&uacute;spe&scaron;nom jednan&iacute; &uacute;Äastn&iacute;kov.</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p style=\"margin-left:35.45pt;\">\r\n	2.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Zmluva bola vyhotoven&aacute; v 3 exempl&aacute;roch, z&nbsp;ktor&yacute;ch kupuj&uacute;ci dostane jeden exempl&aacute;r a&nbsp;pred&aacute;vaj&uacute;ci dva exempl&aacute;re.</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p align=\"center\">\r\n	<strong>XIV.</strong></p>\r\n<p align=\"center\">\r\n	<strong>Z&Aacute;VEREÄŒN&Eacute; USTANOVENIA</strong></p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	Pred&aacute;vaj&uacute;ci je viazan&yacute; t&yacute;mto n&aacute;vrhom zmluvy do 30. 04. 2014.</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	V&nbsp;Poprade, ...................................&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;V&nbsp;.........................., ........................................</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n	<tbody>\r\n		<tr>\r\n			<td style=\"width:205px;\">\r\n				<p align=\"center\">\r\n					Kupuj&uacute;ci&nbsp; (peÄiatka a&nbsp;podpis)</p>\r\n				<p align=\"center\">\r\n					Ing. R&oacute;bert Dula</p>\r\n				<p align=\"center\">\r\n					konateÄ¾ spoloÄnosti</p>\r\n			</td>\r\n			<td style=\"width:205px;\">\r\n				<p>\r\n					&nbsp;</p>\r\n			</td>\r\n			<td style=\"width:205px;\">\r\n				<p align=\"center\" style=\"margin-left:4.8pt;\">\r\n					Pred&aacute;vaj&uacute;ci (peÄiatka a&nbsp;podpis)</p>\r\n				<p align=\"center\" style=\"margin-left:4.8pt;\">\r\n					&nbsp;</p>\r\n				<p align=\"center\" style=\"margin-left:4.8pt;\">\r\n					&nbsp;</p>\r\n			</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<div style=\"clear:both;\">\r\n	&nbsp;</div>\r\n<p>\r\n	&nbsp;</p>\r\n',	3,	0,	0,	0,	0,	0,	1136,	NULL),
(41,	36,	3,	'2015-09-22 09:36:38',	NULL,	'zÃ¡kazka 1/2015',	'<h4>\r\n	V&yacute;zva na predkladanie pon&uacute;k</h4>\r\n<h4>\r\n	&bdquo;V&yacute;stavba protipoÅ¾iarnej n&aacute;drÅ¾e Blech a Preslop &quot;</h4>\r\n<p align=\"center\">\r\n	&nbsp;</p>\r\n<p align=\"center\">\r\n	zad&aacute;vanie z&aacute;kazky podÄ¾a &sect; 9 ods. 9 z&aacute;kona Ä. 25/2006 Z. z. o verejnom obstar&aacute;van&iacute;</p>\r\n<p align=\"center\">\r\n	a&nbsp;o&nbsp;zmene a&nbsp;doplnen&iacute; niektor&yacute;ch z&aacute;konov v&nbsp;znen&iacute; neskor&scaron;&iacute;ch predpisov</p>\r\n<p>\r\n	&nbsp;</p>\r\n<h5>\r\n	1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Identifik&aacute;cia verejn&eacute;ho obstar&aacute;vateÄ¾a</h5>\r\n<p>\r\n	N&aacute;zov organiz&aacute;cie: Mestsk&eacute; lesy, s.r.o. Poprad&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IÄŒO: 36 448 311</p>\r\n<p>\r\n	S&iacute;dlo organiz&aacute;cie: LevoÄsk&aacute; 3312/37,&nbsp; 058 01 Poprad&nbsp;&nbsp;&nbsp;</p>\r\n<p>\r\n	Krajina: Slovensk&aacute; republika</p>\r\n<p>\r\n	Kontaktn&aacute; osoba: &nbsp;Ing. R&oacute;bert Dula &ndash; konateÄ¾ spoloÄnosti</p>\r\n<p>\r\n	Telef&oacute;n: 052 7724160, 0910890440&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n<p>\r\n	&nbsp;e-mail:&nbsp; lesypp@stonline.sk&nbsp;&nbsp;</p>\r\n<h5>\r\n	2.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Predmet z&aacute;kazky</h5>\r\n<p>\r\n	z&aacute;kazka na uskutoÄÅˆovanie stavebn&yacute;ch pr&aacute;c</p>\r\n<h5>\r\n	3.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; N&aacute;zov predmetu z&aacute;kazky</h5>\r\n<h5>\r\n	&bdquo;V&yacute;stavba protipoÅ¾iarnej n&aacute;drÅ¾e Blech a Preslop &quot;</h5>\r\n<h5>\r\n	4.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Rozdelenie predmetu z&aacute;kazky na Äasti</h5>\r\n<p>\r\n	&nbsp; PoÅ¾aduje sa cena za cel&yacute; predmet z&aacute;kazky&nbsp;</p>\r\n<h5>\r\n	5.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Opis predmetu z&aacute;kazky</h5>\r\n<p>\r\n	Predmetom z&aacute;kazky s&uacute; stavebn&eacute; pr&aacute;ce na v&yacute;stavbe dvoch n&aacute;drÅ¾&iacute;, ktor&eacute; vznikn&uacute; prehraden&iacute;m mal&yacute;ch bystriniek kombinovan&yacute;mi zemno-kamenn&yacute;mi hr&aacute;dzami tesne pri lesn&yacute;ch cest&aacute;ch na lokalit&aacute;ch Blech a&nbsp;Preslov, ktor&eacute; najlep&scaron;ie vyhovuj&uacute; konkr&eacute;tnym technick&yacute;m a&nbsp;pr&iacute;rodn&yacute;m poÅ¾iadavk&aacute;m.</p>\r\n<p style=\"margin-left:17.0pt;\">\r\n	<strong>6.</strong><strong>MnoÅ¾stvo alebo rozsah predmetu z&aacute;kazky</strong></p>\r\n<p>\r\n	Podrobn&eacute; vymedzenie predmetu z&aacute;kazky je uveden&eacute; v&nbsp;projektovej dokument&aacute;cii a&nbsp;v&yacute;kaze v&yacute;mer , ktor&eacute; tvoria pr&iacute;lohu v&yacute;zvy. &nbsp;</p>\r\n<h5>\r\n	7.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Miesto dodania predmetu z&aacute;kazky</h5>\r\n<p>\r\n	k.&uacute;. Poprad, Spi&scaron;sk&eacute; Bystr&eacute;</p>\r\n<h5>\r\n	8.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Trvanie zmluvy alebo lehota pre skonÄenie dod&aacute;vky</h5>\r\n<p>\r\n	Predpokladan&eacute; ukonÄenie dod&aacute;vky:&nbsp; do 60 dn&iacute; od odovzdania staveniska.</p>\r\n<h5>\r\n	9.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Hlavn&eacute; podmienky financovania a&nbsp;platobn&eacute; podmienky</h5>\r\n<p>\r\n	Predmet z&aacute;kazky bude financovan&yacute; z&nbsp;nen&aacute;vratn&eacute;ho finanÄn&eacute;ho pr&iacute;spevku (NFP)&nbsp; - Program PRV SR 2014 - 2020,&nbsp;&nbsp; opatrenie: 4 &ndash; Invest&iacute;cie do hmotn&eacute;ho majetku, &nbsp;podopatrenie: 4.3 &ndash; Podpora na invest&iacute;cie do infra&scaron;trukt&uacute;ry s&uacute;visiacej s v&yacute;vojom, moderniz&aacute;ciou alebo a prisp&ocirc;soben&iacute;m poÄ¾nohospod&aacute;rstva a lesn&eacute;ho hospod&aacute;rstva.&nbsp; Preddavky&nbsp;&nbsp; nebud&uacute; poskytovan&eacute;.</p>\r\n<h5>\r\n	10.&nbsp; Podmienky &uacute;Äasti&nbsp; a&nbsp;obsah ponuky</h5>\r\n<p style=\"margin-left:17.0pt;\">\r\n	10.1. doklad o&nbsp;opr&aacute;vnen&iacute; realizovaÅ¥ pr&aacute;ce, vo vzÅ¥ahu k&nbsp;predmetu z&aacute;kazky, na ktor&uacute; predklad&aacute; uch&aacute;dzaÄ ponuku&nbsp; - &nbsp;postaÄuje k&oacute;pia</p>\r\n<p style=\"margin-left:17.0pt;\">\r\n	10.2. Vyplnen&aacute; pr&iacute;loha Ä.1 v&yacute;zvy &ndash; cena predmetu z&aacute;kazky celkom</p>\r\n<p style=\"margin-left:17.0pt;\">\r\n	10.3. Ocenen&yacute; v&yacute;kaz v&yacute;mer &ndash; PoloÅ¾kovit&aacute; kalkul&aacute;cia ponukov&eacute;ho rozpoÄtu diela jednotlivo za n&aacute;drÅ¾ Plech a Preslop</p>\r\n<h5>\r\n	11.&nbsp; Lehota&nbsp; na predkladanie pon&uacute;k</h5>\r\n<p style=\"margin-left:17.0pt;\">\r\n	Lehota na predkladanie pon&uacute;k &ndash; d&aacute;tum:&nbsp;&nbsp; Äas: 30.09.2015 do 15:00 hod</p>\r\n<p style=\"margin-left:17.0pt;\">\r\n	<strong>12.&nbsp; </strong><strong>Miesto a&nbsp;sp&ocirc;sob doruÄenia cenovej ponuky</strong></p>\r\n<p>\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12.1<strong>. Osobn&eacute; doruÄenie</strong> &ndash; v pracovnej dobe 07.30 &ndash; 15.30 hod. v&nbsp;s&iacute;dle spoloÄnosti</p>\r\n<p>\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12.2<strong>. Po&scaron;tou</strong> : - ako adresa obstar&aacute;vateÄ¾skej organiz&aacute;cie uveden&aacute; v&nbsp;bode 1&nbsp;</p>\r\n<p>\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12.3<strong>. Prostredn&iacute;ctvom elektronickej po&scaron;ty:&nbsp;&nbsp;&nbsp; </strong>ZaslaÅ¥ na e-mail: <a href=\"mailto:lesypp@stonline.sk\">lesypp@stonline.sk</a></p>\r\n<p>\r\n	&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;Ob&aacute;lka cenovej ponuky pri os. alebo po&scaron;tovom doruÄen&iacute;&nbsp; mus&iacute; obsahovaÅ¥ identifik&aacute;ciu predkladateÄ¾a ponuky ( obch. meno a&nbsp;s&iacute;dlo) a&nbsp;oznaÄenie &bdquo;<strong>CENOV&Aacute; PONUKA &ndash; n&aacute;drÅ¾e &ndash; neotv&aacute;raÅ¥, </strong>V&nbsp;pr&iacute;pade zaslanie e-mailu - predmet oznaÄen&yacute; ako: <strong>cenov&aacute; ponuka &ndash; n&aacute;drÅ¾e</strong></p>\r\n<h5>\r\n	13.&nbsp; Krit&eacute;ri&aacute; na hodnotenie pon&uacute;k:</h5>\r\n<p>\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Cena predmetu z&aacute;kazky celkom -&nbsp; vyplniÅ¥ pr&iacute;lohu v&yacute;zvy s&nbsp;potvrden&iacute;m opr&aacute;vnenej osoby uch&aacute;dzaÄa.</p>\r\n<h5>\r\n	14.&nbsp; Lehota viazanosti pon&uacute;k</h5>\r\n<p>\r\n	31.06.2016</p>\r\n<h5>\r\n	15.&nbsp; ÄŽal&scaron;ie inform&aacute;cie&nbsp;</h5>\r\n<h5>\r\n	15.1. Plnenie predmetu zmluvy je viazan&eacute; na poskytnutie nen&aacute;vratn&eacute;ho finanÄn&eacute;ho pr&iacute;spevku (NFP) z&nbsp;fondov E&Uacute;. Inform&aacute;ciu o&nbsp;poskytnut&iacute; NFP ozn&aacute;mi objedn&aacute;vateÄ¾ zhotoviteÄ¾ovi&nbsp; a&nbsp;z&aacute;roveÅˆ vyzve zhotoviteÄ¾a na prevzatie staveniska. V pr&iacute;pade, ak objedn&aacute;vateÄ¾ovi nebude poskytnut&yacute; NFP na financovanie plnenia podÄ¾a tejto zmluvy, &uacute;Äinky tejto zmluvy zanikn&uacute;.</h5>\r\n<p>\r\n	15.2. V pr&iacute;pade, Å¾e bude uch&aacute;dzaÄ &uacute;spe&scaron;n&yacute;, predloÅ¾&iacute; pred podpisom zmluvy origin&aacute;l alebo &uacute;radne osvedÄen&uacute; k&oacute;piu dokladu o&nbsp;opr&aacute;vnen&iacute; podnikaÅ¥.</p>\r\n<h5>\r\n	16.&nbsp; PouÅ¾itie elektronickej aukcie</h5>\r\n<p>\r\n	NepouÅ¾ije sa.</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<h5>\r\n	Zodpovedn&aacute; osoba:</h5>\r\n<p>\r\n	Ing. R&oacute;bert Dula- konateÄ¾ spoloÄnosti:..................</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p align=\"right\">\r\n	Pr&iacute;loha Ä. 1&nbsp;</p>\r\n<p align=\"center\">\r\n	&nbsp;</p>\r\n<p align=\"center\">\r\n	<strong>N&aacute;vrh na plnenie krit&eacute;ria</strong></p>\r\n<p align=\"center\">\r\n	&nbsp;</p>\r\n<p align=\"left\">\r\n	Uch&aacute;dzaÄ: ...............................................................................................</p>\r\n<p align=\"left\">\r\n	&nbsp;</p>\r\n<p align=\"left\">\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ..............................................................................................</p>\r\n<p align=\"left\">\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n<p align=\"left\">\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IÄŒO:...................................................................</p>\r\n<h5>\r\n	Cena z&aacute;kazky: &bdquo;V&yacute;stavba protipoÅ¾iarnej n&aacute;drÅ¾e Blech a Preslop &quot;</h5>\r\n<h5>\r\n	&nbsp;</h5>\r\n<p align=\"left\">\r\n	&nbsp;</p>\r\n<table border=\"1\" cellpadding=\"0\" cellspacing=\"0\">\r\n	<tbody>\r\n		<tr>\r\n			<td style=\"width:284px;\">\r\n				<p align=\"center\">\r\n					N&aacute;zov krit&eacute;ria</p>\r\n			</td>\r\n			<td style=\"width:161px;\">\r\n				<p align=\"center\">\r\n					&nbsp;</p>\r\n			</td>\r\n			<td style=\"width:177px;\">\r\n				<p align=\"center\">\r\n					Splnenie krit&eacute;ria</p>\r\n				<p align=\"center\">\r\n					&nbsp;</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width:284px;height:52px;\">\r\n				<p align=\"left\">\r\n					&nbsp;</p>\r\n				<p align=\"left\">\r\n					<strong>Cena celkom za dielo bez&nbsp; DPH</strong></p>\r\n			</td>\r\n			<td style=\"width:161px;height:52px;\">\r\n				<p align=\"left\">\r\n					&nbsp;</p>\r\n			</td>\r\n			<td style=\"width:177px;height:52px;\">\r\n				<p align=\"left\">\r\n					&nbsp;</p>\r\n				<p align=\"left\">\r\n					&nbsp;</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width:284px;\">\r\n				<p align=\"left\">\r\n					&nbsp;</p>\r\n				<p align=\"left\">\r\n					20 %&nbsp; DPH</p>\r\n			</td>\r\n			<td style=\"width:161px;\">\r\n				<p align=\"left\">\r\n					&nbsp;</p>\r\n			</td>\r\n			<td style=\"width:177px;\">\r\n				<p align=\"left\">\r\n					&nbsp;</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\"width:284px;\">\r\n				<p align=\"left\">\r\n					&nbsp;</p>\r\n				<p align=\"left\">\r\n					<strong>Cena celkom za dielo vr&aacute;tane DPH</strong></p>\r\n			</td>\r\n			<td style=\"width:161px;\">\r\n				<p align=\"left\">\r\n					&nbsp;</p>\r\n			</td>\r\n			<td style=\"width:177px;\">\r\n				<p align=\"left\">\r\n					&nbsp;</p>\r\n			</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<p align=\"left\">\r\n	Som &ndash; nie som platcom DPH <sup>( nehodiace sa pre&scaron;krtnite)</sup></p>\r\n<p align=\"left\">\r\n	&nbsp;</p>\r\n<p align=\"left\">\r\n	&nbsp;</p>\r\n<p align=\"left\">\r\n	V...................................dÅˆa:.........................</p>\r\n<p align=\"left\">\r\n	&nbsp;</p>\r\n<p align=\"left\">\r\n	Meno a&nbsp;priezvisko uch&aacute;dzaÄa alebo osoby opr&aacute;vnenej konaÅ¥ za uch&aacute;dzaÄa...............................................&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n<p align=\"left\">\r\n	&nbsp;</p>\r\n<p align=\"left\">\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ....................................................................</p>\r\n<p align=\"left\">\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Podpis tejto osoby&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n<h5>\r\n	&nbsp;</h5>\r\n<p>\r\n	&nbsp;</p>\r\n',	3,	0,	0,	0,	0,	0,	309,	NULL),
(40,	36,	3,	'2014-01-27 20:56:11',	NULL,	'zÃ¡kazka 1/2014',	'<p align=\"center\">\r\n	Ozn&aacute;menie o&nbsp;zad&aacute;van&iacute; z&aacute;kazky</p>\r\n<h3 align=\"center\">\r\n	&nbsp;</h3>\r\n<div>\r\n	<p>\r\n		v r&aacute;mci postupu verejn&eacute;ho obstar&aacute;vania podÄ¾a &sect; 9 ods. 9 z&aacute;kona Ä. 25/2006 Z. z. o verejnom obstar&aacute;van&iacute; a o zmene a doplnen&iacute; niektor&yacute;ch z&aacute;konov v znen&iacute; neskor&scaron;&iacute;ch predpisov.</p>\r\n	<p>\r\n		&nbsp;</p>\r\n	<p style=\"margin-left: 21.3pt;\">\r\n		1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Identifik&aacute;cia verejn&eacute;ho obstar&aacute;vateÄ¾a:</strong></p>\r\n	<p>\r\n		N&aacute;zov: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Mestsk&eacute; lesy, s.r.o. Poprad&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n	<p>\r\n		&Scaron;tatut&aacute;rny org&aacute;n:&nbsp;&nbsp; Ing. R&oacute;bert Dula</p>\r\n	<p>\r\n		S&iacute;dlo: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LevoÄsk&aacute; 3312/37, 058 01 Poprad&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n	<p>\r\n		IÄŒO:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 36448311</p>\r\n	<p>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DIÄŒ:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2020017175</p>\r\n	<p>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IÄŒ DPH:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SK 2020017175</p>\r\n	<p>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n	<p>\r\n		Kontaktn&aacute; osoba pre verejn&eacute; obstar&aacute;vanie: Ing. Dula</p>\r\n	<p>\r\n		Telef&oacute;n: 0910890440</p>\r\n	<p>\r\n		Pracovn&yacute; kontakt pre vysvetlenie ozn&aacute;menia o&nbsp;zad&aacute;van&iacute; z&aacute;kazky:</p>\r\n	<p>\r\n		lesypp@stonline.sk</p>\r\n	<p>\r\n		&nbsp;</p>\r\n	<p style=\"margin-left: 18pt;\">\r\n		2.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>N&aacute;zov predmetu z&aacute;kazky: Pestovn&eacute; pr&aacute;ce na obnove lesa</strong></p>\r\n	<p style=\"margin-left: 18pt;\">\r\n		&nbsp;</p>\r\n	<p style=\"margin-left: 18pt;\">\r\n		Z&aacute;kazka (zmluva) je na: poskytnutie sluÅ¾ieb</p>\r\n	<p style=\"margin-left: 18pt;\">\r\n		3.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Podrobn&yacute; opis predmetu z&aacute;kazky: </strong></p>\r\n	<p>\r\n		-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>jamkov&aacute; sadba obaÄ¾ovan&yacute;ch saden&iacute;c</strong> - prevzatie a&nbsp;don&aacute;&scaron;ka saden&iacute;c na miesto sadby, vyhÄ¾adanie miesta sadby, manipul&aacute;cia so sadenicami pred sadbou (vykopanie r&yacute;h a&nbsp;uloÅ¾enie saden&iacute;c), odstr&aacute;nenie p&ocirc;dneho krytu a&nbsp;buriny na pl&ocirc;&scaron;ke poÅ¾adovanej veÄ¾kosti, vykopanie jamky do poÅ¾adovanej hÄºbky, vloÅ¾enie sadenice, zasypanie zeminou, utlaÄenie</p>\r\n	<p>\r\n		-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>ochrana saden&iacute;c proti burine vyÅ¾&iacute;nan&iacute;m na pl&ocirc;&scaron;kach - </strong>vyhÄ¾adanie saden&iacute;c resp. radov saden&iacute;c, vyÅ¾atie buriny na pl&ocirc;&scaron;ke alebo v p&aacute;soch poÅ¾adovanej veÄ¾kosti &uacute;merne k&nbsp;v&yacute;&scaron;ke sadenice, rozprestretie buriny po vyÅ¾atej ploche.</p>\r\n	<p style=\"margin-left: 18pt;\">\r\n		4.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Predpokladan&aacute; hodnota z&aacute;kazky (bez DPH):&nbsp; 19820 &euro;</strong></p>\r\n	<p style=\"margin-left: 18pt;\">\r\n		&nbsp;</p>\r\n	<p style=\"margin-left: 18pt;\">\r\n		5.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Z&aacute;kladn&eacute; zmluvn&eacute; podmienky: </strong></p>\r\n	<p>\r\n		Miesto poskytnutia sluÅ¾ieb: lesy v&nbsp;n&aacute;jme spoloÄnosti Mestsk&eacute; lesy, s.r.o. Poprad,&nbsp;</p>\r\n	<p>\r\n		LevoÄsk&aacute; 3312/37, 058 01 Poprad&nbsp;</p>\r\n	<p>\r\n		Lehota na dodanie predmetu z&aacute;kazky: od 15.2.2014 do 31.5.2015</p>\r\n	<p>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SplatnosÅ¥ fakt&uacute;r: 15 dn&iacute; od doruÄenia fakt&uacute;ry.</p>\r\n	<p style=\"margin-left: 18pt;\">\r\n		..... Predmet z&aacute;kazky bude financovan&yacute; z&nbsp;nen&aacute;vratn&eacute;ho finanÄn&eacute;ho pr&iacute;spevku z&nbsp;OperaÄn&eacute;ho programu rozvoja vidieka SR 2007-2013, n&aacute;zov opatrenia: 2.1 Obnova potenci&aacute;lu lesn&eacute;ho hospod&aacute;rstva a&nbsp;zavedenie prevent&iacute;vnych opatren&iacute;.</p>\r\n	<p>\r\n		&nbsp;</p>\r\n	<p style=\"margin-left: 18pt;\">\r\n		6.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Lehota na predkladanie dokladov a&nbsp; pon&uacute;k&nbsp; : do 31.1.2014,&nbsp; 11.00 h.</strong></p>\r\n	<p style=\"margin-left: 18pt;\">\r\n		7.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Stanovenie ceny</strong></p>\r\n	<p>\r\n		-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Cenu je potrebn&eacute; spracovaÅ¥ na z&aacute;klade poÅ¾adovan&eacute;ho rozsahu a poÅ¾adovanej kvality a&nbsp;Äal&scaron;&iacute;ch poÅ¾iadaviek uveden&yacute;ch podÄ¾a ozn&aacute;menia o&nbsp;zad&aacute;van&iacute; z&aacute;kazky (Äalej len &bdquo;ozn&aacute;menia&ldquo;). Cenu je potrebn&eacute; uv&aacute;dzaÅ¥ v eur&aacute;ch (&euro;) bez DPH.&nbsp; Ak uch&aacute;dzaÄ nie je platcom DPH, uvedie t&uacute;to skutoÄnosÅ¥ v&nbsp;ponuke.</p>\r\n	<p>\r\n		&nbsp;</p>\r\n	<p style=\"margin-left: 18pt;\">\r\n		8.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Postup vo verejnom obstar&aacute;van&iacute;: </strong>je jednoetapov&yacute;.</p>\r\n	<p style=\"margin-left: 18pt;\">\r\n		&nbsp;</p>\r\n	<p style=\"margin-left: 18pt;\">\r\n		9.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Predkladanie dokladov a ponuky:</strong></p>\r\n	<p>\r\n		a)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Pri jednoetapovom postupe:</strong></p>\r\n	<p>\r\n		Ponuku je potrebn&eacute; doplniÅ¥ do R&aacute;mcovej zmluvy (pr&iacute;loha Ä. 1. Ozn&aacute;menia o&nbsp;zad&aacute;van&iacute; z&aacute;kazky) a&nbsp;<strong><u>poslaÅ¥ v&nbsp;troch rovnopisoch</u></strong>&nbsp; v&yacute;luÄne na adresu s&iacute;dla spoloÄnosti podÄ¾a bodu 1. v&nbsp;uzatvorenej ob&aacute;lke s&nbsp;uveden&iacute;m <strong>n&aacute;zvu z&aacute;kazky,</strong> s&nbsp;oznaÄen&iacute;m &ndash; <strong>NEOTV&Aacute;RAÅ¤</strong>&ldquo; na adresu s&iacute;dla spoloÄnosti uveden&uacute; v&nbsp;bode 1. Ponuky sa predkladaj&uacute; v&nbsp;slovenskom jazyku. V&nbsp;pr&iacute;pade, ak ponuku predklad&aacute; skupina dod&aacute;vateÄ¾ov, je potrebn&eacute; vyplniÅ¥ a&nbsp;zaslaÅ¥&nbsp; Plnomocenstvo pre Älena skupiny dod&aacute;vateÄ¾ov (pr&iacute;loha Ä. 2. Ozn&aacute;menia o&nbsp;zad&aacute;van&iacute; z&aacute;kazky). Ponuku uch&aacute;dzaÄ za&scaron;le spolu s&nbsp; dokladmi, ak s&uacute; poÅ¾adovan&eacute;. Ponuky zaslan&eacute; po term&iacute;ne,&nbsp; v&nbsp;inom jazyku, alebo ak doklady nebud&uacute; predloÅ¾en&eacute; podÄ¾a poÅ¾iadaviek verejn&eacute;ho obstar&aacute;vateÄ¾a alebo uch&aacute;dzaÄ nebude spÄºÅˆaÅ¥ podmienky &uacute;Äasti alebo nebude spÄºÅˆaÅ¥ poÅ¾iadavky na predmet z&aacute;kazky podÄ¾a ozn&aacute;menia o&nbsp;zad&aacute;van&iacute; z&aacute;kazky, tak&eacute;to ponuky nebud&uacute; bran&eacute; do &uacute;vahy a&nbsp;nebud&uacute; vyhodnocovan&eacute;.</p>\r\n	<p>\r\n		&nbsp;</p>\r\n	<p style=\"margin-left: 18pt;\">\r\n		10.&nbsp; <strong>Podmienky &uacute;Äasti s&uacute; nasledovn&eacute; <em>(ak s&uacute; vyÅ¾adovan&eacute;)</em>:</strong></p>\r\n	<p>\r\n		-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; V ponuke je potrebn&eacute; predloÅ¾iÅ¥:</p>\r\n	<p>\r\n		<u>Doklady</u>:&nbsp;</p>\r\n	<p style=\"margin-left: 54pt;\">\r\n		1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; K&oacute;piu opr&aacute;vnenia na dodanie tovaru (v&yacute;pis z&nbsp;OR, Å¾ivnostensk&yacute; list).</p>\r\n	<p style=\"margin-left: 54pt;\">\r\n		&nbsp;</p>\r\n	<p style=\"margin-left: 18pt;\">\r\n		11.&nbsp; <strong>Krit&eacute;ria</strong> na hodnotenie pon&uacute;k s&uacute;: 1. cena.</p>\r\n	<p style=\"margin-left: 18pt;\">\r\n		12.&nbsp; Sp&ocirc;sob hodnotenia krit&eacute;ri&aacute;&nbsp; je nasledovn&yacute;: &Uacute;spe&scaron;n&yacute;m uch&aacute;dzaÄom bude ten, kto bude maÅ¥ najniÅ¾&scaron;iu celkov&uacute; cenu bez DPH za cel&yacute; predmet z&aacute;kazky a&nbsp;spln&iacute; v&scaron;etky&nbsp;&nbsp; poÅ¾iadavky uveden&eacute; v&nbsp;opise predmetu z&aacute;kazky.</p>\r\n	<p>\r\n		&nbsp;</p>\r\n	<p style=\"margin-left: 18pt;\">\r\n		13.&nbsp; <strong>Prijatie ponuky:</strong></p>\r\n	<p style=\"margin-left: 18pt;\">\r\n		S &uacute;spe&scaron;n&yacute; uch&aacute;dzaÄom bude uzatvoren&aacute; r&aacute;mcov&aacute; zmluva, ktor&aacute; je pr&iacute;lohou tohto ozn&aacute;menia. &nbsp;Ak ponuku predklad&aacute; skupina dod&aacute;vateÄ¾ov, skupina dod&aacute;vateÄ¾ov urÄ&iacute; svojho l&iacute;dra a&nbsp;predloÅ¾&iacute; spolu s&nbsp;k&uacute;pnou zmluvou aj Plnomocenstvo pre Älena skupiny dod&aacute;vateÄ¾ov (pr&iacute;loha Ä. 3).</p>\r\n	<p>\r\n		&nbsp;</p>\r\n	<p style=\"margin-left: 18pt;\">\r\n		14.&nbsp; Verejn&yacute; obstar&aacute;vateÄ¾ m&ocirc;Å¾e pred podpisom zmluvy poÅ¾iadaÅ¥ &uacute;spe&scaron;n&eacute;ho uch&aacute;dzaÄa o predloÅ¾enie origin&aacute;lu alebo overenej k&oacute;pie opr&aacute;vnenia&nbsp; na poskytnutie sluÅ¾by, pr&iacute;padne Äal&scaron;&iacute;ch poÅ¾adovan&yacute;ch dokladov podÄ¾a ozn&aacute;menia, ak boli predloÅ¾en&eacute; iba fotok&oacute;pie dokladov.</p>\r\n	<p style=\"margin-left: 283.2pt;\">\r\n		..................................................</p>\r\n	<p>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ing. R&oacute;bert Dula</p>\r\n	<p>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; konateÄ¾</p>\r\n	<p>\r\n		<em><u>Pr&iacute;lohy:</u> </em></p>\r\n	<p style=\"margin-left: 72pt;\">\r\n		1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; R&aacute;mcov&aacute; zmluva (pr&iacute;loha Ä. 1 k&nbsp;R&aacute;mcovej zmluve &ndash; Technologick&yacute; protokol, pr&iacute;loha Ä. 2 k&nbsp;R&aacute;mcovej zmluve &ndash; N&aacute;vrh na plnenie krit&eacute;ri&iacute;)</p>\r\n	<p style=\"margin-left: 72pt;\">\r\n		2.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Plnomocenstvo pre Älena skupiny dod&aacute;vateÄ¾ov</p>\r\n	<p>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n	<p style=\"margin-left: 247.8pt;\">\r\n		Pr&iacute;loha Ä. 1 k&nbsp;Ozn&aacute;meniu o&nbsp;zad&aacute;van&iacute; z&aacute;kazky</p>\r\n	<p align=\"center\" style=\"margin-left: 28.4pt;\">\r\n		&nbsp;</p>\r\n	<p align=\"center\" style=\"margin-left: 28.4pt;\">\r\n		<strong>R&aacute;mcov&aacute; zmluva Ä........................</strong></p>\r\n	<p>\r\n		&nbsp;</p>\r\n	<p align=\"center\" style=\"margin-left: 36pt;\">\r\n		<strong>1. Zmluvn&eacute; strany</strong></p>\r\n	<p align=\"center\" style=\"margin-left: 36pt;\">\r\n		&nbsp;</p>\r\n	<p style=\"margin-left: 28.4pt;\">\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>ZhotoviteÄ¾&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </strong></p>\r\n	<p>\r\n		S&iacute;dlo</p>\r\n	<p>\r\n		Z&aacute;pis v&nbsp;obchodnom registri &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n	<p style=\"margin-left: 180pt;\">\r\n		&Scaron;tatut&aacute;rny org&aacute;n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n	<p style=\"margin-left: 1cm;\">\r\n		IÄŒO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n	<p style=\"margin-left: 1cm;\">\r\n		DIÄŒ</p>\r\n	<p style=\"margin-left: 1cm;\">\r\n		IÄŒ DPH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n	<p>\r\n		Bankov&eacute; spojenie&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n	<p>\r\n		ÄŒ&iacute;slo &uacute;Ätu&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n	<p>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n	<p align=\"center\" style=\"margin-left: 28.4pt;\">\r\n		(Äalej len &bdquo;zhotoviteÄ¾&ldquo;)</p>\r\n	<p align=\"center\" style=\"margin-left: 28.4pt;\">\r\n		&nbsp;</p>\r\n	<p style=\"margin-left: 28.4pt;\">\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Objedn&aacute;vateÄ¾</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Mestsk&eacute; lesy, s.r.o. Poprad</p>\r\n	<p>\r\n		S&iacute;dlo&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LevoÄsk&aacute; 3312/37, 058 01 Poprad&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n	<p style=\"margin-left: 212.4pt;\">\r\n		Z&aacute;pis v&nbsp;obchodnom registri&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spoloÄnosÅ¥ zap&iacute;san&aacute; v&nbsp;Obchodnom registri Okresn&eacute;ho s&uacute;du Pre&scaron;ov, oddiel: Sro, vloÅ¾ka Ä&iacute;slo: 10486/P</p>\r\n	<p style=\"margin-left: 180pt;\">\r\n		&Scaron;tatut&aacute;rny org&aacute;n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ing. R&oacute;bert Dula, konateÄ¾</p>\r\n	<p style=\"margin-left: 1cm;\">\r\n		IÄŒO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 36&nbsp;448 311</p>\r\n	<p style=\"margin-left: 1cm;\">\r\n		DIÄŒ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2020017175</p>\r\n	<p>\r\n		IÄŒ DPH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SK2020017175</p>\r\n	<p>\r\n		Bankov&eacute; spojenie&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sberbank, a.s.&nbsp;</p>\r\n	<p>\r\n		ÄŒ&iacute;slo &uacute;Ätu&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4310021809/3100</p>\r\n	<p>\r\n		&nbsp;</p>\r\n	<p align=\"center\">\r\n		(Äalej len &bdquo;objedn&aacute;vateÄ¾&ldquo;)</p>\r\n	<p style=\"margin-left: 14.2pt;\">\r\n		&nbsp;</p>\r\n	<p style=\"margin-left: 14.2pt;\">\r\n		v&nbsp;zmysle &sect;&nbsp;536 a&nbsp;nasl. z&aacute;kona Ä.&nbsp;513/1991 Z.z. Obchodn&yacute; z&aacute;konn&iacute;k v&nbsp;platnom znen&iacute; v&nbsp;spojen&iacute; s&nbsp;ustanoveniami &sect; 11 a &sect; 64 z&aacute;kona Ä. 25/2006 Z.z. v&nbsp;znen&iacute; neskor&scaron;&iacute;ch predpisov (Äalej len &bdquo;Z&aacute;kon o&nbsp;VO&ldquo;) uzavreli t&uacute;to r&aacute;mcov&uacute; zmluvu za t&yacute;chto podmienok:</p>\r\n	<p align=\"center\" style=\"margin-left: 14.2pt;\">\r\n		<strong>2. Z&aacute;kladn&eacute; ustanovenia</strong></p>\r\n	<p style=\"margin-left: 14.2pt;\">\r\n		2.1 Touto zmluvou sa zav&auml;zuje zhotoviteÄ¾ vykonaÅ¥ dielo a&nbsp;objedn&aacute;vateÄ¾ sa zav&auml;zuje zaplatiÅ¥ cenu za jeho vykonanie podÄ¾a podmienok dojednan&yacute;ch v&nbsp;tejto zmluve.</p>\r\n	<p style=\"margin-left: 14.2pt;\">\r\n		2.2 Dielom sa podÄ¾a tejto r&aacute;mcovej zmluvy rozumie vykonanie pr&aacute;c v&nbsp;pestovnej Äinnosti. Cena diela vypl&yacute;va z&nbsp;v&iacute;Å¥aznej cenovej ponuky zhotoviteÄ¾a, ktor&aacute; bola objedn&aacute;vateÄ¾om urÄen&aacute; ako v&iacute;Å¥azn&aacute; v&nbsp;procese verejn&eacute;ho obstar&aacute;vania v&nbsp;zmysle &sect;9 ods. 9 z&aacute;k. Ä. 25/2006 Z. z. o&nbsp;verejnom obstar&aacute;van&iacute; v&nbsp;platnom znen&iacute;.</p>\r\n	<p style=\"margin-left: 14.2pt;\">\r\n		2.3 Dielo bude financovan&eacute; z&nbsp;vlastn&yacute;ch finanÄn&yacute;ch zdrojov objedn&aacute;vateÄ¾a, v&nbsp;pr&iacute;pade schv&aacute;lenia projektu a uzavretia zmluvy o&nbsp;poskytnut&iacute; nen&aacute;vratn&eacute;ho finanÄn&eacute;ho pr&iacute;spevku medzi objedn&aacute;vateÄ¾om a&nbsp;&nbsp;poskytovateÄ¾om pomoci Ministerstvom p&ocirc;dohospod&aacute;rstva v&nbsp;zast&uacute;pen&iacute; P&ocirc;dohospod&aacute;rskou platobnou agent&uacute;rou bude financovan&eacute; z&nbsp;nen&aacute;vratn&eacute;ho finanÄn&eacute;ho pr&iacute;spevku v&nbsp;zmysle Programu rozvoja vidieka 2007-2013.</p>\r\n	<p style=\"margin-left: 18pt;\">\r\n		2.4&nbsp; R&aacute;mcov&aacute; zmluva sa uzatv&aacute;ra na dobu urÄit&uacute;, a&nbsp;to do <strong>31.5.2015 alebo do vyÄerpania&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; finanÄn&eacute;ho limitu tejto r&aacute;mcovej zmluvy. </strong>FinanÄn&yacute; limit tejto r&aacute;mcovej zmluvy <strong>&nbsp;je<br />\r\n		19 820 eur.</strong></p>\r\n</div>\r\n<p>\r\n	<strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3. Predmet diela</strong></p>\r\n<p>\r\n	3.1 ZhotoviteÄ¾ sa zav&auml;zuje, Å¾e za podmienok dojednan&yacute;ch v&nbsp;tejto r&aacute;mcovej zmluve&nbsp; pre objedn&aacute;vateÄ¾a vykon&aacute; nasledovn&eacute; druhy pestovn&yacute;ch pr&aacute;c v&nbsp;predpokladanom rozsahu :</p>\r\n<h3 align=\"center\">\r\n	&nbsp;</h3>\r\n<div>\r\n	<p>\r\n		&nbsp;</p>\r\n	<p>\r\n		&nbsp;</p>\r\n	<table border=\"1\" cellpadding=\"0\" cellspacing=\"0\" style=\"width:94.58%;\" width=\"94%\">\r\n		<tbody>\r\n			<tr>\r\n				<td rowspan=\"2\" style=\"width:60.7%;\">\r\n					<p align=\"left\">\r\n						Druh pr&aacute;ce</p>\r\n				</td>\r\n				<td rowspan=\"2\" style=\"width:6.7%;\">\r\n					<p align=\"left\">\r\n						MJ</p>\r\n				</td>\r\n				<td colspan=\"3\" style=\"width:32.6%;\">\r\n					<p>\r\n						Predpokladan&yacute; rozsah v&nbsp;roku</p>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td style=\"width:9.28%;\">\r\n					<p>\r\n						2014</p>\r\n				</td>\r\n				<td style=\"width:12.58%;\">\r\n					<p>\r\n						2015</p>\r\n				</td>\r\n				<td style=\"width:10.74%;\">\r\n					<p>\r\n						SPOLU</p>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td style=\"width:60.7%;\">\r\n					<p align=\"left\">\r\n						Jamkov&aacute; sadba obaÄ¾ovan&yacute;ch saden&iacute;c</p>\r\n				</td>\r\n				<td style=\"width:6.7%;\">\r\n					<p align=\"left\">\r\n						ks</p>\r\n				</td>\r\n				<td style=\"width:9.28%;\">\r\n					<p align=\"center\">\r\n						48330</p>\r\n				</td>\r\n				<td style=\"width:12.58%;\">\r\n					<p align=\"center\">\r\n						32020</p>\r\n				</td>\r\n				<td style=\"width:10.74%;\">\r\n					<p align=\"center\">\r\n						80350</p>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td style=\"width:60.7%;\">\r\n					<p align=\"left\">\r\n						Ochrana saden&iacute;c proti burine vyÅ¾&iacute;nan&iacute;m na pl&ocirc;&scaron;kach</p>\r\n				</td>\r\n				<td style=\"width:6.7%;\">\r\n					<p align=\"left\">\r\n						ha</p>\r\n				</td>\r\n				<td style=\"width:9.28%;\">\r\n					<p align=\"center\">\r\n						25</p>\r\n				</td>\r\n				<td style=\"width:12.58%;\">\r\n					<p align=\"center\">\r\n						-</p>\r\n				</td>\r\n				<td style=\"width:10.74%;\">\r\n					<p align=\"center\">\r\n						25</p>\r\n				</td>\r\n			</tr>\r\n		</tbody>\r\n	</table>\r\n</div>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	3.2 Pr&aacute;ce zhotoviteÄ¾ vykon&aacute; podÄ¾a pokynov zodpovedn&yacute;ch zamestnancov objedn&aacute;vateÄ¾a.</p>\r\n<h3 align=\"center\">\r\n	&nbsp;</h3>\r\n<div>\r\n	<p style=\"margin-left: 18pt;\">\r\n		3.3 Ak je zhotoviteÄ¾om skupina dod&aacute;vateÄ¾ov, zmluvn&eacute; strany sa dohodli, Å¾e Älenovia skupiny dod&aacute;vateÄ¾ov s&uacute; zaviazan&iacute; spoloÄne a&nbsp;nerozdielne voÄi objedn&aacute;vateÄ¾ovi zo v&scaron;etk&yacute;ch svojich z&aacute;v&auml;zkov prevzat&yacute;ch v&nbsp;tejto zmluve, najm&auml; vykonaÅ¥ dielo vÄas spoloÄne a&nbsp;nerozdielne, t. j. Å¾e objedn&aacute;vateÄ¾ je opr&aacute;vnen&yacute; poÅ¾adovaÅ¥ plnenie od ktor&eacute;hokoÄ¾vek z&nbsp;nich a&nbsp;ak z&aacute;v&auml;zok skupiny zhotoviteÄ¾ov spln&iacute; Äo len jeden Älen skupiny zhotoviteÄ¾ov, povinnosÅ¥ ostatn&yacute;ch Älenov zanikne.</p>\r\n</div>\r\n<p align=\"center\">\r\n	<strong>4. Doba vykonania diela</strong></p>\r\n<p>\r\n	4.1 Jednotliv&eacute; druhy pr&aacute;c zhotoviteÄ¾ vykon&aacute; podÄ¾a nasledovn&eacute;ho harmonogramu a&nbsp;pokynov zodpovedn&yacute;ch zamestnancov objedn&aacute;vateÄ¾a :</p>\r\n<h3 align=\"center\">\r\n	&nbsp;</h3>\r\n<div>\r\n	<table border=\"1\" cellpadding=\"0\" cellspacing=\"0\" style=\"width:88.46%;\" width=\"88%\">\r\n		<tbody>\r\n			<tr>\r\n				<td rowspan=\"3\" style=\"width:74.54%;height:11px;\">\r\n					<p align=\"left\">\r\n						Druh pr&aacute;ce</p>\r\n				</td>\r\n				<td colspan=\"2\" style=\"width:25.46%;height:11px;\">\r\n					<p>\r\n						Rok</p>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td style=\"width:12.84%;height:11px;\">\r\n					<p>\r\n						2014</p>\r\n				</td>\r\n				<td style=\"width:12.62%;height:11px;\">\r\n					<p>\r\n						2015</p>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td colspan=\"2\" style=\"width:25.46%;height:11px;\">\r\n					<p>\r\n						Mesiac</p>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td style=\"width:74.54%;height:11px;\">\r\n					<p align=\"left\">\r\n						Jamkov&aacute; sadba obaÄ¾ovan&yacute;ch saden&iacute;c</p>\r\n				</td>\r\n				<td style=\"width:12.84%;height:11px;\">\r\n					<p>\r\n						3 &ndash; 6</p>\r\n					<p>\r\n						&nbsp;</p>\r\n				</td>\r\n				<td style=\"width:12.62%;height:11px;\">\r\n					<p>\r\n						3 &ndash; 5</p>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td style=\"width:74.54%;height:11px;\">\r\n					<p align=\"left\">\r\n						Ochrana saden&iacute;c proti burine vyÅ¾&iacute;nan&iacute;m na pl&ocirc;&scaron;kach</p>\r\n				</td>\r\n				<td style=\"width:12.84%;height:11px;\">\r\n					<p>\r\n						6 &ndash; 9</p>\r\n				</td>\r\n				<td style=\"width:12.62%;height:11px;\">\r\n					<p>\r\n						-</p>\r\n				</td>\r\n			</tr>\r\n		</tbody>\r\n	</table>\r\n</div>\r\n<p>\r\n	Vykonanie pr&aacute;c v&nbsp;inej dobe ako je uveden&eacute; v&nbsp;harmonograme uskutoÄn&iacute; zhotoviteÄ¾ len na p&iacute;somn&eacute; poÅ¾iadanie&nbsp;objedn&aacute;vateÄ¾a.</p>\r\n<p align=\"center\">\r\n	<strong>5. Miesto vykonania diela</strong></p>\r\n<p>\r\n	ZhotoviteÄ¾ vykon&aacute; pr&aacute;ce podÄ¾a bodu 3 a podÄ¾a pokynov zodpovedn&yacute;ch zamestnancov objedn&aacute;vateÄ¾a.</p>\r\n<p>\r\n	Miesta vykonania pr&aacute;c bud&uacute; zodpovedn&yacute;m zamestnancom objedn&aacute;vateÄ¾a odovzd&aacute;van&eacute; po dohode so zhotoviteÄ¾om priebeÅ¾ne, vÅ¾dy po ukonÄen&iacute; uÅ¾ objedn&aacute;vateÄ¾om zadan&yacute;ch pr&aacute;c.</p>\r\n<p>\r\n	ZhotoviteÄ¾ ozn&aacute;mi&nbsp;ukonÄenie pr&aacute;c na odovzdanom mieste ich vykonania zodpovedn&eacute;mu zamestnancovi objedn&aacute;vateÄ¾a najnesk&ocirc;r 1 deÅˆ pred ich ukonÄen&iacute;m.</p>\r\n<h3 align=\"center\">\r\n	<strong style=\"font-size: 12px;\">6. Kontrola pri vykon&aacute;van&iacute; diela</strong></h3>\r\n<p>\r\n	Objedn&aacute;vateÄ¾ je opr&aacute;vnen&yacute; kontrolovaÅ¥ vykon&aacute;vanie diela zhotoviteÄ¾om po str&aacute;nke kvality a dodrÅ¾iavania technologick&yacute;ch postupov a&nbsp;platn&yacute;ch STN. ZhotoviteÄ¾ je povinn&yacute; splniÅ¥ poÅ¾iadavky objedn&aacute;vateÄ¾a.</p>\r\n<p align=\"center\">\r\n	<strong>7. Odovzdanie a&nbsp;prevzatie diela</strong></p>\r\n<p>\r\n	7.1 Pri vykon&aacute;van&iacute; diela bude pr&aacute;va a&nbsp;povinnosti objedn&aacute;vateÄ¾a vykon&aacute;vaÅ¥ za objedn&aacute;vateÄ¾a lesn&iacute;k alebo in&yacute; zodpovedn&yacute; pracovn&iacute;k objedn&aacute;vateÄ¾a, ktor&yacute; bude urÄen&yacute; pri podpise technologick&eacute;ho protokolu.</p>\r\n<h3 align=\"center\">\r\n	&nbsp;</h3>\r\n<div>\r\n	<p style=\"margin-left: 18pt;\">\r\n		7.2 Objedn&aacute;vateÄ¾ obozn&aacute;mi zhotoviteÄ¾a pred zaÄat&iacute;m pr&aacute;c a&nbsp;odovzdan&iacute;m pracoviska s&nbsp;technologick&yacute;mi a&nbsp;pr&iacute;rodn&yacute;mi podmienkami, pracovn&yacute;mi postupmi ako aj s&nbsp;in&yacute;mi zvl&aacute;&scaron;tnosÅ¥ami ter&eacute;nu a&nbsp;pracoviska. Tieto si vz&aacute;jomne potvrdia v&nbsp;technologickom protokole. ZhotoviteÄ¾ je povinn&yacute; pri v&yacute;kone pr&aacute;c na nich prihliadaÅ¥. Vzor technologick&eacute;ho protokolu je pr&iacute;lohou Ä. 1 k&nbsp;zmluve.</p>\r\n	<p style=\"margin-left: 18pt;\">\r\n		7.3&nbsp;&nbsp; Technol&oacute;giu pr&aacute;c sa zhotoviteÄ¾ zav&auml;zuje dodrÅ¾aÅ¥ podÄ¾a dohodnut&yacute;ch podmienok v&nbsp;technologickom protokole a&nbsp;to tak, aby maxim&aacute;lne &scaron;etril ost&aacute;vaj&uacute;ci porast, prirodzen&eacute; zmladenie, lesn&eacute; cesty a&nbsp;zv&aacute;Å¾nice a&nbsp;ostatn&yacute; majetok vo vlastn&iacute;ctve alebo v&nbsp;n&aacute;jme objedn&aacute;vateÄ¾a. Pr&aacute;ce bude vykon&aacute;vaÅ¥ tak, aby nedo&scaron;lo k&nbsp;&scaron;kod&aacute;m na lesn&yacute;ch porastoch a&nbsp;kult&uacute;rach.</p>\r\n	<p style=\"margin-left: 18pt;\">\r\n		7.4&nbsp;&nbsp; PreberaÅ¥ a&nbsp;fakturovaÅ¥ sa bud&uacute; len porasty, ktor&eacute; s&uacute; &uacute;plne dokonÄen&eacute; podÄ¾a poÅ¾iadaviek objedn&aacute;vateÄ¾a alebo rozpracovan&eacute; porasty, u&nbsp;ktor&yacute;ch je moÅ¾n&eacute; preveden&eacute; pr&aacute;ce meraÅ¥ v&nbsp;ucelen&yacute;ch Äastiach.</p>\r\n	<p style=\"margin-left: 18pt;\">\r\n		7.5&nbsp;&nbsp; Objedn&aacute;vateÄ¾ sa zav&auml;zuje, Å¾e zhotoviteÄ¾om vykonan&eacute; jednotliv&eacute; druhy pr&aacute;c podÄ¾a bodu 3. prevezme a&nbsp;zaplat&iacute; za ich vykonanie dohodnut&uacute; cenu.</p>\r\n	<p style=\"margin-left: 18pt;\">\r\n		7.6&nbsp;&nbsp; Objedn&aacute;vateÄ¾ prevezme len pr&aacute;ce, ktor&eacute; s&uacute; &uacute;plne dokonÄen&eacute; podÄ¾a pokynov objedn&aacute;vateÄ¾a a&nbsp;podmienok dojednan&yacute;ch v&nbsp;tejto zmluve, bez v&aacute;d na diele alebo jeho Äastiach, ktor&eacute; by z&aacute;vaÅ¾n&yacute;m sp&ocirc;sobom ovplyvÅˆovali podstatu vykonan&eacute;ho diela alebo jeho Äast&iacute;. Lehotu na odovzdanie a&nbsp;prevzatie pr&aacute;c objedn&aacute;vateÄ¾ urÄ&iacute; podÄ¾a povahy pr&aacute;c a&nbsp;ich rozsahu.</p>\r\n	<p style=\"margin-left: 18pt;\">\r\n		7.7&nbsp;&nbsp; ZhotoviteÄ¾ za &uacute;Äelom odovzdania vykonan&yacute;ch pr&aacute;c a&nbsp;za &uacute;Äelom vystavenia fakt&uacute;ry vyzve zodpovedn&eacute;ho zamestnanca objedn&aacute;vateÄ¾a 3 dni vopred na odovzdanie a&nbsp;prevzatie pr&aacute;c na mieste ich vykonania.</p>\r\n	<p style=\"margin-left: 18pt;\">\r\n		7.8&nbsp;&nbsp; Ak&nbsp; zhotoviteÄ¾ nespln&iacute; povinnosÅ¥ uveden&uacute; v&nbsp;bode 7.6 je povinn&yacute; umoÅ¾niÅ¥ objedn&aacute;vateÄ¾ovi vykonanie dodatoÄn&eacute;ho prevzatia pr&aacute;c v&nbsp;n&iacute;m urÄenom term&iacute;ne.</p>\r\n	<p style=\"margin-left: 18pt;\">\r\n		7.9&nbsp; Ak sa objedn&aacute;vateÄ¾ nedostavil na odovzd&aacute;vanie a prevzatie pr&aacute;c, na ktor&eacute; bol zhotoviteÄ¾om vyzvan&yacute; alebo ktor&eacute; sa malo konaÅ¥ podÄ¾a dohodnut&eacute;ho Äasov&eacute;ho rozvrhu, m&ocirc;Å¾e zhotoviteÄ¾ pokraÄovaÅ¥ vo vykon&aacute;van&iacute; diela. Ak v&scaron;ak &uacute;ÄasÅ¥ na odovzd&aacute;van&iacute; a&nbsp;preberan&iacute; pr&aacute;c znemoÅ¾nila objedn&aacute;vateÄ¾ovi prek&aacute;Å¾ka, ktor&uacute; nemohol odvr&aacute;tiÅ¥, m&ocirc;Å¾e objedn&aacute;vateÄ¾ bez zbytoÄn&eacute;ho odkladu poÅ¾adovaÅ¥ vykonanie dodatoÄn&eacute;ho odovzd&aacute;vania a&nbsp;preberania pr&aacute;c, v&nbsp;n&iacute;m urÄenom term&iacute;ne.</p>\r\n	<p align=\"center\" style=\"margin-left: 18pt;\">\r\n		<strong>8. Ostatn&eacute; dojednania pri vykon&aacute;van&iacute; diela</strong></p>\r\n	<p align=\"center\" style=\"margin-left: 18pt;\">\r\n		&nbsp;</p>\r\n	<p style=\"margin-left: 18pt;\">\r\n		8.1 ZhotoviteÄ¾ vykon&aacute; pr&aacute;ce podÄ¾a technologick&yacute;ch postupov na z&aacute;klade usmernenia zodpovedn&yacute;ch zamestnancov objedn&aacute;vateÄ¾a v&nbsp;zmysle Projektu. Na technologick&eacute; zvl&aacute;&scaron;tnosti pracoviska upozorn&iacute; objedn&aacute;vateÄ¾ zhotoviteÄ¾a pred zaÄat&iacute;m pr&aacute;c a&nbsp;odovzdan&iacute;m pracoviska.</p>\r\n	<p style=\"margin-left: 18pt;\">\r\n		8.2 ZhotoviteÄ¾ sa zav&auml;zuje dodrÅ¾iavaÅ¥ platn&eacute; z&aacute;sady ochrany bezpeÄnosti pri pr&aacute;ci a&nbsp;spr&aacute;vne technologick&eacute; postupy a&nbsp;za ich dodrÅ¾iavanie nesie pln&uacute; zodpovednosÅ¥. S&uacute;Äasne zodpoved&aacute; za to, Å¾e bude vykon&aacute;vaÅ¥ len pr&aacute;ce, na ktor&eacute; m&aacute; kvalifikaÄn&eacute; opr&aacute;vnenie.</p>\r\n	<p style=\"margin-left: 18pt;\">\r\n		8.3 PoÄas doby p&ocirc;sobenia a&nbsp;zdrÅ¾iavania sa na pozemkoch objedn&aacute;vateÄ¾a sa zhotoviteÄ¾ zav&auml;zuje dodrÅ¾iavaÅ¥ platn&eacute; protipoÅ¾iarne predpisy. Pri pr&aacute;cach v&nbsp;obdob&iacute; zv&yacute;&scaron;en&eacute;ho poÅ¾iarneho nebezpeÄenstva je zhotoviteÄ¾ povinn&yacute; byÅ¥ vybaven&yacute; potrebn&yacute;m n&aacute;rad&iacute;m k&nbsp;haseniu pr&iacute;padn&eacute;ho poÅ¾iaru.</p>\r\n	<p align=\"center\" style=\"margin-left: 18pt;\">\r\n		&nbsp;</p>\r\n	<p align=\"center\" style=\"margin-left: 18pt;\">\r\n		<strong>9. Veci urÄen&eacute; k&nbsp;vykonaniu diela</strong></p>\r\n	<p align=\"center\" style=\"margin-left: 18pt;\">\r\n		&nbsp;</p>\r\n	<p style=\"margin-left: 18pt;\">\r\n		9.1 ZhotoviteÄ¾ vykon&aacute; dielo vlastn&yacute;m pracovn&yacute;m n&aacute;rad&iacute;m a&nbsp;materi&aacute;lom, ktor&eacute; nezabezpeÄuje podÄ¾a tejto zmluvy objedn&aacute;vateÄ¾.</p>\r\n	<p style=\"margin-left: 18pt;\">\r\n		9.2 Objedn&aacute;vateÄ¾ obstar&aacute;va na vykonanie diela sadenice lesn&yacute;ch drev&iacute;n a&nbsp;prostriedky na ich o&scaron;etrenie pri umelej obnove lesa. Materi&aacute;l podÄ¾a&nbsp; bude objedn&aacute;vateÄ¾ odovzd&aacute;vaÅ¥ priebeÅ¾ne po odovzdan&iacute; miest na vykonanie pr&aacute;c, podÄ¾a skutoÄn&yacute;ch potrieb zhotoviteÄ¾a a&nbsp;na z&aacute;klade rozhodnutia zodpovedn&yacute;ch zamestnancov objedn&aacute;vateÄ¾a.</p>\r\n	<p style=\"margin-left: 18pt;\">\r\n		9.3 Za materi&aacute;l prevzat&yacute; od objedn&aacute;vateÄ¾a do doby skutoÄn&eacute;ho vykonania pr&aacute;c a&nbsp;ich prevzatia zodpovedn&yacute;m zamestnancom objedn&aacute;vateÄ¾a zodpoved&aacute; zhotoviteÄ¾.</p>\r\n	<p style=\"margin-left: 18pt;\">\r\n		Po dokonÄen&iacute; diela je&nbsp; zhotoviteÄ¾ povinn&yacute; bez zbytoÄn&eacute;ho odkladu vr&aacute;tiÅ¥ objedn&aacute;vateÄ¾ovi materi&aacute;l vr&aacute;tane obalov, ktor&eacute; sa nespotrebovali pri vykon&aacute;van&iacute; diela.</p>\r\n	<p align=\"center\" style=\"margin-left: 18pt;\">\r\n		<strong>10. Vady diela</strong></p>\r\n	<p align=\"center\" style=\"margin-left: 18pt;\">\r\n		ZhotoviteÄ¾ zodpoved&aacute; za vady diela, ktor&eacute; m&aacute; v Äase jeho odovzdania ako aj tie, ktor&eacute; sa vyskytn&uacute; po tomto Äase ak boli sp&ocirc;soben&eacute; poru&scaron;en&iacute;m jeho povinnost&iacute;. ZhotoviteÄ¾ nezodpoved&aacute; za vady diela, ak tieto vady sp&ocirc;sobilo pouÅ¾itie materi&aacute;lu odovzdan&eacute;ho mu objedn&aacute;vateÄ¾om v&nbsp;pr&iacute;pade, Å¾e zhotoviteÄ¾ nevhodnosÅ¥ tohto materi&aacute;lu nemohol zistiÅ¥ alebo na ne objedn&aacute;vateÄ¾a upozornil a&nbsp;objedn&aacute;vateÄ¾ na ich pouÅ¾it&iacute; trval. ZhotoviteÄ¾ takisto nezodpoved&aacute; za vady sp&ocirc;soben&eacute; dodrÅ¾an&iacute;m nevhodn&yacute;ch pokynov dan&yacute;ch mu objedn&aacute;vateÄ¾om, ak zhotoviteÄ¾ na nevhodnosÅ¥ t&yacute;chto pokynov upozornil a&nbsp;objedn&aacute;vateÄ¾ na ich dodrÅ¾an&iacute; trval alebo ak zhotoviteÄ¾ t&uacute;to nevhodnosÅ¥ nemohol zistiÅ¥.</p>\r\n	<p style=\"margin-left: 18pt;\">\r\n		&nbsp;</p>\r\n	<p align=\"center\" style=\"margin-left: 18pt;\">\r\n		<strong>11. Cena diela</strong></p>\r\n	<p align=\"center\" style=\"margin-left: 18pt;\">\r\n		&nbsp;</p>\r\n	<p>\r\n		11.1&nbsp; Za jednotliv&eacute; druhy ukonÄen&yacute;ch pr&aacute;c zaplat&iacute; objedn&aacute;vateÄ¾ Äiastku, ktor&uacute; urÄ&iacute; na z&aacute;klade ceny &nbsp;&nbsp;</p>\r\n	<p>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uvedenej v&nbsp;pr&iacute;lohe Ä. 2 tejto zmluvy za mern&uacute; jednotku a&nbsp;poÄtu skutoÄne vykonan&yacute;ch mern&yacute;ch</p>\r\n	<p>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; jednotiek, zhotoviteÄ¾om odovzdan&yacute;ch a&nbsp;objedn&aacute;vateÄ¾om prevzat&yacute;ch pr&aacute;c podÄ¾a bodu 7.</p>\r\n</div>\r\n<p>\r\n	11.2 Cena mus&iacute; zahÅ•ÅˆaÅ¥ v&scaron;etky ekonomicky opr&aacute;vnen&eacute; n&aacute;klady zhotoviteÄ¾a vynaloÅ¾en&eacute; v&nbsp;s&uacute;vislosti s&nbsp;realiz&aacute;ciou sluÅ¾by. Cena &nbsp;je dohodnut&aacute; v eur&aacute;ch. K&nbsp;fakturovanej cene bude vÅ¾dy pripoÄ&iacute;tan&aacute; DPH stanoven&aacute; v&nbsp;s&uacute;lade s&nbsp;pr&aacute;vnymi predpismi v&nbsp;Äase poskytnutia sluÅ¾by.</p>\r\n<p>\r\n	11.3&nbsp; V&nbsp;pr&iacute;pade ak objedn&aacute;vateÄ¾ uloÅ¾il zhotoviteÄ¾ovi sankciu za vady zisten&eacute; pri preberan&iacute; pr&aacute;c, objedn&aacute;vateÄ¾ zaplat&iacute; za jednotliv&eacute; druhy ukonÄen&yacute;ch pr&aacute;c Äiastku urÄen&uacute; podÄ¾a bodu 11.1. zn&iacute;Å¾en&uacute; o&nbsp;v&yacute;&scaron;ku sankcie podÄ¾a bodu 17.</p>\r\n<h3 align=\"center\">\r\n	&nbsp;</h3>\r\n<div>\r\n	<p>\r\n		&nbsp;</p>\r\n</div>\r\n<p align=\"center\">\r\n	<strong>12. Sp&ocirc;sob a&nbsp;term&iacute;n platby</strong></p>\r\n<p>\r\n	12. 1 ZhotoviteÄ¾ vystav&iacute; objedn&aacute;vateÄ¾ovi po ukonÄen&iacute; a&nbsp;prevzat&iacute; pr&aacute;c podÄ¾a bodu 7. fakt&uacute;ru na finanÄn&uacute; Äiastku ods&uacute;hlasen&uacute; a&nbsp;potvrden&uacute; obidvoma stranami na podklade k&nbsp;faktur&aacute;cii (protokol o&nbsp;prevzat&iacute; pr&aacute;c a&nbsp;pracov&iacute;sk od dod&aacute;vateÄ¾a). SplatnosÅ¥ fakt&uacute;ry najviac 15 dn&iacute; odo dÅˆa, kedy objedn&aacute;vateÄ¾ obdrÅ¾&iacute; fakt&uacute;ru.</p>\r\n<h3 align=\"center\">\r\n	&nbsp;</h3>\r\n<div>\r\n	<p style=\"margin-left: 1cm;\">\r\n		12.2. V&nbsp;pr&iacute;pade, Å¾e zhotoviteÄ¾om je skupina dod&aacute;vateÄ¾ov, zmluvn&eacute; strany sa dohodli, Å¾e objedn&aacute;vateÄ¾ je voÄi Älenom skupiny zo svojich z&aacute;v&auml;zkov prevzat&yacute;ch v&nbsp;tejto zmluve, najm&auml; z&aacute;v&auml;zku zaplatiÅ¥ za vykonan&eacute; dielo vÄas dohodnut&uacute; cenu zaviazan&yacute; oddelene, t. j. kaÅ¾d&eacute;mu Älenovi skupiny dod&aacute;vateÄ¾ov je povinn&yacute; zaplatiÅ¥ len n&iacute;m skutoÄne vykonan&uacute; ÄasÅ¥ diela.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n</div>\r\n<p align=\"center\">\r\n	<strong>13. Osobitn&eacute; poÅ¾iadavky objedn&aacute;vateÄ¾a</strong></p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	Po ukonÄen&iacute; Äinnosti musia byÅ¥ na pracovisk&aacute;ch pouÅ¾&iacute;van&eacute; lesn&eacute; cesty a&nbsp;zv&aacute;Å¾nice prejazdn&eacute; a&nbsp;chodn&iacute;ky priechodn&eacute;.</p>\r\n<p align=\"center\">\r\n	<strong>14. &Scaron;kody</strong></p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	ZhotoviteÄ¾ zodpoved&aacute; objedn&aacute;vateÄ¾ovi a&nbsp;in&yacute;m osob&aacute;m za &scaron;kodu sp&ocirc;soben&uacute; poru&scaron;en&iacute;m povinnost&iacute; pri v&yacute;kone pr&aacute;c alebo ÄinnosÅ¥ou v&nbsp;priamej s&uacute;vislosti s&nbsp;Åˆou a&nbsp;zav&auml;zuje sa ju uhradiÅ¥ po&scaron;koden&eacute;mu v&nbsp;plnej v&yacute;&scaron;ke.</p>\r\n<p align=\"center\">\r\n	<strong>15. ZodpovednosÅ¥ za poru&scaron;enie zmluvy</strong></p>\r\n<p>\r\n	15.1&nbsp; Ak objedn&aacute;vateÄ¾ zist&iacute;, Å¾e zhotoviteÄ¾ vykon&aacute;va dielo v&nbsp;rozpore zo svojimi povinnosÅ¥ami a&nbsp;pokynmi zodpovedn&yacute;ch zamestnancov objedn&aacute;vateÄ¾a, je objedn&aacute;vateÄ¾ opr&aacute;vnen&yacute; doÅ¾adovaÅ¥ sa toho, aby zhotoviteÄ¾ odstr&aacute;nil nedostatky vzniknut&eacute; vadn&yacute;m vykon&aacute;van&iacute;m a&nbsp;dielo vykon&aacute;val riadnym sp&ocirc;sobom. Ak tak zhotoviteÄ¾ diela neurob&iacute; ani v&nbsp;primeranej lehote na to poskytnutej a&nbsp;postup&nbsp; zhotoviteÄ¾a by viedol nepochybne k&nbsp; poru&scaron;eniu zmluvy, je objedn&aacute;vateÄ¾ opr&aacute;vnen&yacute; podÄ¾a z&aacute;vaÅ¾nosti poru&scaron;enia zmluvnej povinnosti odst&uacute;piÅ¥ od zmluvy alebo uloÅ¾iÅ¥ zhotoviteÄ¾ovi sankciu, ktorej v&yacute;&scaron;ku objedn&aacute;vateÄ¾ urÄ&iacute; na z&aacute;klade povahy a&nbsp;rozsahu poru&scaron;enia zmluvn&yacute;ch podmienok, maxim&aacute;lne v&scaron;ak do v&yacute;&scaron;ky 5 000 eur.</p>\r\n<h3 align=\"center\">\r\n	&nbsp;</h3>\r\n<div>\r\n	<p>\r\n		&nbsp;</p>\r\n</div>\r\n<p>\r\n	15.2 ZhotoviteÄ¾ nezodpoved&aacute; za poru&scaron;enie zmluvnej povinnosti, ak splneniu jeho povinnosti br&aacute;ni prek&aacute;Å¾ka, ktor&aacute; nastala nez&aacute;visle od jeho v&ocirc;le, ak nemoÅ¾no rozumne predpokladaÅ¥, Å¾e by&nbsp; t&uacute;to prek&aacute;Å¾ku alebo jej n&aacute;sledky odvr&aacute;til alebo prekonal, alebo, Å¾e by v&nbsp;Äase podpisu tejto zmluvy t&uacute;to prek&aacute;Å¾ku predv&iacute;dal.</p>\r\n<p align=\"center\">\r\n	<strong>16. Sankcie</strong></p>\r\n<p>\r\n	16.1&nbsp; Objedn&aacute;vateÄ¾ m&ocirc;Å¾e uloÅ¾iÅ¥ zhotoviteÄ¾ovi peÅˆaÅ¾n&uacute; sankciu za vadn&eacute; vykonanie pr&aacute;c, ak objedn&aacute;vateÄ¾ vykonan&eacute; pr&aacute;ce prevzal a vada zisten&aacute; pri preberan&iacute; pr&aacute;c z&aacute;vaÅ¾n&yacute;m sp&ocirc;sobom neovplyvÅˆuje podstatu vykonan&eacute;ho diela alebo jeho Äast&iacute;&nbsp; alebo ak zhotoviteÄ¾ poru&scaron;il ak&uacute;koÄ¾vek povinnosÅ¥, ku ktorej sa zaviazal podÄ¾a tejto zmluvy pri vykon&aacute;van&iacute; diela.</p>\r\n<h3 align=\"center\">\r\n	&nbsp;</h3>\r\n<div>\r\n	<p>\r\n		&nbsp;</p>\r\n</div>\r\n<p>\r\n	16.2 V&yacute;&scaron;ku sankcie urÄ&iacute; objedn&aacute;vateÄ¾ podÄ¾a povahy a&nbsp;rozsahu zisten&yacute;ch v&aacute;d alebo poru&scaron;enia zmluvn&yacute;ch podmienok. ZhotoviteÄ¾ sa zav&auml;zuje zn&aacute;&scaron;aÅ¥ sankciu uloÅ¾en&uacute; objedn&aacute;vateÄ¾om.</p>\r\n<h3 align=\"center\">\r\n	&nbsp;</h3>\r\n<div>\r\n	<p>\r\n		&nbsp;</p>\r\n	<p align=\"center\">\r\n		<strong>17. Odst&uacute;penie od zmluvy</strong></p>\r\n	<p>\r\n		17.1 Objedn&aacute;vateÄ¾ m&ocirc;Å¾e odst&uacute;piÅ¥ od tejto zmluvy, a&nbsp;to aj len ÄiastoÄne</p>\r\n</div>\r\n<p>\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17.1.1 ak zhotoviteÄ¾ poru&scaron;il ak&uacute;koÄ¾vek povinnosÅ¥, ku ktorej sa zaviazal podÄ¾a tejto&nbsp; zmluvy</p>\r\n<p>\r\n	17.1.2 ak P&ocirc;dohospod&aacute;rska platobn&aacute; agent&uacute;ra neschv&aacute;li objedn&aacute;vateÄ¾om predloÅ¾en&yacute; Projekt&nbsp;&nbsp;</p>\r\n<p>\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a neuzavrie s&nbsp;objedn&aacute;vateÄ¾om zmluvu o poskytnut&iacute; nen&aacute;vratn&eacute;ho finanÄn&eacute;ho&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n<p>\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr&iacute;spevku.&nbsp;</p>\r\n<h3 align=\"center\">\r\n	&nbsp;</h3>\r\n<div>\r\n	<p>\r\n		17.2Odst&uacute;penie od r&aacute;mcovej zmluvy je &uacute;Äinn&eacute; dÅˆom doruÄenia ozn&aacute;menia o&nbsp;odst&uacute;pen&iacute; od&nbsp;</p>\r\n	<p>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r&aacute;mcovej zmluvy.&nbsp;&nbsp;</p>\r\n	<p>\r\n		17.3 Objedn&aacute;vateÄ¾ sa uch&aacute;dza o&nbsp;dot&aacute;ciu predloÅ¾en&iacute;m projektu z&nbsp;OperaÄn&eacute;ho programu rozvoja vidieka SR 2007- 2013, n&aacute;zov opatrenia: 2.1 Obnova potenci&aacute;lu lesn&eacute;ho hospod&aacute;rstva a&nbsp;zavedenie prevent&iacute;vnych opatren&iacute;. Objedn&aacute;vateÄ¾ si vyhradzuje pr&aacute;vo odst&uacute;piÅ¥ od zmluvy v&nbsp;pr&iacute;pade, ak&nbsp; uveden&yacute; projekt nebude &uacute;spe&scaron;n&yacute; a&nbsp;ned&ocirc;jde k&nbsp;uzavretiu zmluvy o&nbsp;poskytnut&iacute; nen&aacute;vratn&eacute;ho finanÄn&eacute;ho pr&iacute;spevku. Objedn&aacute;vateÄ¾ o&nbsp;tom&nbsp; p&iacute;somne obozn&aacute;mi zhotoviteÄ¾a.</p>\r\n	<p align=\"left\" style=\"margin-left: 27pt;\">\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 18. V&yacute;poveÄ r&aacute;mcovej dohody</p>\r\n	<p align=\"left\">\r\n		&nbsp;</p>\r\n	<p>\r\n		V&yacute;povedn&aacute; lehota je dvojmesaÄn&aacute;. ZaÄ&iacute;na plyn&uacute;Å¥ prv&yacute;m dÅˆom mesiaca nasleduj&uacute;com po mesiaci, v&nbsp;ktorom bola v&yacute;poveÄ doruÄen&aacute;. V&nbsp;pr&iacute;pade, Å¾e zhotoviteÄ¾om je skupina, je v&yacute;poveÄ platn&aacute;, len ak je podp&iacute;san&aacute; v&scaron;etk&yacute;mi Älenmi skupiny, ktor&iacute; podp&iacute;sali r&aacute;mcov&uacute; zmluvu.</p>\r\n	<p align=\"left\" style=\"margin-left: 27pt;\">\r\n		&nbsp;&nbsp;</p>\r\n</div>\r\n<p align=\"center\">\r\n	<strong>19. Z&aacute;vereÄn&eacute; ustanovenia</strong></p>\r\n<p>\r\n	19.1 T&aacute;to zmluva nadob&uacute;da platnosÅ¥ a&nbsp;&uacute;ÄinnosÅ¥ dÅˆom podpisu oboma zmluvn&yacute;mi stranami. Zmluvn&yacute; vzÅ¥ah zaloÅ¾en&yacute; touto zmluvou sa bude riadiÅ¥ poÄas celej doby trvania z&aacute;v&auml;zkov z&nbsp;nej vypl&yacute;vaj&uacute;cich pr&iacute;slu&scaron;n&yacute;mi ustanoveniami Obchodn&eacute;ho z&aacute;konn&iacute;ka (z&aacute;k. Ä. 513/1991 Zb. v&nbsp;znen&iacute; neskor&scaron;&iacute;ch predpisov).</p>\r\n<h3 align=\"center\">\r\n	&nbsp;</h3>\r\n<div>\r\n	<p>\r\n		&nbsp;</p>\r\n	<p style=\"margin-left: 1cm;\">\r\n		19.2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; T&aacute;to zmluva nadob&uacute;da platnosÅ¥ dÅˆom jej podpisu oboma zmluvn&yacute;mi stranami a&nbsp;&uacute;ÄinnosÅ¥&nbsp;&nbsp;&nbsp;</p>\r\n	<p style=\"margin-left: 19.2pt;\">\r\n		&nbsp; dÅˆom nasleduj&uacute;cim po zverejnen&iacute; inform&aacute;cie o&nbsp;uzavret&iacute; zmluvy na <a href=\"http://www.lesypoprad.sk/\">www.lesypoprad.sk</a>. &nbsp;&nbsp;</p>\r\n	<p style=\"margin-left: 19.2pt;\">\r\n		&nbsp; ZhotoviteÄ¾ berie na vedomie, Å¾e&nbsp; objedn&aacute;vateÄ¾ je povinnou osobou v&nbsp;zmysle z&aacute;k. Ä. &nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n	<p style=\"margin-left: 19.2pt;\">\r\n		&nbsp; 211/2000 Z. z. o&nbsp;slobodnom pr&iacute;stupe k&nbsp;inform&aacute;ci&aacute;m v&nbsp;platnom znen&iacute; a&nbsp;s&uacute;hlas&iacute; so &nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n	<p style=\"margin-left: 19.2pt;\">\r\n		&nbsp; zverejnen&iacute;m inform&aacute;cie o&nbsp;uzavret&iacute; zmluvy a&nbsp;s&nbsp;jej spr&iacute;stupnen&iacute;m na Å¾iadosÅ¥ tret&iacute;ch os&ocirc;b.</p>\r\n	<p style=\"margin-left: 19.2pt;\">\r\n		&nbsp;</p>\r\n	<p style=\"margin-left: 21.3pt;\">\r\n		19.3 T&uacute;to zmluvu je moÅ¾n&eacute; meniÅ¥ alebo dopÄºÅˆaÅ¥ len na z&aacute;klade vz&aacute;jomnej dohody oboch zmluvn&yacute;ch str&aacute;n, priÄom ak&eacute;koÄ¾vek zmeny a&nbsp;doplnky musia byÅ¥ vykonan&eacute; vo forme p&iacute;somn&eacute;ho dodatku k&nbsp;zmluve.</p>\r\n</div>\r\n<p>\r\n	19.4 &nbsp;V&nbsp;pr&iacute;pade, ak sa ak&eacute;koÄ¾vek ustanovenie tejto zmluvy stane neplatn&yacute;m v&nbsp;d&ocirc;sledku jeho rozporu s&nbsp;platn&yacute;m pr&aacute;vnym poriadkom, zmluvn&eacute; strany sa zav&auml;zuj&uacute; vz&aacute;jomn&yacute;m rokovan&iacute;m nahradiÅ¥ neplatn&eacute; zmluvn&eacute; ustanovenie nov&yacute;m platn&yacute;m ustanoven&iacute;m tak, aby ostal zachovan&yacute; obsah a&nbsp;&uacute;Äel sledovan&yacute; zmluvou.</p>\r\n<h3 align=\"center\">\r\n	&nbsp;</h3>\r\n<div>\r\n	<p>\r\n		V ..............................., dÅˆa .......................&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; V ..............................., dÅˆa .......................&nbsp;</p>\r\n	<p>\r\n		&nbsp;</p>\r\n	<p>\r\n		&nbsp;</p>\r\n	<p>\r\n		Objedn&aacute;vateÄ¾: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ZhotoviteÄ¾:</p>\r\n	<p>\r\n		&nbsp;</p>\r\n	<p>\r\n		Ing. R&oacute;bert Dula&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; ...................................................</p>\r\n	<p>\r\n		&nbsp;&nbsp; konateÄ¾&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n	<p>\r\n		&nbsp;</p>\r\n	<p>\r\n		&nbsp;</p>\r\n	<table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"width:100.06%;\" width=\"100%\">\r\n		<tbody>\r\n			<tr>\r\n				<td colspan=\"8\" style=\"width:100.0%;\">\r\n					<p>\r\n						Objedn&aacute;vateÄ¾: Mestsk&eacute; lesy, s.r.o. Poprad&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>Pr&aacute;ce v&nbsp;pestovnej a&nbsp;ostatnej lesnej Äinnosti</strong></p>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td colspan=\"8\" style=\"width:100.0%;\">\r\n					<p align=\"center\">\r\n						&nbsp;</p>\r\n					<p align=\"center\">\r\n						<strong>TECHNOLOGICK&Yacute; PROTOKOL</strong></p>\r\n					<p align=\"center\">\r\n						<strong>odovzdanie pracoviska dod&aacute;vateÄ¾ovi</strong></p>\r\n					<p>\r\n						&nbsp;</p>\r\n					<p>\r\n						ZhotoviteÄ¾ pr&aacute;ce - dod&aacute;vateÄ¾:</p>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td colspan=\"8\" style=\"width:100.0%;\">\r\n					<p>\r\n						&nbsp;N&aacute;zov (skupina):&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Zmluva Ä.:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n					<p>\r\n						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n					<p>\r\n						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; zo dÅˆa:</p>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td colspan=\"8\" style=\"width:100.0%;\">\r\n					<p>\r\n						&nbsp;</p>\r\n					<p>\r\n						Miesto v&yacute;konu pr&aacute;ce:</p>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td style=\"width:6.38%;height:29px;\">\r\n					<p align=\"center\">\r\n						LS</p>\r\n				</td>\r\n				<td style=\"width:7.08%;height:29px;\">\r\n					<p>\r\n						&nbsp;</p>\r\n				</td>\r\n				<td style=\"width:7.08%;height:29px;\">\r\n					<p align=\"center\">\r\n						LO</p>\r\n				</td>\r\n				<td style=\"width:7.08%;height:29px;\">\r\n					<p>\r\n						&nbsp;</p>\r\n				</td>\r\n				<td colspan=\"2\" style=\"width:8.92%;height:29px;\">\r\n					<p align=\"center\">\r\n						JPRL</p>\r\n				</td>\r\n				<td colspan=\"2\" style=\"width:63.44%;height:29px;\">\r\n					<p>\r\n						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td colspan=\"8\" style=\"width:100.0%;\">\r\n					<p>\r\n						&nbsp;</p>\r\n					<p>\r\n						Technol&oacute;gia vykonania pr&aacute;c &nbsp;jej&nbsp; &scaron;pecifick&eacute; podmienky:</p>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td colspan=\"8\" style=\"width:100.0%;\">\r\n					<p>\r\n						<strong>Obnova lesa: prv&eacute; zalesÅˆovanie </strong><strong>&nbsp;, opakovan&eacute; zalesÅˆovanie </strong><strong>&nbsp;, podsadba </strong></p>\r\n					<p>\r\n						<strong>ÄŒistenie pl&ocirc;ch po t&#39;aÅ¾be:&nbsp; s p&aacute;len&iacute;m </strong><strong>&nbsp;, bez p&aacute;lenia </strong><strong>&nbsp;,</strong><strong> mechanizovane </strong></p>\r\n					<p>\r\n						<strong>Ochrana MLP proti burine: ruÄne </strong><strong>,</strong><strong> chemicky </strong><strong>&nbsp;, </strong><strong>&nbsp;krovinorezom&nbsp; </strong></p>\r\n					<p>\r\n						<strong>Ochrana MLP proti zveri:&nbsp; mechanick&aacute; </strong><strong>&nbsp;chemick&aacute; </strong><strong>&nbsp;, o</strong><strong>plocovan&iacute;m </strong></p>\r\n					<p>\r\n						<strong>Pleci rub a v&yacute;sek krov </strong><strong>&nbsp;, </strong><strong>PreÄistky- prerez&aacute;vky:&nbsp; s rozÄleÅˆovan&iacute;m </strong><strong>,</strong><strong> bez rozÄleÅˆovania</strong></p>\r\n					<p>\r\n						<strong>In&eacute; </strong><strong>&nbsp;:</strong></p>\r\n					<p>\r\n						&nbsp;priemern&yacute; sklon&nbsp;&nbsp;&nbsp; ...&nbsp;&nbsp; %&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chr&aacute;nen&eacute; &uacute;zemie, v&yacute;skyt vz&aacute;cnych druhov</p>\r\n					<p>\r\n						hust&yacute; bylinn&yacute; podrast, trnit&eacute; krovie&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &uacute;zemie PHO, vodn&eacute; zdroje</p>\r\n					<p>\r\n						kamenist&yacute; povrch, v&yacute;skyt balvanov&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; produktovody (elektrovody, telef.vedenie&nbsp; a pod.)</p>\r\n					<p>\r\n						v&yacute;skyt such&yacute;ch, nahnit&yacute;ch stromov&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; verejn&aacute; komunik&aacute;cia (cesta, chodn&iacute;k, most)</p>\r\n					<p>\r\n						v&yacute;skyt zlomov, polomov a&nbsp;v&yacute;vratov&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; moÅ¾n&yacute; pohyb verejnosti po pracovisku</p>\r\n					<p>\r\n						v&yacute;skyt jarkov, bar&iacute;n, zamokren&yacute;ch miest&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; maxim&aacute;lne pr&iacute;pustn&eacute; po&scaron;kodenie ost&aacute;vaj&uacute;cich stromov v poraste&nbsp;&nbsp; ...&nbsp; %</p>\r\n					<p>\r\n						v&yacute;skyt prirodzen&eacute;ho zmladenia&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; pr&iacute;pustn&eacute; po&scaron;kodenie prirodzen&eacute;ho zmladenia&nbsp; ...&nbsp; %</p>\r\n					<p>\r\n						pouÅ¾itie chemick&yacute;ch pr&iacute;pravkov&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;urÄen&eacute; skladovanie PHM, odpadov &nbsp;</p>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td colspan=\"8\" style=\"width:100.0%;\">\r\n					<p>\r\n						urÄen&eacute; vyznaÄenie a hranice pracoviska&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; potvrden&eacute; z&aacute;sady OBP, PO a&nbsp;pouÅ¾&iacute;vania OOPP</p>\r\n					<p>\r\n						in&eacute;:</p>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td colspan=\"8\" style=\"width:100.0%;height:13px;\">\r\n					<p style=\"margin-left: 0.8pt;\">\r\n						&nbsp;</p>\r\n					<p style=\"margin-left: 0.8pt;\">\r\n						Technologick&yacute; n&aacute;kres a popis:</p>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td colspan=\"8\" style=\"width:100.0%;height:151px;\">\r\n					<p align=\"right\">\r\n						&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Mierka:&nbsp; 1 :</p>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td colspan=\"8\" style=\"width:100.0%;\">\r\n					<p>\r\n						&nbsp;</p>\r\n					<p>\r\n						DoplÅˆuj&uacute;ce&nbsp; &uacute;daje:</p>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td colspan=\"8\" style=\"width:100.0%;height:58px;\">\r\n					<p>\r\n						TiesÅˆov&eacute; volanie:112&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NajbliÅ¾&scaron;ia nemocnica:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;Prostriedky prvej pomoci</p>\r\n					<p>\r\n						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;N&aacute;stroje na asan&aacute;ciu zneÄistenia</p>\r\n					<p>\r\n						In&eacute;:</p>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td colspan=\"8\" style=\"width:100.0%;\">\r\n					<p align=\"center\">\r\n						&nbsp;</p>\r\n					<p>\r\n						Objedn&aacute;vateÄ¾ odovzd&aacute;va pracovisko uveden&eacute; v&nbsp;tomto protokole dod&aacute;vateÄ¾ovi pr&aacute;c za &uacute;Äelom vykonania pr&aacute;c dohodnut&yacute;ch v&nbsp;zmluve. Dod&aacute;vateÄ¾ pr&aacute;c bol obozn&aacute;men&yacute; s&nbsp;podmienkami pre v&yacute;kon pr&aacute;c a&nbsp;prehlasuje, Å¾e zabezpeÄ&iacute; ich dodrÅ¾anie. Dod&aacute;vateÄ¾ vykon&aacute; v&scaron;etky pr&aacute;ce na vlastn&eacute; n&aacute;klady a&nbsp;nebezpeÄenstvo.</p>\r\n					<p>\r\n						Predpokladan&eacute; ukonÄenie pr&aacute;c (mesiac/rok):&nbsp; ............ /201..</p>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td colspan=\"5\" style=\"width:33.34%;height:84px;\">\r\n					<p>\r\n						&nbsp;D&aacute;tum zaÄatia pr&aacute;c:&nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n					<p>\r\n						&nbsp;</p>\r\n					<p>\r\n						&nbsp;</p>\r\n					<p>\r\n						&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p>\r\n				</td>\r\n				<td colspan=\"2\" style=\"width:33.32%;height:84px;\">\r\n					<p>\r\n						Dod&aacute;vateÄ¾:</p>\r\n					<p>\r\n						&nbsp;</p>\r\n					<p>\r\n						&nbsp;</p>\r\n					<p>\r\n						&nbsp;</p>\r\n					<p>\r\n						&nbsp;</p>\r\n				</td>\r\n				<td style=\"width:33.34%;height:84px;\">\r\n					<p>\r\n						Objedn&aacute;vateÄ¾:</p>\r\n					<p>\r\n						&nbsp;</p>\r\n					<p>\r\n						&nbsp;</p>\r\n					<p>\r\n						Ved&uacute;ci LO:</p>\r\n					<p>\r\n						&nbsp;</p>\r\n					<p>\r\n						RiaditeÄ¾ ML:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n				</td>\r\n			</tr>\r\n			<tr height=\"0\">\r\n				<td>\r\n					<p>\r\n						&nbsp;</p>\r\n				</td>\r\n				<td>\r\n					<p>\r\n						&nbsp;</p>\r\n				</td>\r\n				<td>\r\n					<p>\r\n						&nbsp;</p>\r\n				</td>\r\n				<td>\r\n					<p>\r\n						&nbsp;</p>\r\n				</td>\r\n				<td>\r\n					<p>\r\n						&nbsp;</p>\r\n				</td>\r\n				<td>\r\n					<p>\r\n						&nbsp;</p>\r\n				</td>\r\n				<td>\r\n					<p>\r\n						&nbsp;</p>\r\n				</td>\r\n				<td>\r\n					<p>\r\n						&nbsp;</p>\r\n				</td>\r\n			</tr>\r\n		</tbody>\r\n	</table>\r\n	<p style=\"margin-left: 283.2pt;\">\r\n		&nbsp;</p>\r\n	<table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"width:100.06%;\" width=\"100%\">\r\n		<tbody>\r\n			<tr>\r\n				<td colspan=\"8\" style=\"width:100.0%;\">\r\n					<p>\r\n						Objedn&aacute;vateÄ¾: Mestsk&eacute; lesy, s.r.o. Poprad&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>Pr&aacute;ce v&nbsp;pestovnej a&nbsp;ostatnej lesnej Äinnosti</strong></p>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td colspan=\"8\" style=\"width:100.0%;\">\r\n					<p align=\"center\">\r\n						<strong>PROTOKOL</strong></p>\r\n					<p align=\"center\">\r\n						<strong>o prevzat&amp;iacu</strong></p>\r\n				</td>\r\n			</tr>\r\n		</tbody>\r\n	</table>\r\n</div>\r\n<p>\r\n	&nbsp;</p>\r\n',	3,	0,	0,	0,	0,	0,	1285,	NULL);

DROP TABLE IF EXISTS `clanok_komponenty`;
CREATE TABLE `clanok_komponenty` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
  `id_hlavne_menu` int(11) NOT NULL COMMENT 'Id hl. menu, ktorému je komponenta pripojená',
  `spec_nazov` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT 'Špecifický názov komponenty',
  `parametre` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT 'Parametre komponenty',
  PRIMARY KEY (`id`),
  KEY `id_clanok` (`id_hlavne_menu`),
  CONSTRAINT `clanok_komponenty_ibfk_3` FOREIGN KEY (`id_hlavne_menu`) REFERENCES `hlavne_menu` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Zoznam komponent, ktoré sú priradené k článku';


DROP TABLE IF EXISTS `clanok_lang`;
CREATE TABLE `clanok_lang` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
  `id_lang` int(11) NOT NULL DEFAULT '1' COMMENT 'Id jazyka',
  `text` text COLLATE utf8_bin,
  `anotacia` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'Anotácia článku v danom jazyku',
  PRIMARY KEY (`id`),
  KEY `id_lang` (`id_lang`),
  CONSTRAINT `clanok_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `lang` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Jazyková mutácia článku';

INSERT INTO `clanok_lang` (`id`, `id_lang`, `text`, `anotacia`) VALUES
(1,	1,	'<p>Spoločnosť <strong>Mestské lesy, s r.o. Poprad</strong> vznikla dňa 25.7.1997,  na základe uznesenia MZ č. 31/1997 zo dňa 17.4.1997. Založená bola zakladateľskou listinou vo forme notárskej zápisnice ako spoločnosť so 100 % - tnou účasťou mesta Poprad. Celková výmera lesov ktoré spoločnosť spravuje je 838,97 ha. Jedná sa o lesný majetok v katastrálnom území Poprad, Veľká, Spišské Bystré, Hranovnica, Stáže pod Tatrami. Prevažná časť lesov vo výmere 556,99 ha sú hospodárske lesy. Lesy osobitného určenia zaberajú výmeru 146,84 ha a lesy ochranné 114,5 ha. Na uvedenom majetku  je najsevernejšie položený autochtónny výskyt duba zimného na Slovensku, ktorého porasty siahajú do výšky  900 m.n.m.  Z tohto dôvodu bola táto lokalita vyhlasená v roku 1966 za Národnú prírodnú rezerváciu. V severnej časti sa nachádza poľovnícky zverník Kvetnica na výmere 21 ha, s chovom muflónej a diviačej zveri. Na vrchu Zámčisko sa nachádza archeologická lokalita Zámčisko.</p>',	NULL),
(2,	1,	'<p><strong>Spoločnosť Mestsk&eacute; lesy, s r.o. Poprad</strong> vznikla dňa 25.7.1997, &nbsp;na z&aacute;klade uznesenia MZ č. 31/1997 zo dňa 17.4.1997.</p><p>Založen&aacute; bola zakladateľskou listinou vo forme not&aacute;rskej z&aacute;pisnice ako spoločnosť so 100 % - tnou &uacute;časťou mesta Poprad. Celkov&aacute; v&yacute;mera lesov ktor&eacute; spoločnosť spravuje je 838,97 ha. Jedn&aacute; sa o lesn&yacute; majetok v katastr&aacute;lnom &uacute;zem&iacute; Poprad, Veľk&aacute;, Spi&scaron;sk&eacute; Bystr&eacute;, Hranovnica, St&aacute;že pod Tatrami. Prevažn&aacute; časť lesov vo v&yacute;mere 556,99 ha s&uacute; hospod&aacute;rske lesy. Lesy osobitn&eacute;ho určenia zaberaj&uacute; v&yacute;meru 146,84 ha a lesy ochrann&eacute; 114,5 ha.</p><p>	Na uvedenom majetku &nbsp;je najsevernej&scaron;ie položen&yacute; autocht&oacute;nny v&yacute;skyt duba zimn&eacute;ho na Slovensku, ktor&eacute;ho porasty siahaj&uacute; do v&yacute;&scaron;ky &nbsp;900 m.n.m. &nbsp;Z tohto d&ocirc;vodu bola t&aacute;to lokalita vyhlasen&aacute; v roku 1966 za N&aacute;rodn&uacute; pr&iacute;rodn&uacute; rezerv&aacute;ciu. V severnej časti sa nach&aacute;dza poľovn&iacute;cky zvern&iacute;k Kvetnica na v&yacute;mere 21 ha, s chovom mufl&oacute;nej a diviačej zveri. Na vrchu Z&aacute;mčisko sa nach&aacute;dza archeologick&aacute; lokalita Z&aacute;mčisko.</p>',	NULL),
(3,	1,	'<h3>Mestsk&eacute; lesy, s.r.o. Poprad</h3><p>	Levočsk&aacute; 3312/37</p><p>	Poprad, 058 01</p><p>	tel: 0527724160</p><p>	e-mail.: lesypp@stonline.sk</p>',	NULL);

DROP TABLE IF EXISTS `clenovia`;
CREATE TABLE `clenovia` (
  `id_clena` int(11) NOT NULL AUTO_INCREMENT,
  `meno` varchar(50) NOT NULL DEFAULT '',
  `telefon` varchar(15) DEFAULT NULL,
  `e_mail` varchar(50) NOT NULL DEFAULT '@',
  `prezyvka` varchar(15) NOT NULL,
  `heslo` varchar(50) NOT NULL DEFAULT '',
  `id_reg` int(11) NOT NULL DEFAULT '0',
  `pripomenute` datetime DEFAULT NULL,
  `jeblokovany` tinyint(4) NOT NULL DEFAULT '0',
  `pocet_pr` int(11) NOT NULL DEFAULT '0',
  `news` tinyint(4) NOT NULL DEFAULT '1',
  `prihlas_teraz` datetime DEFAULT NULL,
  `prihlas_predtym` datetime DEFAULT NULL,
  `reg_od` datetime DEFAULT NULL,
  PRIMARY KEY (`id_clena`),
  UNIQUE KEY `prezivka` (`prezyvka`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `clenovia` (`id_clena`, `meno`, `telefon`, `e_mail`, `prezyvka`, `heslo`, `id_reg`, `pripomenute`, `jeblokovany`, `pocet_pr`, `news`, `prihlas_teraz`, `prihlas_predtym`, `reg_od`) VALUES
(1,	'Peter VOJTECH',	'',	'petak23@gmail.com',	'petov',	'a7fce9787266daaf1b8de1695e7fe57d',	5,	NULL,	0,	21,	1,	'2017-02-16 07:58:47',	'2017-02-13 10:10:23',	'2010-02-01 10:00:00'),
(2,	'Jozef PETRENÄŒÃK',	'',	' jozue@anigraph.eu',	'jozue',	'153bbaf07b5fa9f964539bfecf09ae61',	5,	NULL,	0,	7,	1,	'2012-11-11 21:03:30',	'2012-09-04 19:41:27',	'2010-10-23 21:50:09'),
(3,	'Robert DULA',	'',	'dula.robert@mail.t-com.sk',	'robo',	'482818c538bba46f864d88311e0f47d7',	3,	'2011-03-28 20:09:52',	0,	197,	1,	'2017-02-13 08:34:10',	'2017-02-01 08:42:31',	'2011-02-11 20:14:49');

DROP TABLE IF EXISTS `dlzka_novinky`;
CREATE TABLE `dlzka_novinky` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
  `nazov` varchar(30) COLLATE utf8_bin NOT NULL COMMENT 'Zobrazený názov',
  `dlzka` int(11) NOT NULL COMMENT 'Počet dní, v ktorých je novinka',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tabuľka pre hodnoty dĺžky noviniek';

INSERT INTO `dlzka_novinky` (`id`, `nazov`, `dlzka`) VALUES
(1,	'Nesleduje sa',	0),
(2,	'Deň',	1),
(3,	'Týždeň',	7),
(4,	'Mesiac(30 dní)',	30),
(5,	'Štvrť roka(91 dní)',	91),
(6,	'Pol roka(182 dní)',	182),
(7,	'Rok',	365);

DROP TABLE IF EXISTS `dokumenty_rok`;
CREATE TABLE `dokumenty_rok` (
  `id_polozka` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id roku',
  `rok` int(11) NOT NULL DEFAULT '2011' COMMENT 'Číslo roku v ktorom sú uložené dokumenty',
  PRIMARY KEY (`id_polozka`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci COMMENT='Zoznam rokov pre triedenie dokumentov';

INSERT INTO `dokumenty_rok` (`id_polozka`, `rok`) VALUES
(1,	2008),
(2,	2009),
(3,	2010),
(4,	2011),
(5,	2012);

DROP TABLE IF EXISTS `druh`;
CREATE TABLE `druh` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Id položiek',
  `druh` varchar(20) COLLATE utf8_bin NOT NULL COMMENT 'Názov druhu stredného stĺpca',
  `modul` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT 'Názov špecifického modulu ak NULL vždy',
  `presenter` varchar(30) COLLATE utf8_bin NOT NULL COMMENT 'Názov prezenteru pre Nette',
  `popis` varchar(255) COLLATE utf8_bin DEFAULT 'Popis' COMMENT 'Popis bloku',
  `povolene` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Ak 1 tak daná položka je povolená',
  `je_spec_naz` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Ak 1 tak daný druh potrebuje špecif. názov',
  `robots` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Ak 1 tak je povolené indexovanie daného druhu',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `druh` (`id`, `druh`, `modul`, `presenter`, `popis`, `povolene`, `je_spec_naz`, `robots`) VALUES
(1,	'clanky',	NULL,	'Clanky',	'Články - Stredná časť je ako článok, alebo je sub-menu',	1,	1,	1),
(2,	'debata',	NULL,	'Debata',	'Debatný krúžok',	1,	0,	1),
(3,	'menupol',	NULL,	'Menu',	'Položka menu - nerobí nič, len zobrazí všetky položky, ktoré sú v nej zaradené',	1,	1,	1),
(4,	'polkadnicka',	NULL,	'Pokladnicka',	'Pokladnička',	1,	0,	1),
(5,	'oznam',	NULL,	'Oznam',	'Vypísanie oznamov',	1,	0,	1),
(7,	'dokumenty',	NULL,	'Dokumenty',	'Vkladanie dokumentov do stránky',	0,	0,	0);

DROP TABLE IF EXISTS `fotky`;
CREATE TABLE `fotky` (
  `id_foto` int(11) NOT NULL AUTO_INCREMENT,
  `id_galery` int(11) NOT NULL DEFAULT '0' COMMENT 'Identifikácia príslušnosti ku galérii',
  `nazov` varchar(70) NOT NULL DEFAULT '.jpg' COMMENT 'Názov súboru obrázku',
  `pocitadlo` int(11) NOT NULL DEFAULT '0' COMMENT 'Počet zobrazení obrázku',
  `id_clena` int(11) NOT NULL DEFAULT '1' COMMENT 'Id kto pridal obrázok',
  PRIMARY KEY (`id_foto`),
  KEY `id_akcia` (`id_galery`),
  KEY `nazov` (`nazov`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Zoznam obrázkou vo fotogalérii';

INSERT INTO `fotky` (`id_foto`, `id_galery`, `nazov`, `pocitadlo`, `id_clena`) VALUES
(1,	1,	'p_1.jpg',	0,	1),
(2,	1,	'p_2.jpg',	0,	1),
(3,	1,	'p_3.jpg',	0,	1),
(4,	1,	'p_4.jpg',	0,	1),
(5,	1,	'p_5.jpg',	0,	1),
(6,	1,	'p_6.jpg',	0,	1),
(7,	1,	'p_7.jpg',	0,	1),
(8,	1,	'p_8.jpg',	0,	1),
(9,	1,	'p_9.jpg',	0,	1),
(28,	3,	'ml7-02_004.jpg',	0,	1),
(27,	3,	'ml7-02_003.jpg',	0,	1),
(26,	3,	'ml7-02_002.jpg',	0,	1),
(25,	3,	'ml7-02_001.jpg',	0,	1),
(29,	3,	'trnky1.jpg',	0,	2),
(30,	3,	'100_0059.JPG',	0,	2),
(47,	5,	'cestapreslop_028.jpg',	0,	3),
(34,	4,	'nch_08.jpg',	0,	2),
(35,	4,	'nch_02.jpg',	0,	2),
(36,	4,	'nch_09.jpg',	0,	2),
(37,	4,	'nch_03.jpg',	0,	2),
(38,	4,	'nch_12.jpg',	0,	2),
(39,	4,	'nch_07.jpg',	0,	2),
(40,	4,	'nch_01.jpg',	0,	2),
(41,	4,	'nch_04.jpg',	0,	2),
(42,	4,	'nch_06.jpg',	0,	2),
(43,	4,	'nch_05.jpg',	0,	2),
(44,	4,	'nch_10.jpg',	0,	2),
(45,	4,	'nch_11.jpg',	0,	2),
(48,	5,	'cestapreslop 019.jpg',	0,	3),
(49,	5,	'cestapreslop 049.jpg',	0,	3),
(50,	5,	'cestapreslop 045.jpg',	0,	3),
(51,	5,	'cestapreslop 016.jpg',	0,	3),
(52,	5,	'cestapreslop 021.jpg',	0,	3),
(53,	6,	'leto_79.JPG',	0,	3),
(54,	6,	'jun14-04_035.jpg',	0,	3),
(55,	6,	'jun14-04_041.jpg',	0,	3),
(56,	6,	'krizova19-10_005.jpg',	0,	3),
(57,	6,	'leto_85.JPG',	0,	3),
(58,	6,	'maj-24_029.jpg',	0,	3),
(59,	6,	'obora25-06_072.jpg',	0,	3),
(60,	6,	'paviln_003.jpg',	0,	3),
(61,	6,	'erven_kltor_017.jpg',	0,	3),
(62,	6,	'pavilon_019.jpg',	0,	3),
(63,	6,	'obora25-06_077.jpg',	0,	3),
(64,	6,	'nch13-05_041.jpg',	0,	3),
(65,	6,	'npr_025.jpg',	0,	3),
(66,	6,	'npr_043.jpg',	0,	3),
(67,	7,	'dolka04_031.jpg',	0,	3),
(68,	7,	'dolka04_032.jpg',	0,	3),
(69,	7,	'jun-1_084.jpg',	0,	3),
(70,	7,	'jun-1_114.jpg',	0,	3),
(71,	7,	'jun05-04_030.jpg',	0,	3),
(72,	7,	'jun14-04_045.jpg',	0,	3),
(73,	7,	'jun14-04_066.jpg',	0,	3),
(74,	7,	'jun19-04_013.jpg',	0,	3),
(75,	7,	'Kavca5-10_038.jpg',	0,	3),
(76,	7,	'maj-04_016.jpg',	0,	3),
(77,	7,	'ml19-08_010.jpg',	0,	3),
(78,	7,	'ml17-04_041.jpg',	0,	3),
(79,	7,	'ml19-08_002.jpg',	0,	3),
(80,	7,	'nch24-05_006.jpg',	0,	3),
(81,	7,	'obora25-06_012.jpg',	0,	3),
(82,	7,	'talavaek_009.jpg',	0,	3),
(83,	7,	'D4A21-6_011.jpg',	0,	3),
(84,	7,	'D4A21-6_020.jpg',	0,	3),
(85,	7,	'D4A21-6_035.jpg',	0,	3),
(86,	7,	'jun-1_034.jpg',	0,	3),
(87,	7,	'jun05-04_020.jpg',	0,	3),
(88,	7,	'Kavca5-10_029.jpg',	0,	3),
(89,	7,	'npr_024.jpg',	0,	3),
(90,	7,	'obora25-06_005.jpg',	0,	3),
(91,	7,	'talavaek_013.jpg',	0,	3),
(92,	7,	'jun-1_029.jpg',	0,	3),
(93,	7,	'nch24-05_001.jpg',	0,	3),
(94,	7,	'kava29-07_006.jpg',	0,	3),
(95,	8,	'altnky_008.jpg',	0,	3),
(96,	8,	'cestaobora_010.jpg',	0,	3),
(97,	8,	'cestaobora_019.jpg',	0,	3),
(98,	8,	'cestaobora_020.jpg',	0,	3),
(99,	8,	'cestaobora_008.jpg',	0,	3),
(100,	8,	'znaenie_028.jpg',	0,	3),
(101,	8,	'znaenie_029.jpg',	0,	3),
(102,	8,	'znaenie_037.jpg',	0,	3),
(103,	8,	'P6090008.JPG',	0,	3),
(104,	8,	'P5250163.JPG',	0,	3),
(105,	8,	'kontrolnde_002.jpg',	0,	3),
(106,	8,	'kontrolnde_003.jpg',	0,	3),
(107,	8,	'kontrolnde_004.jpg',	0,	3),
(108,	8,	'P5250166.JPG',	0,	3),
(109,	8,	'kontrolnde_026.jpg',	0,	3),
(110,	8,	'kontrolnde_007.jpg',	0,	3),
(111,	8,	'kontrolnde_024.jpg',	0,	3),
(112,	8,	'kontrolnde_009.jpg',	0,	3),
(113,	8,	'kontrolnde_010.jpg',	0,	3),
(114,	8,	'kontrolnde_022.jpg',	0,	3),
(115,	8,	'kontrolnde_018.jpg',	0,	3),
(116,	8,	'zvernkpreberanie_001.jpg',	0,	3),
(117,	8,	'zvernkpreberanie_006.jpg',	0,	3),
(118,	8,	'zvernkpreberanie_007.jpg',	0,	3),
(119,	8,	'zvernkpreberanie_012.jpg',	0,	3),
(120,	8,	'zvernkpreberanie_004.jpg',	0,	3),
(121,	8,	'altnky_010.jpg',	0,	3),
(122,	9,	'028.JPG',	0,	3),
(123,	9,	'034.JPG',	0,	3),
(124,	9,	'cesta12-03_078.jpg',	0,	3),
(125,	9,	'cestavysova_028.jpg',	0,	3),
(126,	9,	'cestavysova_031.jpg',	0,	3),
(127,	9,	'dostojevskeho_043.jpg',	0,	3),
(128,	9,	'dostojevskeho_105.jpg',	0,	3),
(129,	9,	'dostojevskeho_117.jpg',	0,	3),
(130,	9,	'dostojevskeho_124.jpg',	0,	3),
(131,	9,	'vysov_004.JPG',	0,	3),
(132,	9,	'dostojevskeho_128.jpg',	0,	3),
(133,	9,	'vysov_017.JPG',	0,	3),
(134,	9,	'vysov_014.JPG',	0,	3),
(135,	9,	'vysovakalamita_046.jpg',	0,	3),
(136,	9,	'cesta12-03_079.jpg',	0,	3),
(137,	9,	'vysov_005.JPG',	0,	3),
(138,	9,	'vysovakalamita_049.jpg',	0,	3);

DROP TABLE IF EXISTS `fotky_koment`;
CREATE TABLE `fotky_koment` (
  `id_koment` int(11) NOT NULL AUTO_INCREMENT,
  `id_foto` int(11) NOT NULL DEFAULT '0' COMMENT 'Id fotky ku ktorej patrí komentár',
  `id_clena` int(11) NOT NULL DEFAULT '0' COMMENT 'Kto komentár pridal',
  `text` text CHARACTER SET cp1250 COLLATE cp1250_bin COMMENT 'Samotný komentár',
  `kedy` timestamp NULL DEFAULT NULL COMMENT 'Kedy bol komentár pridaný',
  PRIMARY KEY (`id_koment`),
  KEY `if_foto` (`id_foto`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Komentár k jednotlivým fotkám';

INSERT INTO `fotky_koment` (`id_koment`, `id_foto`, `id_clena`, `text`, `kedy`) VALUES
(1,	2,	1,	'Toto je pokusnĂ˝ komentĂˇr k fotke',	'2011-06-20 04:35:28');

DROP TABLE IF EXISTS `historia`;
CREATE TABLE `historia` (
  `id_polozka` int(11) NOT NULL AUTO_INCREMENT,
  `text` text NOT NULL,
  `datum` date NOT NULL DEFAULT '2010-01-01',
  `id_clena` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_polozka`),
  KEY `kedy` (`datum`)
) ENGINE=MyISAM DEFAULT CHARSET=cp1250;

INSERT INTO `historia` (`id_polozka`, `text`, `datum`, `id_clena`) VALUES
(1,	'Vznik',	'2011-06-15',	1);

DROP TABLE IF EXISTS `hlavicka`;
CREATE TABLE `hlavicka` (
  `id` int(11) NOT NULL COMMENT '[A]Index',
  `nazov` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT 'Veľká' COMMENT 'Zobrazený názov pre daný typ hlavičky',
  `pripona` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT 'Prípona názvu súborov',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `hlavicka` (`id`, `nazov`, `pripona`) VALUES
(0,	'Nerozhoduje',	' '),
(1,	'Veľká',	'normal'),
(2,	'Malá',	'small');

DROP TABLE IF EXISTS `hlavne_menu`;
CREATE TABLE `hlavne_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[5]Id položky hlavného menu',
  `spec_nazov` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT 'Názov položky menu pre URL',
  `id_hlavne_menu_cast` int(11) NOT NULL DEFAULT '1' COMMENT '[5]Ku ktorej časti hl. menu patrí položka',
  `id_registracia` int(11) NOT NULL DEFAULT '0' COMMENT '[4]Min úroveň registrácie pre zobrazenie',
  `id_ikonka` int(11) DEFAULT NULL COMMENT '[4]Názov súboru ikonky aj s koncovkou',
  `id_druh` int(11) NOT NULL DEFAULT '1' COMMENT '[5]Výber druhu priradenej položky. Ak 1 tak je možné priradiť článok v náväznosti na tab. druh',
  `uroven` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Úroveň položky menu',
  `id_nadradenej` int(11) DEFAULT NULL COMMENT 'Id nadradenej položky menu z tejto tabuľky ',
  `id_user_profiles` int(11) NOT NULL DEFAULT '1' COMMENT 'Id užívateľa, ktorý položku zadal ',
  `poradie` int(11) NOT NULL DEFAULT '1' COMMENT 'Poradie v zobrazení',
  `poradie_podclankov` int(11) NOT NULL DEFAULT '0' COMMENT 'Poradie podčlánkov ak sú: 0 - od 1-9, 1 - od 9-1',
  `id_hlavicka` int(11) NOT NULL DEFAULT '0' COMMENT '[5]Druh hlavičky podľa tabuľky hlavicka. 1 - velka',
  `povol_pridanie` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Povolenie pridávania podčlánkov pre nevlastníkov',
  `zvyrazni` tinyint(4) NOT NULL DEFAULT '0' COMMENT '[5]Zvýraznenie položky menu pri pridaní obsahu',
  `pocitadlo` int(11) NOT NULL DEFAULT '0' COMMENT '[R]Počítadlo kliknutí na položku',
  `nazov_ul_sub` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '[5]Názov pomocnej triedy ul-elsementu sub menu',
  `absolutna` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT 'Absolútna adresa',
  `ikonka` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT 'Názov css ikonky',
  `avatar` varchar(300) COLLATE utf8_bin DEFAULT NULL COMMENT 'Názov a cesta k titulnému obrázku',
  `komentar` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Povolenie komentárov',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Posledná zmena',
  `datum_platnosti` date DEFAULT NULL COMMENT 'Platnosť',
  `aktualny_projekt` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Označenie aktuálneho projektu',
  `redirect_id` int(11) DEFAULT NULL COMMENT 'Id článku na ktorý sa má presmerovať',
  `id_dlzka_novinky` int(11) NOT NULL DEFAULT '1' COMMENT 'Do kedy je to novinka',
  PRIMARY KEY (`id`),
  KEY `id_reg` (`id_registracia`),
  KEY `druh` (`id_druh`),
  KEY `id_ikonka` (`id_ikonka`),
  KEY `id_hlavicka` (`id_hlavicka`),
  KEY `id_hlavne_menu_cast` (`id_hlavne_menu_cast`),
  KEY `id_user_profiles` (`id_user_profiles`),
  KEY `id_dlzka_novinky` (`id_dlzka_novinky`),
  CONSTRAINT `hlavne_menu_ibfk_1` FOREIGN KEY (`id_registracia`) REFERENCES `registracia` (`id`),
  CONSTRAINT `hlavne_menu_ibfk_2` FOREIGN KEY (`id_ikonka`) REFERENCES `ikonka` (`id`),
  CONSTRAINT `hlavne_menu_ibfk_4` FOREIGN KEY (`id_hlavicka`) REFERENCES `hlavicka` (`id`),
  CONSTRAINT `hlavne_menu_ibfk_5` FOREIGN KEY (`id_hlavne_menu_cast`) REFERENCES `hlavne_menu_cast` (`id`),
  CONSTRAINT `hlavne_menu_ibfk_6` FOREIGN KEY (`id_druh`) REFERENCES `druh` (`id`),
  CONSTRAINT `hlavne_menu_ibfk_7` FOREIGN KEY (`id_user_profiles`) REFERENCES `user_profiles` (`id`),
  CONSTRAINT `hlavne_menu_ibfk_8` FOREIGN KEY (`id_dlzka_novinky`) REFERENCES `dlzka_novinky` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Položky HLAVNÉHO menu';

INSERT INTO `hlavne_menu` (`id`, `spec_nazov`, `id_hlavne_menu_cast`, `id_registracia`, `id_ikonka`, `id_druh`, `uroven`, `id_nadradenej`, `id_user_profiles`, `poradie`, `poradie_podclankov`, `id_hlavicka`, `povol_pridanie`, `zvyrazni`, `pocitadlo`, `nazov_ul_sub`, `absolutna`, `ikonka`, `avatar`, `komentar`, `modified`, `datum_platnosti`, `aktualny_projekt`, `redirect_id`, `id_dlzka_novinky`) VALUES
(1,	'home',	1,	0,	NULL,	1,	0,	NULL,	3,	1,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	'2017-02-16 07:54:07',	NULL,	0,	NULL,	1),
(2,	'sluzby',	1,	0,	NULL,	3,	0,	NULL,	3,	2,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	'2017-02-16 07:54:52',	NULL,	0,	NULL,	1),
(3,	'sprievodca',	1,	0,	NULL,	3,	0,	NULL,	3,	3,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	'2017-02-16 07:54:07',	NULL,	0,	NULL,	1),
(4,	'zverejnovanie-dokumentov',	1,	0,	NULL,	3,	0,	NULL,	3,	4,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	'2017-02-16 07:54:07',	NULL,	0,	NULL,	1),
(5,	'verejne-obstaravanie',	1,	0,	NULL,	3,	0,	NULL,	3,	5,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	'2017-02-16 07:54:07',	NULL,	0,	NULL,	1),
(6,	'projekty',	1,	0,	NULL,	3,	0,	NULL,	3,	6,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	'2017-02-16 07:54:07',	NULL,	0,	NULL,	1),
(7,	'galeria',	1,	0,	NULL,	3,	0,	NULL,	3,	7,	0,	0,	0,	0,	0,	'foto_album',	NULL,	NULL,	NULL,	0,	'2017-02-16 07:54:07',	NULL,	0,	NULL,	1),
(8,	'oznamy',	1,	3,	NULL,	5,	0,	NULL,	3,	8,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	'2017-02-16 07:54:07',	NULL,	0,	NULL,	1),
(9,	'o-nas',	2,	0,	NULL,	1,	0,	NULL,	3,	1,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	'2017-02-16 07:54:25',	NULL,	0,	NULL,	1),
(10,	'kontakt',	2,	0,	NULL,	1,	0,	NULL,	3,	2,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	'2017-02-16 07:54:25',	NULL,	0,	NULL,	1);

DROP TABLE IF EXISTS `hlavne_menu_cast`;
CREATE TABLE `hlavne_menu_cast` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
  `nazov` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT 'Časť' COMMENT 'Názov časti',
  `id_registracia` int(11) NOT NULL DEFAULT '5' COMMENT 'Úroveň registrácie pre editáciu',
  `mapa_stranky` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Ak 1 tak je časť zahrnutá do mapy',
  PRIMARY KEY (`id`),
  KEY `id_registracia` (`id_registracia`),
  CONSTRAINT `hlavne_menu_cast_ibfk_1` FOREIGN KEY (`id_registracia`) REFERENCES `registracia` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Časti hlavného menu';

INSERT INTO `hlavne_menu_cast` (`id`, `nazov`, `id_registracia`, `mapa_stranky`) VALUES
(1,	'Hlavná ponuka',	4,	1),
(2,	'Druhá časť',	4,	1);

DROP TABLE IF EXISTS `hlavne_menu_lang`;
CREATE TABLE `hlavne_menu_lang` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
  `id_lang` int(11) NOT NULL DEFAULT '1' COMMENT 'Id Jazyka',
  `id_hlavne_menu` int(11) NOT NULL COMMENT 'Id hlavného menu, ku ktorému patrí',
  `id_clanok_lang` int(11) DEFAULT NULL COMMENT 'Id jazka článku ak ho má',
  `nazov` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT 'Názov položky pre daný jazyk',
  `h1part2` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT 'Druhá časť názvu pre daný jazyk',
  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'Popis položky pre daný jazyk',
  PRIMARY KEY (`id`),
  KEY `id_hlavne_menu` (`id_hlavne_menu`),
  KEY `id_lang` (`id_lang`),
  KEY `id_clanok_lang` (`id_clanok_lang`),
  CONSTRAINT `hlavne_menu_lang_ibfk_1` FOREIGN KEY (`id_hlavne_menu`) REFERENCES `hlavne_menu` (`id`),
  CONSTRAINT `hlavne_menu_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `lang` (`id`),
  CONSTRAINT `hlavne_menu_lang_ibfk_3` FOREIGN KEY (`id_clanok_lang`) REFERENCES `clanok_lang` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Popis položiek hlavného menu pre iný jazyk';

INSERT INTO `hlavne_menu_lang` (`id`, `id_lang`, `id_hlavne_menu`, `id_clanok_lang`, `nazov`, `h1part2`, `description`) VALUES
(1,	1,	1,	1,	'home',	NULL,	'Mestské Lesy Poprad - Úvodná stránka'),
(2,	1,	2,	NULL,	'služby',	NULL,	'Mestské Lesy Poprad - Služby mestských lesov'),
(3,	1,	3,	NULL,	'sprievodca',	NULL,	'Mestské Lesy Poprad - Sprievodca mestskými lesmi'),
(4,	1,	4,	NULL,	'zverejňovanie dokumentov',	NULL,	'Mestské Lesy Poprad - Zverejňovanie dokumentov'),
(5,	1,	5,	NULL,	'verejné obstarávanie',	NULL,	'Mestské Lesy Poprad - Verejné obstarávanie'),
(6,	1,	6,	NULL,	'projekty',	NULL,	'Mestské Lesy Poprad - Projekty'),
(7,	1,	7,	NULL,	'galéria',	NULL,	'Mestské Lesy Poprad - Galéria fotografií'),
(8,	1,	8,	NULL,	'oznamy',	NULL,	'Mestské Lesy Poprad - Oznamy'),
(9,	1,	9,	2,	'o nás',	NULL,	'Mestské Lesy Poprad - O nás'),
(10,	1,	10,	3,	'kontakt',	NULL,	'Mestské Lesy Poprad - Kontakt na nás');

DROP TABLE IF EXISTS `ikonka`;
CREATE TABLE `ikonka` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
  `nazov` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT 'ikonka' COMMENT 'Kmeňová časť názvu súboru ikonky',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Ikonky';

INSERT INTO `ikonka` (`id`, `nazov`) VALUES
(0,	'---'),
(1,	'info'),
(2,	'kniha'),
(3,	'kvietok'),
(4,	'lienka'),
(5,	'list_ceruza'),
(6,	'list'),
(7,	'listok'),
(8,	'lupa'),
(9,	'pocasie'),
(10,	'slnko'),
(11,	'smerovnik'),
(12,	'topanka'),
(13,	'vykricnik');

DROP TABLE IF EXISTS `komponenty`;
CREATE TABLE `komponenty` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
  `nazov` varchar(30) COLLATE utf8_bin NOT NULL COMMENT 'Názov použitej komponenty',
  `parametre` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'Názov parametrov oddelený čiarkou',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Zoznam použiteľných komponent';

INSERT INTO `komponenty` (`id`, `nazov`, `parametre`) VALUES
(1,	'odkazNaClanky',	'id_clanok'),
(2,	'aktualne',	NULL),
(3,	'produktZoznam',	NULL);

DROP TABLE IF EXISTS `lang`;
CREATE TABLE `lang` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
  `skratka` varchar(3) COLLATE utf8_bin NOT NULL DEFAULT 'sk' COMMENT 'Skratka jazyka',
  `nazov` varchar(15) COLLATE utf8_bin NOT NULL DEFAULT 'Slovenčina' COMMENT 'Miestny názov jazyka',
  `nazov_en` varchar(15) COLLATE utf8_bin NOT NULL DEFAULT 'Slovak' COMMENT 'Anglický názov jazyka',
  `prijaty` tinyint(4) DEFAULT NULL COMMENT 'Ak je > 0 jazyk je možné použiť na Frond',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Jazyky pre web';

INSERT INTO `lang` (`id`, `skratka`, `nazov`, `nazov_en`, `prijaty`) VALUES
(1,	'sk',	'Slovenčina',	'Slovak',	1);

DROP TABLE IF EXISTS `menu_galeria`;
CREATE TABLE `menu_galeria` (
  `id_polozka` int(11) NOT NULL AUTO_INCREMENT,
  `nazov` varchar(50) COLLATE utf8_bin NOT NULL,
  `id_reg` int(11) NOT NULL DEFAULT '0',
  `zobrazenie` int(11) NOT NULL DEFAULT '1' COMMENT 'Či sa daná položka zobrazuje',
  PRIMARY KEY (`id_polozka`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `menu_galeria` (`id_polozka`, `nazov`, `id_reg`, `zobrazenie`) VALUES
(1,	'Lesy',	0,	1),
(2,	'ChodnÃ­ky',	0,	-1),
(4,	'ChodnÃ­ky',	0,	-1);

DROP TABLE IF EXISTS `news`;
CREATE TABLE `news` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
  `text` text COLLATE utf8_bin NOT NULL COMMENT 'Text novinky',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Dátum novinky',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `old_dokumenty`;
CREATE TABLE `old_dokumenty` (
  `id_polozka` int(11) NOT NULL AUTO_INCREMENT,
  `nazov` varchar(50) COLLATE utf8_bin NOT NULL COMMENT 'Názov titulku pre daný dokument',
  `cislo` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT 'Číslo faktúry, zmluvy, objednávky',
  `predmet` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT 'Predmet faktúry, zmluvy, objednávky',
  `cena` float(15,2) DEFAULT NULL COMMENT 'Cena faktúry, zmluvy, objednávky',
  `subjekt` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT 'Subjekt faktúry,  objednávky - (dodávateľ), zmluvy(Zmluvná strana)',
  `datum_vystavenia` date DEFAULT NULL COMMENT 'Dátum vystavenia pri faktúre a objednávke pri zmluve dátum uzatvorenia',
  `datum_ukoncenia` date DEFAULT NULL COMMENT 'Dátum ukoncenia zmluvy',
  `subor` varchar(50) COLLATE utf8_bin NOT NULL COMMENT 'Názov súboru s relatívnou cestou',
  `id_clena` int(11) NOT NULL DEFAULT '0' COMMENT 'Kto pridal dokument',
  `id_reg` int(11) NOT NULL DEFAULT '0' COMMENT 'Úroveň registrácie',
  `kedy` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Dátum uloženia alebo opravy - časová pečiatka',
  `pocitadlo` int(11) NOT NULL DEFAULT '0' COMMENT 'Počítadlo stiahnutí',
  `id_skupina` int(11) NOT NULL COMMENT 'Id článku do ktorej časti dokument patrí',
  `id_rok` int(11) NOT NULL COMMENT 'Id roku do ktorého sa má zaradiť',
  PRIMARY KEY (`id_polozka`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `old_dokumenty` (`id_polozka`, `nazov`, `cislo`, `predmet`, `cena`, `subjekt`, `datum_vystavenia`, `datum_ukoncenia`, `subor`, `id_clena`, `id_reg`, `kedy`, `pocitadlo`, `id_skupina`, `id_rok`) VALUES
(20,	'',	'4011198',	'prÃ¡ce a materiÃ¡l Ford',	1052.46,	'Autonova s.r.o.',	'2011-01-27',	'0000-00-00',	'img112.pdf',	3,	0,	'2017-02-16 06:12:09',	697,	9023,	0),
(21,	'',	'232011',	'automobil Ford',	27113.02,	'Autonova s.r.o.',	'2011-01-27',	'0000-00-00',	'img113.pdf',	3,	0,	'2017-02-16 02:38:24',	652,	9023,	0),
(22,	'',	'1/2011',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	2348.62,	'Michal Korenko',	'2011-01-31',	'0000-00-00',	'img111.pdf',	3,	0,	'2017-02-09 15:05:26',	669,	9023,	0),
(23,	'',	'111',	'projekt lesnÃ¡ cesta Kvetnica',	2215.00,	'Ing. Å tefan BigoÅ¡',	'2011-02-08',	'0000-00-00',	'img110.pdf',	3,	0,	'2017-02-14 13:38:14',	673,	9023,	0),
(24,	'',	'2/2011',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	3078.21,	'KollÃ¡r JÃ¡n',	'2011-01-31',	'0000-00-00',	'img109.pdf',	3,	0,	'2017-02-12 07:39:24',	675,	9023,	0),
(26,	'',	'0211',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	2611.02,	'Miroslav KarabÃ­n',	'2011-03-31',	'0000-00-00',	'img108.pdf',	3,	0,	'2017-02-16 06:11:11',	686,	9023,	0),
(27,	'',	'02(2011',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	3180.67,	'Michal Korenko',	'2011-02-28',	'0000-00-00',	'img107.pdf',	3,	0,	'2017-02-16 06:10:26',	668,	9023,	0),
(28,	'',	'1/2011',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	2946.98,	'Milan BujnovskÃ½',	'2011-02-28',	'0000-00-00',	'img105.pdf',	3,	0,	'2017-02-16 06:23:25',	683,	9023,	0),
(29,	'',	'VF110058',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	3589.78,	'Stemp-M&G, s.r.o.',	'2011-02-28',	'0000-00-00',	'img104.pdf',	3,	0,	'2017-02-07 21:53:55',	654,	9023,	0),
(30,	'',	'4/2011',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	1844.28,	'KollÃ¡r JÃ¡n',	'2011-02-28',	'0000-00-00',	'img103.pdf',	3,	0,	'2017-02-07 21:53:59',	663,	9023,	0),
(31,	'',	'0411',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	4321.15,	'Miroslav KarabÃ­n',	'2011-02-28',	'0000-00-00',	'img102.pdf',	3,	0,	'2017-02-16 04:59:25',	669,	9023,	0),
(32,	'',	'21100214',	'jiffy tablety',	1380.84,	'Engo, s.r.o.',	'2011-03-15',	'0000-00-00',	'img101.pdf',	3,	0,	'2017-02-07 21:53:34',	663,	9023,	0),
(33,	'',	'4/2011',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	1221.63,	'Milan BujnovskÃ½',	'2011-03-31',	'0000-00-00',	'img100.pdf',	3,	0,	'2017-02-16 06:13:09',	677,	9023,	0),
(34,	'',	'03/2011',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	1723.62,	'Michal Korenko',	'2011-03-31',	'0000-00-00',	'img098.pdf',	3,	0,	'2017-02-14 06:08:35',	646,	9023,	0),
(35,	'',	'6/2011',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	2491.14,	'KollÃ¡r JÃ¡n',	'2011-03-31',	'0000-00-00',	'img097.pdf',	3,	0,	'2017-02-10 03:30:16',	663,	9023,	0),
(36,	'',	'0611',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	4427.87,	'Miroslav KarabÃ­n',	'2011-03-31',	'0000-00-00',	'img096.pdf',	3,	0,	'2017-02-07 21:53:21',	679,	9023,	0),
(37,	'',	'VF110094',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	1624.38,	'Stemp-M&G, s.r.o.',	'2011-03-31',	'0000-00-00',	'img095.pdf',	3,	0,	'2017-02-12 02:11:20',	681,	9023,	0),
(38,	'',	'11/0005',	'ProtipoÅ¾iarna lesnÃ¡ cesta VysovÃ¡',	64765.73,	'Lesostav Poprad, s.r.o.',	'2011-03-31',	'0000-00-00',	'img094.pdf',	3,	0,	'2017-02-11 22:49:37',	714,	9023,	0),
(39,	'',	'21100416',	'tacky na jiffy tablety',	1836.35,	'Engo, s.r.o.',	'2011-04-11',	'0000-00-00',	'img093.pdf',	3,	0,	'2017-02-07 21:53:20',	746,	9023,	0),
(40,	'',	'11/0008',	'ProtipoÅ¾iarna lesnÃ¡ cesta VysovÃ¡',	59555.76,	'Lesostav Poprad, s.r.o.',	'2011-04-30',	'0000-00-00',	'img092.pdf',	3,	0,	'2017-02-08 08:47:33',	689,	9023,	0),
(41,	'',	'8/2011',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	1999.14,	'KollÃ¡r JÃ¡n',	'2011-04-30',	'0000-00-00',	'img091.pdf',	3,	0,	'2017-02-16 06:16:45',	681,	9023,	0),
(42,	'',	'2011143',	'drevnÃ¡ hmota',	1774.32,	'TechnickÃ© sluÅ¾by mesta Svit',	'2011-05-09',	'0000-00-00',	'img090.pdf',	3,	0,	'2017-02-12 21:14:10',	650,	9023,	0),
(43,	'',	'0111052165',	'stravnÃ© lÃ­stky',	1234.32,	'LE CHEQUE DEJEUNER s.r.o',	'2011-05-18',	'0000-00-00',	'img089.pdf',	3,	0,	'2017-02-16 03:51:23',	654,	9023,	0),
(44,	'',	'8/2011',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	4685.80,	'Milan BujnovskÃ½',	'2011-05-31',	'0000-00-00',	'img088.pdf',	3,	0,	'2017-02-16 06:51:16',	678,	9023,	0),
(45,	'',	'11/0013',	'ProtipoÅ¾iarna lesnÃ¡ cesta VysovÃ¡',	41384.46,	'Lesostav Poprad, s.r.o.',	'2011-05-31',	'0000-00-00',	'img087.pdf',	3,	0,	'2017-02-07 21:53:06',	676,	9023,	0),
(46,	'',	'11/0020',	'oprava lesnÃ½ch ciest a zvÃ¡Å¾nic',	4485.54,	'Lesostav Poprad, s.r.o.',	'2011-05-31',	'0000-00-00',	'img086.pdf',	3,	0,	'2017-02-16 06:14:04',	672,	9023,	0),
(47,	'',	'0111065474',	'stravnÃ© lÃ­stky',	1541.52,	'LE CHEQUE DEJEUNER s.r.o',	'2011-06-28',	'0000-00-00',	'img085.pdf',	3,	0,	'2017-02-07 21:52:56',	658,	9023,	0),
(48,	'',	'1100207',	'sadenice lesnÃ½ch drevÃ­n',	2232.00,	'UrbÃ¡rske poz. spol. Vikartovce',	'2011-06-16',	'0000-00-00',	'img084.pdf',	3,	0,	'2017-02-15 04:52:46',	663,	9023,	0),
(49,	'',	'7/2011',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	1332.09,	'Milan BujnovskÃ½',	'2011-06-30',	'0000-00-00',	'img083.pdf',	3,	0,	'2017-02-10 16:43:58',	661,	9023,	0),
(50,	'',	'1011',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	2810.51,	'Miroslav KarabÃ­n',	'2011-06-30',	'0000-00-00',	'img082.pdf',	3,	0,	'2017-02-16 06:20:51',	666,	9023,	0),
(51,	'',	'10/2011',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	2718.63,	'KollÃ¡r JÃ¡n',	'2011-06-30',	'0000-00-00',	'img081.pdf',	3,	0,	'2017-02-11 05:58:09',	652,	9023,	0),
(52,	'',	'OFAT0053',	'inÅ¡talÃ¡cia sklotextilnÃ½ch tapiet',	1547.41,	'Karki s.r.o.',	'2011-07-07',	'0000-00-00',	'img080.pdf',	3,	0,	'2017-02-07 21:52:42',	659,	9023,	0),
(53,	'',	'23411',	'poklÃ¡dka koberca',	1373.14,	'OnÄiÅ¡ s.r.o.',	'2011-07-11',	'0000-00-00',	'img079.pdf',	3,	0,	'2017-02-16 01:14:22',	677,	9023,	0),
(54,	'',	'11/0039',	'ProtipoÅ¾iarna lesnÃ¡ cesta VysovÃ¡',	22481.50,	'Lesostav Poprad, s.r.o.',	'2011-07-29',	'0000-00-00',	'img078.pdf',	3,	0,	'2017-02-16 06:09:42',	694,	9023,	0),
(55,	'',	'1111',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	2006.16,	'Miroslav KarabÃ­n',	'2011-07-31',	'0000-00-00',	'img077.pdf',	3,	0,	'2017-02-16 06:10:49',	678,	9023,	0),
(56,	'',	'0111086690',	'stravnÃ© lÃ­stky',	1541.52,	'LE CHEQUE DEJEUNER s.r.o',	'2011-08-31',	'0000-00-00',	'img076.pdf',	3,	0,	'2017-02-09 11:53:47',	661,	9023,	0),
(57,	'',	'11/0044',	'ProtipoÅ¾iarna lesnÃ¡ cesta VysovÃ¡',	17867.39,	'Lesostav Poprad, s.r.o.',	'2011-08-31',	'0000-00-00',	'img075.pdf',	3,	0,	'2017-02-07 21:52:33',	657,	9023,	0),
(58,	'',	'14/2011',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	2749.16,	'KollÃ¡r JÃ¡n',	'2011-08-31',	'0000-00-00',	'img074.pdf',	3,	0,	'2017-02-16 06:29:36',	680,	9023,	0),
(59,	'',	'1511',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	3416.45,	'Miroslav KarabÃ­n',	'2011-09-30',	'0000-00-00',	'img073.pdf',	3,	0,	'2017-02-13 22:20:54',	656,	9023,	0),
(60,	'',	'1100313',	'sadenice lesnÃ½ch drevÃ­n',	2484.96,	'UrbÃ¡rske poz. spol. Vikartovce',	'2011-09-30',	'0000-00-00',	'img072.pdf',	3,	0,	'2017-02-07 21:52:14',	673,	9023,	0),
(61,	'',	'11/2011',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	3266.72,	'Milan BujnovskÃ½',	'2011-09-30',	'0000-00-00',	'img071.pdf',	3,	0,	'2017-02-15 22:59:34',	666,	9023,	0),
(62,	'',	'0111105443',	'stravnÃ© lÃ­stky',	1542.60,	'LE CHEQUE DEJEUNER s.r.o',	'2011-10-25',	'0000-00-00',	'img069.pdf',	3,	0,	'2017-02-16 06:13:50',	676,	9023,	0),
(63,	'',	'9/2011',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	2627.93,	'JÃ¡n Gavaler',	'2011-10-31',	'0000-00-00',	'img068.pdf',	3,	0,	'2017-02-16 06:10:56',	684,	9023,	0),
(64,	'',	'20/2011',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	1197.01,	'Michal Korenko',	'2011-10-31',	'0000-00-00',	'img066.pdf',	3,	0,	'2017-02-14 05:52:46',	704,	9023,	0),
(65,	'',	'1811',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	4204.94,	'Miroslav KarabÃ­n',	'2011-10-31',	'0000-00-00',	'img065.pdf',	3,	0,	'2017-02-07 21:52:07',	648,	9023,	0),
(66,	'',	'13/2011',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	1569.87,	'Milan BujnovskÃ½',	'2011-10-31',	'0000-00-00',	'img064.pdf',	3,	0,	'2017-02-08 06:14:52',	661,	9023,	0),
(67,	'',	'1911',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	3955.67,	'Miroslav KarabÃ­n',	'2011-11-30',	'0000-00-00',	'img059.pdf',	3,	0,	'2017-02-12 07:39:23',	651,	9023,	0),
(68,	'',	'2011415',	'drevnÃ¡ hmota',	2052.72,	'TechnickÃ© sluÅ¾by mesta Svit',	'2011-12-06',	'0000-00-00',	'img058.pdf',	3,	0,	'2017-02-07 21:51:55',	679,	9023,	0),
(69,	'',	'23/2011',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	1245.38,	'Michal Korenko',	'2011-11-30',	'0000-00-00',	'img057.pdf',	3,	0,	'2017-02-13 11:19:10',	656,	9023,	0),
(70,	'',	'18/2011',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	1192.33,	'Milan BujnovskÃ½',	'2011-12-30',	'0000-00-00',	'img056.pdf',	3,	0,	'2017-02-14 07:24:50',	699,	9023,	0),
(71,	'',	'11/0089',	'zriadenie priepustov',	1616.99,	'Lesostav Poprad, s.r.o.',	'2011-12-20',	'0000-00-00',	'img050.pdf',	3,	0,	'2017-02-16 06:10:50',	692,	9023,	0),
(72,	'',	'032912001',	'nÃ¡jomnÃ© za lesnÃ© pozemky',	20079.53,	'Mesto Poprad',	'2011-12-30',	'0000-00-00',	'img048.pdf',	3,	0,	'2017-02-14 06:00:16',	692,	9023,	0),
(73,	'',	'1/2011',	'jiffy tablety',	2680.99,	'Engo, s.r.o.',	'2011-02-24',	'0000-00-00',	'img123.pdf',	3,	0,	'2017-02-16 06:45:34',	472,	9025,	0),
(74,	'',	'3/2011',	'oprava lesnÃ½ch ciesta a zvÃ¡Å¾nic',	4500.00,	'Lesostav Poprad, s.r.o.',	'2011-05-03',	'0000-00-00',	'img122.pdf',	3,	0,	'2017-02-07 22:02:12',	469,	9025,	0),
(75,	'',	'4/2011',	'sadenice lesnÃ½ch drevÃ­n',	1860.00,	'UrbÃ¡rske poz. spol. Vikartovce',	'2011-06-02',	'0000-00-00',	'img124.pdf',	3,	0,	'2017-02-15 22:59:33',	517,	9025,	0),
(76,	'',	'5/2011',	'inÅ¡talÃ¡cia sklotextilnÃ½ch tapiet',	1547.41,	'Karki s.r.o.',	'2011-06-03',	'0000-00-00',	'img125.pdf',	3,	0,	'2017-02-07 22:02:07',	461,	9025,	0),
(77,	'',	'6/2011',	'poklÃ¡dka koberca',	1373.14,	'OnÄiÅ¡ s.r.o.',	'2011-06-28',	'0000-00-00',	'img127.pdf',	3,	0,	'2017-02-07 22:01:48',	475,	9025,	0),
(78,	'',	'8/2011',	'sadenice lesnÃ½ch drevÃ­n',	2070.80,	'UrbÃ¡rske poz. spol. Vikartovce',	'2011-09-05',	'0000-00-00',	'img128.pdf',	3,	0,	'2017-02-07 22:01:46',	458,	9025,	0),
(79,	'',	'10/2011',	'oprava LC Preslop a zriadenie priepustov',	2225.00,	'Lesostav Poprad, s.r.o.',	'2011-09-08',	'0000-00-00',	'img129.pdf',	3,	0,	'2017-02-14 09:11:24',	483,	9025,	0),
(80,	'zmluva o vykonanÃ­ Å¥aÅ¾by a manipulÃ¡cii dreva',	'6/2011',	'Å¥aÅ¾ba, pribliÅ¾ovanie, triedenie dreva',	0.00,	'Gavaler JÃ¡n',	'2011-09-02',	'2011-12-31',	'img135.pdf',	3,	0,	'2017-02-10 02:54:21',	625,	9024,	0),
(81,	'zmluva o vykonanÃ­ Å¥aÅ¾by a manipulÃ¡cii dreva',	'7/2011',	'Å¥aÅ¾ba, pribliÅ¾ovanie, triedenie dreva',	0.00,	'HlavÄÃ¡k Jozef',	'2011-09-02',	'2011-12-31',	'img136.pdf',	3,	0,	'2017-02-16 08:21:00',	848,	9024,	0),
(82,	'NÃ¡jomnÃ¡ zmluva o doÄasnom uÅ¾Ã­vanÃ­ lesnÃ©ho p',	'1/2011',	'ÄasÅ¥ lesnÃ©ho pozemku parcela KN-C Ä. 7538/1',	185.85,	'Sklenka Peter, Mgr.',	'2011-10-21',	'0000-00-00',	'velri.pdf',	3,	0,	'2017-02-11 21:27:36',	517,	9024,	0),
(104,	'zmluva o dielo',	'1/2012',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	0.00,	'LVL Schory, spol. s r.o.',	'2012-02-15',	'2012-12-31',	'zmluvy_2012.pdf',	3,	0,	'2017-02-07 22:05:25',	472,	9024,	0),
(105,	'zmluva o dielo',	'2/2012',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	0.00,	'Michal Korenko',	'2012-02-15',	'2012-12-31',	'zmluvy_2-2012.pdf',	3,	0,	'2017-02-14 03:11:16',	483,	9024,	0),
(106,	'zmluva o dielo',	'3/2012',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	0.00,	'Stemp M&G s.r.o.',	'2012-02-15',	'2012-12-31',	'zmluvy_3-2012.pdf',	3,	0,	'2017-02-07 22:05:21',	487,	9024,	0),
(107,	'Dodatok Ä.1 k nÃ¡jomnej zmluve',	'1/10/2012',	'doÄasnÃ© uÅ¾Ã­vanie lesnÃ©ho pozemku',	37.80,	'Dietrich Anton',	'2012-03-12',	'2017-03-12',	'zmluvy_4-2012.pdf',	3,	0,	'2017-02-07 22:05:20',	479,	9024,	0),
(108,	'zmluva o dielo',	'4/2012',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	0.00,	'Milan BujnovskÃ½',	'2012-03-15',	'2012-12-31',	'zmluvy_5-2012.pdf',	3,	0,	'2017-02-07 22:05:18',	487,	9024,	0),
(109,	'zmluva o dielo',	'5/2012',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	0.00,	'Miroslav Karabin',	'2012-03-15',	'2012-12-31',	'zmluvy_6-2012.pdf',	3,	0,	'2017-02-07 22:05:16',	499,	9024,	0),
(110,	'zmluva o dielo',	'6/2012',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	0.00,	'Gavaler JÃ¡n',	'2012-03-16',	'2012-12-31',	'zmluvy_7-2012.pdf',	3,	0,	'2017-02-09 14:40:00',	482,	9024,	0),
(111,	'zmluva o dielo',	'7/2012',	'Å¥aÅ¾ba, pribliÅ¾ovanie, manipulÃ¡cia dreva',	0.00,	'HlavÄÃ¡k Jozef',	'2012-03-16',	'2012-12-31',	'zmluvy_8-2012.pdf',	3,	0,	'2017-02-07 22:05:12',	493,	9024,	0),
(112,	'Darovacia zmluva',	'1/28/2012',	'drevnÃ¡ hmota',	351.90,	'Mesto Poprad',	'2012-06-08',	'2012-12-31',	'zmluvy_9-2012.pdf',	3,	0,	'2017-02-16 03:27:21',	480,	9024,	0),
(113,	'dodatok Ä.3 k zmluve',	'PR00111',	'nenavratnÃ½ finanÄnÃ½ prÃ­spevok',	641907.81,	'PÃ´dohospodÃ¡rska platobnÃ¡ agentÃºra',	'2012-06-06',	'2012-06-30',	'zmluvy9-2012.pdf',	3,	0,	'2017-02-07 22:05:10',	492,	9024,	0),
(114,	'dohoda o poskytnutÃ­ nÃ¡hrady',	'789/2012',	'nÃ¡hrada za obmedzenie vlastnÃ­ckych prÃ¡v',	1.20,	'Mesto Poprad',	'2012-07-10',	'2012-12-31',	'zmluvy_11-2012.pdf',	3,	0,	'2017-02-07 22:05:06',	481,	9024,	0),
(115,	'',	'7/2012',	'prehÄ¾ad faktÃºr za obdobie jÃºl 2012',	0.00,	'dodÃ¡vatelia',	'2012-07-31',	'0000-00-00',	'faktry_7-_2012.pdf',	3,	0,	'2017-02-16 06:13:20',	719,	9023,	0),
(119,	'Darovacia zmluva',	'1/37/2012',	'drevnÃ¡ hmota',	1821.60,	'Mesto Poprad',	'2012-09-13',	'2012-09-21',	'zmluvy_12-2012.pdf',	3,	0,	'2017-02-07 22:05:04',	487,	9024,	0),
(120,	'',	'1/2012',	'prehÄ¾ad faktÃºr za obdobie januÃ¡r 2012',	0.00,	'dodÃ¡vatelia',	'2012-01-31',	'0000-00-00',	'faktry_1-2012.pdf',	3,	0,	'2017-02-16 06:09:48',	697,	9023,	0),
(121,	'',	'2/2012',	'prehÄ¾ad faktÃºr za obdobie februÃ¡r 2012',	0.00,	'dodÃ¡vatelia',	'2012-02-29',	'0000-00-00',	'faktry_2-2012.pdf',	3,	0,	'2017-02-12 13:10:52',	664,	9023,	0),
(122,	'',	'3/2012',	'prehÄ¾ad faktÃºr za obdobie marec 2012',	0.00,	'dodÃ¡vatelia',	'2012-03-30',	'0000-00-00',	'faktry_3-2012.pdf',	3,	0,	'2017-02-16 06:13:57',	664,	9023,	0),
(123,	'',	'4/2012',	'prehÄ¾ad faktÃºr za obdobie aprÃ­l 2012',	0.00,	'dodÃ¡vatelia',	'2012-04-30',	'0000-00-00',	'faktry_4-2012.pdf',	3,	0,	'2017-02-16 05:40:03',	674,	9023,	0),
(124,	'',	'5/2012',	'prehÄ¾ad faktÃºr za obdobie mÃ¡j 2012',	0.00,	'dodÃ¡vatelia',	'2012-06-29',	'0000-00-00',	'faktry_5-2012.pdf',	3,	0,	'2017-02-16 01:14:22',	669,	9023,	0),
(126,	'',	'6/2012',	'prehÄ¾ad faktÃºr za obdobie jÃºn 2012',	0.00,	'dodÃ¡vatelia',	'2012-06-29',	'0000-00-00',	'faktry_6-2012.pdf',	3,	0,	'2017-02-12 07:39:21',	663,	9023,	0),
(127,	'',	'8/2012',	'prehÄ¾ad faktÃºr za obdobie august 2012',	0.00,	'dodÃ¡vatelia',	'2012-08-31',	'0000-00-00',	'faktry_8-2012.pdf',	3,	0,	'2017-02-16 06:11:32',	689,	9023,	0),
(129,	'Zmluva o podnÃ¡jme priestorov',	'1/29/2012',	'lesnÃ© pozemky',	796.80,	'Brantner Poprad, s.r.o.',	'2012-09-25',	'0000-00-00',	'zmluvy29-2012.pdf',	3,	0,	'2017-02-07 22:05:03',	476,	9024,	0),
(135,	'Dodatok Ä.2 k nÃ¡jomnej zmluve',	'1/39/2012',	'lesnÃ© pozemky',	0.00,	'Mesto Poprad',	'2012-10-24',	'0000-00-00',	'zmluvy_14-_2012.pdf',	3,	0,	'2017-02-07 22:04:54',	477,	9024,	0),
(136,	'',	'9/2012',	'prehÄ¾ad faktÃºr za obdobie september 2012',	0.00,	'dodÃ¡vatelia',	'2012-09-30',	'0000-00-00',	'faktry_9-2012.pdf',	3,	0,	'2017-02-07 21:51:33',	693,	9023,	0),
(139,	'',	'10/2012',	'prehÄ¾ad faktÃºr za obdobie oktÃ³ber 2012',	0.00,	'dodÃ¡vatelia',	'2012-10-31',	'0000-00-00',	'faktry_10-2012.pdf',	3,	0,	'2017-02-16 06:11:03',	667,	9023,	0),
(142,	'',	'9/2012',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za jÃºl 2012',	'2012-07-13',	'0000-00-00',	'objednvky_jl_2012.pdf',	3,	0,	'2017-02-14 08:21:30',	471,	9025,	0),
(144,	'',	'11/2012',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za september 2012',	'2012-09-14',	'0000-00-00',	'objednvky_september_2012.pdf',	3,	0,	'2017-02-07 22:01:17',	466,	9025,	0),
(146,	'',	'1/2012',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za januÃ¡r 2012',	'2012-01-13',	'0000-00-00',	'objednvky_jan_2012.pdf',	3,	0,	'2017-02-07 22:01:42',	455,	9025,	0),
(149,	'',	'4/2012',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za aprÃ­l 2012',	'2012-04-13',	'0000-00-00',	'objednvky_apr1_2012.pdf',	3,	0,	'2017-02-07 22:01:35',	458,	9025,	0),
(150,	'',	'5/2012',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za aprÃ­l2 2012',	'2012-04-30',	'0000-00-00',	'objednvky_apr2_2012.pdf',	3,	0,	'2017-02-07 22:01:33',	447,	9025,	0),
(151,	'',	'6/2012',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za mÃ¡j 2012',	'2012-05-15',	'0000-00-00',	'objednvky_maj_2012.pdf',	3,	0,	'2017-02-07 22:01:31',	450,	9025,	0),
(152,	'',	'7/2012',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za mÃ¡j2 2012',	'2012-05-31',	'0000-00-00',	'objednvky_maj2_2012.pdf',	3,	0,	'2017-02-08 21:08:32',	449,	9025,	0),
(153,	'',	'8/2012',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za jÃºn 2012',	'2012-06-15',	'0000-00-00',	'objednvky_jun_2012.pdf',	3,	0,	'2017-02-07 22:01:25',	451,	9025,	0),
(155,	'Darovacia zmluva',	'1/40/2012',	'drevnÃ¡ hmota',	322.56,	'Mesto Poprad',	'2012-10-29',	'2012-11-09',	'zmluvy_40-2012.pdf',	3,	0,	'2017-02-07 22:04:48',	476,	9024,	0),
(156,	'NÃ¡jomnÃ¡ zmluva o doÄasnom uÅ¾Ã­vanÃ­ lesnÃ©ho p',	'1/41/2012',	'chov vÄelstiev',	4.32,	'VareÄkovÃ¡ Anna',	'2012-11-09',	'0000-00-00',	'zmluvy_41-2012.pdf',	3,	0,	'2017-02-13 10:38:33',	510,	9024,	0),
(157,	'Zmluva o udelenÃ­ licencie - dodatok',	'1/42/2012',	'software LHKE',	237.59,	'Foresta SK, a.s.',	'2012-11-28',	'0000-00-00',	'zmluvy_42-2012.pdf',	3,	0,	'2017-02-14 13:43:16',	494,	9024,	0),
(159,	'',	'11/2012',	'prehÄ¾ad faktÃºr za obdobie november 2012',	0.00,	'dodÃ¡vatelia',	'2012-11-30',	'0000-00-00',	'Nfaktry11-2012.pdf',	3,	0,	'2017-02-16 06:13:15',	689,	9023,	0),
(164,	'',	'2/2012',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za februÃ¡r 2012',	'2012-02-14',	'0000-00-00',	'februar2012.pdf',	3,	0,	'2017-02-16 02:27:45',	436,	9025,	0),
(165,	'',	'3/2012',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za marec 2012',	'2012-03-30',	'0000-00-00',	'marec2012.pdf',	3,	0,	'2017-02-13 05:39:45',	437,	9025,	0),
(166,	'',	'10/2012',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za august 2012',	'2012-08-14',	'0000-00-00',	'august2012.pdf',	3,	0,	'2017-02-07 22:01:18',	440,	9025,	0),
(167,	'',	'12/2012',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za oktober 2012',	'2012-10-12',	'0000-00-00',	'oktober_2012.pdf',	3,	0,	'2017-02-07 22:01:15',	437,	9025,	0),
(168,	'',	'13/2012',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za oktober2 2012',	'2012-10-31',	'0000-00-00',	'oktober2_2012.pdf',	3,	0,	'2017-02-09 05:53:45',	447,	9025,	0),
(169,	'',	'14/2012',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za november 2012',	'2012-11-14',	'0000-00-00',	'november_2012.pdf',	3,	0,	'2017-02-14 04:24:28',	439,	9025,	0),
(170,	'',	'15/2012',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za november2 2012',	'2012-11-30',	'0000-00-00',	'november2_2012.pdf',	3,	0,	'2017-02-07 22:01:05',	444,	9025,	0),
(171,	'',	'16/2012',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za december 2012',	'2012-12-14',	'0000-00-00',	'december_2012.pdf',	3,	0,	'2017-02-12 21:47:08',	450,	9025,	0),
(172,	'',	'1/2013',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za januar 2013',	'2013-01-31',	'0000-00-00',	'januar_2013.pdf',	3,	0,	'2017-02-10 21:09:08',	456,	9025,	0),
(175,	'zmluva o poskytnutÃ­ dotÃ¡cie',	'418/1169-36/2012',	'dotÃ¡cia na mladÃ© lesnÃ© porasty',	6526.14,	'PÃ´dohospodÃ¡rska platobnÃ¡ agentÃºra',	'2012-12-11',	'2012-12-31',	'zmluva18-2012.pdf',	3,	0,	'2017-02-07 22:04:40',	462,	9024,	0),
(176,	'RÃ¡mcovÃ¡ kÃºpna zmluva',	'1/2013',	'dodÃ¡vka drevnej hmoty',	0.00,	'Zolka Zvolen, s.r.o.',	'2013-01-07',	'2013-12-31',	'zmluva1-2013.pdf',	3,	0,	'2017-02-13 01:30:20',	462,	9024,	0),
(177,	'',	'1/2013',	'prehÄ¾ad faktÃºr za obdobie januar 2013',	0.00,	'dodÃ¡vatelia',	'2013-01-31',	'0000-00-00',	'faktry_1-2013.pdf',	3,	0,	'2017-02-07 21:51:24',	643,	9023,	0),
(178,	'',	'2/2013',	'prehÄ¾ad faktÃºr za obdobie februar 2013',	0.00,	'dodÃ¡vatelia',	'2013-02-28',	'0000-00-00',	'faktry_2-2013.pdf',	3,	0,	'2017-02-16 06:50:36',	651,	9023,	0),
(180,	'',	'3/2013',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za marec 2013',	'2013-03-15',	'0000-00-00',	'marec_2013.pdf',	3,	0,	'2017-02-14 09:20:22',	461,	9025,	0),
(185,	'',	'2/2013',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za februÃ¡r 2013',	'2013-02-28',	'0000-00-00',	'februar_2013.pdf',	3,	0,	'2017-02-14 20:34:37',	437,	9025,	0),
(186,	'KÃºpna zmluva',	'30/2013',	'dodÃ¡vka terÃ©nneho vozidla',	33871.00,	'Dove, s.r.o.',	'2013-04-12',	'2015-12-31',	'zmluvy30_2013.pdf',	3,	0,	'2017-02-07 22:04:32',	502,	9024,	0),
(187,	'zmluva o dielo',	'37/2013',	'FoliovnÃ­k Kvetnica',	11704.61,	'Lesostav Poprad, s.r.o.',	'2013-04-18',	'2015-12-31',	'zmluva_37_2013.pdf',	3,	0,	'2017-02-14 01:42:42',	461,	9024,	0),
(189,	'',	'5/2013',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za april-2 2013',	'2013-04-15',	'0000-00-00',	'april2_2013.pdf',	3,	0,	'2017-02-14 02:44:21',	440,	9025,	0),
(193,	'',	'3/2013',	'prehÄ¾ad faktÃºr za obdobie marec 2013',	0.00,	'dodÃ¡vatelia',	'2013-03-29',	'0000-00-00',	'faktry_3-2013.pdf',	3,	0,	'2017-02-16 06:10:54',	635,	9023,	0),
(197,	'',	'4/2013',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za april 2013',	'2013-04-01',	'0000-00-00',	'april_2013.pdf',	3,	0,	'2017-02-12 20:59:07',	449,	9025,	0),
(199,	'zmluva o dodÃ¡vkach a odberoch tovaru',	'2/2013',	'drevnÃ¡ Å¡tiepka',	1680.00,	'Prius solution s.r.o.',	'2013-01-08',	'2013-12-31',	'zmluva2-2013.pdf',	3,	0,	'2017-02-07 22:04:36',	458,	9024,	0),
(200,	'zmluva o poskytnutÃ­ poradenskÃ½ch sluÅ¾ieb',	'3/2013',	'Å¾iadosÅ¥ o poskytnutie prÃ­spevku z PPA',	1800.00,	'BF Forest, s.r.o., KvetnÃ¡ 2693/16, Poprad',	'2013-04-02',	'2015-12-31',	'zmluva39-2013.pdf',	3,	0,	'2017-02-10 13:13:16',	450,	9024,	0),
(202,	'',	'6/2013',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za mÃ¡j 2013',	'2013-05-15',	'0000-00-00',	'maj_2013.pdf',	3,	0,	'2017-02-11 11:03:19',	434,	9025,	0),
(203,	'dodatok k nÃ¡jomnej zmluve',	'42/2013',	'lesnÃ© pozemky',	0.00,	'mesto Poprad',	'2013-05-29',	'0000-00-00',	'zmluva_42-2013.pdf',	3,	0,	'2017-02-13 00:33:01',	472,	9024,	0),
(204,	'darovacia zmluva',	'43/2013',	'drevnÃ¡ hmota',	315.00,	'mesto Poprad',	'2013-06-03',	'2013-06-30',	'zmluva_43-2013.pdf',	3,	0,	'2017-02-07 22:04:24',	452,	9024,	0),
(205,	'nÃ¡jomnÃ¡ zmluva',	'41/2013',	'lesnÃ© pozemky',	1.00,	'RÃ­mskokatolÃ­cka cirkev, farnosÅ¥ Poprad',	'2013-06-13',	'2033-06-15',	'zmluva_41-2013.pdf',	3,	0,	'2017-02-13 19:30:01',	471,	9024,	0),
(206,	'nÃ¡jomnÃ¡ zmluva',	'45/2013',	'lesnÃ© cesty',	0.00,	'SlovenskÃ½ pozemkovÃ½ fond Bratislava',	'2013-06-28',	'0000-00-00',	'zmluva_45-2013.pdf',	3,	0,	'2017-02-11 03:29:42',	458,	9024,	0),
(207,	'',	'7/2013',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za jÃºn 2013',	'2013-06-14',	'0000-00-00',	'jun_2013.pdf',	3,	0,	'2017-02-12 07:32:14',	420,	9025,	0),
(208,	'',	'8/2013',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za jÃºl 2013',	'2013-07-15',	'0000-00-00',	'jul_2013.pdf',	3,	0,	'2017-02-07 22:00:33',	420,	9025,	0),
(209,	'',	'9/2013',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za jÃºl2 2013',	'2013-07-31',	'0000-00-00',	'jul2_2013.pdf',	3,	0,	'2017-02-07 22:00:29',	439,	9025,	0),
(210,	'',	'6/2013',	'prehÄ¾ad faktÃºr za obdobie jÃºn 2013',	0.00,	'dodÃ¡vatelia',	'2013-06-28',	'0000-00-00',	'faktry_6-2013.pdf',	3,	0,	'2017-02-16 02:38:23',	587,	9023,	0),
(211,	'',	'7/2013',	'prehÄ¾ad faktÃºr za obdobie jÃºl 2013',	0.00,	'dodÃ¡vatelia',	'2013-07-31',	'0000-00-00',	'faktry_7-2013.pdf',	3,	0,	'2017-02-16 06:11:25',	607,	9023,	0),
(212,	'',	'5/2013',	'prehÄ¾ad faktÃºr za obdobie mÃ¡j 2013',	0.00,	'dodÃ¡vatelia',	'2013-05-31',	'0000-00-00',	'faktry_5-2013.pdf',	3,	0,	'2017-02-16 06:10:28',	604,	9023,	0),
(214,	'',	'4/2013',	'prehÄ¾ad faktÃºr za obdobie aprÃ­l 2013',	0.00,	'dodÃ¡vatelia',	'2013-04-30',	'0000-00-00',	'faktry_4-2013.pdf',	3,	0,	'2017-02-16 06:11:22',	599,	9023,	0),
(215,	'',	'8/2013',	'prehÄ¾ad faktÃºr za obdobie august 2013',	0.00,	'dodÃ¡vatelia',	'2013-08-30',	'0000-00-00',	'faktry_8-2013.pdf',	3,	0,	'2017-02-16 06:10:20',	586,	9023,	0),
(217,	'',	'10/2013',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za august 2013',	'2013-08-15',	'0000-00-00',	'august_2013.pdf',	3,	0,	'2017-02-07 22:00:24',	435,	9025,	0),
(218,	'',	'11/2013',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za september 2013',	'2013-09-16',	'0000-00-00',	'sept_2013.pdf',	3,	0,	'2017-02-13 03:44:46',	433,	9025,	0),
(219,	'',	'12/2013',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za september2 2013',	'2013-09-30',	'0000-00-00',	'sept2-2013.pdf',	3,	0,	'2017-02-07 22:00:19',	425,	9025,	0),
(220,	'darovacia zmluva',	'54/2013',	'drevnÃ¡ hmota',	322.56,	'Mesto Poprad',	'2013-09-26',	'2013-12-31',	'zmluva_54-2013.pdf',	3,	0,	'2017-02-07 22:04:19',	432,	9024,	0),
(225,	'',	'9/2013',	'prehÄ¾ad faktÃºr za obdobie september 2013',	0.00,	'dodÃ¡vatelia',	'2013-09-30',	'0000-00-00',	'faktry_9-2013.pdf',	3,	0,	'2017-02-07 21:50:49',	569,	9023,	0),
(226,	'',	'10/2013',	'prehÄ¾ad faktÃºr za obdobie oktober 2013',	0.00,	'dodÃ¡vatelia',	'2013-10-31',	'0000-00-00',	'faktry_10-2013.pdf',	3,	0,	'2017-02-07 21:50:46',	608,	9023,	0),
(227,	'',	'13/2013',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za oktober 2013',	'2013-10-15',	'0000-00-00',	'oktober_2013.pdf',	3,	0,	'2017-02-08 05:38:11',	416,	9025,	0),
(228,	'',	'14/2013',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za oktober2 2013',	'2013-10-31',	'0000-00-00',	'oktober_2_2013.pdf',	3,	0,	'2017-02-07 22:00:14',	418,	9025,	0),
(229,	'zmluva o poskytnutÃ­ dotÃ¡cie',	'418/1148-10/2013',	'dotÃ¡cia',	4399.70,	'PÃ´dohospodÃ¡rska platobnÃ¡ agentÃºra',	'2013-11-04',	'2013-12-31',	'zmluva_418.pdf',	3,	0,	'2017-02-10 14:02:25',	410,	9024,	0),
(230,	'darovacia zmluva',	'60/2013',	'ihliÄnatÃ¡ guÄ¾atina',	840.06,	'Mesto Poprad',	'2013-12-11',	'2013-12-31',	'zmluva_60-2013.pdf',	3,	0,	'2017-02-10 21:08:51',	425,	9024,	0),
(232,	'',	'16/2013',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za november2 2013',	'2013-11-29',	'0000-00-00',	'nov2_2013.pdf',	3,	0,	'2017-02-07 22:00:09',	393,	9025,	0),
(233,	'',	'17/2013',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za december 2013',	'2013-12-16',	'0000-00-00',	'dec_2013.pdf',	3,	0,	'2017-02-07 22:00:03',	391,	9025,	0),
(234,	'',	'18/2013',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za december 2 2013',	'2013-12-20',	'0000-00-00',	'dec2_2013.pdf',	3,	0,	'2017-02-07 21:59:59',	397,	9025,	0),
(235,	'',	'15/2013',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za november 2013',	'2013-11-15',	'0000-00-00',	'november_2013.pdf',	3,	0,	'2017-02-12 20:22:13',	392,	9025,	0),
(236,	'',	'11/2013',	'prehÄ¾ad faktÃºr za obdobie november 2013',	0.00,	'dodÃ¡vatelia',	'2013-11-29',	'0000-00-00',	'faktry_11-2013.pdf',	3,	0,	'2017-02-16 07:15:00',	543,	9023,	0),
(237,	'',	'12/2013',	'prehÄ¾ad faktÃºr za obdobie december 2013',	0.00,	'dodÃ¡vatelia',	'2013-12-31',	'0000-00-00',	'faktry_12-2013.pdf',	3,	0,	'2017-02-13 17:17:44',	549,	9023,	0),
(238,	'zmluva na vykonanie odsÃºhlasenÃ½ch postupov',	'1/2014',	'SluÅ¾by audÃ­tora',	360.00,	'GemerAudit, spol. s r.o.',	'2014-01-29',	'2014-12-31',	'zmluva1-2014.pdf',	3,	0,	'2017-02-09 20:27:08',	392,	9024,	0),
(239,	'RÃ¡mcovÃ¡ kÃºpna zmluva',	'9/2014',	'ihliÄnatÃ¡ guÄ¾atina, vlÃ¡knina',	0.00,	'Zolka Zvolen, s.r.o.',	'2014-02-07',	'2014-12-31',	'zmluva2-2014.pdf',	3,	0,	'2017-02-09 03:57:58',	410,	9024,	0),
(240,	'',	'1/2014',	'prehÄ¾ad faktÃºr za obdobie januÃ¡r  2014',	0.00,	'dodÃ¡vatelia',	'2014-02-12',	'0000-00-00',	'faktry_1-2014.pdf',	3,	0,	'2017-02-07 21:50:41',	523,	9023,	0),
(241,	'',	'2/2014',	'prehÄ¾ad faktÃºr za obdobie februÃ¡r  2014',	0.00,	'dodÃ¡vatelia',	'2014-03-14',	'0000-00-00',	'faktry_2-2014.pdf',	3,	0,	'2017-02-16 06:11:30',	549,	9023,	0),
(242,	'',	'1/2014',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za januÃ¡r 2013',	'2014-01-15',	'0000-00-00',	'objednvky_1-2014.pdf',	3,	0,	'2017-02-07 21:59:57',	356,	9025,	0),
(243,	'',	'2/2014',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za februÃ¡r 2013',	'2014-02-14',	'0000-00-00',	'objednvky_2-2014.pdf',	3,	0,	'2017-02-16 04:35:14',	367,	9025,	0),
(244,	'darovacia zmluva',	'10/2014',	'ihliÄnatÃ¡ guÄ¾atina smrekovec',	4320.00,	'RÃ­mskokatolÃ­cka cirkev, farnosÅ¥ Poprad',	'2014-04-02',	'2014-04-30',	'zmluva_10-2014.pdf',	3,	0,	'2017-02-10 16:50:23',	356,	9024,	0),
(246,	'KÃºpna zmluva',	'13/2014',	'LesovÅˆa Kolieska',	2220.00,	'Marek KovalÄÃ­k',	'2014-04-16',	'2014-04-16',	'zmluva13_2014.pdf',	3,	0,	'2017-02-07 22:03:51',	367,	9024,	0),
(247,	'RÃ¡mcovÃ¡ zmluva',	'6/2014',	'PrÃ¡ce v pestovnej Äinnosti',	19820.00,	'Anna JakubÄÃ¡kovÃ¡ a spol.',	'2014-02-03',	'2015-05-31',	'zmluva6-2014.pdf',	3,	0,	'2017-02-13 05:00:32',	336,	9024,	0),
(248,	'KÃºpna zmluva',	'7/2014',	'sadenice lesnÃ½ch drevÃ­n',	18915.12,	'UrbÃ¡rske pozemkovÃ© spoloÄenstvo Vikartovce',	'2014-02-03',	'2015-05-31',	'zmluva7-2014.pdf',	3,	0,	'2017-02-07 22:04:00',	343,	9024,	0),
(249,	'Dodatok k nÃ¡jomnej zmluve',	'5/2014',	'lesnÃ© pozemky',	1.00,	'Mesto Poprad',	'2014-03-06',	'2019-12-31',	'zmluva5-2014.pdf',	3,	0,	'2017-02-07 22:03:54',	357,	9024,	0),
(250,	'Dodatok k zmluve o udelenÃ­ licencie',	'21/2014',	'Program Webles',	249.59,	'Foresta SK, a.s.',	'2014-05-20',	'2014-12-31',	'zmluva21-2014.pdf',	3,	0,	'2017-02-11 21:05:28',	349,	9024,	0),
(251,	'',	'4/2014',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za marec2 2014',	'2014-04-01',	'0000-00-00',	'objednvky3-2-2014.pdf',	3,	0,	'2017-02-12 04:16:41',	359,	9025,	0),
(253,	'',	'3/2014',	'prehÄ¾ad faktÃºr za obdobie marec  2014',	0.00,	'dodÃ¡vatelia',	'2014-04-09',	'0000-00-00',	'faktry_3-2014.pdf',	3,	0,	'2017-02-16 06:12:13',	488,	9023,	0),
(254,	'',	'4/2014',	'prehÄ¾ad faktÃºr za obdobie aprÃ­l  2014',	0.00,	'dodÃ¡vatelia',	'2014-05-13',	'0000-00-00',	'faktry_4-2014.pdf',	3,	0,	'2017-02-13 02:06:10',	505,	9023,	0),
(255,	'Dodatok Ä. 5 k nÃ¡jomnej zmluve',	'23/2014',	'lesnÃ© pozemky',	0.00,	'Mesto Poprad',	'2014-06-10',	'0000-00-00',	'zmluva23-2014.pdf',	3,	0,	'2017-02-07 22:03:46',	355,	9024,	0),
(256,	'',	'5/2014',	'prehÄ¾ad faktÃºr za obdobie mÃ¡j  2014',	0.00,	'dodÃ¡vatelia',	'2014-06-10',	'0000-00-00',	'faktry5-2014.pdf',	3,	0,	'2017-02-16 06:11:40',	457,	9023,	0),
(258,	'',	'5/2014',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za aprÃ­l 2014',	'2014-04-16',	'0000-00-00',	'objednvky4-2014.pdf',	3,	0,	'2017-02-11 23:18:36',	341,	9025,	0),
(260,	'',	'6/2014',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za mÃ¡j1 2014',	'2014-05-16',	'0000-00-00',	'objednvky5-2014.pdf',	3,	0,	'2017-02-09 18:45:30',	323,	9025,	0),
(261,	'',	'7/2014',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za mÃ¡j2 2014',	'2014-06-02',	'0000-00-00',	'objednvky52-2014.pdf',	3,	0,	'2017-02-07 21:59:26',	343,	9025,	0),
(262,	'',	'8/2014',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za jÃºn1 2014',	'2014-06-16',	'0000-00-00',	'objednvky6-2014.pdf',	3,	0,	'2017-02-07 21:59:24',	338,	9025,	0),
(263,	'',	'9/2014',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za jÃºn2 2014',	'2014-07-01',	'0000-00-00',	'objednvky62-2014.pdf',	3,	0,	'2017-02-14 19:13:14',	348,	9025,	0),
(264,	'Darovacia zmluva',	'25/2014',	'ihliÄnatÃ© palivo',	129.02,	'Klub StrÃ¡Å¾anov',	'2014-09-18',	'2014-09-30',	'zmluva25-2014.pdf',	3,	0,	'2017-02-07 22:03:44',	314,	9024,	0),
(265,	'Dodatok Ä. 6 k nÃ¡jomnej zmluve',	'26/2014',	'lesnÃ© pozemky',	0.00,	'Mesto Poprad',	'2014-09-19',	'0000-00-00',	'zmluva26-2014.pdf',	3,	0,	'2017-02-10 07:36:23',	320,	9024,	0),
(269,	'',	'11/2014',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za jÃºl2 2014',	'2014-08-01',	'0000-00-00',	'objednvky72-2014.pdf',	3,	0,	'2017-02-07 21:59:19',	328,	9025,	0),
(271,	'',	'12/2014',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za august 2014',	'2014-08-18',	'0000-00-00',	'objednvky8_2014.pdf',	3,	0,	'2017-02-13 05:39:01',	318,	9025,	0),
(272,	'',	'13/2014',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za september 2014',	'2014-09-16',	'0000-00-00',	'objednvky_9-2014.pdf',	3,	0,	'2017-02-07 21:59:13',	313,	9025,	0),
(275,	'',	'10/2014',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za jÃºl 2014',	'2014-07-16',	'0000-00-00',	'objednvky7-2014.pdf',	3,	0,	'2017-02-07 21:59:21',	317,	9025,	0),
(276,	'Dodatok Ä. 1 k kÃºpnej zmluve',	'31/2014',	'sadenice lesnÃ½ch drevÃ­n',	8069.04,	'UrbÃ¡rske poz. spol. Vikartovce',	'2014-11-24',	'2015-12-31',	'zmluva31-2014.pdf',	3,	0,	'2017-02-16 07:42:41',	298,	9024,	0),
(277,	'kÃºpna zmluva',	'33/2014',	'sadenice lesnÃ½ch drevÃ­n',	6400.80,	'UrbÃ¡rske poz. spol. Vikartovce',	'2014-12-15',	'2015-12-31',	'zmluva33-2014.pdf',	3,	0,	'2017-02-15 13:05:08',	310,	9024,	0),
(278,	'',	'14/2014',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za oktÃ³ber 2014',	'2014-10-16',	'0000-00-00',	'objednvky10-2014.pdf',	3,	0,	'2017-02-12 06:05:22',	313,	9025,	0),
(279,	'',	'15/2014',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za november-1 2014',	'2014-11-17',	'0000-00-00',	'objednvky_11-2014.pdf',	3,	0,	'2017-02-09 17:23:34',	308,	9025,	0),
(280,	'',	'16/2014',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za november-2 2014',	'2014-12-01',	'0000-00-00',	'objednvky_112-2014.pdf',	3,	0,	'2017-02-08 08:30:53',	304,	9025,	0),
(286,	'',	'6/2014',	'prehÄ¾ad faktÃºr za obdobie jÃºn 2014',	0.00,	'dodÃ¡vatelia',	'2014-07-11',	'0000-00-00',	'faktry6-2014.pdf',	3,	0,	'2017-02-15 12:06:45',	366,	9023,	0),
(287,	'',	'7/2014',	'prehÄ¾ad faktÃºr za obdobie jÃºl 2014',	0.00,	'dodÃ¡vatelia',	'2014-08-12',	'0000-00-00',	'faktry7-2014.pdf',	3,	0,	'2017-02-16 06:17:27',	384,	9023,	0),
(288,	'',	'8/2014',	'prehÄ¾ad faktÃºr za obdobie august 2014',	0.00,	'dodÃ¡vatelia',	'2014-09-09',	'0000-00-00',	'faktry_8-2014.pdf',	3,	0,	'2017-02-08 13:15:32',	351,	9023,	0),
(289,	'',	'9/2014',	'prehÄ¾ad faktÃºr za obdobie september 2014',	0.00,	'dodÃ¡vatelia',	'2014-10-10',	'0000-00-00',	'faktry9-2014.pdf',	3,	0,	'2017-02-12 13:10:53',	385,	9023,	0),
(291,	'',	'10/2014',	'prehÄ¾ad faktÃºr za obdobie oktÃ³bert 2014',	0.00,	'dodÃ¡vatelia',	'2014-11-14',	'0000-00-00',	'faktry_10-2014.pdf',	3,	0,	'2017-02-16 06:09:57',	379,	9023,	0),
(292,	'',	'11/2014',	'prehÄ¾ad faktÃºr za obdobie november 2014',	0.00,	'dodÃ¡vatelia',	'2014-12-10',	'0000-00-00',	'faktry_11-2014.pdf',	3,	0,	'2017-02-07 21:50:16',	384,	9023,	0),
(294,	'',	'12/2014',	'prehÄ¾ad faktÃºr za obdobie december 2014',	0.00,	'dodÃ¡vatelia',	'2014-12-31',	'0000-00-00',	'faktry12-2014.pdf',	3,	0,	'2017-02-16 06:10:55',	385,	9023,	0),
(295,	'',	'17/2014',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za december 2014',	'2014-12-16',	'0000-00-00',	'objednvky_12-2014.pdf',	3,	0,	'2017-02-07 21:58:55',	302,	9025,	0),
(296,	'',	'1/2015',	'prehÄ¾ad faktÃºr za obdobie januÃ¡r 2015',	0.00,	'dodÃ¡vatelia',	'2015-02-12',	'0000-00-00',	'faktry_1-2015.pdf',	3,	0,	'2017-02-11 08:19:48',	393,	9023,	0),
(297,	'',	'1/2015',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za januÃ¡r-1 2015',	'2015-01-16',	'0000-00-00',	'objednvky1-2015.pdf',	3,	0,	'2017-02-07 21:58:45',	307,	9025,	0),
(301,	'',	'2/2015',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za januÃ¡r-2 2015',	'2015-02-02',	'0000-00-00',	'Nobjednvky2-2015.pdf',	3,	0,	'2017-02-07 21:58:43',	299,	9025,	0),
(302,	'',	'3/2014',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za marec 2014',	'2014-03-17',	'0000-00-00',	'objednvky_3-2014.pdf',	3,	0,	'2017-02-07 21:59:37',	295,	9025,	0),
(303,	'',	'3/2015',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za februar 1 2015',	'2015-02-16',	'0000-00-00',	'objednvky3-2015.pdf',	3,	0,	'2017-02-07 21:58:39',	281,	9025,	0),
(304,	'',	'4/2015',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za februar 2 2015',	'2015-03-02',	'0000-00-00',	'objednvky4-2015.pdf',	3,	0,	'2017-02-13 12:10:08',	288,	9025,	0),
(305,	'',	'2/2015',	'prehÄ¾ad faktÃºr za obdobie februÃ¡r 2015',	0.00,	'dodÃ¡vatelia',	'2015-03-18',	'0000-00-00',	'faktry_2-_2015.pdf',	3,	0,	'2017-02-07 21:50:09',	380,	9023,	0),
(307,	'rÃ¡mcovÃ¡ kÃºpna zmluva',	'1/2015',	'ihliÄnatÃ¡ guÄ¾atina',	0.00,	'Zolka Zvolen, s.r.o.',	'2015-01-12',	'2015-12-31',	'zmluva_1-2015.pdf',	3,	0,	'2017-02-07 22:03:34',	270,	9024,	0),
(308,	'rÃ¡mcovÃ¡ zmluva',	'4/2015',	'sluÅ¾by mechanizaÄnÃ½mi prostriedkami',	0.00,	'Lesostav Poprad, s.r.o.',	'2015-01-16',	'2016-12-31',	'zmluva4-2015.pdf',	3,	0,	'2017-02-07 22:03:32',	280,	9024,	0),
(309,	'KÃºpna zmluva',	'5/2015',	'sadenice lesnÃ½ch drevÃ­n',	13860.00,	'UrbÃ¡rske pozemkovÃ© spoloÄenstvo Vikartovce',	'2015-01-16',	'2016-04-15',	'zmluva5_2015.pdf',	3,	0,	'2017-02-07 22:03:31',	288,	9024,	0),
(310,	'Dodatok Ä. 1 k zmluve o poradenstve',	'7/2015',	'poskytovanie odbornÃ½ch a poradenskÃ½ch sluÅ¾ieb',	0.00,	'Ing. Eva DobisovÃ¡',	'2015-01-30',	'2015-05-31',	'zmluva7-2015.pdf',	3,	0,	'2017-02-08 14:42:56',	310,	9024,	0),
(312,	'',	'5/2015',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za marec 2015',	'2015-03-16',	'0000-00-00',	'objednvky5-2015.pdf',	3,	0,	'2017-02-13 02:33:47',	271,	9025,	0),
(313,	'',	'6/2015',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za marec-2 2015',	'2015-04-01',	'0000-00-00',	'objednvky6-2015.pdf',	3,	0,	'2017-02-07 21:58:22',	275,	9025,	0),
(314,	'',	'7/2015',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za april 2015',	'2015-04-17',	'0000-00-00',	'objednvky7-2015.pdf',	3,	0,	'2017-02-16 05:58:15',	281,	9025,	0),
(315,	'',	'3/2015',	'prehÄ¾ad faktÃºr za obdobie marec 2015',	0.00,	'dodÃ¡vatelia',	'2015-04-15',	'0000-00-00',	'faktry3-2015.pdf',	3,	0,	'2017-02-16 06:13:10',	308,	9023,	0),
(317,	'',	'4/2015',	'prehÄ¾ad faktÃºr za obdobie april 2015',	0.00,	'dodÃ¡vatelia',	'2015-05-08',	'0000-00-00',	'faktry4-2015.pdf',	3,	0,	'2017-02-13 20:10:49',	331,	9023,	0),
(320,	'Darovacia zmluva',	'10/2015',	'ihliÄnatÃ¡ guÄ¾atina',	1900.80,	'Klub VeliÄanov, Scherfelova 1360/36, 058 01 Poprad',	'2015-08-03',	'2015-09-01',	'zmluva10-2015.pdf',	3,	0,	'2017-02-14 03:09:48',	192,	9024,	0),
(321,	'Zmluva o poskytnutÃ­ finanÄnÃ©ho daru',	'9/2015',	'finanÄnÃ½ dar',	300.00,	'CirkevnÃ¡ spojenÃ¡ Å¡kola, CirkevnÃ© gymnÃ¡zium Pavla UÅ¡Ã¡ka Olivu',	'2015-03-03',	'2015-03-10',	'zmluva9-2015.pdf',	3,	0,	'2017-02-15 05:24:45',	187,	9024,	0),
(322,	'Darovacia zmluva',	'19/2015',	'ihliÄnatÃ¡ guÄ¾atina',	129.02,	'Mesto Poprad',	'2015-07-01',	'2015-07-31',	'zmluva19-2015.pdf',	3,	0,	'2017-02-07 22:03:11',	214,	9024,	0),
(323,	'Zmluva o dielo Ä.2/2015',	'90/2015',	'LesnÃ¡ cesta Kvetnica - prestavba',	179520.00,	'Lesostav Poprad s.r.o.',	'2015-09-28',	'2016-11-30',	'zmluva90-2015.pdf',	3,	0,	'2017-02-10 21:06:24',	214,	9024,	0),
(324,	'Zmluva o dielo',	'88/2015',	'pestovnÃ© prÃ¡ce',	142536.55,	'Forest LK, s.r.o.',	'2015-09-30',	'2018-12-31',	'zmluva88-2015.pdf',	3,	0,	'2017-02-12 06:40:55',	195,	9024,	0),
(326,	'Zmluva o vÃ½poÅ¾iÄke',	'107/2015',	'drobnÃ½ vodnÃ½ tok VysovÃ¡',	0.00,	'LESY SR, Å¡.p.',	'2015-09-30',	'2030-12-31',	'Nzmluva107-2015.pdf',	3,	0,	'2017-02-07 22:03:05',	217,	9024,	0),
(327,	'',	'7/2015',	'prehÄ¾ad faktÃºr za obdobie jÃºl 2015',	0.00,	'dodÃ¡vatelia',	'2015-08-14',	'0000-00-00',	'faktry7-2015.pdf',	3,	0,	'2017-02-16 07:13:41',	276,	9023,	0),
(328,	'',	'8/2015',	'prehÄ¾ad faktÃºr za obdobie august 2015',	0.00,	'dodÃ¡vatelia',	'2015-09-10',	'0000-00-00',	'faktry8-2015.pdf',	3,	0,	'2017-02-16 06:13:01',	284,	9023,	0),
(329,	'',	'9/2015',	'prehÄ¾ad faktÃºr za obdobie september 2015',	0.00,	'dodÃ¡vatelia',	'2015-10-14',	'0000-00-00',	'faktry9-2015.pdf',	3,	0,	'2017-02-16 06:10:41',	300,	9023,	0),
(330,	'',	'5/2015',	'prehÄ¾ad faktÃºr za obdobie mÃ¡j 2015',	0.00,	'dodÃ¡vatelia',	'2015-06-11',	'0000-00-00',	'faktry5-2015.pdf',	3,	0,	'2017-02-16 06:15:34',	266,	9023,	0),
(332,	'',	'9/2015',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za mÃ¡j-2 2015',	'2015-06-01',	'0000-00-00',	'objednvky9-2015.pdf',	3,	0,	'2017-02-15 22:49:53',	209,	9025,	0),
(336,	'',	'10/2015',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za jÃºn 2015',	'2015-06-16',	'0000-00-00',	'objednvky10-2015.pdf',	3,	0,	'2017-02-07 21:58:10',	207,	9025,	0),
(337,	'',	'11/2015',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za jÃºl 2015',	'2015-07-16',	'0000-00-00',	'objednvky11-2015.pdf',	3,	0,	'2017-02-14 08:13:01',	213,	9025,	0),
(338,	'',	'12/2015',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za jÃºl-2 2015',	'2015-08-03',	'0000-00-00',	'objednvky12-2015.pdf',	3,	0,	'2017-02-07 21:58:06',	205,	9025,	0),
(339,	'',	'13/2015',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za august 2015',	'2015-08-17',	'0000-00-00',	'objednvky13-2015.pdf',	3,	0,	'2017-02-10 21:06:46',	209,	9025,	0),
(341,	'',	'14/2015',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za september 2015',	'2015-09-16',	'0000-00-00',	'objednvky14-2015.pdf',	3,	0,	'2017-02-14 16:52:17',	201,	9025,	0),
(342,	'',	'15/2015',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za september2 2015',	'2015-10-01',	'0000-00-00',	'objednvky15-2015.pdf',	3,	0,	'2017-02-07 21:57:57',	207,	9025,	0),
(343,	'Zmluva o dielo',	'109/2015',	'ProtipoÅ¾iarne nÃ¡drÅ¾e Blech a Preslop',	34460.11,	'Lesostav Poprad s.r.o.',	'2015-10-09',	'2016-11-30',	'zmluva109-2015.pdf',	3,	0,	'2017-02-09 02:26:14',	208,	9024,	0),
(344,	'',	'10/2015',	'prehÄ¾ad faktÃºr za obdobie oktÃ³ber 2015',	0.00,	'dodÃ¡vatelia',	'2015-11-09',	'0000-00-00',	'faktry10-2015.pdf',	3,	0,	'2017-02-16 06:10:33',	222,	9023,	0),
(345,	'',	'11/2015',	'prehÄ¾ad faktÃºr za obdobie november 2015',	0.00,	'dodÃ¡vatelia',	'2015-12-14',	'0000-00-00',	'faktry11-2015.pdf',	3,	0,	'2017-02-15 14:22:52',	213,	9023,	0),
(346,	'',	'12/2015',	'prehÄ¾ad faktÃºr za obdobie december 2015',	0.00,	'dodÃ¡vatelia',	'2016-01-26',	'0000-00-00',	'faktry12-2015.pdf',	3,	0,	'2017-02-16 06:20:45',	220,	9023,	0),
(347,	'',	'16/2015',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za oktÃ³ber 2015',	'2015-10-16',	'0000-00-00',	'objednvky16-2015.pdf',	3,	0,	'2017-02-14 14:20:33',	150,	9025,	0),
(348,	'',	'17/2015',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za november 2015',	'2015-11-16',	'0000-00-00',	'objednvky17-2015.pdf',	3,	0,	'2017-02-14 04:14:33',	150,	9025,	0),
(349,	'',	'18/2015',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za november-2 2015',	'2015-12-01',	'0000-00-00',	'objednvky18-2015.pdf',	3,	0,	'2017-02-08 04:04:06',	152,	9025,	0),
(350,	'',	'19/2015',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za december 2015',	'2015-12-16',	'0000-00-00',	'objednvky19-2015.pdf',	3,	0,	'2017-02-07 21:57:50',	164,	9025,	0),
(352,	'Dodatok Ä. 2015/1 k Zmluve o udelenÃ­ licencie',	'122/2015',	'software WebLES',	249.59,	'Foresta SK, a.s.',	'2015-12-04',	'2015-12-31',	'zmluva122-2015.pdf',	3,	0,	'2017-02-09 10:29:21',	135,	9024,	0),
(353,	'kÃºpno - predajnÃ¡ zmluva',	'119/2015',	'osobnÃ½ automobil',	1200.00,	'Stanislav ÄŒonka',	'2015-12-01',	'2015-12-01',	'zmluva119-2015.pdf',	3,	0,	'2017-02-13 13:56:23',	140,	9024,	0),
(356,	'rÃ¡mcovÃ¡ kÃºpna zmluva',	'1/2016',	'drevnÃ¡ hmota',	0.00,	'Zolka Zvolen, s.r.o.',	'2016-01-13',	'2016-12-31',	'zmluva2-2016.pdf',	3,	0,	'2017-02-15 12:34:11',	138,	9024,	0),
(362,	'rÃ¡mcovÃ¡ zmluva',	'52/2014',	'pestovnÃ© prÃ¡ce - zalesnenie',	23400.00,	'Anna JakubÄÃ¡kovÃ¡ a spol.',	'2015-04-01',	'2015-12-31',	'zmluva_52-2014.pdf',	3,	0,	'2017-02-14 01:27:56',	79,	9024,	0),
(363,	'rÃ¡mcovÃ¡ zmluva',	'53/2014',	'pestovnÃ© prÃ¡ce - ochrana mladÃ½ch lesnÃ½ch porastov',	23760.00,	'Anna JakubÄÃ¡kovÃ¡ a spol.',	'2015-04-01',	'2015-12-31',	'zmluva53-2014.pdf',	3,	0,	'2017-02-07 22:03:14',	77,	9024,	0),
(364,	'rÃ¡mcovÃ¡ zmluva',	'54/2014',	'ostatnÃ© pestovnÃ© prÃ¡ce',	23820.00,	'Anna JakubÄÃ¡kovÃ¡ a spol.',	'2015-04-01',	'2015-12-31',	'zmluva54-2014.pdf',	3,	0,	'2017-02-10 21:25:59',	79,	9024,	0),
(366,	'',	'6/2015',	'prehÄ¾ad faktÃºr za obdobie jÃºn 2015',	0.00,	'dodÃ¡vatelia',	'2015-07-17',	'0000-00-00',	'faktry6-2015.pdf',	3,	0,	'2017-02-07 21:49:41',	116,	9023,	0),
(368,	'',	'8/2015',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za mÃ¡j 2015',	'2015-05-15',	'0000-00-00',	'Nobjednvky5-2015.pdf',	3,	0,	'2017-02-11 21:32:46',	91,	9025,	0),
(373,	'',	'2/2016',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za februÃ¡r 2016',	'2016-02-16',	'0000-00-00',	'objednvky-2.pdf',	3,	0,	'2017-02-09 10:06:19',	48,	9025,	0),
(375,	'',	'4/2016',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za marec 2 2016',	'2016-04-01',	'0000-00-00',	'objednvky-32.pdf',	3,	0,	'2017-02-09 10:06:29',	48,	9025,	0),
(377,	'',	'6/2016',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za aprÃ­l -2 2016',	'2016-05-02',	'0000-00-00',	'objednvky-42.pdf',	3,	0,	'2017-02-09 10:06:51',	52,	9025,	0),
(378,	'',	'7/2016',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za mÃ¡j 2016',	'2016-05-16',	'0000-00-00',	'objednvky-5.pdf',	3,	0,	'2017-02-09 10:06:55',	50,	9025,	0),
(379,	'',	'8/2016',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za mÃ¡j 2-2016',	'2016-06-01',	'0000-00-00',	'objednvky-52.pdf',	3,	0,	'2017-02-09 10:07:01',	50,	9025,	0),
(380,	'',	'9/2016',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za jÃºn 2016',	'2016-06-16',	'0000-00-00',	'objednvky-6.pdf',	3,	0,	'2017-02-09 10:07:06',	45,	9025,	0),
(381,	'',	'10/2016',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za jÃºn 2- 2016',	'2016-07-01',	'0000-00-00',	'objednvky-62.pdf',	3,	0,	'2017-02-09 10:07:12',	43,	9025,	0),
(382,	'',	'11/2016',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za jÃºl 2016',	'2016-07-18',	'0000-00-00',	'objednvky-7.pdf',	3,	0,	'2017-02-09 10:07:16',	48,	9025,	0),
(383,	'',	'1/2016',	'prehÄ¾ad faktÃºr za obdobie januÃ¡r 2016',	0.00,	'dodÃ¡vatelia',	'2016-02-15',	'0000-00-00',	'faktry_2016-1.pdf',	3,	0,	'2017-02-16 05:51:48',	68,	9023,	0),
(384,	'',	'2/2016',	'prehÄ¾ad faktÃºr za obdobie februÃ¡r 2016',	0.00,	'dodÃ¡vatelia',	'2016-03-14',	'0000-00-00',	'faktry_2016-2.pdf',	3,	0,	'2017-02-14 17:13:20',	66,	9023,	0),
(385,	'',	'3/2016',	'prehÄ¾ad faktÃºr za obdobie marec 2016',	0.00,	'dodÃ¡vatelia',	'2016-04-12',	'0000-00-00',	'faktry_2016-3.pdf',	3,	0,	'2017-02-16 08:00:07',	74,	9023,	0),
(386,	'',	'4/2016',	'prehÄ¾ad faktÃºr za obdobie aprÃ­l 2016',	0.00,	'dodÃ¡vatelia',	'2016-05-17',	'0000-00-00',	'faktry_2016-4.pdf',	3,	0,	'2017-02-14 17:14:09',	72,	9023,	0),
(387,	'',	'5/2016',	'prehÄ¾ad faktÃºr za obdobie mÃ¡j 2016',	0.00,	'dodÃ¡vatelia',	'2016-06-10',	'0000-00-00',	'faktry_2016-5.pdf',	3,	0,	'2017-02-15 05:22:26',	78,	9023,	0),
(388,	'',	'6/2016',	'prehÄ¾ad faktÃºr za obdobie jÃºn 2016',	0.00,	'dodÃ¡vatelia',	'2016-07-14',	'0000-00-00',	'faktry_2016-6.pdf',	3,	0,	'2017-02-15 15:25:03',	75,	9023,	0),
(389,	'',	'7/2016',	'prehÄ¾ad faktÃºr za obdobie jÃºl 2016',	0.00,	'dodÃ¡vatelia',	'2016-08-12',	'0000-00-00',	'faktry_2016-7.pdf',	3,	0,	'2017-02-09 14:32:13',	89,	9023,	0),
(391,	'Dodatok k nÃ¡jomnej zmluve',	'3/2016',	'prenÃ¡jom lesnÃ½ch pozemkov za ÃºÄelom vÄelÃ¡renia',	70.80,	'Mgr. Peter Sklenka',	'2016-02-01',	'0000-00-00',	'zmluva3-2016.tif',	3,	0,	'2017-02-08 23:41:57',	27,	9024,	0),
(392,	'KÃºpna zmluva',	'4/2016',	'Sadenice lesnÃ½ch drevÃ­n',	13096.44,	'UrbÃ¡rske poz. spol. Vikartovce',	'2016-02-02',	'2016-12-31',	'zmluva4-2016.pdf',	3,	0,	'2017-02-09 00:37:55',	26,	9024,	0),
(393,	'RÃ¡mcovÃ¡ zmluva',	'9/2016',	'PestovnÃ© prÃ¡ce zalesnenie',	23400.00,	'Skupina dodÃ¡vateÄ¾ov Anna JakubÄÃ¡kovÃ¡ a spol.',	'2016-03-07',	'2016-12-31',	'zmluva9-2016.pdf',	3,	0,	'2017-02-07 22:02:35',	23,	9024,	0),
(394,	'RÃ¡mcovÃ¡ zmluva',	'10/2016',	'PestovnÃ© prÃ¡ce ochrana MLP',	23760.00,	'Skupina dodÃ¡vateÄ¾ov Anna JakubÄÃ¡kovÃ¡ a spol.',	'2016-03-07',	'2016-12-31',	'zmluva10-2016.pdf',	3,	0,	'2017-02-07 22:02:30',	26,	9024,	0),
(395,	'RÃ¡mcovÃ¡ zmluva',	'11/2016',	'PestovnÃ© prÃ¡ce ostatnÃ©',	23988.00,	'Skupina dodÃ¡vateÄ¾ov Anna JakubÄÃ¡kovÃ¡ a spol.',	'2016-03-07',	'2016-12-31',	'zmluva11-2016.pdf',	3,	0,	'2017-02-13 06:08:25',	24,	9024,	0),
(396,	'Darovacia zmluva',	'31/2016',	'ihliÄnatÃ© palivo',	129.02,	'Mesto Poprad',	'2016-06-22',	'2016-06-30',	'zmluva31-2016.pdf',	3,	0,	'2017-02-07 22:02:23',	26,	9024,	0),
(397,	'Darovacia zmluva',	'32/2016',	'ihliÄnatÃ¡ guÄ¾atina',	121.18,	'Mesto Poprad',	'2016-07-25',	'2016-07-31',	'zmluva32-2016.pdf',	3,	0,	'2017-02-13 07:23:41',	25,	9024,	0),
(398,	'Darovacia zmluva',	'33/2016',	'ihliÄnatÃ¡ guÄ¾atina',	552.00,	'3AL biketrial club Poprad',	'2016-08-22',	'2016-08-31',	'zmluva33-2016.pdf',	3,	0,	'2017-02-13 09:59:58',	27,	9024,	0),
(399,	'Zmluva o dodÃ¡vke vody',	'1072/144/16Pv',	'dodÃ¡vka  vody verejnÃ½m vodovodom',	1.09,	'PodtatranskÃ¡ vodÃ¡renskÃ¡ prevÃ¡dzkovÃ¡ spoloÄnosÅ¥ a.s.',	'2016-09-09',	'1970-01-01',	'zmluva36-2016.pdf',	3,	0,	'2017-02-14 03:28:36',	26,	9024,	0),
(400,	'Dodatok zmluvy o udelenÃ­ licencie',	'2016/1',	'Software Webles',	249.59,	'Foresta SK, a.s.',	'2016-10-04',	'2016-12-31',	'zmluva37-2016.pdf',	3,	0,	'2017-02-07 22:02:14',	26,	9024,	0),
(401,	'',	'12/2016',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za august 2016',	'2016-08-16',	'0000-00-00',	'objednvky8.pdf',	3,	0,	'2017-02-07 21:57:01',	25,	9025,	0),
(402,	'',	'13/2016',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za august 2-2016',	'2016-08-31',	'0000-00-00',	'objednvky82.pdf',	3,	0,	'2017-02-14 22:06:01',	24,	9025,	0),
(403,	'',	'14/2016',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za september 2016',	'2016-09-16',	'0000-00-00',	'objednvky9.pdf',	3,	0,	'2017-02-07 21:56:45',	24,	9025,	0),
(404,	'nÃ¡jomnÃ¡ zmluva',	'121/2015',	'prenÃ¡jom lesnÃ½ch pozemkov za ÃºÄelom vÄelÃ¡renia',	6.30,	'Ä½ubomÃ­r MazÃºr',	'2016-01-11',	'2016-12-31',	'zmluva_1-2016.tif',	3,	0,	'2017-02-14 02:16:48',	24,	9024,	0),
(405,	'',	'8/2016',	'prehÄ¾ad faktÃºr za obdobie august 2016',	0.00,	'dodÃ¡vatelia',	'2016-09-09',	'0000-00-00',	'faktry_2016-8.pdf',	3,	0,	'2017-02-07 21:49:04',	38,	9023,	0),
(406,	'',	'9/2016',	'prehÄ¾ad faktÃºr za obdobie september 2016',	0.00,	'dodÃ¡vatelia',	'2016-10-10',	'0000-00-00',	'faktry_1016-9.pdf',	3,	0,	'2017-02-09 03:35:46',	48,	9023,	0),
(407,	'',	'10/2016',	'prehÄ¾ad faktÃºr za obdobie oktÃ³ber 2016',	0.00,	'dodÃ¡vatelia',	'2016-11-09',	'0000-00-00',	'faktry_2016-10.pdf',	3,	0,	'2017-02-14 06:00:42',	40,	9023,	0),
(408,	'',	'15/2016',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za oktÃ³ber 2016',	'2016-10-31',	'0000-00-00',	'objednvky_10-2016.pdf',	3,	0,	'2017-02-10 08:16:36',	21,	9025,	0),
(409,	'',	'16/2016',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za november 2016',	'2016-11-30',	'0000-00-00',	'objednvky_11-2016.pdf',	3,	0,	'2017-02-07 21:56:36',	6,	9025,	0),
(410,	'',	'11/2016',	'prehÄ¾ad faktÃºr za obdobie november 2016',	0.00,	'dodÃ¡vatelia',	'2016-12-13',	'0000-00-00',	'faktry_2016-11.pdf',	3,	0,	'2017-02-07 21:48:55',	16,	9023,	0),
(411,	'',	'12/2016',	'prehÄ¾ad faktÃºr za obdobie december 2016',	0.00,	'dodÃ¡vatelia',	'2017-01-13',	'0000-00-00',	'faktry_2016-12.pdf',	3,	0,	'2017-02-13 09:33:32',	8,	9023,	0),
(412,	'',	'1/2016',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za januÃ¡r 2016',	'2016-01-18',	'0000-00-00',	'objednvky_1-2016.pdf',	3,	0,	'2017-02-07 21:57:46',	2,	9025,	0),
(413,	'',	'3/2016',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za marec 2016',	'2016-03-16',	'0000-00-00',	'objednvky_3.1-2016.pdf',	3,	0,	'2017-02-07 21:57:40',	2,	9025,	0),
(414,	'',	'5/2016',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za aprÃ­l 2016',	'2016-04-18',	'0000-00-00',	'objednvky_4.1-2016.pdf',	3,	0,	'2017-02-07 21:57:26',	2,	9025,	0),
(415,	'',	'17/2016',	'',	0.00,	'prehÄ¾ad objednÃ¡vok za december 2016',	'2016-12-16',	'0000-00-00',	'objednvky_12-2016.pdf',	3,	0,	'2017-02-07 21:56:35',	3,	9025,	0);

DROP TABLE IF EXISTS `old_hlavne_menu`;
CREATE TABLE `old_hlavne_menu` (
  `id_hlavne_menu` int(11) NOT NULL COMMENT 'Hlavné menu',
  `nazov` varchar(40) COLLATE utf8_bin NOT NULL COMMENT 'Názov',
  `title` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT 'Titulok do odkazu "a"',
  `clanok` varchar(30) COLLATE utf8_bin DEFAULT 'uvod' COMMENT 'Názov priradeného článku alebo základná položka',
  `kl_skratka` varchar(5) COLLATE utf8_bin DEFAULT NULL COMMENT 'Klávesová skratka',
  `id_reg` int(11) NOT NULL DEFAULT '0' COMMENT 'Min úroveň registrácie',
  `id_blok` int(11) NOT NULL DEFAULT '1' COMMENT 'Ak 1 tak nie je ľavá strana',
  `zvyrazni` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Zvýraznenie',
  `id_hlavicka` int(11) NOT NULL DEFAULT '0' COMMENT 'Ak 1 tak je malá hlavička',
  `clanky` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Ak 1 tak je možné priradiť článok',
  `description` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT 'Mestsk&eacute; Lesy Poprad' COMMENT 'Popis položky pre vyhľadávač do meta tagu',
  `pocitadlo` int(11) NOT NULL DEFAULT '0' COMMENT 'Počítadlo kliknutí na položku',
  PRIMARY KEY (`id_hlavne_menu`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Položky HLAVNÉHO menu';

INSERT INTO `old_hlavne_menu` (`id_hlavne_menu`, `nazov`, `title`, `clanok`, `kl_skratka`, `id_reg`, `id_blok`, `zvyrazni`, `id_hlavicka`, `clanky`, `description`, `pocitadlo`) VALUES
(0,	'---VÃ½ber---',	NULL,	NULL,	NULL,	0,	0,	0,	0,	0,	'Mestsk&eacute; Lesy Poprad',	0),
(1,	'home',	'ÃšvodnÃ¡ strÃ¡nka',	'4',	'h',	0,	0,	0,	0,	1,	'MestskÃ© Lesy Poprad - ÃšvodnÃ¡ strÃ¡nka',	73527),
(2,	'sluÅ¾by',	'SluÅ¾by mestskÃ½ch lesov',	'29',	's',	0,	0,	0,	0,	1,	'MestskÃ© Lesy Poprad - SluÅ¾by mestskÃ½ch lesov',	14279),
(3,	'sprievodca',	'Sprievodca mestskÃ½mi lesmi',	'24',	'e',	0,	0,	0,	0,	1,	'MestskÃ© Lesy Poprad - Sprievodca mestskÃ½mi lesmi',	21996),
(4,	'zverejÅˆovanie dokumentov',	'ZverejÅˆovanie dokumentov',	'9023',	'd',	0,	0,	0,	0,	0,	'MestskÃ© Lesy Poprad - ZverejÅˆovanie dokumentov',	137677),
(5,	'verejnÃ© obstarÃ¡vanie',	'VerejnÃ© obstarÃ¡vanie',	'32',	'o',	0,	0,	0,	0,	1,	'MestskÃ© Lesy Poprad - VerejnÃ© obstarÃ¡vanie',	18388),
(7,	'galÃ©ria',	'GalÃ©ria fotografiÃ­',	'fotogalery',	'g',	0,	0,	0,	0,	0,	'Mestsk&amp;eacute; Lesy Poprad - GalÃ©ria fotografiÃ­',	27544),
(20,	'administrÃ¡cia',	'AdministrÃ¡cia strÃ¡nky',	'9002',	'a',	3,	0,	0,	0,	0,	'MestskÃ© Lesy Poprad - AdministrÃ¡cia strÃ¡nky',	732),
(9,	'oznamy',	'Oznamy',	'oznam',	'z',	3,	0,	0,	0,	0,	'MestskÃ© Lesy Poprad - Oznamy',	497),
(-1,	'o nas, kontakt',	'O nÃ¡s, kontakt',	NULL,	NULL,	0,	-1,	0,	0,	1,	'AdministrÃ¡torskÃ¡ ÄasÅ¥ pre O nÃ¡s a Kontakt',	18316),
(-2,	'VyhÄ¾adÃ¡vanie',	'',	'hladaj',	'',	0,	0,	0,	0,	0,	'VyhÄ¾adÃ¡vanie pre MestskÃ© Lesy Poprad',	526),
(6,	'projekty',	'Projekty mestskÃ½ch lesov',	'',	'p',	0,	0,	0,	0,	1,	'MestskÃ© Lesy Poprad - Projekty',	13445);

DROP TABLE IF EXISTS `operacia`;
CREATE TABLE `operacia` (
  `id_polozka` int(11) NOT NULL AUTO_INCREMENT,
  `nazov` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'Názov operácie použitý v odkaze ako: co',
  `subor` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'Názov súboru aj s relatívnou cestou, kde sa vykoná operácia',
  PRIMARY KEY (`id_polozka`),
  UNIQUE KEY `nazov_operacie` (`nazov`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `operacia` (`id_polozka`, `nazov`, `subor`) VALUES
(1,	'edit_clen',	'edit_clen_info.php'),
(2,	'nova_reg',	'nova_reg_info.php'),
(3,	'zab_heslo',	'zab_heslo_info.php'),
(4,	'new_clanok',	'function/edit_clanok.php'),
(5,	'new_oznam',	'oznam_info.php'),
(6,	'edit_clanok',	'function/edit_clanok.php'),
(7,	'del_clanok',	'clanky_info.php'),
(8,	'del_oznam',	'oznam_info.php'),
(9,	'edit_oznam',	'oznam_info.php'),
(10,	'mapa',	'mapa_info.php'),
(11,	'mail',	'mail_info.php'),
(12,	'aktualizacia',	'bloky/aktualizacia.php'),
(13,	'uvodnik',	'uvod/uvodnik.php'),
(14,	'f_history',	'fotoakcie/historia.php'),
(15,	'adm_edit_hlavne_menu',	'admin/admin_hlavne_menu.php'),
(16,	'adm_del_sub_menu',	'admin/admin_sub_menu.php'),
(17,	'adm_edit_sub_menu',	'admin/admin_sub_menu.php'),
(18,	'adm_edit_slider',	'admin/admin_slider.php'),
(19,	'adm_del_slider',	'admin/admin_slider.php'),
(20,	'adm_del_menu_galery',	'admin/admin_menu_galery.php'),
(21,	'adm_edit_menu_galery',	'admin/admin_menu_galery.php'),
(22,	'new_menu_galery',	'fotogalery_info.php'),
(23,	'del_menu_galery',	'fotogalery_info.php'),
(24,	'edit_menu_galery',	'fotogalery_info.php'),
(25,	'edit_podgalery',	'fotogalery_info.php'),
(26,	'add_podgalery',	'fotogalery_info.php'),
(27,	'foto_upload',	'fotogalery_info.php'),
(28,	'onas',	'function/pracujesa.php'),
(29,	'kontakt',	'function/pracujesa.php'),
(30,	'del_podgalery',	'fotogalery_info.php'),
(31,	'new_podgalery',	'fotogalery_info.php'),
(32,	'title_podgalery',	'fotogalery_info.php'),
(33,	'odstr_podgalery',	'fotogalery_info.php'),
(34,	'add_dokumenty',	'bloky/dokumenty/dokumenty_info.php'),
(35,	'del_dokumenty',	'bloky/dokumenty/dokumenty_info.php'),
(36,	'edit_dokumenty',	'bloky/dokumenty/dokumenty_info.php'),
(37,	'oznam_info',	'oznam_info.php'),
(38,	'adm_edit_clen',	'admin/admin_clen.php'),
(39,	'adm_del_clen',	'admin/admin_clen.php'),
(40,	'adm_new_clen',	'admin/admin_clen.php'),
(41,	'adm_edit_udaj',	'admin/admin_hlavne_udaje.php'),
(42,	'adm_new_udaj',	'admin/admin_hlavne_udaje.php'),
(43,	'admin',	'bloky/prihlasenie.php');

DROP TABLE IF EXISTS `oznam`;
CREATE TABLE `oznam` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user_profiles` int(11) NOT NULL DEFAULT '0' COMMENT 'Id člena, ktorý zadal oznam',
  `id_registracia` int(11) NOT NULL DEFAULT '0' COMMENT 'Úroveň registrácie pre zobrazenie',
  `id_ikonka` int(11) NOT NULL DEFAULT '0' COMMENT 'Id použitej ikonky',
  `datum_platnosti` date NOT NULL DEFAULT '0000-00-00' COMMENT 'Dátum platnosti',
  `datum_zadania` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Dátum zadania oznamu',
  `nazov` varchar(50) DEFAULT NULL COMMENT 'Názov oznamu',
  `text` text COMMENT 'Text oznamu',
  PRIMARY KEY (`id`),
  KEY `id_user_profiles` (`id_user_profiles`),
  KEY `id_registracia` (`id_registracia`),
  KEY `id_ikonka` (`id_ikonka`),
  CONSTRAINT `oznam_ibfk_1` FOREIGN KEY (`id_user_profiles`) REFERENCES `user_profiles` (`id`),
  CONSTRAINT `oznam_ibfk_2` FOREIGN KEY (`id_registracia`) REFERENCES `registracia` (`id`),
  CONSTRAINT `oznam_ibfk_3` FOREIGN KEY (`id_ikonka`) REFERENCES `ikonka` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `oznam_volba`;
CREATE TABLE `oznam_volba` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
  `volba` varchar(30) COLLATE utf8_bin NOT NULL COMMENT 'Popis voľby',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Volby pre potvrdenie účasti';

INSERT INTO `oznam_volba` (`id`, `volba`) VALUES
(1,	'Áno'),
(2,	'Asi áno'),
(3,	'50 na 50'),
(4,	'Asi nie'),
(5,	'Nie');

DROP TABLE IF EXISTS `pocitadla`;
CREATE TABLE `pocitadla` (
  `id_poc` int(11) NOT NULL AUTO_INCREMENT,
  `nazov` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'Názov počítadla alebo súboru ku ktorému sa vzťahuje',
  `pocita` int(11) NOT NULL DEFAULT '0' COMMENT 'Stav',
  `komentar` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'Bližšia špecifikácia',
  PRIMARY KEY (`id_poc`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `podclanok`;
CREATE TABLE `podclanok` (
  `id_polozka` int(11) NOT NULL,
  `nazov` varchar(40) COLLATE utf8_bin NOT NULL DEFAULT 'Článok',
  PRIMARY KEY (`id_polozka`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `podclanok` (`id_polozka`, `nazov`) VALUES
(-1,	'---Výber---'),
(0,	'ČlÃ¡nok'),
(1,	'Odkaz v zÃ¡hlaví nadradeného člÃ¡nku'),
(2,	'Odkaz v bočnom menu'),
(3,	'Odkaz na oboch miestach');

DROP TABLE IF EXISTS `podgaleria`;
CREATE TABLE `podgaleria` (
  `id_polozka` int(11) NOT NULL AUTO_INCREMENT,
  `nazov` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT 'akcia' COMMENT 'Názov podgalérie',
  `tit_foto` int(11) NOT NULL DEFAULT '0' COMMENT 'Číslo titulnej fotky v danej galérii',
  `popis` text COLLATE utf8_bin COMMENT 'Popis podgalérie',
  `pocita` int(11) NOT NULL DEFAULT '0' COMMENT 'Počet zobrazení',
  `id_menu` int(11) NOT NULL DEFAULT '1' COMMENT 'Príslušnosť k menu galérie',
  `datum` date NOT NULL DEFAULT '0000-00-00' COMMENT 'Dátum pridania',
  `id_oznamu` int(11) NOT NULL DEFAULT '0' COMMENT 'Ak je priradený oznam jeho id',
  `id_clena` int(11) NOT NULL DEFAULT '0' COMMENT 'Kto pridal podgalériu',
  `id_reg` int(11) NOT NULL DEFAULT '0' COMMENT 'Úroveň registrácie',
  `zobrazenie` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Či sa daná položka zobrazuje',
  PRIMARY KEY (`id_polozka`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `podgaleria` (`id_polozka`, `nazov`, `tit_foto`, `popis`, `pocita`, `id_menu`, `datum`, `id_oznamu`, `id_clena`, `id_reg`, `zobrazenie`) VALUES
(1,	'PokusnÃ¡ galÃ©ria',	3,	'Na toto miesto je moÅ¾nÃ© pridÃ¡vaÅ¥ Ä¾ubovoÄ¾nÃ½ text. Len ten text...',	1188,	1,	'2011-06-20',	0,	1,	0,	1),
(5,	'NovÃ½ chodnÃ­k',	47,	'VÃ½stavba novÃ©ho chodnÃ­ka',	48,	1,	'2011-09-20',	0,	3,	0,	-1),
(3,	'NovÃ¡ galÃ©ria',	29,	'Toto je len galÃ©ria ako ukÃ¡Å¾ka',	49,	1,	'2011-08-19',	0,	1,	0,	-1),
(4,	'NÃ¡uÄnÃ½ chodnÃ­k',	44,	'NovÃ½ nÃ¡uÄnÃ½ chodnÃ­k',	57,	1,	'2011-09-06',	0,	2,	0,	-1),
(6,	'Okruh zdravia',	56,	'',	1404,	1,	'2011-10-31',	0,	3,	0,	1),
(7,	'NÃ¡uÄnÃ½ chodnÃ­k',	81,	'',	1314,	1,	'2011-11-02',	0,	3,	0,	1),
(8,	'LesnÃ¡ cesta ZvernÃ­k Kvetnica',	118,	'',	1724,	1,	'2011-11-02',	0,	3,	0,	1),
(9,	'LesnÃ¡ cesta VysovÃ¡',	131,	'',	1514,	1,	'2012-02-06',	0,	3,	0,	1),
(10,	'Pestovanie lesa',	0,	'',	1130,	1,	'2012-02-06',	0,	3,	0,	1),
(11,	'LesnÃ¡ pedagogika',	0,	'',	1055,	1,	'2012-02-06',	0,	3,	0,	1),
(12,	'VetrovÃ© kalamity',	0,	'',	929,	1,	'2012-02-06',	0,	3,	0,	1),
(13,	'LesnÃ¡ cesta Preslop',	0,	'',	1058,	1,	'2012-02-06',	0,	3,	0,	1),
(14,	'LesnÃ¡ cesta VysovÃ¡ 2',	0,	'',	4,	1,	'2013-10-16',	0,	3,	0,	-1);

DROP TABLE IF EXISTS `prihlasenie`;
CREATE TABLE `prihlasenie` (
  `id_clena` int(11) NOT NULL DEFAULT '0',
  `prihl_dat` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `prihlasenie` (`id_clena`, `prihl_dat`) VALUES
(1,	'2011-12-07 17:45:40'),
(2,	'2011-11-26 20:50:33'),
(3,	'2011-11-22 08:23:58'),
(3,	'2011-11-21 11:44:19'),
(3,	'2011-11-08 15:19:42'),
(1,	'2011-11-07 10:12:11'),
(1,	'2011-11-07 10:10:46'),
(1,	'2011-11-07 09:56:49'),
(1,	'2011-11-07 08:58:01'),
(3,	'2011-11-05 14:30:23'),
(1,	'2011-11-05 08:59:15'),
(2,	'2011-11-03 17:36:26'),
(3,	'2011-11-03 07:45:14'),
(2,	'2011-11-02 22:22:25'),
(3,	'2011-11-02 22:22:06'),
(3,	'2011-11-02 22:19:13'),
(2,	'2011-11-02 22:18:11'),
(2,	'2011-11-02 22:11:18'),
(2,	'2011-11-02 21:57:33'),
(3,	'2011-11-02 21:56:16'),
(2,	'2011-11-02 15:11:01'),
(2,	'2011-11-02 14:58:47'),
(3,	'2011-11-02 14:48:54'),
(3,	'2011-11-02 13:11:27'),
(3,	'2011-11-02 07:56:32'),
(3,	'2011-10-31 10:54:39'),
(3,	'2011-10-31 08:44:47'),
(1,	'2011-10-19 17:05:04'),
(2,	'2011-10-13 22:40:03'),
(2,	'2011-10-13 22:38:41'),
(3,	'2011-10-11 13:10:59'),
(3,	'2011-10-05 14:34:08'),
(2,	'2011-10-04 14:02:04'),
(2,	'2011-09-28 08:01:04'),
(3,	'2011-09-28 07:58:11'),
(3,	'2011-09-27 15:03:29'),
(2,	'2011-09-26 18:30:28'),
(3,	'2011-09-23 15:11:29'),
(3,	'2011-09-22 21:09:10'),
(3,	'2011-09-21 21:47:11'),
(1,	'2011-09-21 17:28:57'),
(3,	'2011-09-20 21:19:02'),
(3,	'2011-09-20 20:47:10'),
(1,	'2011-09-19 09:52:13'),
(1,	'2011-09-19 09:50:23'),
(1,	'2011-09-17 17:14:17'),
(1,	'2011-09-17 17:14:16'),
(3,	'2011-09-13 17:15:41'),
(2,	'2011-09-13 17:14:02'),
(3,	'2011-09-13 16:32:57'),
(2,	'2011-09-13 15:38:22'),
(1,	'2011-09-13 10:09:59'),
(1,	'2011-09-13 07:59:00'),
(3,	'2011-09-12 17:28:37'),
(3,	'2011-09-12 15:32:54'),
(2,	'2011-09-12 15:06:21'),
(3,	'2011-09-12 15:02:50'),
(2,	'2011-09-10 23:27:05'),
(3,	'2011-09-10 23:16:48'),
(3,	'2011-09-10 22:20:50'),
(3,	'2011-09-10 22:08:37'),
(3,	'2011-09-10 21:24:56'),
(2,	'2011-09-10 21:11:41'),
(3,	'2011-09-10 21:09:36'),
(1,	'2011-09-06 12:15:59'),
(4,	'2011-09-06 12:17:24'),
(1,	'2011-09-06 12:22:06'),
(1,	'2011-09-06 18:10:12'),
(2,	'2011-09-06 18:28:52'),
(2,	'2011-09-06 22:20:02'),
(1,	'2011-09-07 06:53:16'),
(1,	'2011-12-13 12:20:31'),
(3,	'2012-02-01 10:09:26'),
(3,	'2012-02-01 10:12:33'),
(3,	'2012-02-06 09:01:13'),
(3,	'2012-02-06 11:13:36'),
(3,	'2012-02-06 13:29:44'),
(3,	'2012-02-06 20:33:05'),
(2,	'2012-02-08 20:40:43'),
(2,	'2012-02-08 21:01:29'),
(1,	'2012-02-10 13:58:34'),
(2,	'2012-02-10 17:30:17'),
(1,	'2012-02-11 13:22:33'),
(3,	'2012-02-11 13:30:30'),
(3,	'2012-02-11 13:32:02'),
(1,	'2012-02-12 07:03:00'),
(3,	'2012-02-14 09:09:15'),
(2,	'2012-02-15 20:50:57'),
(1,	'2012-02-27 11:06:46'),
(1,	'2012-02-28 05:53:42'),
(3,	'2012-02-28 09:42:27'),
(1,	'2012-02-29 04:21:15'),
(3,	'2012-02-29 11:57:32'),
(3,	'2012-02-29 12:01:05'),
(3,	'2012-03-05 09:35:40'),
(3,	'2012-03-06 14:32:33'),
(3,	'2012-03-06 14:49:28'),
(3,	'2012-03-08 08:25:45'),
(3,	'2012-03-15 08:45:43'),
(1,	'2012-03-16 07:31:03'),
(3,	'2012-03-16 08:45:14'),
(3,	'2012-04-16 13:21:47'),
(3,	'2012-04-24 08:55:02'),
(3,	'2012-04-24 09:33:36'),
(2,	'2012-05-24 21:12:06'),
(3,	'2012-05-24 21:24:23'),
(3,	'2012-06-15 14:17:48'),
(3,	'2012-07-20 08:17:03'),
(3,	'2012-07-20 08:47:03'),
(3,	'2012-07-20 09:29:34'),
(3,	'2012-07-23 09:00:28'),
(3,	'2012-07-25 11:55:25'),
(3,	'2012-07-25 12:25:13'),
(3,	'2012-07-25 12:35:41'),
(3,	'2012-07-25 13:51:00'),
(3,	'2012-08-22 09:25:17'),
(3,	'2012-08-22 09:49:40'),
(3,	'2012-08-23 10:52:13'),
(3,	'2012-08-23 14:41:59'),
(3,	'2012-08-23 15:14:17'),
(3,	'2012-08-23 15:14:58'),
(2,	'2012-09-04 19:41:27'),
(3,	'2012-09-17 09:01:16'),
(3,	'2012-09-17 09:02:35'),
(3,	'2012-09-19 11:24:10'),
(1,	'2012-09-19 11:47:15'),
(3,	'2012-09-19 12:22:07'),
(3,	'2012-09-19 12:36:51'),
(3,	'2012-09-19 12:37:23'),
(3,	'2012-10-02 15:06:46'),
(3,	'2012-10-16 10:53:53'),
(3,	'2012-10-16 15:00:07'),
(3,	'2012-11-02 08:31:14'),
(3,	'2012-11-02 09:12:44'),
(3,	'2012-11-02 09:28:00'),
(3,	'2012-11-02 09:32:36'),
(3,	'2012-11-02 10:35:51'),
(3,	'2012-11-02 14:45:48'),
(1,	'2012-11-05 11:48:34'),
(3,	'2012-11-07 08:58:44'),
(3,	'2012-11-07 09:24:01'),
(3,	'2012-11-07 09:25:31'),
(2,	'2012-11-11 21:03:30'),
(3,	'2012-11-14 10:18:04'),
(3,	'2012-11-14 12:35:49'),
(3,	'2012-11-28 12:43:52'),
(3,	'2013-01-17 08:59:02'),
(3,	'2013-01-17 09:01:05'),
(3,	'2013-01-17 10:51:20'),
(3,	'2013-01-25 12:16:47'),
(3,	'2013-02-18 11:11:29'),
(3,	'2013-02-18 11:25:11'),
(3,	'2013-03-05 08:42:50'),
(3,	'2013-03-05 09:42:19'),
(3,	'2013-03-06 16:10:45'),
(3,	'2013-03-06 17:03:54'),
(3,	'2013-04-08 11:40:48'),
(3,	'2013-04-08 11:51:54'),
(3,	'2013-04-15 09:24:08'),
(3,	'2013-04-19 15:39:45'),
(3,	'2013-04-23 09:42:36'),
(3,	'2013-05-03 16:47:28'),
(3,	'2013-05-13 10:47:20'),
(3,	'2013-05-13 11:07:13'),
(3,	'2013-05-13 15:39:08'),
(3,	'2013-05-13 15:39:27'),
(3,	'2013-05-13 15:40:55'),
(3,	'2013-05-13 15:41:16'),
(3,	'2013-05-13 15:41:33'),
(3,	'2013-05-13 15:42:09'),
(3,	'2013-05-13 15:43:22'),
(3,	'2013-05-13 15:43:43'),
(3,	'2013-05-13 15:46:13'),
(3,	'2013-05-13 15:46:52'),
(3,	'2013-05-13 15:48:14'),
(3,	'2013-05-17 12:59:30'),
(3,	'2013-05-17 13:20:44'),
(3,	'2013-05-17 13:26:25'),
(3,	'2013-06-26 14:38:02'),
(3,	'2013-06-26 14:51:30'),
(3,	'2013-06-26 15:03:16'),
(3,	'2013-06-28 10:44:38'),
(3,	'2013-08-09 09:26:32'),
(3,	'2013-08-28 08:08:01'),
(3,	'2013-08-28 08:32:22'),
(3,	'2013-08-28 08:34:46'),
(3,	'2013-10-16 09:54:44'),
(3,	'2013-10-16 11:28:43'),
(3,	'2013-10-16 12:47:04'),
(3,	'2013-11-25 14:54:06'),
(3,	'2013-11-26 13:06:21'),
(3,	'2013-11-27 10:11:14'),
(3,	'2013-11-29 09:03:52'),
(3,	'2013-11-29 12:36:32'),
(3,	'2013-12-16 08:32:49'),
(3,	'2013-12-16 08:36:56'),
(3,	'2014-01-15 14:40:10'),
(3,	'2014-01-24 22:24:06'),
(3,	'2014-01-27 17:11:51'),
(3,	'2014-01-27 20:10:17'),
(3,	'2014-01-27 20:39:13'),
(3,	'2014-01-27 20:57:31'),
(3,	'2014-01-27 21:00:03'),
(3,	'2014-01-27 21:35:01'),
(3,	'2014-01-28 09:03:34'),
(3,	'2014-01-29 09:34:58'),
(3,	'2014-01-29 10:24:45'),
(3,	'2014-01-29 18:23:55'),
(1,	'2014-02-03 13:18:37'),
(3,	'2014-02-05 10:03:45'),
(3,	'2014-02-05 11:53:20'),
(3,	'2014-02-05 11:53:49'),
(3,	'2014-02-20 10:57:14'),
(3,	'2014-03-25 12:12:11'),
(3,	'2014-04-02 10:16:40'),
(3,	'2014-04-04 08:49:21'),
(3,	'2014-04-23 08:17:11'),
(3,	'2014-04-25 15:04:35'),
(3,	'2014-05-02 08:46:36'),
(3,	'2014-05-02 09:35:04'),
(3,	'2014-05-22 11:59:22'),
(3,	'2014-05-22 18:20:44'),
(3,	'2014-07-16 09:48:10'),
(3,	'2014-07-16 13:22:05'),
(3,	'2014-10-01 09:30:35'),
(3,	'2014-10-01 09:40:54'),
(3,	'2014-10-01 14:02:14'),
(3,	'2014-11-11 11:11:04'),
(3,	'2014-11-11 11:33:41'),
(3,	'2014-11-11 11:45:34'),
(3,	'2014-11-12 09:31:03'),
(3,	'2014-11-21 09:19:27'),
(3,	'2014-12-30 08:40:39'),
(3,	'2015-01-16 09:55:39'),
(3,	'2015-01-29 11:10:35'),
(3,	'2015-02-13 21:41:57'),
(3,	'2015-02-23 14:03:48'),
(3,	'2015-02-27 10:14:08'),
(3,	'2015-04-08 09:10:13'),
(3,	'2015-07-14 08:34:18'),
(3,	'2015-09-22 09:33:56'),
(3,	'2015-09-30 18:17:07'),
(3,	'2015-09-30 18:33:56'),
(3,	'2015-10-09 19:23:29'),
(3,	'2015-11-09 08:27:38'),
(3,	'2015-11-09 14:15:00'),
(3,	'2015-11-10 11:19:10'),
(3,	'2015-11-11 10:34:29'),
(3,	'2015-11-13 11:00:17'),
(3,	'2016-02-10 11:20:53'),
(3,	'2016-02-22 11:00:10'),
(3,	'2016-02-22 11:12:13'),
(3,	'2016-02-25 12:54:27'),
(3,	'2016-04-13 12:02:40'),
(3,	'2016-04-13 12:44:52'),
(3,	'2016-04-25 17:32:38'),
(3,	'2016-05-12 18:09:45'),
(3,	'2016-05-12 18:16:05'),
(3,	'2016-05-16 09:19:31'),
(3,	'2016-05-16 09:22:42'),
(3,	'2016-05-18 08:10:20'),
(3,	'2016-05-18 08:11:57'),
(3,	'2016-05-18 08:16:02'),
(3,	'2016-05-18 08:16:52'),
(3,	'2016-05-18 08:19:29'),
(3,	'2016-05-18 08:22:30'),
(3,	'2016-05-18 10:44:38'),
(3,	'2016-05-20 08:05:01'),
(3,	'2016-05-30 13:21:15'),
(3,	'2016-06-09 11:01:55'),
(3,	'2016-06-28 17:19:32'),
(3,	'2016-06-29 17:07:01'),
(3,	'2016-08-17 11:17:36'),
(3,	'2016-08-18 17:42:12'),
(3,	'2016-08-19 11:16:22'),
(3,	'2016-10-18 14:25:52'),
(3,	'2016-10-20 08:51:47'),
(3,	'2016-10-21 08:29:02'),
(3,	'2016-10-24 16:30:38'),
(3,	'2016-10-25 11:09:23'),
(3,	'2016-10-25 11:21:39'),
(3,	'2016-11-18 09:22:38'),
(3,	'2016-12-29 11:17:01'),
(3,	'2017-01-02 10:55:47'),
(3,	'2017-02-01 08:42:31'),
(1,	'2017-02-03 10:00:45'),
(1,	'2017-02-08 06:58:00'),
(1,	'2017-02-08 07:40:49'),
(1,	'2017-02-09 08:35:34'),
(1,	'2017-02-09 08:36:45'),
(1,	'2017-02-09 13:18:16'),
(1,	'2017-02-10 12:07:21'),
(1,	'2017-02-13 07:58:55'),
(3,	'2017-02-13 08:34:10'),
(1,	'2017-02-13 10:10:23'),
(1,	'2017-02-16 07:58:47');

DROP TABLE IF EXISTS `registracia`;
CREATE TABLE `registracia` (
  `id` int(11) NOT NULL COMMENT '[A]Index',
  `role` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT 'guest' COMMENT 'Názov pre ACL',
  `nazov` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT 'Registracia cez web' COMMENT 'Názov úrovne registrácie',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Úrovne registrácie a ich názvy';

INSERT INTO `registracia` (`id`, `role`, `nazov`) VALUES
(0,	'guest',	'Bez registrácie'),
(1,	'register',	'Registrácia cez web'),
(2,	'pasivny',	'Registrovaný člen'),
(3,	'aktivny',	'Aktívny člen'),
(4,	'spravca',	'Správca obsahu'),
(5,	'admin',	'Administrátor');

DROP TABLE IF EXISTS `slider`;
CREATE TABLE `slider` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
  `poradie` int(11) NOT NULL DEFAULT '1' COMMENT 'Určuje poradie obrázkov v slidery',
  `nadpis` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT 'Nadpis obrázku',
  `popis` varchar(150) COLLATE utf8_bin NOT NULL DEFAULT 'Popis obrázku' COMMENT 'Popis obrázku slideru vypisovaný v dolnej časti',
  `subor` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '*.jpg' COMMENT 'Názov obrázku slideru aj s relatívnou cestou',
  `zobrazenie` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT 'Kedy sa obrázok zobrazí',
  `id_hlavne_menu` int(11) DEFAULT NULL COMMENT 'Odkaz na položku hlavného menu',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Popis obrázkou slideru aj s názvami súborov';

INSERT INTO `slider` (`id`, `poradie`, `nadpis`, `popis`, `subor`, `zobrazenie`, `id_hlavne_menu`) VALUES
(1,	1,	NULL,	'',	'www/files/slider/01_obora.jpg',	'',	NULL),
(2,	1,	NULL,	'',	'www/files/slider/02_mravenisko.jpg',	'',	NULL),
(3,	1,	NULL,	'',	'www/files/slider/03_ml.jpg',	'',	NULL),
(4,	1,	NULL,	'',	'www/files/slider/04_poprad.jpg',	'',	NULL),
(5,	1,	NULL,	'',	'www/files/slider/05_tatry.jpg',	'',	NULL),
(6,	1,	NULL,	'',	'www/files/slider/06_preslop.jpg',	'',	NULL),
(7,	1,	NULL,	'',	'www/files/slider/07_obloha.jpg',	'',	NULL),
(8,	1,	NULL,	'',	'www/files/slider/08_preslop.jpg',	'',	NULL),
(9,	1,	NULL,	'',	'www/files/slider/09_pavilon.jpg',	'',	NULL);

DROP TABLE IF EXISTS `sub_menu`;
CREATE TABLE `sub_menu` (
  `id_sub_menu` int(11) NOT NULL AUTO_INCREMENT,
  `nazov` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT 'Úvod',
  `id_hl_menu` int(11) NOT NULL DEFAULT '0',
  `polozka` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `id_reg` int(11) NOT NULL DEFAULT '0',
  `subor` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT 'none.php',
  `clanky` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Ak 1 tak je možné pridať článok',
  `zobrazenie` int(11) NOT NULL DEFAULT '1' COMMENT 'Ak 1 tak sa daná položka zobrazí',
  PRIMARY KEY (`id_sub_menu`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Položky VEDĽAJŠIEHO menu';

INSERT INTO `sub_menu` (`id_sub_menu`, `nazov`, `id_hl_menu`, `polozka`, `id_reg`, `subor`, `clanky`, `zobrazenie`) VALUES
(9001,	'2. boÄnÃ©ho menu',	20,	'sub_menu',	5,	'admin/admin_sub_menu.php',	0,	1),
(9002,	'1. hlavnÃ©ho menu',	20,	'hlavne_menu',	5,	'admin/admin_hlavne_menu.php',	0,	1),
(9005,	' EditÃ¡cia aktualizÃ¡cie',	20,	'aktualizacia',	5,	'admin/admin_aktualizacia.php',	0,	-1),
(9007,	' EditÃ¡cia verzie',	20,	'verzia',	5,	'admin/admin_verzie.php',	0,	-1),
(9008,	' Stav strÃ¡nky',	20,	'stav_str',	5,	'admin/admin_stav_str.php',	0,	-1),
(9009,	' EditÃ¡cia akcie',	20,	'akcia',	5,	'admin/admin_akcia.php',	0,	-1),
(9010,	'menu galÃ©rie',	20,	'menu_galery',	5,	'admin/admin_menu_galery.php',	0,	-1),
(9011,	' EditÃ¡cia poÄÃ­tadiel',	20,	'pocitadlo',	5,	'admin/admin_pocitadlo.php',	0,	-1),
(9014,	'hlavnÃ½ch Ãºdajov webu',	20,	'hlavne_udaje',	3,	'admin/admin_hlavne_udaje.php',	0,	1),
(9015,	'Älenov',	20,	'clen',	3,	'admin/admin_clen.php',	0,	1),
(9023,	'FaktÃºry',	4,	'faktury-1',	0,	'bloky/dokumenty/dokumenty_info.php',	0,	1),
(9020,	'poloÅ¾iek slider-u',	20,	'slider',	3,	'admin/admin_slider.php',	0,	1),
(9021,	'ZÃ¡kazky s nÃ­zkou hodnotou',	4,	'zakazky-4',	0,	'bloky/dokumenty/dokumenty_info.php',	0,	1),
(9024,	'Zmluvy',	4,	'zmluvy-1',	0,	'bloky/dokumenty/dokumenty_info.php',	0,	1),
(9025,	'ObjednÃ¡vky',	4,	'objednavky-1',	0,	'bloky/dokumenty/dokumenty_info.php',	0,	1);

DROP TABLE IF EXISTS `udaje`;
CREATE TABLE `udaje` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
  `id_registracia` int(11) NOT NULL DEFAULT '5' COMMENT 'Aká úroveň môže danú hodnotu editovať.',
  `id_druh` int(11) DEFAULT NULL COMMENT 'Druhová skupina pre nastavenia',
  `id_udaje_typ` int(11) NOT NULL DEFAULT '1' COMMENT 'Typ input-u',
  `nazov` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT 'nazov' COMMENT 'Názov prvku',
  `text` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT 'Definícia' COMMENT 'Hodnota prvku',
  `comment` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'Komentár k hodnote',
  PRIMARY KEY (`id`),
  KEY `id_registracia` (`id_registracia`),
  KEY `id_druh` (`id_druh`),
  KEY `id_udaje_typ` (`id_udaje_typ`),
  CONSTRAINT `udaje_ibfk_1` FOREIGN KEY (`id_registracia`) REFERENCES `registracia` (`id`),
  CONSTRAINT `udaje_ibfk_2` FOREIGN KEY (`id_druh`) REFERENCES `druh` (`id`),
  CONSTRAINT `udaje_ibfk_3` FOREIGN KEY (`id_udaje_typ`) REFERENCES `udaje_typ` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tabuľka na uschovanie základných údajov o stránke';

INSERT INTO `udaje` (`id`, `id_registracia`, `id_druh`, `id_udaje_typ`, `nazov`, `text`, `comment`) VALUES
(1,	3,	NULL,	1,	'titulka',	'MestskÃ© lesy Poprad',	'NÃ¡zov zobrazenÃ½ v titulke'),
(2,	3,	NULL,	1,	'keywords',	'MestskÃ© lesy Poprad, Turistika, oddych, ochrana Å¾ivotnÃ©ho prostredia.',	'KÄ¾ÃºÄovÃ© slovÃ¡'),
(3,	5,	NULL,	1,	'autor',	'Ing. Peter VOJTECH, Mgr. Jozef PETRENÄŒÃ­K',	'Meno autora'),
(4,	5,	NULL,	1,	'sub_menu_date',	'0',	'Zobrazenie dÃ¡tumu v boÄnom menu. Ak > 0 tak Ã¡no.'),
(5,	5,	NULL,	1,	'galeria_small',	'160',	'VeÄ¾kosÅ¥ obrÃ¡zku nÃ¡hÄ¾adu pre titulnÃ© obrÃ¡zky v galÃ©rii');

DROP TABLE IF EXISTS `udaje_typ`;
CREATE TABLE `udaje_typ` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
  `nazov` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT 'text' COMMENT 'Typ input-u pre danú položku',
  `comment` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT 'Text' COMMENT 'Popis navonok',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Typy prvkov pre tabuľku udaje';

INSERT INTO `udaje_typ` (`id`, `nazov`, `comment`) VALUES
(1,	'text',	'Text'),
(2,	'radio',	'Vyber jednu možnosť'),
(3,	'checkbox',	'Áno alebo nie');

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) COLLATE utf8_bin NOT NULL,
  `password` varchar(255) COLLATE utf8_bin NOT NULL,
  `email` varchar(100) COLLATE utf8_bin NOT NULL,
  `activated` tinyint(1) NOT NULL DEFAULT '1',
  `banned` tinyint(1) NOT NULL DEFAULT '0',
  `ban_reason` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `new_password_key` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `new_password_requested` datetime DEFAULT NULL,
  `new_email` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `new_email_key` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `last_ip` varchar(40) COLLATE utf8_bin NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `users` (`id`, `username`, `password`, `email`, `activated`, `banned`, `ban_reason`, `new_password_key`, `new_password_requested`, `new_email`, `new_email_key`, `last_ip`, `created`, `modified`) VALUES
(1,	'petov',	'$2a$08$pWTgI.3Vkx.1GsoyX.ov7O7/YyN3P/pispAAgYQJdUG6V7LFt8oNq',	'petak23@gmail.com',	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	'217.12.48.22',	'0000-00-00 00:00:00',	'2014-12-08 06:48:37'),
(2,	'jozue',	'$2a$08$2AkVBGbpNKkHppPC89TNqO4I7ZSiHDD/UVhNQecVVaqHB5VU1pvFS',	'jozue@anigraph.eu',	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	'',	'0000-00-00 00:00:00',	'2017-02-13 08:54:07'),
(3,	'robo',	'$2a$08$pyutyDEVhMzj0EgyZ6K5Z.7IJklZPQo9l0avi2bqv8xlK2MGErGIi',	'dula.robert@mail.t-com.sk',	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	'',	'0000-00-00 00:00:00',	'2017-02-13 08:38:27');

DROP TABLE IF EXISTS `user_prihlasenie`;
CREATE TABLE `user_prihlasenie` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
  `id_user_profiles` int(11) NOT NULL COMMENT 'Id člena, ktorý sa prihlásil',
  `prihlasenie_datum` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Dátum a čas prihlásenia',
  PRIMARY KEY (`id`),
  KEY `id_user_profiles` (`id_user_profiles`),
  CONSTRAINT `user_prihlasenie_ibfk_1` FOREIGN KEY (`id_user_profiles`) REFERENCES `user_profiles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Evidencia prihlásenia užívateľov';


DROP TABLE IF EXISTS `user_profiles`;
CREATE TABLE `user_profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_users` int(11) NOT NULL COMMENT 'Id v tabuľke users',
  `id_registracia` int(11) NOT NULL DEFAULT '0' COMMENT 'Úroveň registrácie',
  `meno` varchar(50) COLLATE utf8_bin NOT NULL COMMENT 'Meno',
  `priezvisko` varchar(50) COLLATE utf8_bin NOT NULL COMMENT 'Priezvisko',
  `rok` int(11) DEFAULT NULL COMMENT 'Rok narodenia',
  `telefon` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT 'Telefón',
  `poznamka` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'Poznámka',
  `pocet_pr` int(11) NOT NULL DEFAULT '0' COMMENT 'Počet prihlásení',
  `pohl` enum('Z','M') COLLATE utf8_bin NOT NULL DEFAULT 'Z' COMMENT 'Pohlavie',
  `prihlas_teraz` datetime DEFAULT NULL COMMENT 'Posledné prihlásenie',
  `prihlas_predtym` datetime DEFAULT NULL COMMENT 'Predposledné prihlásenie',
  `avatar_25` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT 'Cesta k avatarovi veľkosti 25x25',
  `avatar_75` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT 'Cesta k avatarovi veľkosti 75x75',
  `foto` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT 'Názov fotky člena',
  `news` enum('A','N') COLLATE utf8_bin NOT NULL DEFAULT 'A' COMMENT 'Posielanie info emailou',
  `created` datetime DEFAULT NULL COMMENT 'Dátum vytvorenia člena',
  `modified` datetime DEFAULT NULL COMMENT 'Posledná zmena',
  PRIMARY KEY (`id`),
  KEY `user_id` (`id_users`),
  KEY `id_registracia` (`id_registracia`),
  CONSTRAINT `user_profiles_ibfk_2` FOREIGN KEY (`id_users`) REFERENCES `users` (`id`),
  CONSTRAINT `user_profiles_ibfk_3` FOREIGN KEY (`id_registracia`) REFERENCES `registracia` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `user_profiles` (`id`, `id_users`, `id_registracia`, `meno`, `priezvisko`, `rok`, `telefon`, `poznamka`, `pocet_pr`, `pohl`, `prihlas_teraz`, `prihlas_predtym`, `avatar_25`, `avatar_75`, `foto`, `news`, `created`, `modified`) VALUES
(1,	1,	5,	'Peter',	'VOJTECH',	NULL,	NULL,	'Administrátor',	0,	'M',	NULL,	NULL,	NULL,	NULL,	NULL,	'A',	'2013-01-03 11:17:32',	'2015-01-11 07:05:28'),
(2,	2,	4,	'Jozef',	'PETRENČÍK',	NULL,	NULL,	NULL,	0,	'M',	NULL,	NULL,	NULL,	NULL,	NULL,	'A',	'2017-02-13 08:54:07',	'2017-02-13 08:54:07'),
(3,	3,	4,	'Róbert',	'DULA',	NULL,	NULL,	NULL,	0,	'M',	NULL,	NULL,	NULL,	NULL,	NULL,	'A',	'2017-02-13 08:38:27',	'2017-02-13 08:38:27');

DROP TABLE IF EXISTS `verzie`;
CREATE TABLE `verzie` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
  `id_user_profiles` int(11) NOT NULL DEFAULT '1' COMMENT 'Id člena, ktorý zadal verziu',
  `cislo` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '',
  `subory` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `text` text COLLATE utf8_bin,
  `datum` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cislo` (`cislo`),
  KEY `datum` (`datum`),
  KEY `id_clena` (`id_user_profiles`),
  CONSTRAINT `verzie_ibfk_1` FOREIGN KEY (`id_user_profiles`) REFERENCES `user_profiles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `verzie` (`id`, `id_user_profiles`, `cislo`, `subory`, `text`, `datum`) VALUES
(1,	1,	'0.1.',	NULL,	'Východzia verzia',	'2017-02-13 08:03:32');

-- 2017-02-16 08:25:45
