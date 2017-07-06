-- Adminer 4.3.1 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `admin_menu`;
CREATE TABLE `admin_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
  `odkaz` varchar(50) COLLATE utf8_bin NOT NULL COMMENT 'Odkaz',
  `nazov` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'Názov položky',
  `id_user_roles` int(11) NOT NULL DEFAULT '4' COMMENT 'Id min úrovne registrácie',
  `avatar` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT 'Odkaz na avatar aj s relatívnou cestou od adresára www',
  PRIMARY KEY (`id`),
  KEY `id_registracia` (`id_user_roles`),
  CONSTRAINT `admin_menu_ibfk_2` FOREIGN KEY (`id_user_roles`) REFERENCES `user_roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Administračné menu';

INSERT INTO `admin_menu` (`id`, `odkaz`, `nazov`, `id_user_roles`, `avatar`) VALUES
(1,	'Homepage:',	'Úvod',	3,	'ikonky/AzulLustre_icons/Cerrada.png'),
(2,	'Lang:',	'Editácia jazykov',	4,	'ikonky/AzulLustre_icons/Webfolder.png'),
(3,	'Slider:',	'Editácia slider-u',	4,	'ikonky/AzulLustre_icons/Imagenes.png'),
(4,	'User:',	'Editácia užívateľov',	5,	'ikonky/AzulLustre_icons/Fuentes.png'),
(5,	'Verzie:',	'Verzie webu',	4,	'ikonky/AzulLustre_icons/URL_historial.png'),
(6,	'Udaje:',	'Údaje webu',	4,	'ikonky/AzulLustre_icons/Admin.png'),
(7,	'Oznam:',	'Aktuality(oznamy)',	4,	'ikonky/AzulLustre_icons/Documentos_azul.png');

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

INSERT INTO `clanok_komponenty` (`id`, `id_hlavne_menu`, `spec_nazov`, `parametre`) VALUES
(1,	23,	'viewFaktury',	NULL),
(2,	24,	'viewFaktury',	NULL),
(3,	25,	'viewFaktury',	NULL),
(4,	26,	'viewFaktury',	NULL),
(5,	3,	'zobrazKartyPodclankov',	NULL);

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
(2,	1,	'<p class=\"text-info\">Turistické trasy a náučné chodníky, vyhliadky aj malá roklina, archeologické nálezisko, krížová cesta, odpočívadlá s ohniskom, chov muflónov a diviakov. \nToto všetko a ešte viac nájdete v lesoch mesta Poprad, ktoré sú blízko a ponúkajú skutočný relax a zážitok v prírode. \nTurista, cyklista, alebo rodiny s deťmi, každý si nájde niečo pre seba.</p>',	''),
(4,	1,	'<p class=\"text-info\">\n	Na&scaron;ou hlavnou činnosťou v oblasti obchodu a služieb je predaj dreva. Venujeme sa aj pestovaniu a predaju saden&iacute;c v pr&iacute;pade ich prebytku a ako doplnkov&eacute; služby vykon&aacute;vame sprievodcovsk&uacute; činnosť v mestsk&yacute;ch lesoch.</p>\n<div class=\"wrap border-t\">\n	<img class=\"img-responsive img-left\" src=\"http://localhost/lesypoprad/www/ikonky/96/dreva_96.png\" style=\"width: 96px; height: 96px;\" />\n	<h3>\n		Predaj dreva.</h3>\n	<p class=\"text\">\n		Spoločnosť realizuje predaj dreva za trhov&eacute; ceny. O aktu&aacute;lnych cen&aacute;ch jednotliv&yacute;ch sortimentov dreva sa dozviete na kontaktom č&iacute;sle na&scaron;ej spoločnosti.</p>\n</div>\n<div class=\"wrap border-t\">\n	<img class=\"img-responsive img-left\" src=\"http://localhost/lesypoprad/www/ikonky/96/rastlinka_96.png\" />\n	<h3>\n		Predaj saden&iacute;c.</h3>\n	<p class=\"text\">\n		Spoločnosť uskutočňuje predaj prebytkov&yacute;ch obaľovan&yacute;ch saden&iacute;c jednotliv&yacute;ch druhov drev&iacute;n. O aktu&aacute;lnej ponuke saden&iacute;c sa dozviete na kontaktom čisle na&scaron;ej spoločnosti.</p>\n</div>\n<div class=\"wrap border-t\">\n	<img class=\"img-responsive img-left\" src=\"http://localhost/lesypoprad/www/ikonky/96/skatula_96.png\" />\n	<h3>\n		Ostatn&eacute; služby.</h3>\n	<p class=\"text\">\n		Sprievodcovsk&aacute; činnosť je zabezpečovan&aacute; najm&auml; pre &scaron;koly z mesta Poprad po dohode s riaditeľom spoločnosti. K dispoz&iacute;ci&iacute; s&uacute; aj sprievodcovsk&eacute; materi&aacute;ly z n&aacute;učn&eacute;ho chodn&iacute;ka Kvetnica.</p>\n</div>\n<p>\n	&nbsp;</p>\n',	'Hlavnou činnosťou v oblasti obchodu a služieb je predaj dreva. Venujeme sa aj pestovaniu a predaju sadeníc v prípade ich prebytku a doplnkovo aj sprievodcovskej činnosti v mestských lesoch.'),
(5,	1,	'<p>\n	N&aacute;učn&yacute; chodn&iacute;k Kvetnica je zameran&yacute; hlavne na prezent&aacute;ciu&nbsp; lesn&yacute;ch vegetačn&yacute;ch stupňov Slovenska na malom &uacute;zem&iacute; Mestsk&yacute;ch lesov Poprad, historickej lokality Z&aacute;mčisko a N&aacute;rodne pr&iacute;rodnej rezerv&aacute;cie Hranovn&iacute;cka dubina.&nbsp; Trasa n&aacute;učn&eacute;ho chodn&iacute;ka je okružn&aacute;, s 9 n&aacute;učn&yacute;mi zast&aacute;vkami a s&nbsp;informačn&yacute;mi panelmi. Chodn&iacute;k sa zač&iacute;na v&nbsp; Lesoparku Kvetnica a prech&aacute;dza lokalitami Z&aacute;mčisko, Hor&aacute;reň, Hranovn&iacute;cka dubina,&nbsp; Vysov&aacute;, Zvern&iacute;k Kvetnica, Pod Kr&iacute;žov&aacute;. Na chodn&iacute;k sa m&ocirc;žete dostať z&nbsp;troch v&yacute;chodiskov&yacute;ch bodov &ndash; Kvetnica, Vysov&aacute;, Podstr&aacute;ň. Prev&yacute;&scaron;enie vo v&yacute;chodnej časti na Z&aacute;mčisko je 300 m, v&nbsp;z&aacute;padnej časti na Kr&iacute;žov&uacute; 400 m. Dĺžka chodn&iacute;ka je 13,6 km a&nbsp;prejdete ho za 3 hod. 45 min. Vstupy na trase s&uacute; ľahko a&nbsp;r&yacute;chlo dostupn&eacute; k&nbsp;zast&aacute;vkam MHD.</p>\n',	NULL),
(6,	1,	'<p style=\"text-align: justify;\">\n	Okruh zdravia je označen&yacute; žltou značkou v&nbsp;tvare kruhu, ktor&yacute; zač&iacute;na v Kvetnickom lesoparku. Okruh je dlh&yacute; 4,8 km a&nbsp;prejdete ho za 1 hodinu a 15 min&uacute;t. V &uacute;dolnej časti nad b&yacute;val&yacute;m Liečebn&yacute;m &uacute;stavom Kvetnica V&aacute;s cesta povedie zmie&scaron;an&yacute;mi prevažne jedľov&yacute;mi lesmi s bukom, jaseňom a smrekom k alt&aacute;nku a studničke, odkiaľ sa vyjde na lokalitu Pod Kr&iacute;žov&aacute;. Od tohto miesta prejdete vrcholov&yacute;m chodn&iacute;kom na r&aacute;czestie, od ktor&eacute;ho&nbsp; chodn&iacute;k prech&aacute;dza dubov&yacute;mi lesmi až na vyhliadku. Z tohto miesta je kr&aacute;sny v&yacute;hľad na časť Slovensk&eacute;ho raja, Kr&aacute;ľohoľsk&uacute; časť N&iacute;zkych Tatier a na Horn&aacute;dsku kotlinu. Z vyhliadky sa okolo Hor&aacute;rne dostanete sp&auml;ť do Lesoparku na Kvetnici.</p>\n<!-- p>\n	<iframe frameborder=\"0\" height=\"350\" marginheight=\"0\" marginwidth=\"0\" scrolling=\"no\" src=\"http://maps.google.sk/maps/ms?hl=sk&amp;vpsrc=1&amp;ctz=-60&amp;ie=UTF8&amp;msa=0&amp;msid=203736417966808765708.0004b0c089820d0b64221&amp;t=h&amp;ll=49.01359,20.274666&amp;spn=0.008937,0.016268&amp;output=embed\" width=\"425\"></iframe><br />\n	<small>Zobraziť <a href=\"http://maps.google.sk/maps/ms?hl=sk&amp;vpsrc=1&amp;ctz=-60&amp;ie=UTF8&amp;msa=0&amp;msid=203736417966808765708.0004b0c089820d0b64221&amp;t=h&amp;ll=49.01359,20.274666&amp;spn=0.008937,0.016268&amp;source=embed\" style=\"color: rgb(0, 0, 255); text-align: left;\">Okruh zdravia</a> na v&auml;č&scaron;ej mape</small> Zobraziť Okruh zdravia na v&auml;č&scaron;ej mape</p -->\n',	''),
(7,	1,	'<p>\n	Zelená turistická značka Vás povedie trasou od Železničnej stanici Poprad cez sídlisko Juh, Gánovce, Kvetnicu a končí na kóte Zámčisko. Trasa je dlhá 9,5 km a prejdete ju za 2 hod. 30 min.</p>\n',	NULL),
(8,	1,	'',	NULL),
(9,	1,	'<p>\n	Pletivo Polynet, zverejnené 15.8.2013</p>\n<p>\n	Dátum podpisu 20.8.2013</p>\n<p>\n	 </p>\n',	NULL),
(10,	1,	'<p align=\"center\">\n	Ozn&aacute;menie o&nbsp;zad&aacute;van&iacute; z&aacute;kazky</p>\n<h3 align=\"center\">\n	&nbsp;</h3>\n<div>\n	<p>\n		v r&aacute;mci postupu verejn&eacute;ho obstar&aacute;vania podľa &sect; 9 ods. 9 z&aacute;kona č. 25/2006 Z. z. o verejnom obstar&aacute;van&iacute; a o zmene a doplnen&iacute; niektor&yacute;ch z&aacute;konov v znen&iacute; neskor&scaron;&iacute;ch predpisov.</p>\n	<p>\n		&nbsp;</p>\n	<p style=\"margin-left: 21.3pt;\">\n		1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Identifik&aacute;cia verejn&eacute;ho obstar&aacute;vateľa:</strong></p>\n	<p>\n		N&aacute;zov: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Mestsk&eacute; lesy, s.r.o. Poprad&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\n	<p>\n		&Scaron;tatut&aacute;rny org&aacute;n:&nbsp;&nbsp; Ing. R&oacute;bert Dula</p>\n	<p>\n		S&iacute;dlo: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Levočsk&aacute; 3312/37, 058 01 Poprad&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\n	<p>\n		IČO:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 36448311</p>\n	<p>\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DIČ:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2020017175</p>\n	<p>\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IČ DPH:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SK 2020017175</p>\n	<p>\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\n	<p>\n		Kontaktn&aacute; osoba pre verejn&eacute; obstar&aacute;vanie: Ing. Dula</p>\n	<p>\n		Telef&oacute;n: 0910890440</p>\n	<p>\n		Pracovn&yacute; kontakt pre vysvetlenie ozn&aacute;menia o&nbsp;zad&aacute;van&iacute; z&aacute;kazky:</p>\n	<p>\n		lesypp@stonline.sk</p>\n	<p>\n		&nbsp;</p>\n	<p style=\"margin-left: 18pt;\">\n		2.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>N&aacute;zov predmetu z&aacute;kazky: Pestovn&eacute; pr&aacute;ce na obnove lesa</strong></p>\n	<p style=\"margin-left: 18pt;\">\n		&nbsp;</p>\n	<p style=\"margin-left: 18pt;\">\n		Z&aacute;kazka (zmluva) je na: poskytnutie služieb</p>\n	<p style=\"margin-left: 18pt;\">\n		3.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Podrobn&yacute; opis predmetu z&aacute;kazky: </strong></p>\n	<p>\n		-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>jamkov&aacute; sadba obaľovan&yacute;ch saden&iacute;c</strong> - prevzatie a&nbsp;don&aacute;&scaron;ka saden&iacute;c na miesto sadby, vyhľadanie miesta sadby, manipul&aacute;cia so sadenicami pred sadbou (vykopanie r&yacute;h a&nbsp;uloženie saden&iacute;c), odstr&aacute;nenie p&ocirc;dneho krytu a&nbsp;buriny na pl&ocirc;&scaron;ke požadovanej veľkosti, vykopanie jamky do požadovanej hĺbky, vloženie sadenice, zasypanie zeminou, utlačenie</p>\n	<p>\n		-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>ochrana saden&iacute;c proti burine vyž&iacute;nan&iacute;m na pl&ocirc;&scaron;kach - </strong>vyhľadanie saden&iacute;c resp. radov saden&iacute;c, vyžatie buriny na pl&ocirc;&scaron;ke alebo v p&aacute;soch požadovanej veľkosti &uacute;merne k&nbsp;v&yacute;&scaron;ke sadenice, rozprestretie buriny po vyžatej ploche.</p>\n	<p style=\"margin-left: 18pt;\">\n		4.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Predpokladan&aacute; hodnota z&aacute;kazky (bez DPH):&nbsp; 19820 &euro;</strong></p>\n	<p style=\"margin-left: 18pt;\">\n		&nbsp;</p>\n	<p style=\"margin-left: 18pt;\">\n		5.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Z&aacute;kladn&eacute; zmluvn&eacute; podmienky: </strong></p>\n	<p>\n		Miesto poskytnutia služieb: lesy v&nbsp;n&aacute;jme spoločnosti Mestsk&eacute; lesy, s.r.o. Poprad,&nbsp;</p>\n	<p>\n		Levočsk&aacute; 3312/37, 058 01 Poprad&nbsp;</p>\n	<p>\n		Lehota na dodanie predmetu z&aacute;kazky: od 15.2.2014 do 31.5.2015</p>\n	<p>\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Splatnosť fakt&uacute;r: 15 dn&iacute; od doručenia fakt&uacute;ry.</p>\n	<p style=\"margin-left: 18pt;\">\n		..... Predmet z&aacute;kazky bude financovan&yacute; z&nbsp;nen&aacute;vratn&eacute;ho finančn&eacute;ho pr&iacute;spevku z&nbsp;Operačn&eacute;ho programu rozvoja vidieka SR 2007-2013, n&aacute;zov opatrenia: 2.1 Obnova potenci&aacute;lu lesn&eacute;ho hospod&aacute;rstva a&nbsp;zavedenie prevent&iacute;vnych opatren&iacute;.</p>\n	<p>\n		&nbsp;</p>\n	<p style=\"margin-left: 18pt;\">\n		6.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Lehota na predkladanie dokladov a&nbsp; pon&uacute;k&nbsp; : do 31.1.2014,&nbsp; 11.00 h.</strong></p>\n	<p style=\"margin-left: 18pt;\">\n		7.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Stanovenie ceny</strong></p>\n	<p>\n		-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Cenu je potrebn&eacute; spracovať na z&aacute;klade požadovan&eacute;ho rozsahu a požadovanej kvality a&nbsp;ďal&scaron;&iacute;ch požiadaviek uveden&yacute;ch podľa ozn&aacute;menia o&nbsp;zad&aacute;van&iacute; z&aacute;kazky (ďalej len &bdquo;ozn&aacute;menia&ldquo;). Cenu je potrebn&eacute; uv&aacute;dzať v eur&aacute;ch (&euro;) bez DPH.&nbsp; Ak uch&aacute;dzač nie je platcom DPH, uvedie t&uacute;to skutočnosť v&nbsp;ponuke.</p>\n	<p>\n		&nbsp;</p>\n	<p style=\"margin-left: 18pt;\">\n		8.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Postup vo verejnom obstar&aacute;van&iacute;: </strong>je jednoetapov&yacute;.</p>\n	<p style=\"margin-left: 18pt;\">\n		&nbsp;</p>\n	<p style=\"margin-left: 18pt;\">\n		9.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Predkladanie dokladov a ponuky:</strong></p>\n	<p>\n		a)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Pri jednoetapovom postupe:</strong></p>\n	<p>\n		Ponuku je potrebn&eacute; doplniť do R&aacute;mcovej zmluvy (pr&iacute;loha č. 1. Ozn&aacute;menia o&nbsp;zad&aacute;van&iacute; z&aacute;kazky) a&nbsp;<strong><u>poslať v&nbsp;troch rovnopisoch</u></strong>&nbsp; v&yacute;lučne na adresu s&iacute;dla spoločnosti podľa bodu 1. v&nbsp;uzatvorenej ob&aacute;lke s&nbsp;uveden&iacute;m <strong>n&aacute;zvu z&aacute;kazky,</strong> s&nbsp;označen&iacute;m &ndash; <strong>NEOTV&Aacute;RAŤ</strong>&ldquo; na adresu s&iacute;dla spoločnosti uveden&uacute; v&nbsp;bode 1. Ponuky sa predkladaj&uacute; v&nbsp;slovenskom jazyku. V&nbsp;pr&iacute;pade, ak ponuku predklad&aacute; skupina dod&aacute;vateľov, je potrebn&eacute; vyplniť a&nbsp;zaslať&nbsp; Plnomocenstvo pre člena skupiny dod&aacute;vateľov (pr&iacute;loha č. 2. Ozn&aacute;menia o&nbsp;zad&aacute;van&iacute; z&aacute;kazky). Ponuku uch&aacute;dzač za&scaron;le spolu s&nbsp; dokladmi, ak s&uacute; požadovan&eacute;. Ponuky zaslan&eacute; po term&iacute;ne,&nbsp; v&nbsp;inom jazyku, alebo ak doklady nebud&uacute; predložen&eacute; podľa požiadaviek verejn&eacute;ho obstar&aacute;vateľa alebo uch&aacute;dzač nebude spĺňať podmienky &uacute;časti alebo nebude spĺňať požiadavky na predmet z&aacute;kazky podľa ozn&aacute;menia o&nbsp;zad&aacute;van&iacute; z&aacute;kazky, tak&eacute;to ponuky nebud&uacute; bran&eacute; do &uacute;vahy a&nbsp;nebud&uacute; vyhodnocovan&eacute;.</p>\n	<p>\n		&nbsp;</p>\n	<p style=\"margin-left: 18pt;\">\n		10.&nbsp; <strong>Podmienky &uacute;časti s&uacute; nasledovn&eacute; <em>(ak s&uacute; vyžadovan&eacute;)</em>:</strong></p>\n	<p>\n		-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; V ponuke je potrebn&eacute; predložiť:</p>\n	<p>\n		<u>Doklady</u>:&nbsp;</p>\n	<p style=\"margin-left: 54pt;\">\n		1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; K&oacute;piu opr&aacute;vnenia na dodanie tovaru (v&yacute;pis z&nbsp;OR, živnostensk&yacute; list).</p>\n	<p style=\"margin-left: 54pt;\">\n		&nbsp;</p>\n	<p style=\"margin-left: 18pt;\">\n		11.&nbsp; <strong>Krit&eacute;ria</strong> na hodnotenie pon&uacute;k s&uacute;: 1. cena.</p>\n	<p style=\"margin-left: 18pt;\">\n		12.&nbsp; Sp&ocirc;sob hodnotenia krit&eacute;ri&aacute;&nbsp; je nasledovn&yacute;: &Uacute;spe&scaron;n&yacute;m uch&aacute;dzačom bude ten, kto bude mať najniž&scaron;iu celkov&uacute; cenu bez DPH za cel&yacute; predmet z&aacute;kazky a&nbsp;spln&iacute; v&scaron;etky&nbsp;&nbsp; požiadavky uveden&eacute; v&nbsp;opise predmetu z&aacute;kazky.</p>\n	<p>\n		&nbsp;</p>\n	<p style=\"margin-left: 18pt;\">\n		13.&nbsp; <strong>Prijatie ponuky:</strong></p>\n	<p style=\"margin-left: 18pt;\">\n		S &uacute;spe&scaron;n&yacute; uch&aacute;dzačom bude uzatvoren&aacute; r&aacute;mcov&aacute; zmluva, ktor&aacute; je pr&iacute;lohou tohto ozn&aacute;menia. &nbsp;Ak ponuku predklad&aacute; skupina dod&aacute;vateľov, skupina dod&aacute;vateľov urč&iacute; svojho l&iacute;dra a&nbsp;predlož&iacute; spolu s&nbsp;k&uacute;pnou zmluvou aj Plnomocenstvo pre člena skupiny dod&aacute;vateľov (pr&iacute;loha č. 3).</p>\n	<p>\n		&nbsp;</p>\n	<p style=\"margin-left: 18pt;\">\n		14.&nbsp; Verejn&yacute; obstar&aacute;vateľ m&ocirc;že pred podpisom zmluvy požiadať &uacute;spe&scaron;n&eacute;ho uch&aacute;dzača o predloženie origin&aacute;lu alebo overenej k&oacute;pie opr&aacute;vnenia&nbsp; na poskytnutie služby, pr&iacute;padne ďal&scaron;&iacute;ch požadovan&yacute;ch dokladov podľa ozn&aacute;menia, ak boli predložen&eacute; iba fotok&oacute;pie dokladov.</p>\n	<p style=\"margin-left: 283.2pt;\">\n		..................................................</p>\n	<p>\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ing. R&oacute;bert Dula</p>\n	<p>\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; konateľ</p>\n	<p>\n		<em><u>Pr&iacute;lohy:</u> </em></p>\n	<p style=\"margin-left: 72pt;\">\n		1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; R&aacute;mcov&aacute; zmluva (pr&iacute;loha č. 1 k&nbsp;R&aacute;mcovej zmluve &ndash; Technologick&yacute; protokol, pr&iacute;loha č. 2 k&nbsp;R&aacute;mcovej zmluve &ndash; N&aacute;vrh na plnenie krit&eacute;ri&iacute;)</p>\n	<p style=\"margin-left: 72pt;\">\n		2.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Plnomocenstvo pre člena skupiny dod&aacute;vateľov</p>\n	<p>\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\n	<p style=\"margin-left: 247.8pt;\">\n		Pr&iacute;loha č. 1 k&nbsp;Ozn&aacute;meniu o&nbsp;zad&aacute;van&iacute; z&aacute;kazky</p>\n	<p align=\"center\" style=\"margin-left: 28.4pt;\">\n		&nbsp;</p>\n	<p align=\"center\" style=\"margin-left: 28.4pt;\">\n		<strong>R&aacute;mcov&aacute; zmluva č........................</strong></p>\n	<p>\n		&nbsp;</p>\n	<p align=\"center\" style=\"margin-left: 36pt;\">\n		<strong>1. Zmluvn&eacute; strany</strong></p>\n	<p align=\"center\" style=\"margin-left: 36pt;\">\n		&nbsp;</p>\n	<p style=\"margin-left: 28.4pt;\">\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Zhotoviteľ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </strong></p>\n	<p>\n		S&iacute;dlo</p>\n	<p>\n		Z&aacute;pis v&nbsp;obchodnom registri &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\n	<p style=\"margin-left: 180pt;\">\n		&Scaron;tatut&aacute;rny org&aacute;n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\n	<p style=\"margin-left: 1cm;\">\n		IČO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\n	<p style=\"margin-left: 1cm;\">\n		DIČ</p>\n	<p style=\"margin-left: 1cm;\">\n		IČ DPH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\n	<p>\n		Bankov&eacute; spojenie&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\n	<p>\n		Č&iacute;slo &uacute;čtu&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\n	<p>\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\n	<p align=\"center\" style=\"margin-left: 28.4pt;\">\n		(ďalej len &bdquo;zhotoviteľ&ldquo;)</p>\n	<p align=\"center\" style=\"margin-left: 28.4pt;\">\n		&nbsp;</p>\n	<p style=\"margin-left: 28.4pt;\">\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Objedn&aacute;vateľ</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Mestsk&eacute; lesy, s.r.o. Poprad</p>\n	<p>\n		S&iacute;dlo&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Levočsk&aacute; 3312/37, 058 01 Poprad&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\n	<p style=\"margin-left: 212.4pt;\">\n		Z&aacute;pis v&nbsp;obchodnom registri&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spoločnosť zap&iacute;san&aacute; v&nbsp;Obchodnom registri Okresn&eacute;ho s&uacute;du Pre&scaron;ov, oddiel: Sro, vložka č&iacute;slo: 10486/P</p>\n	<p style=\"margin-left: 180pt;\">\n		&Scaron;tatut&aacute;rny org&aacute;n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ing. R&oacute;bert Dula, konateľ</p>\n	<p style=\"margin-left: 1cm;\">\n		IČO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 36&nbsp;448 311</p>\n	<p style=\"margin-left: 1cm;\">\n		DIČ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2020017175</p>\n	<p>\n		IČ DPH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SK2020017175</p>\n	<p>\n		Bankov&eacute; spojenie&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sberbank, a.s.&nbsp;</p>\n	<p>\n		Č&iacute;slo &uacute;čtu&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4310021809/3100</p>\n	<p>\n		&nbsp;</p>\n	<p align=\"center\">\n		(ďalej len &bdquo;objedn&aacute;vateľ&ldquo;)</p>\n	<p style=\"margin-left: 14.2pt;\">\n		&nbsp;</p>\n	<p style=\"margin-left: 14.2pt;\">\n		v&nbsp;zmysle &sect;&nbsp;536 a&nbsp;nasl. z&aacute;kona č.&nbsp;513/1991 Z.z. Obchodn&yacute; z&aacute;konn&iacute;k v&nbsp;platnom znen&iacute; v&nbsp;spojen&iacute; s&nbsp;ustanoveniami &sect; 11 a &sect; 64 z&aacute;kona č. 25/2006 Z.z. v&nbsp;znen&iacute; neskor&scaron;&iacute;ch predpisov (ďalej len &bdquo;Z&aacute;kon o&nbsp;VO&ldquo;) uzavreli t&uacute;to r&aacute;mcov&uacute; zmluvu za t&yacute;chto podmienok:</p>\n	<p align=\"center\" style=\"margin-left: 14.2pt;\">\n		<strong>2. Z&aacute;kladn&eacute; ustanovenia</strong></p>\n	<p style=\"margin-left: 14.2pt;\">\n		2.1 Touto zmluvou sa zav&auml;zuje zhotoviteľ vykonať dielo a&nbsp;objedn&aacute;vateľ sa zav&auml;zuje zaplatiť cenu za jeho vykonanie podľa podmienok dojednan&yacute;ch v&nbsp;tejto zmluve.</p>\n	<p style=\"margin-left: 14.2pt;\">\n		2.2 Dielom sa podľa tejto r&aacute;mcovej zmluvy rozumie vykonanie pr&aacute;c v&nbsp;pestovnej činnosti. Cena diela vypl&yacute;va z&nbsp;v&iacute;ťaznej cenovej ponuky zhotoviteľa, ktor&aacute; bola objedn&aacute;vateľom určen&aacute; ako v&iacute;ťazn&aacute; v&nbsp;procese verejn&eacute;ho obstar&aacute;vania v&nbsp;zmysle &sect;9 ods. 9 z&aacute;k. č. 25/2006 Z. z. o&nbsp;verejnom obstar&aacute;van&iacute; v&nbsp;platnom znen&iacute;.</p>\n	<p style=\"margin-left: 14.2pt;\">\n		2.3 Dielo bude financovan&eacute; z&nbsp;vlastn&yacute;ch finančn&yacute;ch zdrojov objedn&aacute;vateľa, v&nbsp;pr&iacute;pade schv&aacute;lenia projektu a uzavretia zmluvy o&nbsp;poskytnut&iacute; nen&aacute;vratn&eacute;ho finančn&eacute;ho pr&iacute;spevku medzi objedn&aacute;vateľom a&nbsp;&nbsp;poskytovateľom pomoci Ministerstvom p&ocirc;dohospod&aacute;rstva v&nbsp;zast&uacute;pen&iacute; P&ocirc;dohospod&aacute;rskou platobnou agent&uacute;rou bude financovan&eacute; z&nbsp;nen&aacute;vratn&eacute;ho finančn&eacute;ho pr&iacute;spevku v&nbsp;zmysle Programu rozvoja vidieka 2007-2013.</p>\n	<p style=\"margin-left: 18pt;\">\n		2.4&nbsp; R&aacute;mcov&aacute; zmluva sa uzatv&aacute;ra na dobu určit&uacute;, a&nbsp;to do <strong>31.5.2015 alebo do vyčerpania&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; finančn&eacute;ho limitu tejto r&aacute;mcovej zmluvy. </strong>Finančn&yacute; limit tejto r&aacute;mcovej zmluvy <strong>&nbsp;je<br />\n		19 820 eur.</strong></p>\n</div>\n<p>\n	<strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3. Predmet diela</strong></p>\n<p>\n	3.1 Zhotoviteľ sa zav&auml;zuje, že za podmienok dojednan&yacute;ch v&nbsp;tejto r&aacute;mcovej zmluve&nbsp; pre objedn&aacute;vateľa vykon&aacute; nasledovn&eacute; druhy pestovn&yacute;ch pr&aacute;c v&nbsp;predpokladanom rozsahu :</p>\n<h3 align=\"center\">\n	&nbsp;</h3>\n<div>\n	<p>\n		&nbsp;</p>\n	<p>\n		&nbsp;</p>\n	<table border=\"1\" cellpadding=\"0\" cellspacing=\"0\" style=\"width:94.58%;\" width=\"94%\">\n		<tbody>\n			<tr>\n				<td rowspan=\"2\" style=\"width:60.7%;\">\n					<p align=\"left\">\n						Druh pr&aacute;ce</p>\n				</td>\n				<td rowspan=\"2\" style=\"width:6.7%;\">\n					<p align=\"left\">\n						MJ</p>\n				</td>\n				<td colspan=\"3\" style=\"width:32.6%;\">\n					<p>\n						Predpokladan&yacute; rozsah v&nbsp;roku</p>\n				</td>\n			</tr>\n			<tr>\n				<td style=\"width:9.28%;\">\n					<p>\n						2014</p>\n				</td>\n				<td style=\"width:12.58%;\">\n					<p>\n						2015</p>\n				</td>\n				<td style=\"width:10.74%;\">\n					<p>\n						SPOLU</p>\n				</td>\n			</tr>\n			<tr>\n				<td style=\"width:60.7%;\">\n					<p align=\"left\">\n						Jamkov&aacute; sadba obaľovan&yacute;ch saden&iacute;c</p>\n				</td>\n				<td style=\"width:6.7%;\">\n					<p align=\"left\">\n						ks</p>\n				</td>\n				<td style=\"width:9.28%;\">\n					<p align=\"center\">\n						48330</p>\n				</td>\n				<td style=\"width:12.58%;\">\n					<p align=\"center\">\n						32020</p>\n				</td>\n				<td style=\"width:10.74%;\">\n					<p align=\"center\">\n						80350</p>\n				</td>\n			</tr>\n			<tr>\n				<td style=\"width:60.7%;\">\n					<p align=\"left\">\n						Ochrana saden&iacute;c proti burine vyž&iacute;nan&iacute;m na pl&ocirc;&scaron;kach</p>\n				</td>\n				<td style=\"width:6.7%;\">\n					<p align=\"left\">\n						ha</p>\n				</td>\n				<td style=\"width:9.28%;\">\n					<p align=\"center\">\n						25</p>\n				</td>\n				<td style=\"width:12.58%;\">\n					<p align=\"center\">\n						-</p>\n				</td>\n				<td style=\"width:10.74%;\">\n					<p align=\"center\">\n						25</p>\n				</td>\n			</tr>\n		</tbody>\n	</table>\n</div>\n<p>\n	&nbsp;</p>\n<p>\n	3.2 Pr&aacute;ce zhotoviteľ vykon&aacute; podľa pokynov zodpovedn&yacute;ch zamestnancov objedn&aacute;vateľa.</p>\n<h3 align=\"center\">\n	&nbsp;</h3>\n<div>\n	<p style=\"margin-left: 18pt;\">\n		3.3 Ak je zhotoviteľom skupina dod&aacute;vateľov, zmluvn&eacute; strany sa dohodli, že členovia skupiny dod&aacute;vateľov s&uacute; zaviazan&iacute; spoločne a&nbsp;nerozdielne voči objedn&aacute;vateľovi zo v&scaron;etk&yacute;ch svojich z&aacute;v&auml;zkov prevzat&yacute;ch v&nbsp;tejto zmluve, najm&auml; vykonať dielo včas spoločne a&nbsp;nerozdielne, t. j. že objedn&aacute;vateľ je opr&aacute;vnen&yacute; požadovať plnenie od ktor&eacute;hokoľvek z&nbsp;nich a&nbsp;ak z&aacute;v&auml;zok skupiny zhotoviteľov spln&iacute; čo len jeden člen skupiny zhotoviteľov, povinnosť ostatn&yacute;ch členov zanikne.</p>\n</div>\n<p align=\"center\">\n	<strong>4. Doba vykonania diela</strong></p>\n<p>\n	4.1 Jednotliv&eacute; druhy pr&aacute;c zhotoviteľ vykon&aacute; podľa nasledovn&eacute;ho harmonogramu a&nbsp;pokynov zodpovedn&yacute;ch zamestnancov objedn&aacute;vateľa :</p>\n<h3 align=\"center\">\n	&nbsp;</h3>\n<div>\n	<table border=\"1\" cellpadding=\"0\" cellspacing=\"0\" style=\"width:88.46%;\" width=\"88%\">\n		<tbody>\n			<tr>\n				<td rowspan=\"3\" style=\"width:74.54%;height:11px;\">\n					<p align=\"left\">\n						Druh pr&aacute;ce</p>\n				</td>\n				<td colspan=\"2\" style=\"width:25.46%;height:11px;\">\n					<p>\n						Rok</p>\n				</td>\n			</tr>\n			<tr>\n				<td style=\"width:12.84%;height:11px;\">\n					<p>\n						2014</p>\n				</td>\n				<td style=\"width:12.62%;height:11px;\">\n					<p>\n						2015</p>\n				</td>\n			</tr>\n			<tr>\n				<td colspan=\"2\" style=\"width:25.46%;height:11px;\">\n					<p>\n						Mesiac</p>\n				</td>\n			</tr>\n			<tr>\n				<td style=\"width:74.54%;height:11px;\">\n					<p align=\"left\">\n						Jamkov&aacute; sadba obaľovan&yacute;ch saden&iacute;c</p>\n				</td>\n				<td style=\"width:12.84%;height:11px;\">\n					<p>\n						3 &ndash; 6</p>\n					<p>\n						&nbsp;</p>\n				</td>\n				<td style=\"width:12.62%;height:11px;\">\n					<p>\n						3 &ndash; 5</p>\n				</td>\n			</tr>\n			<tr>\n				<td style=\"width:74.54%;height:11px;\">\n					<p align=\"left\">\n						Ochrana saden&iacute;c proti burine vyž&iacute;nan&iacute;m na pl&ocirc;&scaron;kach</p>\n				</td>\n				<td style=\"width:12.84%;height:11px;\">\n					<p>\n						6 &ndash; 9</p>\n				</td>\n				<td style=\"width:12.62%;height:11px;\">\n					<p>\n						-</p>\n				</td>\n			</tr>\n		</tbody>\n	</table>\n</div>\n<p>\n	Vykonanie pr&aacute;c v&nbsp;inej dobe ako je uveden&eacute; v&nbsp;harmonograme uskutočn&iacute; zhotoviteľ len na p&iacute;somn&eacute; požiadanie&nbsp;objedn&aacute;vateľa.</p>\n<p align=\"center\">\n	<strong>5. Miesto vykonania diela</strong></p>\n<p>\n	Zhotoviteľ vykon&aacute; pr&aacute;ce podľa bodu 3 a podľa pokynov zodpovedn&yacute;ch zamestnancov objedn&aacute;vateľa.</p>\n<p>\n	Miesta vykonania pr&aacute;c bud&uacute; zodpovedn&yacute;m zamestnancom objedn&aacute;vateľa odovzd&aacute;van&eacute; po dohode so zhotoviteľom priebežne, vždy po ukončen&iacute; už objedn&aacute;vateľom zadan&yacute;ch pr&aacute;c.</p>\n<p>\n	Zhotoviteľ ozn&aacute;mi&nbsp;ukončenie pr&aacute;c na odovzdanom mieste ich vykonania zodpovedn&eacute;mu zamestnancovi objedn&aacute;vateľa najnesk&ocirc;r 1 deň pred ich ukončen&iacute;m.</p>\n<h3 align=\"center\">\n	<strong style=\"font-size: 12px;\">6. Kontrola pri vykon&aacute;van&iacute; diela</strong></h3>\n<p>\n	Objedn&aacute;vateľ je opr&aacute;vnen&yacute; kontrolovať vykon&aacute;vanie diela zhotoviteľom po str&aacute;nke kvality a dodržiavania technologick&yacute;ch postupov a&nbsp;platn&yacute;ch STN. Zhotoviteľ je povinn&yacute; splniť požiadavky objedn&aacute;vateľa.</p>\n<p align=\"center\">\n	<strong>7. Odovzdanie a&nbsp;prevzatie diela</strong></p>\n<p>\n	7.1 Pri vykon&aacute;van&iacute; diela bude pr&aacute;va a&nbsp;povinnosti objedn&aacute;vateľa vykon&aacute;vať za objedn&aacute;vateľa lesn&iacute;k alebo in&yacute; zodpovedn&yacute; pracovn&iacute;k objedn&aacute;vateľa, ktor&yacute; bude určen&yacute; pri podpise technologick&eacute;ho protokolu.</p>\n<h3 align=\"center\">\n	&nbsp;</h3>\n<div>\n	<p style=\"margin-left: 18pt;\">\n		7.2 Objedn&aacute;vateľ obozn&aacute;mi zhotoviteľa pred začat&iacute;m pr&aacute;c a&nbsp;odovzdan&iacute;m pracoviska s&nbsp;technologick&yacute;mi a&nbsp;pr&iacute;rodn&yacute;mi podmienkami, pracovn&yacute;mi postupmi ako aj s&nbsp;in&yacute;mi zvl&aacute;&scaron;tnosťami ter&eacute;nu a&nbsp;pracoviska. Tieto si vz&aacute;jomne potvrdia v&nbsp;technologickom protokole. Zhotoviteľ je povinn&yacute; pri v&yacute;kone pr&aacute;c na nich prihliadať. Vzor technologick&eacute;ho protokolu je pr&iacute;lohou č. 1 k&nbsp;zmluve.</p>\n	<p style=\"margin-left: 18pt;\">\n		7.3&nbsp;&nbsp; Technol&oacute;giu pr&aacute;c sa zhotoviteľ zav&auml;zuje dodržať podľa dohodnut&yacute;ch podmienok v&nbsp;technologickom protokole a&nbsp;to tak, aby maxim&aacute;lne &scaron;etril ost&aacute;vaj&uacute;ci porast, prirodzen&eacute; zmladenie, lesn&eacute; cesty a&nbsp;zv&aacute;žnice a&nbsp;ostatn&yacute; majetok vo vlastn&iacute;ctve alebo v&nbsp;n&aacute;jme objedn&aacute;vateľa. Pr&aacute;ce bude vykon&aacute;vať tak, aby nedo&scaron;lo k&nbsp;&scaron;kod&aacute;m na lesn&yacute;ch porastoch a&nbsp;kult&uacute;rach.</p>\n	<p style=\"margin-left: 18pt;\">\n		7.4&nbsp;&nbsp; Preberať a&nbsp;fakturovať sa bud&uacute; len porasty, ktor&eacute; s&uacute; &uacute;plne dokončen&eacute; podľa požiadaviek objedn&aacute;vateľa alebo rozpracovan&eacute; porasty, u&nbsp;ktor&yacute;ch je možn&eacute; preveden&eacute; pr&aacute;ce merať v&nbsp;ucelen&yacute;ch častiach.</p>\n	<p style=\"margin-left: 18pt;\">\n		7.5&nbsp;&nbsp; Objedn&aacute;vateľ sa zav&auml;zuje, že zhotoviteľom vykonan&eacute; jednotliv&eacute; druhy pr&aacute;c podľa bodu 3. prevezme a&nbsp;zaplat&iacute; za ich vykonanie dohodnut&uacute; cenu.</p>\n	<p style=\"margin-left: 18pt;\">\n		7.6&nbsp;&nbsp; Objedn&aacute;vateľ prevezme len pr&aacute;ce, ktor&eacute; s&uacute; &uacute;plne dokončen&eacute; podľa pokynov objedn&aacute;vateľa a&nbsp;podmienok dojednan&yacute;ch v&nbsp;tejto zmluve, bez v&aacute;d na diele alebo jeho častiach, ktor&eacute; by z&aacute;važn&yacute;m sp&ocirc;sobom ovplyvňovali podstatu vykonan&eacute;ho diela alebo jeho čast&iacute;. Lehotu na odovzdanie a&nbsp;prevzatie pr&aacute;c objedn&aacute;vateľ urč&iacute; podľa povahy pr&aacute;c a&nbsp;ich rozsahu.</p>\n	<p style=\"margin-left: 18pt;\">\n		7.7&nbsp;&nbsp; Zhotoviteľ za &uacute;čelom odovzdania vykonan&yacute;ch pr&aacute;c a&nbsp;za &uacute;čelom vystavenia fakt&uacute;ry vyzve zodpovedn&eacute;ho zamestnanca objedn&aacute;vateľa 3 dni vopred na odovzdanie a&nbsp;prevzatie pr&aacute;c na mieste ich vykonania.</p>\n	<p style=\"margin-left: 18pt;\">\n		7.8&nbsp;&nbsp; Ak&nbsp; zhotoviteľ nespln&iacute; povinnosť uveden&uacute; v&nbsp;bode 7.6 je povinn&yacute; umožniť objedn&aacute;vateľovi vykonanie dodatočn&eacute;ho prevzatia pr&aacute;c v&nbsp;n&iacute;m určenom term&iacute;ne.</p>\n	<p style=\"margin-left: 18pt;\">\n		7.9&nbsp; Ak sa objedn&aacute;vateľ nedostavil na odovzd&aacute;vanie a prevzatie pr&aacute;c, na ktor&eacute; bol zhotoviteľom vyzvan&yacute; alebo ktor&eacute; sa malo konať podľa dohodnut&eacute;ho časov&eacute;ho rozvrhu, m&ocirc;že zhotoviteľ pokračovať vo vykon&aacute;van&iacute; diela. Ak v&scaron;ak &uacute;časť na odovzd&aacute;van&iacute; a&nbsp;preberan&iacute; pr&aacute;c znemožnila objedn&aacute;vateľovi prek&aacute;žka, ktor&uacute; nemohol odvr&aacute;tiť, m&ocirc;že objedn&aacute;vateľ bez zbytočn&eacute;ho odkladu požadovať vykonanie dodatočn&eacute;ho odovzd&aacute;vania a&nbsp;preberania pr&aacute;c, v&nbsp;n&iacute;m určenom term&iacute;ne.</p>\n	<p align=\"center\" style=\"margin-left: 18pt;\">\n		<strong>8. Ostatn&eacute; dojednania pri vykon&aacute;van&iacute; diela</strong></p>\n	<p align=\"center\" style=\"margin-left: 18pt;\">\n		&nbsp;</p>\n	<p style=\"margin-left: 18pt;\">\n		8.1 Zhotoviteľ vykon&aacute; pr&aacute;ce podľa technologick&yacute;ch postupov na z&aacute;klade usmernenia zodpovedn&yacute;ch zamestnancov objedn&aacute;vateľa v&nbsp;zmysle Projektu. Na technologick&eacute; zvl&aacute;&scaron;tnosti pracoviska upozorn&iacute; objedn&aacute;vateľ zhotoviteľa pred začat&iacute;m pr&aacute;c a&nbsp;odovzdan&iacute;m pracoviska.</p>\n	<p style=\"margin-left: 18pt;\">\n		8.2 Zhotoviteľ sa zav&auml;zuje dodržiavať platn&eacute; z&aacute;sady ochrany bezpečnosti pri pr&aacute;ci a&nbsp;spr&aacute;vne technologick&eacute; postupy a&nbsp;za ich dodržiavanie nesie pln&uacute; zodpovednosť. S&uacute;časne zodpoved&aacute; za to, že bude vykon&aacute;vať len pr&aacute;ce, na ktor&eacute; m&aacute; kvalifikačn&eacute; opr&aacute;vnenie.</p>\n	<p style=\"margin-left: 18pt;\">\n		8.3 Počas doby p&ocirc;sobenia a&nbsp;zdržiavania sa na pozemkoch objedn&aacute;vateľa sa zhotoviteľ zav&auml;zuje dodržiavať platn&eacute; protipožiarne predpisy. Pri pr&aacute;cach v&nbsp;obdob&iacute; zv&yacute;&scaron;en&eacute;ho požiarneho nebezpečenstva je zhotoviteľ povinn&yacute; byť vybaven&yacute; potrebn&yacute;m n&aacute;rad&iacute;m k&nbsp;haseniu pr&iacute;padn&eacute;ho požiaru.</p>\n	<p align=\"center\" style=\"margin-left: 18pt;\">\n		&nbsp;</p>\n	<p align=\"center\" style=\"margin-left: 18pt;\">\n		<strong>9. Veci určen&eacute; k&nbsp;vykonaniu diela</strong></p>\n	<p align=\"center\" style=\"margin-left: 18pt;\">\n		&nbsp;</p>\n	<p style=\"margin-left: 18pt;\">\n		9.1 Zhotoviteľ vykon&aacute; dielo vlastn&yacute;m pracovn&yacute;m n&aacute;rad&iacute;m a&nbsp;materi&aacute;lom, ktor&eacute; nezabezpečuje podľa tejto zmluvy objedn&aacute;vateľ.</p>\n	<p style=\"margin-left: 18pt;\">\n		9.2 Objedn&aacute;vateľ obstar&aacute;va na vykonanie diela sadenice lesn&yacute;ch drev&iacute;n a&nbsp;prostriedky na ich o&scaron;etrenie pri umelej obnove lesa. Materi&aacute;l podľa&nbsp; bude objedn&aacute;vateľ odovzd&aacute;vať priebežne po odovzdan&iacute; miest na vykonanie pr&aacute;c, podľa skutočn&yacute;ch potrieb zhotoviteľa a&nbsp;na z&aacute;klade rozhodnutia zodpovedn&yacute;ch zamestnancov objedn&aacute;vateľa.</p>\n	<p style=\"margin-left: 18pt;\">\n		9.3 Za materi&aacute;l prevzat&yacute; od objedn&aacute;vateľa do doby skutočn&eacute;ho vykonania pr&aacute;c a&nbsp;ich prevzatia zodpovedn&yacute;m zamestnancom objedn&aacute;vateľa zodpoved&aacute; zhotoviteľ.</p>\n	<p style=\"margin-left: 18pt;\">\n		Po dokončen&iacute; diela je&nbsp; zhotoviteľ povinn&yacute; bez zbytočn&eacute;ho odkladu vr&aacute;tiť objedn&aacute;vateľovi materi&aacute;l vr&aacute;tane obalov, ktor&eacute; sa nespotrebovali pri vykon&aacute;van&iacute; diela.</p>\n	<p align=\"center\" style=\"margin-left: 18pt;\">\n		<strong>10. Vady diela</strong></p>\n	<p align=\"center\" style=\"margin-left: 18pt;\">\n		Zhotoviteľ zodpoved&aacute; za vady diela, ktor&eacute; m&aacute; v čase jeho odovzdania ako aj tie, ktor&eacute; sa vyskytn&uacute; po tomto čase ak boli sp&ocirc;soben&eacute; poru&scaron;en&iacute;m jeho povinnost&iacute;. Zhotoviteľ nezodpoved&aacute; za vady diela, ak tieto vady sp&ocirc;sobilo použitie materi&aacute;lu odovzdan&eacute;ho mu objedn&aacute;vateľom v&nbsp;pr&iacute;pade, že zhotoviteľ nevhodnosť tohto materi&aacute;lu nemohol zistiť alebo na ne objedn&aacute;vateľa upozornil a&nbsp;objedn&aacute;vateľ na ich použit&iacute; trval. Zhotoviteľ takisto nezodpoved&aacute; za vady sp&ocirc;soben&eacute; dodržan&iacute;m nevhodn&yacute;ch pokynov dan&yacute;ch mu objedn&aacute;vateľom, ak zhotoviteľ na nevhodnosť t&yacute;chto pokynov upozornil a&nbsp;objedn&aacute;vateľ na ich dodržan&iacute; trval alebo ak zhotoviteľ t&uacute;to nevhodnosť nemohol zistiť.</p>\n	<p style=\"margin-left: 18pt;\">\n		&nbsp;</p>\n	<p align=\"center\" style=\"margin-left: 18pt;\">\n		<strong>11. Cena diela</strong></p>\n	<p align=\"center\" style=\"margin-left: 18pt;\">\n		&nbsp;</p>\n	<p>\n		11.1&nbsp; Za jednotliv&eacute; druhy ukončen&yacute;ch pr&aacute;c zaplat&iacute; objedn&aacute;vateľ čiastku, ktor&uacute; urč&iacute; na z&aacute;klade ceny &nbsp;&nbsp;</p>\n	<p>\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uvedenej v&nbsp;pr&iacute;lohe č. 2 tejto zmluvy za mern&uacute; jednotku a&nbsp;počtu skutočne vykonan&yacute;ch mern&yacute;ch</p>\n	<p>\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; jednotiek, zhotoviteľom odovzdan&yacute;ch a&nbsp;objedn&aacute;vateľom prevzat&yacute;ch pr&aacute;c podľa bodu 7.</p>\n</div>\n<p>\n	11.2 Cena mus&iacute; zahŕňať v&scaron;etky ekonomicky opr&aacute;vnen&eacute; n&aacute;klady zhotoviteľa vynaložen&eacute; v&nbsp;s&uacute;vislosti s&nbsp;realiz&aacute;ciou služby. Cena &nbsp;je dohodnut&aacute; v eur&aacute;ch. K&nbsp;fakturovanej cene bude vždy pripoč&iacute;tan&aacute; DPH stanoven&aacute; v&nbsp;s&uacute;lade s&nbsp;pr&aacute;vnymi predpismi v&nbsp;čase poskytnutia služby.</p>\n<p>\n	11.3&nbsp; V&nbsp;pr&iacute;pade ak objedn&aacute;vateľ uložil zhotoviteľovi sankciu za vady zisten&eacute; pri preberan&iacute; pr&aacute;c, objedn&aacute;vateľ zaplat&iacute; za jednotliv&eacute; druhy ukončen&yacute;ch pr&aacute;c čiastku určen&uacute; podľa bodu 11.1. zn&iacute;žen&uacute; o&nbsp;v&yacute;&scaron;ku sankcie podľa bodu 17.</p>\n<h3 align=\"center\">\n	&nbsp;</h3>\n<div>\n	<p>\n		&nbsp;</p>\n</div>\n<p align=\"center\">\n	<strong>12. Sp&ocirc;sob a&nbsp;term&iacute;n platby</strong></p>\n<p>\n	12. 1 Zhotoviteľ vystav&iacute; objedn&aacute;vateľovi po ukončen&iacute; a&nbsp;prevzat&iacute; pr&aacute;c podľa bodu 7. fakt&uacute;ru na finančn&uacute; čiastku ods&uacute;hlasen&uacute; a&nbsp;potvrden&uacute; obidvoma stranami na podklade k&nbsp;faktur&aacute;cii (protokol o&nbsp;prevzat&iacute; pr&aacute;c a&nbsp;pracov&iacute;sk od dod&aacute;vateľa). Splatnosť fakt&uacute;ry najviac 15 dn&iacute; odo dňa, kedy objedn&aacute;vateľ obdrž&iacute; fakt&uacute;ru.</p>\n<h3 align=\"center\">\n	&nbsp;</h3>\n<div>\n	<p style=\"margin-left: 1cm;\">\n		12.2. V&nbsp;pr&iacute;pade, že zhotoviteľom je skupina dod&aacute;vateľov, zmluvn&eacute; strany sa dohodli, že objedn&aacute;vateľ je voči členom skupiny zo svojich z&aacute;v&auml;zkov prevzat&yacute;ch v&nbsp;tejto zmluve, najm&auml; z&aacute;v&auml;zku zaplatiť za vykonan&eacute; dielo včas dohodnut&uacute; cenu zaviazan&yacute; oddelene, t. j. každ&eacute;mu členovi skupiny dod&aacute;vateľov je povinn&yacute; zaplatiť len n&iacute;m skutočne vykonan&uacute; časť diela.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\n</div>\n<p align=\"center\">\n	<strong>13. Osobitn&eacute; požiadavky objedn&aacute;vateľa</strong></p>\n<p>\n	&nbsp;</p>\n<p>\n	Po ukončen&iacute; činnosti musia byť na pracovisk&aacute;ch použ&iacute;van&eacute; lesn&eacute; cesty a&nbsp;zv&aacute;žnice prejazdn&eacute; a&nbsp;chodn&iacute;ky priechodn&eacute;.</p>\n<p align=\"center\">\n	<strong>14. &Scaron;kody</strong></p>\n<p>\n	&nbsp;</p>\n<p>\n	Zhotoviteľ zodpoved&aacute; objedn&aacute;vateľovi a&nbsp;in&yacute;m osob&aacute;m za &scaron;kodu sp&ocirc;soben&uacute; poru&scaron;en&iacute;m povinnost&iacute; pri v&yacute;kone pr&aacute;c alebo činnosťou v&nbsp;priamej s&uacute;vislosti s&nbsp;ňou a&nbsp;zav&auml;zuje sa ju uhradiť po&scaron;koden&eacute;mu v&nbsp;plnej v&yacute;&scaron;ke.</p>\n<p align=\"center\">\n	<strong>15. Zodpovednosť za poru&scaron;enie zmluvy</strong></p>\n<p>\n	15.1&nbsp; Ak objedn&aacute;vateľ zist&iacute;, že zhotoviteľ vykon&aacute;va dielo v&nbsp;rozpore zo svojimi povinnosťami a&nbsp;pokynmi zodpovedn&yacute;ch zamestnancov objedn&aacute;vateľa, je objedn&aacute;vateľ opr&aacute;vnen&yacute; dožadovať sa toho, aby zhotoviteľ odstr&aacute;nil nedostatky vzniknut&eacute; vadn&yacute;m vykon&aacute;van&iacute;m a&nbsp;dielo vykon&aacute;val riadnym sp&ocirc;sobom. Ak tak zhotoviteľ diela neurob&iacute; ani v&nbsp;primeranej lehote na to poskytnutej a&nbsp;postup&nbsp; zhotoviteľa by viedol nepochybne k&nbsp; poru&scaron;eniu zmluvy, je objedn&aacute;vateľ opr&aacute;vnen&yacute; podľa z&aacute;važnosti poru&scaron;enia zmluvnej povinnosti odst&uacute;piť od zmluvy alebo uložiť zhotoviteľovi sankciu, ktorej v&yacute;&scaron;ku objedn&aacute;vateľ urč&iacute; na z&aacute;klade povahy a&nbsp;rozsahu poru&scaron;enia zmluvn&yacute;ch podmienok, maxim&aacute;lne v&scaron;ak do v&yacute;&scaron;ky 5 000 eur.</p>\n<h3 align=\"center\">\n	&nbsp;</h3>\n<div>\n	<p>\n		&nbsp;</p>\n</div>\n<p>\n	15.2 Zhotoviteľ nezodpoved&aacute; za poru&scaron;enie zmluvnej povinnosti, ak splneniu jeho povinnosti br&aacute;ni prek&aacute;žka, ktor&aacute; nastala nez&aacute;visle od jeho v&ocirc;le, ak nemožno rozumne predpokladať, že by&nbsp; t&uacute;to prek&aacute;žku alebo jej n&aacute;sledky odvr&aacute;til alebo prekonal, alebo, že by v&nbsp;čase podpisu tejto zmluvy t&uacute;to prek&aacute;žku predv&iacute;dal.</p>\n<p align=\"center\">\n	<strong>16. Sankcie</strong></p>\n<p>\n	16.1&nbsp; Objedn&aacute;vateľ m&ocirc;že uložiť zhotoviteľovi peňažn&uacute; sankciu za vadn&eacute; vykonanie pr&aacute;c, ak objedn&aacute;vateľ vykonan&eacute; pr&aacute;ce prevzal a vada zisten&aacute; pri preberan&iacute; pr&aacute;c z&aacute;važn&yacute;m sp&ocirc;sobom neovplyvňuje podstatu vykonan&eacute;ho diela alebo jeho čast&iacute;&nbsp; alebo ak zhotoviteľ poru&scaron;il ak&uacute;koľvek povinnosť, ku ktorej sa zaviazal podľa tejto zmluvy pri vykon&aacute;van&iacute; diela.</p>\n<h3 align=\"center\">\n	&nbsp;</h3>\n<div>\n	<p>\n		&nbsp;</p>\n</div>\n<p>\n	16.2 V&yacute;&scaron;ku sankcie urč&iacute; objedn&aacute;vateľ podľa povahy a&nbsp;rozsahu zisten&yacute;ch v&aacute;d alebo poru&scaron;enia zmluvn&yacute;ch podmienok. Zhotoviteľ sa zav&auml;zuje zn&aacute;&scaron;ať sankciu uložen&uacute; objedn&aacute;vateľom.</p>\n<h3 align=\"center\">\n	&nbsp;</h3>\n<div>\n	<p>\n		&nbsp;</p>\n	<p align=\"center\">\n		<strong>17. Odst&uacute;penie od zmluvy</strong></p>\n	<p>\n		17.1 Objedn&aacute;vateľ m&ocirc;že odst&uacute;piť od tejto zmluvy, a&nbsp;to aj len čiastočne</p>\n</div>\n<p>\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17.1.1 ak zhotoviteľ poru&scaron;il ak&uacute;koľvek povinnosť, ku ktorej sa zaviazal podľa tejto&nbsp; zmluvy</p>\n<p>\n	17.1.2 ak P&ocirc;dohospod&aacute;rska platobn&aacute; agent&uacute;ra neschv&aacute;li objedn&aacute;vateľom predložen&yacute; Projekt&nbsp;&nbsp;</p>\n<p>\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a neuzavrie s&nbsp;objedn&aacute;vateľom zmluvu o poskytnut&iacute; nen&aacute;vratn&eacute;ho finančn&eacute;ho&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\n<p>\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr&iacute;spevku.&nbsp;</p>\n<h3 align=\"center\">\n	&nbsp;</h3>\n<div>\n	<p>\n		17.2Odst&uacute;penie od r&aacute;mcovej zmluvy je &uacute;činn&eacute; dňom doručenia ozn&aacute;menia o&nbsp;odst&uacute;pen&iacute; od&nbsp;</p>\n	<p>\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r&aacute;mcovej zmluvy.&nbsp;&nbsp;</p>\n	<p>\n		17.3 Objedn&aacute;vateľ sa uch&aacute;dza o&nbsp;dot&aacute;ciu predložen&iacute;m projektu z&nbsp;Operačn&eacute;ho programu rozvoja vidieka SR 2007- 2013, n&aacute;zov opatrenia: 2.1 Obnova potenci&aacute;lu lesn&eacute;ho hospod&aacute;rstva a&nbsp;zavedenie prevent&iacute;vnych opatren&iacute;. Objedn&aacute;vateľ si vyhradzuje pr&aacute;vo odst&uacute;piť od zmluvy v&nbsp;pr&iacute;pade, ak&nbsp; uveden&yacute; projekt nebude &uacute;spe&scaron;n&yacute; a&nbsp;ned&ocirc;jde k&nbsp;uzavretiu zmluvy o&nbsp;poskytnut&iacute; nen&aacute;vratn&eacute;ho finančn&eacute;ho pr&iacute;spevku. Objedn&aacute;vateľ o&nbsp;tom&nbsp; p&iacute;somne obozn&aacute;mi zhotoviteľa.</p>\n	<p align=\"left\" style=\"margin-left: 27pt;\">\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 18. V&yacute;poveď r&aacute;mcovej dohody</p>\n	<p align=\"left\">\n		&nbsp;</p>\n	<p>\n		V&yacute;povedn&aacute; lehota je dvojmesačn&aacute;. Zač&iacute;na plyn&uacute;ť prv&yacute;m dňom mesiaca nasleduj&uacute;com po mesiaci, v&nbsp;ktorom bola v&yacute;poveď doručen&aacute;. V&nbsp;pr&iacute;pade, že zhotoviteľom je skupina, je v&yacute;poveď platn&aacute;, len ak je podp&iacute;san&aacute; v&scaron;etk&yacute;mi členmi skupiny, ktor&iacute; podp&iacute;sali r&aacute;mcov&uacute; zmluvu.</p>\n	<p align=\"left\" style=\"margin-left: 27pt;\">\n		&nbsp;&nbsp;</p>\n</div>\n<p align=\"center\">\n	<strong>19. Z&aacute;verečn&eacute; ustanovenia</strong></p>\n<p>\n	19.1 T&aacute;to zmluva nadob&uacute;da platnosť a&nbsp;&uacute;činnosť dňom podpisu oboma zmluvn&yacute;mi stranami. Zmluvn&yacute; vzťah založen&yacute; touto zmluvou sa bude riadiť počas celej doby trvania z&aacute;v&auml;zkov z&nbsp;nej vypl&yacute;vaj&uacute;cich pr&iacute;slu&scaron;n&yacute;mi ustanoveniami Obchodn&eacute;ho z&aacute;konn&iacute;ka (z&aacute;k. č. 513/1991 Zb. v&nbsp;znen&iacute; neskor&scaron;&iacute;ch predpisov).</p>\n<h3 align=\"center\">\n	&nbsp;</h3>\n<div>\n	<p>\n		&nbsp;</p>\n	<p style=\"margin-left: 1cm;\">\n		19.2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; T&aacute;to zmluva nadob&uacute;da platnosť dňom jej podpisu oboma zmluvn&yacute;mi stranami a&nbsp;&uacute;činnosť&nbsp;&nbsp;&nbsp;</p>\n	<p style=\"margin-left: 19.2pt;\">\n		&nbsp; dňom nasleduj&uacute;cim po zverejnen&iacute; inform&aacute;cie o&nbsp;uzavret&iacute; zmluvy na <a href=\"http://www.lesypoprad.sk/\">www.lesypoprad.sk</a>. &nbsp;&nbsp;</p>\n	<p style=\"margin-left: 19.2pt;\">\n		&nbsp; Zhotoviteľ berie na vedomie, že&nbsp; objedn&aacute;vateľ je povinnou osobou v&nbsp;zmysle z&aacute;k. č. &nbsp;&nbsp;&nbsp;&nbsp;</p>\n	<p style=\"margin-left: 19.2pt;\">\n		&nbsp; 211/2000 Z. z. o&nbsp;slobodnom pr&iacute;stupe k&nbsp;inform&aacute;ci&aacute;m v&nbsp;platnom znen&iacute; a&nbsp;s&uacute;hlas&iacute; so &nbsp;&nbsp;&nbsp;&nbsp;</p>\n	<p style=\"margin-left: 19.2pt;\">\n		&nbsp; zverejnen&iacute;m inform&aacute;cie o&nbsp;uzavret&iacute; zmluvy a&nbsp;s&nbsp;jej spr&iacute;stupnen&iacute;m na žiadosť tret&iacute;ch os&ocirc;b.</p>\n	<p style=\"margin-left: 19.2pt;\">\n		&nbsp;</p>\n	<p style=\"margin-left: 21.3pt;\">\n		19.3 T&uacute;to zmluvu je možn&eacute; meniť alebo dopĺňať len na z&aacute;klade vz&aacute;jomnej dohody oboch zmluvn&yacute;ch str&aacute;n, pričom ak&eacute;koľvek zmeny a&nbsp;doplnky musia byť vykonan&eacute; vo forme p&iacute;somn&eacute;ho dodatku k&nbsp;zmluve.</p>\n</div>\n<p>\n	19.4 &nbsp;V&nbsp;pr&iacute;pade, ak sa ak&eacute;koľvek ustanovenie tejto zmluvy stane neplatn&yacute;m v&nbsp;d&ocirc;sledku jeho rozporu s&nbsp;platn&yacute;m pr&aacute;vnym poriadkom, zmluvn&eacute; strany sa zav&auml;zuj&uacute; vz&aacute;jomn&yacute;m rokovan&iacute;m nahradiť neplatn&eacute; zmluvn&eacute; ustanovenie nov&yacute;m platn&yacute;m ustanoven&iacute;m tak, aby ostal zachovan&yacute; obsah a&nbsp;&uacute;čel sledovan&yacute; zmluvou.</p>\n<h3 align=\"center\">\n	&nbsp;</h3>\n<div>\n	<p>\n		V ..............................., dňa .......................&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; V ..............................., dňa .......................&nbsp;</p>\n	<p>\n		&nbsp;</p>\n	<p>\n		&nbsp;</p>\n	<p>\n		Objedn&aacute;vateľ: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Zhotoviteľ:</p>\n	<p>\n		&nbsp;</p>\n	<p>\n		Ing. R&oacute;bert Dula&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; ...................................................</p>\n	<p>\n		&nbsp;&nbsp; konateľ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\n	<p>\n		&nbsp;</p>\n	<p>\n		&nbsp;</p>\n	<table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"width:100.06%;\" width=\"100%\">\n		<tbody>\n			<tr>\n				<td colspan=\"8\" style=\"width:100.0%;\">\n					<p>\n						Objedn&aacute;vateľ: Mestsk&eacute; lesy, s.r.o. Poprad&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>Pr&aacute;ce v&nbsp;pestovnej a&nbsp;ostatnej lesnej činnosti</strong></p>\n				</td>\n			</tr>\n			<tr>\n				<td colspan=\"8\" style=\"width:100.0%;\">\n					<p align=\"center\">\n						&nbsp;</p>\n					<p align=\"center\">\n						<strong>TECHNOLOGICK&Yacute; PROTOKOL</strong></p>\n					<p align=\"center\">\n						<strong>odovzdanie pracoviska dod&aacute;vateľovi</strong></p>\n					<p>\n						&nbsp;</p>\n					<p>\n						Zhotoviteľ pr&aacute;ce - dod&aacute;vateľ:</p>\n				</td>\n			</tr>\n			<tr>\n				<td colspan=\"8\" style=\"width:100.0%;\">\n					<p>\n						&nbsp;N&aacute;zov (skupina):&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Zmluva č.:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\n					<p>\n						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\n					<p>\n						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; zo dňa:</p>\n				</td>\n			</tr>\n			<tr>\n				<td colspan=\"8\" style=\"width:100.0%;\">\n					<p>\n						&nbsp;</p>\n					<p>\n						Miesto v&yacute;konu pr&aacute;ce:</p>\n				</td>\n			</tr>\n			<tr>\n				<td style=\"width:6.38%;height:29px;\">\n					<p align=\"center\">\n						LS</p>\n				</td>\n				<td style=\"width:7.08%;height:29px;\">\n					<p>\n						&nbsp;</p>\n				</td>\n				<td style=\"width:7.08%;height:29px;\">\n					<p align=\"center\">\n						LO</p>\n				</td>\n				<td style=\"width:7.08%;height:29px;\">\n					<p>\n						&nbsp;</p>\n				</td>\n				<td colspan=\"2\" style=\"width:8.92%;height:29px;\">\n					<p align=\"center\">\n						JPRL</p>\n				</td>\n				<td colspan=\"2\" style=\"width:63.44%;height:29px;\">\n					<p>\n						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\n				</td>\n			</tr>\n			<tr>\n				<td colspan=\"8\" style=\"width:100.0%;\">\n					<p>\n						&nbsp;</p>\n					<p>\n						Technol&oacute;gia vykonania pr&aacute;c &nbsp;jej&nbsp; &scaron;pecifick&eacute; podmienky:</p>\n				</td>\n			</tr>\n			<tr>\n				<td colspan=\"8\" style=\"width:100.0%;\">\n					<p>\n						<strong>Obnova lesa: prv&eacute; zalesňovanie </strong><strong>&nbsp;, opakovan&eacute; zalesňovanie </strong><strong>&nbsp;, podsadba </strong></p>\n					<p>\n						<strong>Čistenie pl&ocirc;ch po ťažbe:&nbsp; s p&aacute;len&iacute;m </strong><strong>&nbsp;, bez p&aacute;lenia </strong><strong>&nbsp;,</strong><strong> mechanizovane </strong></p>\n					<p>\n						<strong>Ochrana MLP proti burine: ručne </strong><strong>,</strong><strong> chemicky </strong><strong>&nbsp;, </strong><strong>&nbsp;krovinorezom&nbsp; </strong></p>\n					<p>\n						<strong>Ochrana MLP proti zveri:&nbsp; mechanick&aacute; </strong><strong>&nbsp;chemick&aacute; </strong><strong>&nbsp;, o</strong><strong>plocovan&iacute;m </strong></p>\n					<p>\n						<strong>Pleci rub a v&yacute;sek krov </strong><strong>&nbsp;, </strong><strong>Prečistky- prerez&aacute;vky:&nbsp; s rozčleňovan&iacute;m </strong><strong>,</strong><strong> bez rozčleňovania</strong></p>\n					<p>\n						<strong>In&eacute; </strong><strong>&nbsp;:</strong></p>\n					<p>\n						&nbsp;priemern&yacute; sklon&nbsp;&nbsp;&nbsp; ...&nbsp;&nbsp; %&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chr&aacute;nen&eacute; &uacute;zemie, v&yacute;skyt vz&aacute;cnych druhov</p>\n					<p>\n						hust&yacute; bylinn&yacute; podrast, trnit&eacute; krovie&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &uacute;zemie PHO, vodn&eacute; zdroje</p>\n					<p>\n						kamenist&yacute; povrch, v&yacute;skyt balvanov&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; produktovody (elektrovody, telef.vedenie&nbsp; a pod.)</p>\n					<p>\n						v&yacute;skyt such&yacute;ch, nahnit&yacute;ch stromov&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; verejn&aacute; komunik&aacute;cia (cesta, chodn&iacute;k, most)</p>\n					<p>\n						v&yacute;skyt zlomov, polomov a&nbsp;v&yacute;vratov&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; možn&yacute; pohyb verejnosti po pracovisku</p>\n					<p>\n						v&yacute;skyt jarkov, bar&iacute;n, zamokren&yacute;ch miest&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; maxim&aacute;lne pr&iacute;pustn&eacute; po&scaron;kodenie ost&aacute;vaj&uacute;cich stromov v poraste&nbsp;&nbsp; ...&nbsp; %</p>\n					<p>\n						v&yacute;skyt prirodzen&eacute;ho zmladenia&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; pr&iacute;pustn&eacute; po&scaron;kodenie prirodzen&eacute;ho zmladenia&nbsp; ...&nbsp; %</p>\n					<p>\n						použitie chemick&yacute;ch pr&iacute;pravkov&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;určen&eacute; skladovanie PHM, odpadov &nbsp;</p>\n				</td>\n			</tr>\n			<tr>\n				<td colspan=\"8\" style=\"width:100.0%;\">\n					<p>\n						určen&eacute; vyznačenie a hranice pracoviska&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; potvrden&eacute; z&aacute;sady OBP, PO a&nbsp;použ&iacute;vania OOPP</p>\n					<p>\n						in&eacute;:</p>\n				</td>\n			</tr>\n			<tr>\n				<td colspan=\"8\" style=\"width:100.0%;height:13px;\">\n					<p style=\"margin-left: 0.8pt;\">\n						&nbsp;</p>\n					<p style=\"margin-left: 0.8pt;\">\n						Technologick&yacute; n&aacute;kres a popis:</p>\n				</td>\n			</tr>\n			<tr>\n				<td colspan=\"8\" style=\"width:100.0%;height:151px;\">\n					<p align=\"right\">\n						&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Mierka:&nbsp; 1 :</p>\n				</td>\n			</tr>\n			<tr>\n				<td colspan=\"8\" style=\"width:100.0%;\">\n					<p>\n						&nbsp;</p>\n					<p>\n						Doplňuj&uacute;ce&nbsp; &uacute;daje:</p>\n				</td>\n			</tr>\n			<tr>\n				<td colspan=\"8\" style=\"width:100.0%;height:58px;\">\n					<p>\n						Tiesňov&eacute; volanie:112&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Najbliž&scaron;ia nemocnica:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;Prostriedky prvej pomoci</p>\n					<p>\n						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;N&aacute;stroje na asan&aacute;ciu znečistenia</p>\n					<p>\n						In&eacute;:</p>\n				</td>\n			</tr>\n			<tr>\n				<td colspan=\"8\" style=\"width:100.0%;\">\n					<p align=\"center\">\n						&nbsp;</p>\n					<p>\n						Objedn&aacute;vateľ odovzd&aacute;va pracovisko uveden&eacute; v&nbsp;tomto protokole dod&aacute;vateľovi pr&aacute;c za &uacute;čelom vykonania pr&aacute;c dohodnut&yacute;ch v&nbsp;zmluve. Dod&aacute;vateľ pr&aacute;c bol obozn&aacute;men&yacute; s&nbsp;podmienkami pre v&yacute;kon pr&aacute;c a&nbsp;prehlasuje, že zabezpeč&iacute; ich dodržanie. Dod&aacute;vateľ vykon&aacute; v&scaron;etky pr&aacute;ce na vlastn&eacute; n&aacute;klady a&nbsp;nebezpečenstvo.</p>\n					<p>\n						Predpokladan&eacute; ukončenie pr&aacute;c (mesiac/rok):&nbsp; ............ /201..</p>\n				</td>\n			</tr>\n			<tr>\n				<td colspan=\"5\" style=\"width:33.34%;height:84px;\">\n					<p>\n						&nbsp;D&aacute;tum začatia pr&aacute;c:&nbsp;&nbsp;&nbsp;&nbsp;</p>\n					<p>\n						&nbsp;</p>\n					<p>\n						&nbsp;</p>\n					<p>\n						&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p>\n				</td>\n				<td colspan=\"2\" style=\"width:33.32%;height:84px;\">\n					<p>\n						Dod&aacute;vateľ:</p>\n					<p>\n						&nbsp;</p>\n					<p>\n						&nbsp;</p>\n					<p>\n						&nbsp;</p>\n					<p>\n						&nbsp;</p>\n				</td>\n				<td style=\"width:33.34%;height:84px;\">\n					<p>\n						Objedn&aacute;vateľ:</p>\n					<p>\n						&nbsp;</p>\n					<p>\n						&nbsp;</p>\n					<p>\n						Ved&uacute;ci LO:</p>\n					<p>\n						&nbsp;</p>\n					<p>\n						Riaditeľ ML:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\n				</td>\n			</tr>\n			<tr height=\"0\">\n				<td>\n					<p>\n						&nbsp;</p>\n				</td>\n				<td>\n					<p>\n						&nbsp;</p>\n				</td>\n				<td>\n					<p>\n						&nbsp;</p>\n				</td>\n				<td>\n					<p>\n						&nbsp;</p>\n				</td>\n				<td>\n					<p>\n						&nbsp;</p>\n				</td>\n				<td>\n					<p>\n						&nbsp;</p>\n				</td>\n				<td>\n					<p>\n						&nbsp;</p>\n				</td>\n				<td>\n					<p>\n						&nbsp;</p>\n				</td>\n			</tr>\n		</tbody>\n	</table>\n	<p style=\"margin-left: 283.2pt;\">\n		&nbsp;</p>\n	<table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"width:100.06%;\" width=\"100%\">\n		<tbody>\n			<tr>\n				<td colspan=\"8\" style=\"width:100.0%;\">\n					<p>\n						Objedn&aacute;vateľ: Mestsk&eacute; lesy, s.r.o. Poprad&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>Pr&aacute;ce v&nbsp;pestovnej a&nbsp;ostatnej lesnej činnosti</strong></p>\n				</td>\n			</tr>\n			<tr>\n				<td colspan=\"8\" style=\"width:100.0%;\">\n					<p align=\"center\">\n						<strong>PROTOKOL</strong></p>\n					<p align=\"center\">\n						<strong>o prevzat&amp;iacu</strong></p>\n				</td>\n			</tr>\n		</tbody>\n	</table>\n</div>\n<p>\n	&nbsp;</p>\n',	NULL),
(11,	1,	'<h3 align=\"center\">\n	Oznámenie o zadávaní zákazky</h3>\n<p>\n	v rámci postupu verejného obstarávania podľa § 9 ods. 9 zákona č. 25/2006 Z. z. o verejnom obstarávaní a o zmene a doplnení niektorých zákonov v znení neskorších predpisov.</p>\n<p>\n	 </p>\n<p style=\"margin-left:21.3pt;\">\n	1.        <strong>Identifikácia verejného obstarávateľa:</strong></p>\n<p>\n	Názov:                  Mestské lesy, s.r.o. Poprad                            </p>\n<p>\n	Štatutárny orgán:   Ing. Róbert Dula</p>\n<p>\n	Sídlo:                    Levočská 3312/37, 058 01 Poprad                           </p>\n<p>\n	IČO:                     36448311</p>\n<p>\n	       DIČ:                     2020017175</p>\n<p>\n	       IČ DPH:               SK 2020017175</p>\n<p>\n	                                              </p>\n<p>\n	Kontaktná osoba pre verejné obstarávanie: Ing. Dula</p>\n<p>\n	Telefón: 0910890440</p>\n<p>\n	Pracovný kontakt pre vysvetlenie oznámenia o zadávaní zákazky:</p>\n<p>\n	lesypp@stonline.sk</p>\n<p style=\"margin-left:18.0pt;\">\n	2.        <strong>Názov predmetu zákazky: Sadenice lesných drevín</strong></p>\n<p style=\"margin-left:18.0pt;\">\n	Zákazka (zmluva) je na: dodanie tovaru</p>\n<p style=\"margin-left:18.0pt;\">\n	3.        <strong>Podrobný opis predmetu zákazky: </strong></p>\n<p style=\"margin-left:18.0pt;\">\n	 </p>\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"width:100.0%;\" width=\"100%\">\n	<tbody>\n		<tr>\n			<td style=\"width:45px;\">\n				<p>\n					 </p>\n			</td>\n			<td>\n				<p>\n					Verejný obstarávateľ má záujem o tovar spĺňajúci nasledujúce požiadavky:</p>\n				<p>\n					 </p>\n				<p>\n					<u>Požiadavky na semenársku oblasť  a výškový prenos :</u></p>\n				<p>\n					Semenárska oblasť   podľa vyhlášky č. 501/2010 Z. z.  o produkcii lesného reprodukčného materiálu a jeho uvádzaní na trh</p>\n				<p>\n					<strong>Buk lesný</strong></p>\n				<p style=\"margin-left:36.0pt;\">\n					1-Stredoslovenská  :   počet sadeníc pre lesný vegetačný stupeň  4  =  6860 ks</p>\n				<p>\n					                                            počet sadeníc pre lesný vegetačný stupeň  5  = 22390 ks</p>\n				<p>\n					<strong>Smrekovec opadavý</strong></p>\n				<p style=\"margin-left:36.0pt;\">\n					2-Podtatranská  :   počet sadeníc pre lesný vegetačný stupeň  4  =  2820 ks</p>\n				<p>\n					                                            počet sadeníc pre lesný vegetačný stupeň  5  = 12920 ks</p>\n				<p>\n					<strong>Borovica lesná</strong></p>\n				<p style=\"margin-left:36.0pt;\">\n					1-Severoslovenská  :   počet sadeníc pre lesný vegetačný stupeň  4  =  7090 ks</p>\n				<p>\n					                                            počet sadeníc pre lesný vegetačný stupeň  5  = 20210 ks</p>\n				<p>\n					<strong>Dub zimný</strong></p>\n				<p style=\"margin-left:36.0pt;\">\n					4-Mimo územie oblastí:  počet sadeníc pre lesný vegetačný stupeň  4  =  2770 ks</p>\n				<p>\n					                                        </p>\n				<p>\n					Vek sadeníc = min. 1 rok</p>\n				<p>\n					<strong>Spôsob pestovania = krytokorenné</strong><br />\n					 </p>\n				<p>\n					<u>Požiadavky na kvalitu sadbového materiálu:</u><br />\n					Výška nadzemnej časti sc 15+ cm, bo 10+ cm, bk 15+ cm, db 15+ cm.<br />\n					Iné požiadavky na kvalitu - v súlade s technickou normou STN 482211 Pestovanie lesov. Semenáčiky a sadenice lesných drevín.</p>\n			</td>\n		</tr>\n	</tbody>\n</table>\n<p>\n	 </p>\n<p style=\"margin-left:18.0pt;\">\n	4.      <strong>Predpokladaná hodnota zákazky (bez DPH):  15 763 €</strong></p>\n<p style=\"margin-left:18.0pt;\">\n	 </p>\n<p style=\"margin-left:18.0pt;\">\n	5.      <strong>Základné zmluvné podmienky: </strong></p>\n<p>\n	-         Miesto dodania tovaru: sídlo predávajúceho,  verejný obstarávateľ si zabezpečí prepravu tovaru na vlastné náklady</p>\n<p>\n	-         Lehota na dodanie predmetu zákazky:</p>\n<p>\n	Rok 2014: cca 15. apríl 2014 prípadne dohodou podľa priebehu jarného počasia</p>\n<p>\n	 bo 27300 ks, sc 15740 ks</p>\n<p>\n	Rok 2015: cca 15. apríl 2015, prípadne dohodou poľa priebehu jarného počasia</p>\n<p>\n	Bk 29250 ks, db 2770 ks.</p>\n<p>\n	-         Splatnosť faktúr: 21 dní od doručenia faktúry.</p>\n<p style=\"margin-left:18.0pt;\">\n	6.      <strong>Lehota na predkladanie dokladov a  ponúk  : do 31.1.2014,  11.00 h.</strong></p>\n<p>\n	 </p>\n<p style=\"margin-left:18.0pt;\">\n	7.      <strong>Stanovenie ceny</strong></p>\n<p>\n	-         Cenu je potrebné spracovať na základe požadovaného rozsahu a požadovanej kvality a ďalších požiadaviek uvedených podľa oznámenia o zadávaní zákazky (ďalej len „oznámenia“). Cenu je potrebné uvádzať v eurách (€) bez DPH.  Ak uchádzač nie je platcom DPH, uvedie túto skutočnosť v ponuke.</p>\n<p style=\"margin-left:18.0pt;\">\n	8.      <strong>Postup vo verejnom obstarávaní: </strong>je jednoetapový.</p>\n<p style=\"margin-left:18.0pt;\">\n	9.      <strong>Verejný obstarávateľ nepripúšťa rozdelenie zákazky, </strong>t.j. uchádzač predloží ponuku na celý predmet zákazky.</p>\n<p style=\"margin-left:18.0pt;\">\n	10.  <strong>Predkladanie dokladov a ponuky:</strong></p>\n<p>\n	a)      <strong>Pri jednoetapovom postupe:</strong></p>\n<p>\n	Ponuku je potrebné doplniť do Kúpnej zmluvy – príloha č. 1. a <strong><u>poslať v troch rovnopisoch</u></strong>  výlučne na adresu sídla spoločnosti podľa bodu 1. v uzatvorenej obálke s uvedením <strong>názvu zákazky,</strong> s označením – <strong>NEOTVÁRAŤ</strong>“ na adresu sídla spoločnosti uvedenú v bode 1. Ponuky sa predkladajú v slovenskom jazyku. Ponuku uchádzač zašle spolu s  dokladmi, ak sú požadované. Ponuky zaslané po termíne,  v inom jazyku, alebo ak doklady nebudú predložené podľa požiadaviek verejného obstarávateľa alebo uchádzač nebude spĺňať podmienky účasti alebo nebude spĺňať požiadavky na predmet zákazky podľa oznámenia o zadávaní zákazky, takéto ponuky nebudú brané do úvahy a nebudú vyhodnocované.</p>\n<p style=\"margin-left:18.0pt;\">\n	11.  <strong>Podmienky účasti sú nasledovné <em>(ak sú vyžadované)</em>:</strong></p>\n<p>\n	-         V ponuke je potrebné predložiť:</p>\n<p>\n	<u>Doklady</u>: </p>\n<p style=\"margin-left:54.0pt;\">\n	1.      Kópiu oprávnenia na dodanie tovaru (výpis z OR, živnostenský list)</p>\n<p style=\"margin-left:54.0pt;\">\n	2.      Kópiu osvedčenia o odbornej spôsobilosti na činnosť s lesným reprodukčným materiálom podľa § 17 zák. č. 138/2010 Z. z.</p>\n<p style=\"margin-left:54.0pt;\">\n	3.      Kópiu listu o pôvode reprodukčného materiálu.</p>\n<p style=\"margin-left:54.0pt;\">\n	 </p>\n<p style=\"margin-left:54.0pt;\">\n	12.  <strong>Kritéria</strong> na hodnotenie ponúk sú: 1. cena.</p>\n<p style=\"margin-left:18.0pt;\">\n	13.  Spôsob hodnotenia kritériá  je nasledovný: Úspešným uchádzačom bude ten, kto bude mať najnižšiu celkovú cenu za celý predmet zákazky a splní všetky   požiadavky uvedené v opise predmetu zákazky.</p>\n<p style=\"margin-left:18.0pt;\">\n	14.  <strong>Prijatie ponuky:</strong></p>\n<p style=\"margin-left:18.0pt;\">\n	S úspešný uchádzačom bude uzatvorená zmluva, ktorá je prílohou tohto oznámenia.  </p>\n<p>\n	 </p>\n<p style=\"margin-left:18.0pt;\">\n	15.  Verejný obstarávateľ môže pred podpisom zmluvy požiadať úspešného uchádzača o predloženie originálu alebo overenej kópie oprávnenia  na dodanie tovaru, prípadne ďalších požadovaných dokladov podľa oznámenia, ak boli predložené iba fotokópie dokladov.</p>\n<p>\n	 </p>\n<p style=\"margin-left:283.2pt;\">\n	...................................................</p>\n<p>\n	                                                                                                          Ing. Róbert Dula</p>\n<p>\n	                                                                                                              konateľ</p>\n<p>\n	 </p>\n<p>\n	<em><u>Prílohy:</u> </em></p>\n<p style=\"margin-left:72.0pt;\">\n	1.      Kúpna zmluva</p>\n<p style=\"margin-left:54.0pt;\">\n	 </p>\n<p align=\"center\">\n	<strong>K Ú P N A    Z M L U V A</strong></p>\n<p align=\"center\">\n	Č.:  </p>\n<p align=\"center\">\n	uzatvorená podľa § 409 a nasl. zákona č. 513/91 Zb. – Obchodný zákonník v znení neskorších predpisov</p>\n<p align=\"center\">\n	m e d z i</p>\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n	<tbody>\n		<tr>\n			<td style=\"width:319px;\">\n				<p style=\"margin-left:14.2pt;\">\n					KUPUJÚCI</p>\n			</td>\n			<td style=\"width:295px;\">\n				<p style=\"margin-left:8.8pt;\">\n					 </p>\n			</td>\n		</tr>\n		<tr>\n			<td style=\"width:319px;\">\n				<p style=\"margin-left:14.2pt;\">\n					Mestské lesy, s.r.o. Poprad</p>\n			</td>\n			<td style=\"width:295px;\">\n				<p style=\"margin-left:8.8pt;\">\n					 </p>\n			</td>\n		</tr>\n		<tr>\n			<td style=\"width:319px;\">\n				<p style=\"margin-left:14.2pt;\">\n					Levočská 3312/37</p>\n			</td>\n			<td style=\"width:295px;\">\n				<p style=\"margin-left:8.8pt;\">\n					 </p>\n			</td>\n		</tr>\n		<tr>\n			<td style=\"width:319px;\">\n				<p style=\"margin-left:14.2pt;\">\n					058 01 Poprad</p>\n			</td>\n			<td style=\"width:295px;\">\n				<p style=\"margin-left:8.8pt;\">\n					 </p>\n			</td>\n		</tr>\n		<tr>\n			<td style=\"width:319px;\">\n				<p style=\"margin-left:14.2pt;\">\n					 </p>\n			</td>\n			<td style=\"width:295px;\">\n				<p style=\"margin-left:8.8pt;\">\n					 </p>\n			</td>\n		</tr>\n		<tr>\n			<td style=\"width:319px;\">\n				<p style=\"margin-left:14.2pt;\">\n					V zastúpení: Ing. Róbert Dula</p>\n			</td>\n			<td style=\"width:295px;\">\n				<p style=\"margin-left:8.8pt;\">\n					 </p>\n			</td>\n		</tr>\n		<tr>\n			<td style=\"width:319px;\">\n				<p style=\"margin-left:14.2pt;\">\n					Konateľ spoločnosti</p>\n			</td>\n			<td style=\"width:295px;\">\n				<p style=\"margin-left:8.8pt;\">\n					 </p>\n			</td>\n		</tr>\n		<tr>\n			<td style=\"width:319px;\">\n				<p style=\"margin-left:14.2pt;\">\n					Osoba oprávnená konať vo veci zákazky</p>\n			</td>\n			<td style=\"width:295px;\">\n				<p style=\"margin-left:8.8pt;\">\n					 </p>\n			</td>\n		</tr>\n		<tr>\n			<td style=\"width:319px;\">\n				<p style=\"margin-left:14.2pt;\">\n					IČO: 36 448 311</p>\n			</td>\n			<td style=\"width:295px;\">\n				<p style=\"margin-left:8.8pt;\">\n					 </p>\n			</td>\n		</tr>\n		<tr>\n			<td style=\"width:319px;\">\n				<p style=\"margin-left:14.2pt;\">\n					DIČ: 2020017175</p>\n			</td>\n			<td style=\"width:295px;\">\n				<p style=\"margin-left:8.8pt;\">\n					 </p>\n			</td>\n		</tr>\n		<tr>\n			<td style=\"width:319px;\">\n				<p style=\"margin-left:14.2pt;\">\n					IČ DPH: SK2020017175</p>\n			</td>\n			<td style=\"width:295px;\">\n				<p style=\"margin-left:8.8pt;\">\n					 </p>\n			</td>\n		</tr>\n		<tr>\n			<td style=\"width:319px;\">\n				<p style=\"margin-left:14.2pt;\">\n					Č. ú.:  4310021809/3100</p>\n			</td>\n			<td style=\"width:295px;\">\n				<p style=\"margin-left:8.8pt;\">\n					 </p>\n			</td>\n		</tr>\n		<tr>\n			<td style=\"width:319px;\">\n				<p style=\"margin-left:14.2pt;\">\n					Peň. ústav: Sberbank, a.s.</p>\n			</td>\n			<td style=\"width:295px;\">\n				<p style=\"margin-left:8.8pt;\">\n					 </p>\n			</td>\n		</tr>\n	</tbody>\n</table>\n<p>\n	 </p>\n<p>\n	 </p>\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n	<tbody>\n		<tr>\n			<td style=\"width:295px;\">\n				<p style=\"margin-left:8.8pt;\">\n					PREDÁVAJÚCI</p>\n			</td>\n		</tr>\n		<tr>\n			<td style=\"width:295px;\">\n				<p style=\"margin-left:8.8pt;\">\n					Obchodné meno :</p>\n			</td>\n		</tr>\n		<tr>\n			<td style=\"width:295px;\">\n				<p style=\"margin-left:8.8pt;\">\n					Sídlo:</p>\n			</td>\n		</tr>\n		<tr>\n			<td style=\"width:295px;\">\n				<p style=\"margin-left:8.8pt;\">\n					V zastúpení:</p>\n			</td>\n		</tr>\n		<tr>\n			<td style=\"width:295px;\">\n				<p style=\"margin-left:8.8pt;\">\n					Kontaktný e-mail</p>\n			</td>\n		</tr>\n		<tr>\n			<td style=\"width:295px;\">\n				<p>\n					 </p>\n			</td>\n		</tr>\n		<tr>\n			<td style=\"width:295px;\">\n				<p style=\"margin-left:8.8pt;\">\n					IČO:</p>\n			</td>\n		</tr>\n		<tr>\n			<td style=\"width:295px;\">\n				<p style=\"margin-left:8.8pt;\">\n					DIČ:</p>\n			</td>\n		</tr>\n		<tr>\n			<td style=\"width:295px;\">\n				<p style=\"margin-left:8.8pt;\">\n					IČ pre DPH:</p>\n			</td>\n		</tr>\n		<tr>\n			<td style=\"width:295px;\">\n				<p style=\"margin-left:8.8pt;\">\n					Č. ú.: </p>\n			</td>\n		</tr>\n		<tr>\n			<td style=\"width:295px;\">\n				<p style=\"margin-left:8.8pt;\">\n					Peň. ústav:</p>\n			</td>\n		</tr>\n	</tbody>\n</table>\n<p align=\"center\">\n	Za nasledovných podmienok :</p>\n<p align=\"center\">\n	<strong>I.</strong></p>\n<p align=\"center\">\n	<strong>PREDMET ZMLUVY</strong></p>\n<p>\n	1.Predávajúci sa zaväzuje na základe zmluvy dodať v nižšie dohodnutom množstve, kvalite a čase   predmet zmluvy a kupujúci sa zaväzuje tento prevziať a uhradiť kúpnu cenu.</p>\n<p>\n	 </p>\n<p style=\"margin-left:72.0pt;\">\n	<strong>2.     </strong><strong>Dodávka tovaru pre rok 2014</strong></p>\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"width:100.0%;\" width=\"100%\">\n	<tbody>\n		<tr>\n			<td style=\"width:12.02%;height:28px;\">\n				<p align=\"center\">\n					<strong>Druh dreviny</strong></p>\n				<p>\n					 </p>\n			</td>\n			<td style=\"width:11.68%;height:28px;\">\n				<p align=\"center\">\n					<strong>Množstvo</strong></p>\n				<p align=\"center\">\n					<strong>( ks )</strong></p>\n			</td>\n			<td style=\"width:39.14%;height:28px;\">\n				<p align=\"center\">\n					<strong>Spôsob pestovania, výška a iné rozmery</strong></p>\n			</td>\n			<td style=\"width:18.06%;height:28px;\">\n				<p>\n					<strong>Pôvod (sem. oblasť, výšk. zóna)</strong></p>\n				<p align=\"center\" style=\"margin-left:5.05pt;\">\n					 </p>\n			</td>\n			<td style=\"width:19.1%;height:28px;\">\n				<p>\n					<strong>Vek sadeníc</strong></p>\n			</td>\n		</tr>\n		<tr>\n			<td style=\"width:12.02%;\">\n				<p>\n					Smrekovec opadavý</p>\n				<p>\n					 </p>\n			</td>\n			<td style=\"width:11.68%;\">\n				<p align=\"center\">\n					15740</p>\n			</td>\n			<td style=\"width:39.14%;\">\n				<p>\n					Obaľované, výška <u>nč  15+ cm</u></p>\n			</td>\n			<td style=\"width:18.06%;\">\n				<p style=\"margin-left:5.05pt;\">\n					sem. oblasť podtatranská, výšk. zóna 4 alebo 5</p>\n			</td>\n			<td style=\"width:19.1%;\">\n				<p style=\"margin-left:5.05pt;\">\n					min. 1 - rok</p>\n			</td>\n		</tr>\n		<tr>\n			<td style=\"width:12.02%;height:52px;\">\n				<p>\n					Borovica lesná</p>\n				<p>\n					 </p>\n			</td>\n			<td style=\"width:11.68%;height:52px;\">\n				<p align=\"center\">\n					27300</p>\n			</td>\n			<td style=\"width:39.14%;height:52px;\">\n				<p>\n					Obaľované, výška <u>nč  10+</u> cm,</p>\n			</td>\n			<td style=\"width:18.06%;height:52px;\">\n				<p style=\"margin-left:5.05pt;\">\n					sem. oblasť severoslovenská, výšk. zóna 4 alebo 5</p>\n			</td>\n			<td style=\"width:19.1%;height:52px;\">\n				<p style=\"margin-left:5.05pt;\">\n					min. 1 - rok</p>\n			</td>\n		</tr>\n	</tbody>\n</table>\n<p>\n	<u>Vysvetlivky :</u>      <u>nč</u>  –  nadzemná časť</p>\n<p>\n	                           </p>\n<p style=\"margin-left:72.0pt;\">\n	<strong>3.     </strong><strong>Dodávka tovaru pre rok 2015</strong></p>\n<p>\n	 </p>\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"width:100.0%;\" width=\"100%\">\n	<tbody>\n		<tr>\n			<td style=\"width:12.02%;height:28px;\">\n				<p align=\"center\">\n					<strong>Druh dreviny</strong></p>\n				<p>\n					 </p>\n			</td>\n			<td style=\"width:11.7%;height:28px;\">\n				<p align=\"center\">\n					<strong>Množstvo</strong></p>\n				<p align=\"center\">\n					<strong>( ks )</strong></p>\n			</td>\n			<td style=\"width:39.16%;height:28px;\">\n				<p align=\"center\">\n					<strong>Výška a iné rozmery</strong></p>\n			</td>\n			<td style=\"width:18.0%;height:28px;\">\n				<p>\n					<strong>Pôvod (sem. oblasť, výšk. zóna)</strong></p>\n				<p align=\"center\" style=\"margin-left:5.05pt;\">\n					 </p>\n			</td>\n			<td style=\"width:19.12%;height:28px;\">\n				<p>\n					<strong>Vek sadeníc</strong></p>\n			</td>\n		</tr>\n		<tr>\n			<td style=\"width:12.02%;\">\n				<p>\n					Buk lesný</p>\n			</td>\n			<td style=\"width:11.7%;\">\n				<p align=\"center\">\n					29250</p>\n			</td>\n			<td style=\"width:39.16%;\">\n				<p>\n					Obaľované, výška <u>nč 15+</u> cm,</p>\n			</td>\n			<td style=\"width:18.0%;\">\n				<p style=\"margin-left:5.05pt;\">\n					sem. oblasť stredoslovenská, výšk. zóna 4 alebo 5</p>\n			</td>\n			<td style=\"width:19.12%;\">\n				<p style=\"margin-left:5.05pt;\">\n					min. 1 - rok</p>\n			</td>\n		</tr>\n		<tr>\n			<td style=\"width:12.02%;\">\n				<p>\n					Dub zimný</p>\n			</td>\n			<td style=\"width:11.7%;\">\n				<p align=\"center\">\n					2770</p>\n			</td>\n			<td style=\"width:39.16%;\">\n				<p>\n					Obaľované, výška <u>nč 15+ cm</u></p>\n			</td>\n			<td style=\"width:18.0%;\">\n				<p style=\"margin-left:5.05pt;\">\n					sem. oblasť mimo územia oblastí, výšk. zóna 4</p>\n			</td>\n			<td style=\"width:19.12%;\">\n				<p style=\"margin-left:5.05pt;\">\n					min. 1 - rok</p>\n			</td>\n		</tr>\n	</tbody>\n</table>\n<p>\n	 </p>\n<p>\n	<u>Vysvetlivky :</u>      <u>nč</u>  –  nadzemná časť</p>\n<p>\n	                         </p>\n<p>\n	4.             Predávajúci ako aj kupujúci nezodpovedá za to, že tovar nie je dodaný ako aj odobratý z dôvodu živelných udalostí, požiarov, záplav, kalamít, búrok, štrajkov, pracovnoprávnych sporov, občianskych nepokojov, obmedzení alebo akýchkoľvek iných okolností, ktoré sú úplne mimo jeho kontrolu  (vyššia moc).</p>\n<p>\n	5.             Kvalitatívne a technické podmienky: podľa STN 48 22 11</p>\n<p align=\"center\">\n	<strong>II.</strong></p>\n<p align=\"center\">\n	<strong>KÚPNA CENA</strong></p>\n<p>\n	 </p>\n<p>\n	1.             Cena predmetu je určená ako cena dohodou  v súlade so  zák. č. 18/1996 Zb. o cenách v platnom znení.</p>\n<p>\n	 </p>\n<p>\n	2.  Dohodnutá cena je cena spolu ................................................eur (slovom:....................................................................................) bez dane z pridanej hodnoty. DPH bude účtovaná v súlade s platným právnymi predpismi.</p>\n<p>\n	 </p>\n<p>\n	3.Dodávka tovaru bude realizovaná v nasledovných dohodnutých cenových reláciách:  </p>\n<p>\n	      </p>\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"width:77.48%;\" width=\"77%\">\n	<tbody>\n		<tr>\n			<td style=\"width:15.5%;height:28px;\">\n				<p align=\"center\">\n					<strong>Druh dreviny</strong></p>\n				<p>\n					 </p>\n			</td>\n			<td style=\"width:32.76%;height:28px;\">\n				<p align=\"center\">\n					<strong>Množstvo</strong></p>\n				<p align=\"center\">\n					<strong>( ks )</strong></p>\n			</td>\n			<td style=\"width:26.84%;height:28px;\">\n				<p>\n					<strong>Cena za ks bez DPH</strong></p>\n			</td>\n			<td style=\"width:24.88%;height:28px;\">\n				<p>\n					<strong>Cena spolu bez DPH:</strong></p>\n			</td>\n		</tr>\n		<tr>\n			<td style=\"width:15.5%;\">\n				<p>\n					Buk lesný</p>\n			</td>\n			<td style=\"width:32.76%;\">\n				<p align=\"center\">\n					29 250</p>\n				<p align=\"center\">\n					 </p>\n			</td>\n			<td style=\"width:26.84%;\">\n				<p style=\"margin-left:5.05pt;\">\n					 </p>\n			</td>\n			<td style=\"width:24.88%;\">\n				<p style=\"margin-left:5.05pt;\">\n					 </p>\n			</td>\n		</tr>\n		<tr>\n			<td style=\"width:15.5%;\">\n				<p>\n					Smrekovec opadavý</p>\n				<p>\n					 </p>\n			</td>\n			<td style=\"width:32.76%;\">\n				<p align=\"center\">\n					15 740</p>\n			</td>\n			<td style=\"width:26.84%;\">\n				<p style=\"margin-left:5.05pt;\">\n					 </p>\n			</td>\n			<td style=\"width:24.88%;\">\n				<p style=\"margin-left:5.05pt;\">\n					 </p>\n			</td>\n		</tr>\n		<tr>\n			<td style=\"width:15.5%;\">\n				<p>\n					Borovica lesná</p>\n				<p>\n					 </p>\n			</td>\n			<td style=\"width:32.76%;\">\n				<p align=\"center\">\n					27 300</p>\n			</td>\n			<td style=\"width:26.84%;\">\n				<p style=\"margin-left:5.05pt;\">\n					 </p>\n			</td>\n			<td style=\"width:24.88%;\">\n				<p style=\"margin-left:5.05pt;\">\n					 </p>\n			</td>\n		</tr>\n		<tr>\n			<td style=\"width:15.5%;height:23px;\">\n				<p>\n					Dub zimný</p>\n			</td>\n			<td style=\"width:32.76%;height:23px;\">\n				<p align=\"center\">\n					2 770</p>\n			</td>\n			<td style=\"width:26.84%;height:23px;\">\n				<p style=\"margin-left:5.05pt;\">\n					 </p>\n			</td>\n			<td style=\"width:24.88%;height:23px;\">\n				<p style=\"margin-left:5.05pt;\">\n					 </p>\n			</td>\n		</tr>\n		<tr>\n			<td style=\"width:15.5%;\">\n				<p>\n					SPOLU</p>\n				<p>\n					 </p>\n			</td>\n			<td style=\"width:32.76%;\">\n				<p align=\"center\">\n					75 060</p>\n			</td>\n			<td style=\"width:26.84%;\">\n				<p align=\"center\" style=\"margin-left:5.05pt;\">\n					 </p>\n				<p align=\"center\" style=\"margin-left:5.05pt;\">\n					x</p>\n			</td>\n			<td style=\"width:24.88%;\">\n				<p style=\"margin-left:5.05pt;\">\n					 </p>\n			</td>\n		</tr>\n	</tbody>\n</table>\n<p>\n	 </p>\n<p align=\"center\">\n	<strong>III.</strong></p>\n<p align=\"center\">\n	<strong>ČAS PLNENIA</strong></p>\n<p>\n	 </p>\n<p style=\"margin-left:18.0pt;\">\n	Zmluvné strany sa dohodli, že predávajúci dodá kupujúcemu sadenice uvedené:</p>\n<p>\n	-           v článku I. Predmet zmluvy, bod 2.  v čase 15. apríla 2014 príp. dohodou podľa priebehu jarného počasia, a to v celosti a naraz,</p>\n<p>\n	-          v článku I. Predmet zmluvy, bod 3. v čase 15. apríla 2015 príp. dohodou podľa priebehu jarného počasia, a to v celosti a naraz.</p>\n<p style=\"margin-left:18.0pt;\">\n	 </p>\n<p style=\"margin-left:18.0pt;\">\n	Predávajúci vyzve kupujúceho na prevzatie tovaru e-mailom aspoň 3 dni vopred. Kupujúci odsúhlasí presný termín prevzatia sadeníc e-mailom aspoň jeden deň vopred.</p>\n<p>\n	 </p>\n<p align=\"center\">\n	<strong>IV.</strong></p>\n<p align=\"center\">\n	<strong>MIESTO PLNENIA</strong></p>\n<p>\n	 </p>\n<p style=\"margin-left:18.0pt;\">\n	Predávajúci si splní záväzok z tejto zmluvy odovzdaním tovaru.</p>\n<p>\n	 </p>\n<p align=\"center\">\n	<strong>V.</strong></p>\n<p align=\"center\">\n	<strong>SPôSOB ÚHRADY KÚPNEJ CENY</strong></p>\n<p>\n	 </p>\n<p style=\"margin-left:18.0pt;\">\n	Kúpna cena určená spôsobom uvedeným v bode II. zmluvy bude zo strany kupujúceho uhradená: v lehote do 21 dní od dátumu doručenia faktúry, obsahujúcej všetky zákonom predpísané náležitosti.</p>\n<p align=\"center\">\n	 </p>\n<p align=\"center\">\n	<strong>VI.</strong></p>\n<p align=\"center\">\n	<strong>PREPRAVNÉ DOKLADY</strong></p>\n<p style=\"margin-left:18.0pt;\">\n	Doklady, vzťahujúce sa k predmetu plnenia budú zo strany predávajúceho vyhotovené a odovzdané kupujúcemu v deň odovzdania tovaru kupujúcemu.</p>\n<p>\n	 </p>\n<p align=\"center\">\n	<strong>VII.</strong></p>\n<p align=\"center\">\n	<strong>VLASTNÍCKE PRÁVO</strong></p>\n<p>\n	1.             Vlastnícke právo k dodanému tovaru nadobudne kupujúci až zaplatením vyfakturovanej kúpnej ceny.</p>\n<p>\n	 </p>\n<p style=\"margin-left:35.45pt;\">\n	2.             Kúpna cena sa považuje za zaplatenú momentom jej pripísania na účet predávajúceho, resp. prijatím     hotovosti predávajúcim od kupujúceho.</p>\n<p>\n	 </p>\n<p style=\"margin-left:35.45pt;\">\n	3.             Nebezpečenstvo škody na tovare prechádza na kupujúceho potom, čo mu tento bol odovzdaný priamo alebo v čase, keď mu predávajúci umožní nakladať s tovarom a kupujúci poruší zmluvu tým, že tovar neprevezme.</p>\n<p align=\"center\">\n	<strong>VIII.</strong></p>\n<p align=\"center\">\n	<strong>ODSTÚPENIE OD ZMLUVY</strong></p>\n<p>\n	Nesplnenie povinnosti predávajúceho uvedených v tejto zmluve zakladá právo kupujúceho odstúpiť od zmluvy, a to do 30 dní odo dňa, keď sa kupujúci o porušení dozvedel, inak právo zaniká. Predávajúci zodpovedá kupujúcemu za všetku prípadnú škodu, ktorá mu porušením povinností vznikne. </p>\n<p align=\"center\">\n	<strong>IX.</strong></p>\n<p align=\"center\">\n	<strong>AKOSŤ A  ZODPOVEDNOSŤ ZA CHYBY</strong></p>\n<p style=\"margin-left:35.45pt;\">\n	1.                   Predávajúci prehlasuje, že tovar dodaný na základe tejto zmluvy bude vykazovať kvalitu dohodnutú   v čl. I. zmluvy.</p>\n<p>\n	2.             Prípadné chyby tovaru môže kupujúci reklamovať takto :</p>\n<p style=\"margin-left:35.45pt;\">\n	- chyby kvantitatívne do 5-tich kalendárnych dní od prevzatia tovaru,</p>\n<p style=\"margin-left:35.45pt;\">\n	                - chyby vizuálne a iné do 8 kalendárnych dní od prevzatia tovaru.         </p>\n<p style=\"margin-left:35.45pt;\">\n	Neuplatnenie nároku z titulu chybného plnenia v dohodnutých lehotách má za následok zánik práva z tohto titulu.</p>\n<p style=\"margin-left:35.45pt;\">\n	 </p>\n<p>\n	3.             Kupujúci svoje právo z titulu chybného plnenia si uplatňuje písomne a vo svojej žiadosti uvedie :</p>\n<p style=\"margin-left:35.45pt;\">\n	-              popis chýb na dodanom tovare, dátum dodania tovaru, číslo kúpnej zmluvy, množstvo chybného tovaru a uplatňovaný nárok z titulu chybného plnenia.</p>\n<p style=\"margin-left:35.45pt;\">\n	 </p>\n<p style=\"margin-left:35.45pt;\">\n	4.                                            Predávajúci sa k písomnej reklamácii vyjadrí, resp. dostaví sa k reklamačnému konaniu v lehote do   5 dní odo dňa doručenia reklamácie.</p>\n<p>\n	 </p>\n<p style=\"margin-left:35.45pt;\">\n	5.                   Kupujúci je do doby dostavenia sa predávajúceho k reklamačnému konaniu povinný tovar uskladniť oddelene.</p>\n<p align=\"center\">\n	<strong>X.</strong></p>\n<p align=\"center\">\n	<strong>ČIASTOČNÉ PLNENIE A SANKCIE</strong></p>\n<p style=\"margin-left:35.45pt;\">\n	1.             Plnenie menšieho množstva zo strany predávajúceho ako bolo dohodnuté bude riešené poplatkom z omeškania nasledovne: ak predávajúci nedodá tovar v požadovanom množstve, je povinný zaplatiť kupujúcemu poplatok z omeškania vo výške 3,5 % z ceny nedodaného tovaru za každý začatý týždeň omeškania.</p>\n<p>\n	 </p>\n<p style=\"margin-left:35.45pt;\">\n	2.           Súčasne si účastníci na zabezpečenie záväzku dohodli pre prípad omeškania predávajúceho s plnením povinností z tejto zmluvy zmluvnú pokutu vo výške 0,1 % z ceny nedodaného tovaru za každý začatý týždeň meškania. Právo na náhradu škody tým nie je dotknuté.</p>\n<p>\n	 </p>\n<p align=\"center\">\n	<strong>XI.</strong></p>\n<p align=\"center\">\n	<strong>PLATNOSŤ A ÚČINNOSŤ KÚPNEJ ZMLUVY</strong></p>\n<p style=\"margin-left:35.45pt;\">\n	1.                   Zmeny podmienok zmluvne dohodnutých možno upraviť po dohode strán dodatkom výhradne písomnou formou.</p>\n<p style=\"margin-left:35.45pt;\">\n	2.                   Táto zmluva nadobúda platnosť a účinnosť dňom jej podpisu oboma zmluvnými stranami.</p>\n<p style=\"margin-left:35.45pt;\">\n	3.                   Predávajúci berie na vedomie, že kupujúci je povinnou osobou v  zmysle § 2 ods. 3 Zákona č. 211/2000 o slobodnom prístupe k informáciám v platnom znení, súhlasí so zverejnením a sprístupnením obsahu zmluvy. Táto zmluva nadobúda účinnosť najskôr dňom  nasledujúcom po dni jej zverejnenia na webovej stránke kupujúceho.</p>\n<p style=\"margin-left:53.25pt;\">\n	                                                                                             </p>\n<p align=\"center\">\n	<strong>XIII.</strong></p>\n<p align=\"center\">\n	<strong>RIEŠENIE SPOROV</strong></p>\n<p style=\"margin-left:35.45pt;\">\n	1.             Všetky spory napadnuté zo zmluvy budú riešené prostredníctvom príslušného súdu až po predchádzajúcom neúspešnom jednaní účastníkov.</p>\n<p>\n	 </p>\n<p style=\"margin-left:35.45pt;\">\n	2.             Zmluva bola vyhotovená v 3 exemplároch, z ktorých kupujúci dostane jeden exemplár a predávajúci dva exempláre.</p>\n<p>\n	 </p>\n<p align=\"center\">\n	<strong>XIV.</strong></p>\n<p align=\"center\">\n	<strong>ZÁVEREČNÉ USTANOVENIA</strong></p>\n<p>\n	 </p>\n<p>\n	Predávajúci je viazaný týmto návrhom zmluvy do 30. 04. 2014.</p>\n<p>\n	 </p>\n<p>\n	 </p>\n<p>\n	V Poprade, ...................................                                                   V .........................., ........................................</p>\n<p>\n	 </p>\n<p>\n	 </p>\n<table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n	<tbody>\n		<tr>\n			<td style=\"width:205px;\">\n				<p align=\"center\">\n					Kupujúci  (pečiatka a podpis)</p>\n				<p align=\"center\">\n					Ing. Róbert Dula</p>\n				<p align=\"center\">\n					konateľ spoločnosti</p>\n			</td>\n			<td style=\"width:205px;\">\n				<p>\n					 </p>\n			</td>\n			<td style=\"width:205px;\">\n				<p align=\"center\" style=\"margin-left:4.8pt;\">\n					Predávajúci (pečiatka a podpis)</p>\n				<p align=\"center\" style=\"margin-left:4.8pt;\">\n					 </p>\n				<p align=\"center\" style=\"margin-left:4.8pt;\">\n					 </p>\n			</td>\n		</tr>\n	</tbody>\n</table>\n<div style=\"clear:both;\">\n	 </div>\n<p>\n	 </p>\n',	NULL),
(12,	1,	'<h4>\n	Výzva na predkladanie ponúk</h4>\n<h4>\n	„Výstavba protipožiarnej nádrže Blech a Preslop \"</h4>\n<p align=\"center\">\n	 </p>\n<p align=\"center\">\n	zadávanie zákazky podľa § 9 ods. 9 zákona č. 25/2006 Z. z. o verejnom obstarávaní</p>\n<p align=\"center\">\n	a o zmene a doplnení niektorých zákonov v znení neskorších predpisov</p>\n<p>\n	 </p>\n<h5>\n	1.      Identifikácia verejného obstarávateľa</h5>\n<p>\n	Názov organizácie: Mestské lesy, s.r.o. Poprad       IČO: 36 448 311</p>\n<p>\n	Sídlo organizácie: Levočská 3312/37,  058 01 Poprad   </p>\n<p>\n	Krajina: Slovenská republika</p>\n<p>\n	Kontaktná osoba:  Ing. Róbert Dula – konateľ spoločnosti</p>\n<p>\n	Telefón: 052 7724160, 0910890440               </p>\n<p>\n	 e-mail:  lesypp@stonline.sk  </p>\n<h5>\n	2.      Predmet zákazky</h5>\n<p>\n	zákazka na uskutočňovanie stavebných prác</p>\n<h5>\n	3.      Názov predmetu zákazky</h5>\n<h5>\n	„Výstavba protipožiarnej nádrže Blech a Preslop \"</h5>\n<h5>\n	4.      Rozdelenie predmetu zákazky na časti</h5>\n<p>\n	  Požaduje sa cena za celý predmet zákazky </p>\n<h5>\n	5.      Opis predmetu zákazky</h5>\n<p>\n	Predmetom zákazky sú stavebné práce na výstavbe dvoch nádrží, ktoré vzniknú prehradením malých bystriniek kombinovanými zemno-kamennými hrádzami tesne pri lesných cestách na lokalitách Blech a Preslov, ktoré najlepšie vyhovujú konkrétnym technickým a prírodným požiadavkám.</p>\n<p style=\"margin-left:17.0pt;\">\n	<strong>6.</strong><strong>Množstvo alebo rozsah predmetu zákazky</strong></p>\n<p>\n	Podrobné vymedzenie predmetu zákazky je uvedené v projektovej dokumentácii a výkaze výmer , ktoré tvoria prílohu výzvy.  </p>\n<h5>\n	7.      Miesto dodania predmetu zákazky</h5>\n<p>\n	k.ú. Poprad, Spišské Bystré</p>\n<h5>\n	8.      Trvanie zmluvy alebo lehota pre skončenie dodávky</h5>\n<p>\n	Predpokladané ukončenie dodávky:  do 60 dní od odovzdania staveniska.</p>\n<h5>\n	9.      Hlavné podmienky financovania a platobné podmienky</h5>\n<p>\n	Predmet zákazky bude financovaný z nenávratného finančného príspevku (NFP)  - Program PRV SR 2014 - 2020,   opatrenie: 4 – Investície do hmotného majetku,  podopatrenie: 4.3 – Podpora na investície do infraštruktúry súvisiacej s vývojom, modernizáciou alebo a prispôsobením poľnohospodárstva a lesného hospodárstva.  Preddavky   nebudú poskytované.</p>\n<h5>\n	10.  Podmienky účasti  a obsah ponuky</h5>\n<p style=\"margin-left:17.0pt;\">\n	10.1. doklad o oprávnení realizovať práce, vo vzťahu k predmetu zákazky, na ktorú predkladá uchádzač ponuku  -  postačuje kópia</p>\n<p style=\"margin-left:17.0pt;\">\n	10.2. Vyplnená príloha č.1 výzvy – cena predmetu zákazky celkom</p>\n<p style=\"margin-left:17.0pt;\">\n	10.3. Ocenený výkaz výmer – Položkovitá kalkulácia ponukového rozpočtu diela jednotlivo za nádrž Plech a Preslop</p>\n<h5>\n	11.  Lehota  na predkladanie ponúk</h5>\n<p style=\"margin-left:17.0pt;\">\n	Lehota na predkladanie ponúk – dátum:   čas: 30.09.2015 do 15:00 hod</p>\n<p style=\"margin-left:17.0pt;\">\n	<strong>12.  </strong><strong>Miesto a spôsob doručenia cenovej ponuky</strong></p>\n<p>\n	      12.1<strong>. Osobné doručenie</strong> – v pracovnej dobe 07.30 – 15.30 hod. v sídle spoločnosti</p>\n<p>\n	      12.2<strong>. Poštou</strong> : - ako adresa obstarávateľskej organizácie uvedená v bode 1 </p>\n<p>\n	      12.3<strong>. Prostredníctvom elektronickej pošty:    </strong>Zaslať na e-mail: <a href=\"mailto:lesypp@stonline.sk\">lesypp@stonline.sk</a></p>\n<p>\n	      Obálka cenovej ponuky pri os. alebo poštovom doručení  musí obsahovať identifikáciu predkladateľa ponuky ( obch. meno a sídlo) a označenie „<strong>CENOVÁ PONUKA – nádrže – neotvárať, </strong>V prípade zaslanie e-mailu - predmet označený ako: <strong>cenová ponuka – nádrže</strong></p>\n<h5>\n	13.  Kritériá na hodnotenie ponúk:</h5>\n<p>\n	      Cena predmetu zákazky celkom -  vyplniť prílohu výzvy s potvrdením oprávnenej osoby uchádzača.</p>\n<h5>\n	14.  Lehota viazanosti ponúk</h5>\n<p>\n	31.06.2016</p>\n<h5>\n	15.  Ďalšie informácie </h5>\n<h5>\n	15.1. Plnenie predmetu zmluvy je viazané na poskytnutie nenávratného finančného príspevku (NFP) z fondov EÚ. Informáciu o poskytnutí NFP oznámi objednávateľ zhotoviteľovi  a zároveň vyzve zhotoviteľa na prevzatie staveniska. V prípade, ak objednávateľovi nebude poskytnutý NFP na financovanie plnenia podľa tejto zmluvy, účinky tejto zmluvy zaniknú.</h5>\n<p>\n	15.2. V prípade, že bude uchádzač úspešný, predloží pred podpisom zmluvy originál alebo úradne osvedčenú kópiu dokladu o oprávnení podnikať.</p>\n<h5>\n	16.  Použitie elektronickej aukcie</h5>\n<p>\n	Nepoužije sa.</p>\n<p>\n	 </p>\n<p>\n	 </p>\n<p>\n	 </p>\n<h5>\n	Zodpovedná osoba:</h5>\n<p>\n	Ing. Róbert Dula- konateľ spoločnosti:..................</p>\n<p>\n	 </p>\n<p>\n	 </p>\n<p>\n	 </p>\n<p>\n	 </p>\n<p>\n	 </p>\n<p>\n	 </p>\n<p>\n	 </p>\n<p>\n	 </p>\n<p>\n	 </p>\n<p>\n	 </p>\n<p>\n	 </p>\n<p>\n	 </p>\n<p>\n	 </p>\n<p>\n	 </p>\n<p>\n	 </p>\n<p>\n	 </p>\n<p>\n	 </p>\n<p>\n	 </p>\n<p>\n	 </p>\n<p>\n	 </p>\n<p>\n	 </p>\n<p>\n	 </p>\n<p>\n	 </p>\n<p>\n	 </p>\n<p>\n	 </p>\n<p>\n	 </p>\n<p>\n	 </p>\n<p align=\"right\">\n	Príloha č. 1 </p>\n<p align=\"center\">\n	 </p>\n<p align=\"center\">\n	<strong>Návrh na plnenie kritéria</strong></p>\n<p align=\"center\">\n	 </p>\n<p align=\"left\">\n	Uchádzač: ...............................................................................................</p>\n<p align=\"left\">\n	 </p>\n<p align=\"left\">\n	                  ..............................................................................................</p>\n<p align=\"left\">\n	               </p>\n<p align=\"left\">\n	               IČO:...................................................................</p>\n<h5>\n	Cena zákazky: „Výstavba protipožiarnej nádrže Blech a Preslop \"</h5>\n<h5>\n	 </h5>\n<p align=\"left\">\n	 </p>\n<table border=\"1\" cellpadding=\"0\" cellspacing=\"0\">\n	<tbody>\n		<tr>\n			<td style=\"width:284px;\">\n				<p align=\"center\">\n					Názov kritéria</p>\n			</td>\n			<td style=\"width:161px;\">\n				<p align=\"center\">\n					 </p>\n			</td>\n			<td style=\"width:177px;\">\n				<p align=\"center\">\n					Splnenie kritéria</p>\n				<p align=\"center\">\n					 </p>\n			</td>\n		</tr>\n		<tr>\n			<td style=\"width:284px;height:52px;\">\n				<p align=\"left\">\n					 </p>\n				<p align=\"left\">\n					<strong>Cena celkom za dielo bez  DPH</strong></p>\n			</td>\n			<td style=\"width:161px;height:52px;\">\n				<p align=\"left\">\n					 </p>\n			</td>\n			<td style=\"width:177px;height:52px;\">\n				<p align=\"left\">\n					 </p>\n				<p align=\"left\">\n					 </p>\n			</td>\n		</tr>\n		<tr>\n			<td style=\"width:284px;\">\n				<p align=\"left\">\n					 </p>\n				<p align=\"left\">\n					20 %  DPH</p>\n			</td>\n			<td style=\"width:161px;\">\n				<p align=\"left\">\n					 </p>\n			</td>\n			<td style=\"width:177px;\">\n				<p align=\"left\">\n					 </p>\n			</td>\n		</tr>\n		<tr>\n			<td style=\"width:284px;\">\n				<p align=\"left\">\n					 </p>\n				<p align=\"left\">\n					<strong>Cena celkom za dielo vrátane DPH</strong></p>\n			</td>\n			<td style=\"width:161px;\">\n				<p align=\"left\">\n					 </p>\n			</td>\n			<td style=\"width:177px;\">\n				<p align=\"left\">\n					 </p>\n			</td>\n		</tr>\n	</tbody>\n</table>\n<p align=\"left\">\n	Som – nie som platcom DPH <sup>( nehodiace sa preškrtnite)</sup></p>\n<p align=\"left\">\n	 </p>\n<p align=\"left\">\n	 </p>\n<p align=\"left\">\n	V...................................dňa:.........................</p>\n<p align=\"left\">\n	 </p>\n<p align=\"left\">\n	Meno a priezvisko uchádzača alebo osoby oprávnenej konať za uchádzača...............................................                       </p>\n<p align=\"left\">\n	 </p>\n<p align=\"left\">\n	                                                                   ....................................................................</p>\n<p align=\"left\">\n	                                                                                            Podpis tejto osoby                                                                  </p>\n<h5>\n	 </h5>\n<p>\n	 </p>\n',	NULL),
(13,	1,	'<table class=\"table bg-dark\">\n  <caption>\n    Zakázky <small>§ 9 ods. 9 zákona č. 25/2006</small>\n  </caption>\n  <tbody>\n    <tr>\n      <td>Názov:</td>\n      <td>Mestské lesy, s.r.o. Poprad</td>\n    </tr>\n    <tr>\n      <td>Štatutárny zástupca:</td>\n      <td>Ing. Róbert Dula</td>\n    </tr>\n    <tr>\n      <td>Sídlo:</td>\n      <td>Levočská 3312/37<br>058 01 Poprad</td>\n    </tr>\n    <tr>\n      <td>IČO:</td>\n      <td>36448311</td>\n    </tr>\n    <tr>\n      <td>DIČ:</td>\n      <td>2020017175</td>\n    </tr>\n    <tr>\n      <td>IČ DPH:</td>\n      <td>SK2020017175</td>\n    </tr>\n    <tr>\n      <td>Telefón:</td>\n      <td>052/7724160</td>\n    </tr>\n    <tr>\n      <td>Mobil:</td>\n      <td>0910 890 440</td>\n    </tr>\n    <tr>\n      <td>Email:</td>\n      <td>lesypp@stonline.sk</td>\n    </tr>\n  </tbody>\n</table>',	''),
(14,	1,	'<p>\n	Momentálne spoločnosť nepodáva žiadne výzvy na verejné obstarávanie</p>\n',	NULL),
(15,	1,	'',	NULL),
(16,	1,	'\r\n',	NULL),
(17,	1,	'\r\n',	NULL),
(18,	1,	'\r\n',	NULL),
(19,	1,	'\r\n',	NULL),
(23,	1,	'<h3>\n	Mestsk&eacute; lesy, s.r.o. Poprad</h3>\n<p>\n	Levočsk&aacute; 3312/37</p>\n<p>\n	Poprad, 058 01</p>\n<p>\n	tel: 0527724160</p>\n<p>\n	e-mail.: lesypp@stonline.sk</p>',	NULL),
(25,	1,	'<p>\n	Turistick&eacute; trasy a n&aacute;učn&eacute; chodn&iacute;ky, vyhliadky aj mal&aacute; roklina, archeologick&eacute; n&aacute;lezisko, kr&iacute;žov&aacute; cesta, odpoč&iacute;vadl&aacute; s ohniskom, chov mufl&oacute;nov a diviakov. Toto v&scaron;etko a e&scaron;te viac n&aacute;jdete v lesoch mesta Poprad, ktor&eacute; s&uacute; bl&iacute;zko a pon&uacute;kaj&uacute; skutočn&yacute; relax a z&aacute;žitok v pr&iacute;rode. Turista, cyklista, alebo rodiny s deťmi, každ&yacute; si m&ocirc;že vychutnať pobyt v pr&iacute;rode mestsk&yacute;ch lesov</p>\n',	'Urobte si výlet na naše značkované chodníky, alebo cyklistické trasy. Na každom z chodníkov nájdete krásne a zaujímavé miesta, na ktoré sa budete radi vracať.'),
(26,	1,	NULL,	'Pozrite si fotografie z našich mestských lesov. Fotografie z turistických chodníkov, zaujímavých miest, ale aj z prác na projektoch, ktoré sme zrealizovali.');

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

DROP TABLE IF EXISTS `dokumenty`;
CREATE TABLE `dokumenty` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_hlavne_menu` int(11) NOT NULL DEFAULT '1' COMMENT 'Id položky hl. menu ku ktorej patrí',
  `id_user_main` int(11) NOT NULL DEFAULT '1' COMMENT 'Id užívateľa',
  `id_user_roles` int(11) NOT NULL DEFAULT '0' COMMENT 'Id min úrovne registrácie pre zobrazenie',
  `znacka` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT 'Značka súboru pre vloženie do textu',
  `nazov` varchar(50) COLLATE utf8_bin NOT NULL COMMENT 'Názov titulku pre daný dokument',
  `pripona` varchar(20) COLLATE utf8_bin NOT NULL COMMENT 'Prípona súboru',
  `spec_nazov` varchar(50) COLLATE utf8_bin NOT NULL COMMENT 'Špecifický názov dokumentu pre URL',
  `popis` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'Popis dokumentu',
  `subor` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'Názov súboru s relatívnou cestou',
  `thumb` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'Názov súboru thumb pre obrázky a iné ',
  `zmena` datetime NOT NULL COMMENT 'Dátum uloženia alebo opravy - časová pečiatka',
  `zobraz_v_texte` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Zobrazenie obrázku v texte',
  `pocitadlo` int(11) NOT NULL DEFAULT '0' COMMENT 'Počítadlo stiahnutí',
  PRIMARY KEY (`id`),
  UNIQUE KEY `spec_nazov` (`spec_nazov`),
  KEY `id_user_profiles` (`id_user_main`),
  KEY `id_registracia` (`id_user_roles`),
  KEY `id_hlavne_menu` (`id_hlavne_menu`),
  CONSTRAINT `dokumenty_ibfk_1` FOREIGN KEY (`id_user_main`) REFERENCES `user_main` (`id`),
  CONSTRAINT `dokumenty_ibfk_3` FOREIGN KEY (`id_hlavne_menu`) REFERENCES `hlavne_menu` (`id`),
  CONSTRAINT `dokumenty_ibfk_4` FOREIGN KEY (`id_user_roles`) REFERENCES `user_roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Prílohy k článkom';

INSERT INTO `dokumenty` (`id`, `id_hlavne_menu`, `id_user_main`, `id_user_roles`, `znacka`, `nazov`, `pripona`, `spec_nazov`, `popis`, `subor`, `thumb`, `zmena`, `zobraz_v_texte`, `pocitadlo`) VALUES
(1,	22,	1,	0,	'#I-1#',	'028.JPG',	'JPG',	'028-jpg',	NULL,	'www/files/prilohy/028.JPG',	'www/files/prilohy/tb_028.JPG',	'2017-03-27 09:18:37',	1,	0),
(2,	22,	1,	0,	'#I-2#',	'034.JPG',	'JPG',	'034-jpg',	NULL,	'www/files/prilohy/034.JPG',	'www/files/prilohy/tb_034.JPG',	'2017-03-27 09:20:17',	1,	0),
(3,	22,	1,	0,	'#I-3#',	'cesta12-03-078.jpg',	'jpg',	'cesta12-03-078-jpg',	NULL,	'www/files/prilohy/cesta12-03-078.jpg',	'www/files/prilohy/tb_cesta12-03-078.jpg',	'2017-03-27 09:20:38',	1,	0),
(4,	22,	1,	0,	'#I-4#',	'cestavysova-028.jpg',	'jpg',	'cestavysova-028-jpg',	NULL,	'www/files/prilohy/cestavysova-028.jpg',	'www/files/prilohy/tb_cestavysova-028.jpg',	'2017-03-27 09:20:56',	1,	0),
(5,	22,	1,	0,	'#I-5#',	'cestavysova-031.jpg',	'jpg',	'cestavysova-031-jpg',	NULL,	'www/files/prilohy/cestavysova-031.jpg',	'www/files/prilohy/tb_cestavysova-031.jpg',	'2017-03-27 09:21:01',	1,	0),
(6,	22,	1,	0,	'#I-6#',	'dostojevskeho-043.jpg',	'jpg',	'dostojevskeho-043-jpg',	NULL,	'www/files/prilohy/dostojevskeho-043.jpg',	'www/files/prilohy/tb_dostojevskeho-043.jpg',	'2017-03-27 09:21:20',	1,	0),
(7,	22,	1,	0,	'#I-7#',	'dostojevskeho-105.jpg',	'jpg',	'dostojevskeho-105-jpg',	NULL,	'www/files/prilohy/dostojevskeho-105.jpg',	'www/files/prilohy/tb_dostojevskeho-105.jpg',	'2017-03-27 09:21:28',	1,	0),
(8,	22,	1,	0,	'#I-8#',	'dostojevskeho-117.jpg',	'jpg',	'dostojevskeho-117-jpg',	NULL,	'www/files/prilohy/dostojevskeho-117.jpg',	'www/files/prilohy/tb_dostojevskeho-117.jpg',	'2017-03-27 09:21:38',	1,	0),
(9,	22,	1,	0,	'#I-9#',	'dostojevskeho-124.jpg',	'jpg',	'dostojevskeho-124-jpg',	NULL,	'www/files/prilohy/dostojevskeho-124.jpg',	'www/files/prilohy/tb_dostojevskeho-124.jpg',	'2017-03-27 09:21:50',	1,	0),
(10,	22,	1,	0,	'#I-10#',	'dostojevskeho-128.jpg',	'jpg',	'dostojevskeho-128-jpg',	NULL,	'www/files/prilohy/dostojevskeho-128.jpg',	'www/files/prilohy/tb_dostojevskeho-128.jpg',	'2017-03-27 09:22:10',	1,	0),
(11,	22,	1,	0,	'#I-11#',	'vysov-004.JPG',	'JPG',	'vysov-004-jpg',	NULL,	'www/files/prilohy/vysov-004.JPG',	'www/files/prilohy/tb_vysov-004.JPG',	'2017-03-27 09:22:20',	1,	0),
(12,	22,	1,	0,	'#I-12#',	'vysov-014.JPG',	'JPG',	'vysov-014-jpg',	NULL,	'www/files/prilohy/vysov-014.JPG',	'www/files/prilohy/tb_vysov-014.JPG',	'2017-03-27 09:22:37',	1,	0),
(13,	22,	1,	0,	'#I-13#',	'vysov-017.JPG',	'JPG',	'vysov-017-jpg',	NULL,	'www/files/prilohy/vysov-017.JPG',	'www/files/prilohy/tb_vysov-017.JPG',	'2017-03-27 09:22:45',	1,	0),
(14,	22,	1,	0,	'#I-14#',	'vysovakalamita-046.jpg',	'jpg',	'vysovakalamita-046-jpg',	NULL,	'www/files/prilohy/vysovakalamita-046.jpg',	'www/files/prilohy/tb_vysovakalamita-046.jpg',	'2017-03-27 09:23:07',	1,	0),
(15,	22,	1,	0,	'#I-15#',	'vysovakalamita-049.jpg',	'jpg',	'vysovakalamita-049-jpg',	NULL,	'www/files/prilohy/vysovakalamita-049.jpg',	'www/files/prilohy/tb_vysovakalamita-049.jpg',	'2017-03-27 09:23:20',	1,	0),
(16,	22,	1,	0,	'#I-16#',	'cesta12-03-079.jpg',	'jpg',	'cesta12-03-079-jpg',	NULL,	'www/files/prilohy/cesta12-03-079.jpg',	'www/files/prilohy/tb_cesta12-03-079.jpg',	'2017-03-27 09:23:31',	1,	0),
(17,	22,	1,	0,	'#I-17#',	'vysov-005.JPG',	'JPG',	'vysov-005-jpg',	NULL,	'www/files/prilohy/vysov-005.JPG',	'www/files/prilohy/tb_vysov-005.JPG',	'2017-03-27 09:23:44',	1,	0);

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
(3,	'menupol',	NULL,	'Menu',	'Položka menu - nerobí nič, len zobrazí všetky položky, ktoré sú v nej zaradené',	1,	1,	1),
(5,	'oznam',	NULL,	'Oznam',	'Vypísanie oznamov',	1,	0,	1),
(7,	'dokumenty',	NULL,	'Dokumenty',	'Vkladanie dokumentov do stránky',	0,	0,	0);

DROP TABLE IF EXISTS `faktury`;
CREATE TABLE `faktury` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_hlavne_menu` int(11) NOT NULL DEFAULT '1' COMMENT 'Ku ktorej položke patrí',
  `nazov` varchar(50) COLLATE utf8_bin NOT NULL COMMENT 'Názov titulku pre daný dokument',
  `cislo` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT 'Číslo faktúry, zmluvy, objednávky',
  `predmet` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT 'Predmet faktúry, zmluvy, objednávky',
  `cena` float(15,2) DEFAULT NULL COMMENT 'Cena faktúry, zmluvy, objednávky',
  `subjekt` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT 'Subjekt faktúry,  objednávky - (dodávateľ), zmluvy(Zmluvná strana)',
  `datum_vystavenia` date DEFAULT NULL COMMENT 'Dátum vystavenia pri faktúre a objednávke pri zmluve dátum uzatvorenia',
  `datum_ukoncenia` date DEFAULT NULL COMMENT 'Dátum ukoncenia zmluvy',
  `subor` varchar(50) COLLATE utf8_bin NOT NULL COMMENT 'Názov súboru s relatívnou cestou',
  `id_user_main` int(11) NOT NULL DEFAULT '1' COMMENT 'Kto pridal dokument',
  `id_reg` int(11) NOT NULL DEFAULT '0' COMMENT 'Úroveň registrácie',
  `kedy` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Dátum uloženia alebo opravy - časová pečiatka',
  `pocitadlo` int(11) NOT NULL DEFAULT '0' COMMENT 'Počítadlo stiahnutí',
  `id_skupina` int(11) NOT NULL COMMENT 'Id článku do ktorej časti dokument patrí',
  `id_rok` int(11) NOT NULL COMMENT 'Id roku do ktorého sa má zaradiť',
  PRIMARY KEY (`id`),
  KEY `id_hlavne_menu` (`id_hlavne_menu`),
  KEY `id_user_profiles` (`id_user_main`),
  CONSTRAINT `faktury_ibfk_1` FOREIGN KEY (`id_hlavne_menu`) REFERENCES `hlavne_menu` (`id`),
  CONSTRAINT `faktury_ibfk_3` FOREIGN KEY (`id_user_main`) REFERENCES `user_main` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `faktury` (`id`, `id_hlavne_menu`, `nazov`, `cislo`, `predmet`, `cena`, `subjekt`, `datum_vystavenia`, `datum_ukoncenia`, `subor`, `id_user_main`, `id_reg`, `kedy`, `pocitadlo`, `id_skupina`, `id_rok`) VALUES
(20,	23,	'',	'4011198',	'práce a materiál Ford',	1052.46,	'Autonova s.r.o.',	'2011-01-27',	'0000-00-00',	'img112.pdf',	3,	0,	'2017-04-27 09:41:35',	697,	9023,	0),
(21,	23,	'',	'232011',	'automobil Ford',	27113.02,	'Autonova s.r.o.',	'2011-01-27',	'0000-00-00',	'img113.pdf',	3,	0,	'2017-04-27 09:41:35',	652,	9023,	0),
(22,	23,	'',	'1/2011',	'ťažba, približovanie, manipulácia dreva',	2348.62,	'Michal Korenko',	'2011-01-31',	'0000-00-00',	'img111.pdf',	3,	0,	'2017-04-27 09:41:35',	669,	9023,	0),
(23,	23,	'',	'111',	'projekt lesná cesta Kvetnica',	2215.00,	'Ing. Štefan Bigoš',	'2011-02-08',	'0000-00-00',	'img110.pdf',	3,	0,	'2017-04-27 09:41:35',	673,	9023,	0),
(24,	23,	'',	'2/2011',	'ťažba, približovanie, manipulácia dreva',	3078.21,	'Kollár Ján',	'2011-01-31',	'0000-00-00',	'img109.pdf',	3,	0,	'2017-04-27 09:41:35',	675,	9023,	0),
(26,	23,	'',	'0211',	'ťažba, približovanie, manipulácia dreva',	2611.02,	'Miroslav Karabín',	'2011-03-31',	'0000-00-00',	'img108.pdf',	3,	0,	'2017-04-27 09:41:35',	686,	9023,	0),
(27,	23,	'',	'02(2011',	'ťažba, približovanie, manipulácia dreva',	3180.67,	'Michal Korenko',	'2011-02-28',	'0000-00-00',	'img107.pdf',	3,	0,	'2017-04-27 09:41:35',	668,	9023,	0),
(28,	23,	'',	'1/2011',	'ťažba, približovanie, manipulácia dreva',	2946.98,	'Milan Bujnovský',	'2011-02-28',	'0000-00-00',	'img105.pdf',	3,	0,	'2017-04-27 09:41:35',	683,	9023,	0),
(29,	23,	'',	'VF110058',	'ťažba, približovanie, manipulácia dreva',	3589.78,	'Stemp-M&G, s.r.o.',	'2011-02-28',	'0000-00-00',	'img104.pdf',	3,	0,	'2017-04-27 09:41:35',	654,	9023,	0),
(30,	23,	'',	'4/2011',	'ťažba, približovanie, manipulácia dreva',	1844.28,	'Kollár Ján',	'2011-02-28',	'0000-00-00',	'img103.pdf',	3,	0,	'2017-04-27 09:41:35',	663,	9023,	0),
(31,	23,	'',	'0411',	'ťažba, približovanie, manipulácia dreva',	4321.15,	'Miroslav Karabín',	'2011-02-28',	'0000-00-00',	'img102.pdf',	3,	0,	'2017-04-27 09:41:35',	669,	9023,	0),
(32,	23,	'',	'21100214',	'jiffy tablety',	1380.84,	'Engo, s.r.o.',	'2011-03-15',	'0000-00-00',	'img101.pdf',	3,	0,	'2017-04-27 09:41:35',	663,	9023,	0),
(33,	23,	'',	'4/2011',	'ťažba, približovanie, manipulácia dreva',	1221.63,	'Milan Bujnovský',	'2011-03-31',	'0000-00-00',	'img100.pdf',	3,	0,	'2017-04-27 09:41:35',	677,	9023,	0),
(34,	23,	'',	'03/2011',	'ťažba, približovanie, manipulácia dreva',	1723.62,	'Michal Korenko',	'2011-03-31',	'0000-00-00',	'img098.pdf',	3,	0,	'2017-04-27 09:41:35',	646,	9023,	0),
(35,	23,	'',	'6/2011',	'ťažba, približovanie, manipulácia dreva',	2491.14,	'Kollár Ján',	'2011-03-31',	'0000-00-00',	'img097.pdf',	3,	0,	'2017-04-27 09:41:35',	663,	9023,	0),
(36,	23,	'',	'0611',	'ťažba, približovanie, manipulácia dreva',	4427.87,	'Miroslav Karabín',	'2011-03-31',	'0000-00-00',	'img096.pdf',	3,	0,	'2017-04-27 09:41:35',	679,	9023,	0),
(37,	23,	'',	'VF110094',	'ťažba, približovanie, manipulácia dreva',	1624.38,	'Stemp-M&G, s.r.o.',	'2011-03-31',	'0000-00-00',	'img095.pdf',	3,	0,	'2017-04-27 09:41:35',	681,	9023,	0),
(38,	23,	'',	'11/0005',	'Protipožiarna lesná cesta Vysová',	64765.73,	'Lesostav Poprad, s.r.o.',	'2011-03-31',	'0000-00-00',	'img094.pdf',	3,	0,	'2017-04-27 09:41:35',	714,	9023,	0),
(39,	23,	'',	'21100416',	'tacky na jiffy tablety',	1836.35,	'Engo, s.r.o.',	'2011-04-11',	'0000-00-00',	'img093.pdf',	3,	0,	'2017-04-27 09:41:35',	746,	9023,	0),
(40,	23,	'',	'11/0008',	'Protipožiarna lesná cesta Vysová',	59555.76,	'Lesostav Poprad, s.r.o.',	'2011-04-30',	'0000-00-00',	'img092.pdf',	3,	0,	'2017-04-27 09:41:35',	689,	9023,	0),
(41,	23,	'',	'8/2011',	'ťažba, približovanie, manipulácia dreva',	1999.14,	'Kollár Ján',	'2011-04-30',	'0000-00-00',	'img091.pdf',	3,	0,	'2017-04-27 09:41:35',	681,	9023,	0),
(42,	23,	'',	'2011143',	'drevná hmota',	1774.32,	'Technické služby mesta Svit',	'2011-05-09',	'0000-00-00',	'img090.pdf',	3,	0,	'2017-04-27 09:41:35',	650,	9023,	0),
(43,	23,	'',	'0111052165',	'stravné lístky',	1234.32,	'LE CHEQUE DEJEUNER s.r.o',	'2011-05-18',	'0000-00-00',	'img089.pdf',	3,	0,	'2017-04-27 09:41:35',	654,	9023,	0),
(44,	23,	'',	'8/2011',	'ťažba, približovanie, manipulácia dreva',	4685.80,	'Milan Bujnovský',	'2011-05-31',	'0000-00-00',	'img088.pdf',	3,	0,	'2017-04-27 09:41:35',	678,	9023,	0),
(45,	23,	'',	'11/0013',	'Protipožiarna lesná cesta Vysová',	41384.46,	'Lesostav Poprad, s.r.o.',	'2011-05-31',	'0000-00-00',	'img087.pdf',	3,	0,	'2017-04-27 09:41:35',	676,	9023,	0),
(46,	23,	'',	'11/0020',	'oprava lesných ciest a zvážnic',	4485.54,	'Lesostav Poprad, s.r.o.',	'2011-05-31',	'0000-00-00',	'img086.pdf',	3,	0,	'2017-04-27 09:41:35',	672,	9023,	0),
(47,	23,	'',	'0111065474',	'stravné lístky',	1541.52,	'LE CHEQUE DEJEUNER s.r.o',	'2011-06-28',	'0000-00-00',	'img085.pdf',	3,	0,	'2017-04-27 09:41:35',	658,	9023,	0),
(48,	23,	'',	'1100207',	'sadenice lesných drevín',	2232.00,	'Urbárske poz. spol. Vikartovce',	'2011-06-16',	'0000-00-00',	'img084.pdf',	3,	0,	'2017-04-27 09:41:35',	663,	9023,	0),
(49,	23,	'',	'7/2011',	'ťažba, približovanie, manipulácia dreva',	1332.09,	'Milan Bujnovský',	'2011-06-30',	'0000-00-00',	'img083.pdf',	3,	0,	'2017-04-27 09:41:35',	661,	9023,	0),
(50,	23,	'',	'1011',	'ťažba, približovanie, manipulácia dreva',	2810.51,	'Miroslav Karabín',	'2011-06-30',	'0000-00-00',	'img082.pdf',	3,	0,	'2017-04-27 09:41:35',	666,	9023,	0),
(51,	23,	'',	'10/2011',	'ťažba, približovanie, manipulácia dreva',	2718.63,	'Kollár Ján',	'2011-06-30',	'0000-00-00',	'img081.pdf',	3,	0,	'2017-04-27 09:41:35',	652,	9023,	0),
(52,	23,	'',	'OFAT0053',	'inštalácia sklotextilných tapiet',	1547.41,	'Karki s.r.o.',	'2011-07-07',	'0000-00-00',	'img080.pdf',	3,	0,	'2017-04-27 09:41:35',	659,	9023,	0),
(53,	23,	'',	'23411',	'pokládka koberca',	1373.14,	'Ončiš s.r.o.',	'2011-07-11',	'0000-00-00',	'img079.pdf',	3,	0,	'2017-04-27 09:41:35',	677,	9023,	0),
(54,	23,	'',	'11/0039',	'Protipožiarna lesná cesta Vysová',	22481.50,	'Lesostav Poprad, s.r.o.',	'2011-07-29',	'0000-00-00',	'img078.pdf',	3,	0,	'2017-04-27 09:41:35',	694,	9023,	0),
(55,	23,	'',	'1111',	'ťažba, približovanie, manipulácia dreva',	2006.16,	'Miroslav Karabín',	'2011-07-31',	'0000-00-00',	'img077.pdf',	3,	0,	'2017-04-27 09:41:35',	678,	9023,	0),
(56,	23,	'',	'0111086690',	'stravné lístky',	1541.52,	'LE CHEQUE DEJEUNER s.r.o',	'2011-08-31',	'0000-00-00',	'img076.pdf',	3,	0,	'2017-04-27 09:41:35',	661,	9023,	0),
(57,	23,	'',	'11/0044',	'Protipožiarna lesná cesta Vysová',	17867.39,	'Lesostav Poprad, s.r.o.',	'2011-08-31',	'0000-00-00',	'img075.pdf',	3,	0,	'2017-04-27 09:41:35',	657,	9023,	0),
(58,	23,	'',	'14/2011',	'ťažba, približovanie, manipulácia dreva',	2749.16,	'Kollár Ján',	'2011-08-31',	'0000-00-00',	'img074.pdf',	3,	0,	'2017-04-27 09:41:35',	680,	9023,	0),
(59,	23,	'',	'1511',	'ťažba, približovanie, manipulácia dreva',	3416.45,	'Miroslav Karabín',	'2011-09-30',	'0000-00-00',	'img073.pdf',	3,	0,	'2017-04-27 09:41:35',	656,	9023,	0),
(60,	23,	'',	'1100313',	'sadenice lesných drevín',	2484.96,	'Urbárske poz. spol. Vikartovce',	'2011-09-30',	'0000-00-00',	'img072.pdf',	3,	0,	'2017-04-27 09:41:35',	673,	9023,	0),
(61,	23,	'',	'11/2011',	'ťažba, približovanie, manipulácia dreva',	3266.72,	'Milan Bujnovský',	'2011-09-30',	'0000-00-00',	'img071.pdf',	3,	0,	'2017-04-27 09:41:35',	666,	9023,	0),
(62,	23,	'',	'0111105443',	'stravné lístky',	1542.60,	'LE CHEQUE DEJEUNER s.r.o',	'2011-10-25',	'0000-00-00',	'img069.pdf',	3,	0,	'2017-04-27 09:41:35',	676,	9023,	0),
(63,	23,	'',	'9/2011',	'ťažba, približovanie, manipulácia dreva',	2627.93,	'Ján Gavaler',	'2011-10-31',	'0000-00-00',	'img068.pdf',	3,	0,	'2017-04-27 09:41:35',	684,	9023,	0),
(64,	23,	'',	'20/2011',	'ťažba, približovanie, manipulácia dreva',	1197.01,	'Michal Korenko',	'2011-10-31',	'0000-00-00',	'img066.pdf',	3,	0,	'2017-04-27 09:41:35',	704,	9023,	0),
(65,	23,	'',	'1811',	'ťažba, približovanie, manipulácia dreva',	4204.94,	'Miroslav Karabín',	'2011-10-31',	'0000-00-00',	'img065.pdf',	3,	0,	'2017-04-27 09:41:35',	648,	9023,	0),
(66,	23,	'',	'13/2011',	'ťažba, približovanie, manipulácia dreva',	1569.87,	'Milan Bujnovský',	'2011-10-31',	'0000-00-00',	'img064.pdf',	3,	0,	'2017-04-27 09:41:35',	661,	9023,	0),
(67,	23,	'',	'1911',	'ťažba, približovanie, manipulácia dreva',	3955.67,	'Miroslav Karabín',	'2011-11-30',	'0000-00-00',	'img059.pdf',	3,	0,	'2017-04-27 09:41:35',	651,	9023,	0),
(68,	23,	'',	'2011415',	'drevná hmota',	2052.72,	'Technické služby mesta Svit',	'2011-12-06',	'0000-00-00',	'img058.pdf',	3,	0,	'2017-04-27 09:41:35',	679,	9023,	0),
(69,	23,	'',	'23/2011',	'ťažba, približovanie, manipulácia dreva',	1245.38,	'Michal Korenko',	'2011-11-30',	'0000-00-00',	'img057.pdf',	3,	0,	'2017-04-27 09:41:35',	656,	9023,	0),
(70,	23,	'',	'18/2011',	'ťažba, približovanie, manipulácia dreva',	1192.33,	'Milan Bujnovský',	'2011-12-30',	'0000-00-00',	'img056.pdf',	3,	0,	'2017-04-27 09:41:35',	699,	9023,	0),
(71,	23,	'',	'11/0089',	'zriadenie priepustov',	1616.99,	'Lesostav Poprad, s.r.o.',	'2011-12-20',	'0000-00-00',	'img050.pdf',	3,	0,	'2017-04-27 09:41:35',	692,	9023,	0),
(72,	23,	'',	'032912001',	'nájomné za lesné pozemky',	20079.53,	'Mesto Poprad',	'2011-12-30',	'0000-00-00',	'img048.pdf',	3,	0,	'2017-04-27 09:41:35',	692,	9023,	0),
(73,	24,	'',	'1/2011',	'jiffy tablety',	2680.99,	'Engo, s.r.o.',	'2011-02-24',	'0000-00-00',	'img123.pdf',	3,	0,	'2017-04-27 09:42:01',	472,	9025,	0),
(74,	24,	'',	'3/2011',	'oprava lesných ciesta a zvážnic',	4500.00,	'Lesostav Poprad, s.r.o.',	'2011-05-03',	'0000-00-00',	'img122.pdf',	3,	0,	'2017-04-27 09:42:01',	469,	9025,	0),
(75,	24,	'',	'4/2011',	'sadenice lesných drevín',	1860.00,	'Urbárske poz. spol. Vikartovce',	'2011-06-02',	'0000-00-00',	'img124.pdf',	3,	0,	'2017-04-27 09:42:01',	517,	9025,	0),
(76,	24,	'',	'5/2011',	'inštalácia sklotextilných tapiet',	1547.41,	'Karki s.r.o.',	'2011-06-03',	'0000-00-00',	'img125.pdf',	3,	0,	'2017-04-27 09:42:01',	461,	9025,	0),
(77,	24,	'',	'6/2011',	'pokládka koberca',	1373.14,	'Ončiš s.r.o.',	'2011-06-28',	'0000-00-00',	'img127.pdf',	3,	0,	'2017-04-27 09:42:01',	475,	9025,	0),
(78,	24,	'',	'8/2011',	'sadenice lesných drevín',	2070.80,	'Urbárske poz. spol. Vikartovce',	'2011-09-05',	'0000-00-00',	'img128.pdf',	3,	0,	'2017-04-27 09:42:01',	458,	9025,	0),
(79,	24,	'',	'10/2011',	'oprava LC Preslop a zriadenie priepustov',	2225.00,	'Lesostav Poprad, s.r.o.',	'2011-09-08',	'0000-00-00',	'img129.pdf',	3,	0,	'2017-04-27 09:42:01',	483,	9025,	0),
(80,	25,	'zmluva o vykonaní ťažby a manipulácii dreva',	'6/2011',	'ťažba, približovanie, triedenie dreva',	0.00,	'Gavaler Ján',	'2011-09-02',	'2011-12-31',	'img135.pdf',	3,	0,	'2017-04-27 09:42:41',	625,	9024,	0),
(81,	25,	'zmluva o vykonaní ťažby a manipulácii dreva',	'7/2011',	'ťažba, približovanie, triedenie dreva',	0.00,	'Hlavčák Jozef',	'2011-09-02',	'2011-12-31',	'img136.pdf',	3,	0,	'2017-04-27 09:42:41',	848,	9024,	0),
(82,	25,	'Nájomná zmluva o dočasnom užívaní lesného p',	'1/2011',	'časť lesného pozemku parcela KN-C č. 7538/1',	185.85,	'Sklenka Peter, Mgr.',	'2011-10-21',	'0000-00-00',	'velri.pdf',	3,	0,	'2017-04-27 09:42:41',	517,	9024,	0),
(104,	25,	'zmluva o dielo',	'1/2012',	'ťažba, približovanie, manipulácia dreva',	0.00,	'LVL Schory, spol. s r.o.',	'2012-02-15',	'2012-12-31',	'zmluvy_2012.pdf',	3,	0,	'2017-04-27 09:42:41',	472,	9024,	0),
(105,	25,	'zmluva o dielo',	'2/2012',	'ťažba, približovanie, manipulácia dreva',	0.00,	'Michal Korenko',	'2012-02-15',	'2012-12-31',	'zmluvy_2-2012.pdf',	3,	0,	'2017-04-27 09:42:41',	483,	9024,	0),
(106,	25,	'zmluva o dielo',	'3/2012',	'ťažba, približovanie, manipulácia dreva',	0.00,	'Stemp M&G s.r.o.',	'2012-02-15',	'2012-12-31',	'zmluvy_3-2012.pdf',	3,	0,	'2017-04-27 09:42:41',	487,	9024,	0),
(107,	25,	'Dodatok č.1 k nájomnej zmluve',	'1/10/2012',	'dočasné užívanie lesného pozemku',	37.80,	'Dietrich Anton',	'2012-03-12',	'2017-03-12',	'zmluvy_4-2012.pdf',	3,	0,	'2017-04-27 09:42:41',	479,	9024,	0),
(108,	25,	'zmluva o dielo',	'4/2012',	'ťažba, približovanie, manipulácia dreva',	0.00,	'Milan Bujnovský',	'2012-03-15',	'2012-12-31',	'zmluvy_5-2012.pdf',	3,	0,	'2017-04-27 09:42:41',	487,	9024,	0),
(109,	25,	'zmluva o dielo',	'5/2012',	'ťažba, približovanie, manipulácia dreva',	0.00,	'Miroslav Karabin',	'2012-03-15',	'2012-12-31',	'zmluvy_6-2012.pdf',	3,	0,	'2017-04-27 09:42:41',	499,	9024,	0),
(110,	25,	'zmluva o dielo',	'6/2012',	'ťažba, približovanie, manipulácia dreva',	0.00,	'Gavaler Ján',	'2012-03-16',	'2012-12-31',	'zmluvy_7-2012.pdf',	3,	0,	'2017-04-27 09:42:41',	482,	9024,	0),
(111,	25,	'zmluva o dielo',	'7/2012',	'ťažba, približovanie, manipulácia dreva',	0.00,	'Hlavčák Jozef',	'2012-03-16',	'2012-12-31',	'zmluvy_8-2012.pdf',	3,	0,	'2017-04-27 09:42:41',	493,	9024,	0),
(112,	25,	'Darovacia zmluva',	'1/28/2012',	'drevná hmota',	351.90,	'Mesto Poprad',	'2012-06-08',	'2012-12-31',	'zmluvy_9-2012.pdf',	3,	0,	'2017-04-27 09:42:41',	480,	9024,	0),
(113,	25,	'dodatok č.3 k zmluve',	'PR00111',	'nenavratný finančný príspevok',	641907.81,	'PÃ´dohospodárska platobná agentúra',	'2012-06-06',	'2012-06-30',	'zmluvy9-2012.pdf',	3,	0,	'2017-04-27 09:42:41',	492,	9024,	0),
(114,	25,	'dohoda o poskytnutí náhrady',	'789/2012',	'náhrada za obmedzenie vlastníckych práv',	1.20,	'Mesto Poprad',	'2012-07-10',	'2012-12-31',	'zmluvy_11-2012.pdf',	3,	0,	'2017-04-27 09:42:41',	481,	9024,	0),
(115,	23,	'',	'7/2012',	'prehľad faktúr za obdobie júl 2012',	0.00,	'dodávatelia',	'2012-07-31',	'0000-00-00',	'faktry_7-_2012.pdf',	3,	0,	'2017-04-27 09:41:35',	719,	9023,	0),
(119,	25,	'Darovacia zmluva',	'1/37/2012',	'drevná hmota',	1821.60,	'Mesto Poprad',	'2012-09-13',	'2012-09-21',	'zmluvy_12-2012.pdf',	3,	0,	'2017-04-27 09:42:41',	487,	9024,	0),
(120,	23,	'',	'1/2012',	'prehľad faktúr za obdobie január 2012',	0.00,	'dodávatelia',	'2012-01-31',	'0000-00-00',	'faktry_1-2012.pdf',	3,	0,	'2017-04-27 09:41:35',	697,	9023,	0),
(121,	23,	'',	'2/2012',	'prehľad faktúr za obdobie február 2012',	0.00,	'dodávatelia',	'2012-02-29',	'0000-00-00',	'faktry_2-2012.pdf',	3,	0,	'2017-04-27 09:41:35',	664,	9023,	0),
(122,	23,	'',	'3/2012',	'prehľad faktúr za obdobie marec 2012',	0.00,	'dodávatelia',	'2012-03-30',	'0000-00-00',	'faktry_3-2012.pdf',	3,	0,	'2017-04-27 09:41:35',	664,	9023,	0),
(123,	23,	'',	'4/2012',	'prehľad faktúr za obdobie apríl 2012',	0.00,	'dodávatelia',	'2012-04-30',	'0000-00-00',	'faktry_4-2012.pdf',	3,	0,	'2017-04-27 09:41:35',	674,	9023,	0),
(124,	23,	'',	'5/2012',	'prehľad faktúr za obdobie máj 2012',	0.00,	'dodávatelia',	'2012-06-29',	'0000-00-00',	'faktry_5-2012.pdf',	3,	0,	'2017-04-27 09:41:35',	669,	9023,	0),
(126,	23,	'',	'6/2012',	'prehľad faktúr za obdobie jún 2012',	0.00,	'dodávatelia',	'2012-06-29',	'0000-00-00',	'faktry_6-2012.pdf',	3,	0,	'2017-04-27 09:41:35',	663,	9023,	0),
(127,	23,	'',	'8/2012',	'prehľad faktúr za obdobie august 2012',	0.00,	'dodávatelia',	'2012-08-31',	'0000-00-00',	'faktry_8-2012.pdf',	3,	0,	'2017-04-27 09:41:35',	689,	9023,	0),
(129,	25,	'Zmluva o podnájme priestorov',	'1/29/2012',	'lesné pozemky',	796.80,	'Brantner Poprad, s.r.o.',	'2012-09-25',	'0000-00-00',	'zmluvy29-2012.pdf',	3,	0,	'2017-04-27 09:42:41',	476,	9024,	0),
(135,	25,	'Dodatok č.2 k nájomnej zmluve',	'1/39/2012',	'lesné pozemky',	0.00,	'Mesto Poprad',	'2012-10-24',	'0000-00-00',	'zmluvy_14-_2012.pdf',	3,	0,	'2017-04-27 09:42:41',	477,	9024,	0),
(136,	23,	'',	'9/2012',	'prehľad faktúr za obdobie september 2012',	0.00,	'dodávatelia',	'2012-09-30',	'0000-00-00',	'faktry_9-2012.pdf',	3,	0,	'2017-04-27 09:41:35',	693,	9023,	0),
(139,	23,	'',	'10/2012',	'prehľad faktúr za obdobie október 2012',	0.00,	'dodávatelia',	'2012-10-31',	'0000-00-00',	'faktry_10-2012.pdf',	3,	0,	'2017-04-27 09:41:35',	667,	9023,	0),
(142,	24,	'',	'9/2012',	'',	0.00,	'prehľad objednávok za júl 2012',	'2012-07-13',	'0000-00-00',	'objednvky_jl_2012.pdf',	3,	0,	'2017-04-27 09:42:01',	471,	9025,	0),
(144,	24,	'',	'11/2012',	'',	0.00,	'prehľad objednávok za september 2012',	'2012-09-14',	'0000-00-00',	'objednvky_september_2012.pdf',	3,	0,	'2017-04-27 09:42:01',	466,	9025,	0),
(146,	24,	'',	'1/2012',	'',	0.00,	'prehľad objednávok za január 2012',	'2012-01-13',	'0000-00-00',	'objednvky_jan_2012.pdf',	3,	0,	'2017-04-27 09:42:01',	455,	9025,	0),
(149,	24,	'',	'4/2012',	'',	0.00,	'prehľad objednávok za apríl 2012',	'2012-04-13',	'0000-00-00',	'objednvky_apr1_2012.pdf',	3,	0,	'2017-04-27 09:42:01',	458,	9025,	0),
(150,	24,	'',	'5/2012',	'',	0.00,	'prehľad objednávok za apríl2 2012',	'2012-04-30',	'0000-00-00',	'objednvky_apr2_2012.pdf',	3,	0,	'2017-04-27 09:42:01',	447,	9025,	0),
(151,	24,	'',	'6/2012',	'',	0.00,	'prehľad objednávok za máj 2012',	'2012-05-15',	'0000-00-00',	'objednvky_maj_2012.pdf',	3,	0,	'2017-04-27 09:42:01',	450,	9025,	0),
(152,	24,	'',	'7/2012',	'',	0.00,	'prehľad objednávok za máj2 2012',	'2012-05-31',	'0000-00-00',	'objednvky_maj2_2012.pdf',	3,	0,	'2017-04-27 09:42:01',	449,	9025,	0),
(153,	24,	'',	'8/2012',	'',	0.00,	'prehľad objednávok za jún 2012',	'2012-06-15',	'0000-00-00',	'objednvky_jun_2012.pdf',	3,	0,	'2017-04-27 09:42:01',	451,	9025,	0),
(155,	25,	'Darovacia zmluva',	'1/40/2012',	'drevná hmota',	322.56,	'Mesto Poprad',	'2012-10-29',	'2012-11-09',	'zmluvy_40-2012.pdf',	3,	0,	'2017-04-27 09:42:41',	476,	9024,	0),
(156,	25,	'Nájomná zmluva o dočasnom užívaní lesného p',	'1/41/2012',	'chov včelstiev',	4.32,	'Varečková Anna',	'2012-11-09',	'0000-00-00',	'zmluvy_41-2012.pdf',	3,	0,	'2017-04-27 09:42:41',	510,	9024,	0),
(157,	25,	'Zmluva o udelení licencie - dodatok',	'1/42/2012',	'software LHKE',	237.59,	'Foresta SK, a.s.',	'2012-11-28',	'0000-00-00',	'zmluvy_42-2012.pdf',	3,	0,	'2017-04-27 09:42:41',	494,	9024,	0),
(159,	23,	'',	'11/2012',	'prehľad faktúr za obdobie november 2012',	0.00,	'dodávatelia',	'2012-11-30',	'0000-00-00',	'Nfaktry11-2012.pdf',	3,	0,	'2017-04-27 09:41:35',	689,	9023,	0),
(164,	24,	'',	'2/2012',	'',	0.00,	'prehľad objednávok za február 2012',	'2012-02-14',	'0000-00-00',	'februar2012.pdf',	3,	0,	'2017-04-27 09:42:01',	436,	9025,	0),
(165,	24,	'',	'3/2012',	'',	0.00,	'prehľad objednávok za marec 2012',	'2012-03-30',	'0000-00-00',	'marec2012.pdf',	3,	0,	'2017-04-27 09:42:01',	437,	9025,	0),
(166,	24,	'',	'10/2012',	'',	0.00,	'prehľad objednávok za august 2012',	'2012-08-14',	'0000-00-00',	'august2012.pdf',	3,	0,	'2017-04-27 09:42:01',	440,	9025,	0),
(167,	24,	'',	'12/2012',	'',	0.00,	'prehľad objednávok za oktober 2012',	'2012-10-12',	'0000-00-00',	'oktober_2012.pdf',	3,	0,	'2017-04-27 09:42:01',	437,	9025,	0),
(168,	24,	'',	'13/2012',	'',	0.00,	'prehľad objednávok za oktober2 2012',	'2012-10-31',	'0000-00-00',	'oktober2_2012.pdf',	3,	0,	'2017-04-27 09:42:01',	447,	9025,	0),
(169,	24,	'',	'14/2012',	'',	0.00,	'prehľad objednávok za november 2012',	'2012-11-14',	'0000-00-00',	'november_2012.pdf',	3,	0,	'2017-04-27 09:42:01',	439,	9025,	0),
(170,	24,	'',	'15/2012',	'',	0.00,	'prehľad objednávok za november2 2012',	'2012-11-30',	'0000-00-00',	'november2_2012.pdf',	3,	0,	'2017-04-27 09:42:01',	444,	9025,	0),
(171,	24,	'',	'16/2012',	'',	0.00,	'prehľad objednávok za december 2012',	'2012-12-14',	'0000-00-00',	'december_2012.pdf',	3,	0,	'2017-04-27 09:42:01',	450,	9025,	0),
(172,	24,	'',	'1/2013',	'',	0.00,	'prehľad objednávok za januar 2013',	'2013-01-31',	'0000-00-00',	'januar_2013.pdf',	3,	0,	'2017-04-27 09:42:01',	456,	9025,	0),
(175,	25,	'zmluva o poskytnutí dotácie',	'418/1169-36/2012',	'dotácia na mladé lesné porasty',	6526.14,	'PÃ´dohospodárska platobná agentúra',	'2012-12-11',	'2012-12-31',	'zmluva18-2012.pdf',	3,	0,	'2017-04-27 09:42:41',	462,	9024,	0),
(176,	25,	'Rámcová kúpna zmluva',	'1/2013',	'dodávka drevnej hmoty',	0.00,	'Zolka Zvolen, s.r.o.',	'2013-01-07',	'2013-12-31',	'zmluva1-2013.pdf',	3,	0,	'2017-04-27 09:42:41',	462,	9024,	0),
(177,	23,	'',	'1/2013',	'prehľad faktúr za obdobie januar 2013',	0.00,	'dodávatelia',	'2013-01-31',	'0000-00-00',	'faktry_1-2013.pdf',	3,	0,	'2017-04-27 09:41:35',	643,	9023,	0),
(178,	23,	'',	'2/2013',	'prehľad faktúr za obdobie februar 2013',	0.00,	'dodávatelia',	'2013-02-28',	'0000-00-00',	'faktry_2-2013.pdf',	3,	0,	'2017-04-27 09:41:35',	651,	9023,	0),
(180,	24,	'',	'3/2013',	'',	0.00,	'prehľad objednávok za marec 2013',	'2013-03-15',	'0000-00-00',	'marec_2013.pdf',	3,	0,	'2017-04-27 09:42:01',	461,	9025,	0),
(185,	24,	'',	'2/2013',	'',	0.00,	'prehľad objednávok za február 2013',	'2013-02-28',	'0000-00-00',	'februar_2013.pdf',	3,	0,	'2017-04-27 09:42:01',	437,	9025,	0),
(186,	25,	'Kúpna zmluva',	'30/2013',	'dodávka terénneho vozidla',	33871.00,	'Dove, s.r.o.',	'2013-04-12',	'2015-12-31',	'zmluvy30_2013.pdf',	3,	0,	'2017-04-27 09:42:41',	502,	9024,	0),
(187,	25,	'zmluva o dielo',	'37/2013',	'Foliovník Kvetnica',	11704.61,	'Lesostav Poprad, s.r.o.',	'2013-04-18',	'2015-12-31',	'zmluva_37_2013.pdf',	3,	0,	'2017-04-27 09:42:41',	461,	9024,	0),
(189,	24,	'',	'5/2013',	'',	0.00,	'prehľad objednávok za april-2 2013',	'2013-04-15',	'0000-00-00',	'april2_2013.pdf',	3,	0,	'2017-04-27 09:42:01',	440,	9025,	0),
(193,	23,	'',	'3/2013',	'prehľad faktúr za obdobie marec 2013',	0.00,	'dodávatelia',	'2013-03-29',	'0000-00-00',	'faktry_3-2013.pdf',	3,	0,	'2017-04-27 09:41:35',	635,	9023,	0),
(197,	24,	'',	'4/2013',	'',	0.00,	'prehľad objednávok za april 2013',	'2013-04-01',	'0000-00-00',	'april_2013.pdf',	3,	0,	'2017-04-27 09:42:01',	449,	9025,	0),
(199,	25,	'zmluva o dodávkach a odberoch tovaru',	'2/2013',	'drevná štiepka',	1680.00,	'Prius solution s.r.o.',	'2013-01-08',	'2013-12-31',	'zmluva2-2013.pdf',	3,	0,	'2017-04-27 09:42:41',	458,	9024,	0),
(200,	25,	'zmluva o poskytnutí poradenských služieb',	'3/2013',	'žiadosť o poskytnutie príspevku z PPA',	1800.00,	'BF Forest, s.r.o., Kvetná 2693/16, Poprad',	'2013-04-02',	'2015-12-31',	'zmluva39-2013.pdf',	3,	0,	'2017-04-27 09:42:41',	450,	9024,	0),
(202,	24,	'',	'6/2013',	'',	0.00,	'prehľad objednávok za máj 2013',	'2013-05-15',	'0000-00-00',	'maj_2013.pdf',	3,	0,	'2017-04-27 09:42:01',	434,	9025,	0),
(203,	25,	'dodatok k nájomnej zmluve',	'42/2013',	'lesné pozemky',	0.00,	'mesto Poprad',	'2013-05-29',	'0000-00-00',	'zmluva_42-2013.pdf',	3,	0,	'2017-04-27 09:42:41',	472,	9024,	0),
(204,	25,	'darovacia zmluva',	'43/2013',	'drevná hmota',	315.00,	'mesto Poprad',	'2013-06-03',	'2013-06-30',	'zmluva_43-2013.pdf',	3,	0,	'2017-04-27 09:42:41',	452,	9024,	0),
(205,	25,	'nájomná zmluva',	'41/2013',	'lesné pozemky',	1.00,	'Rímskokatolícka cirkev, farnosť Poprad',	'2013-06-13',	'2033-06-15',	'zmluva_41-2013.pdf',	3,	0,	'2017-04-27 09:42:41',	471,	9024,	0),
(206,	25,	'nájomná zmluva',	'45/2013',	'lesné cesty',	0.00,	'Slovenský pozemkový fond Bratislava',	'2013-06-28',	'0000-00-00',	'zmluva_45-2013.pdf',	3,	0,	'2017-04-27 09:42:41',	458,	9024,	0),
(207,	24,	'',	'7/2013',	'',	0.00,	'prehľad objednávok za jún 2013',	'2013-06-14',	'0000-00-00',	'jun_2013.pdf',	3,	0,	'2017-04-27 09:42:01',	420,	9025,	0),
(208,	24,	'',	'8/2013',	'',	0.00,	'prehľad objednávok za júl 2013',	'2013-07-15',	'0000-00-00',	'jul_2013.pdf',	3,	0,	'2017-04-27 09:42:01',	420,	9025,	0),
(209,	24,	'',	'9/2013',	'',	0.00,	'prehľad objednávok za júl2 2013',	'2013-07-31',	'0000-00-00',	'jul2_2013.pdf',	3,	0,	'2017-04-27 09:42:01',	439,	9025,	0),
(210,	23,	'',	'6/2013',	'prehľad faktúr za obdobie jún 2013',	0.00,	'dodávatelia',	'2013-06-28',	'0000-00-00',	'faktry_6-2013.pdf',	3,	0,	'2017-04-27 09:41:35',	587,	9023,	0),
(211,	23,	'',	'7/2013',	'prehľad faktúr za obdobie júl 2013',	0.00,	'dodávatelia',	'2013-07-31',	'0000-00-00',	'faktry_7-2013.pdf',	3,	0,	'2017-04-27 09:41:35',	607,	9023,	0),
(212,	23,	'',	'5/2013',	'prehľad faktúr za obdobie máj 2013',	0.00,	'dodávatelia',	'2013-05-31',	'0000-00-00',	'faktry_5-2013.pdf',	3,	0,	'2017-04-27 09:41:35',	604,	9023,	0),
(214,	23,	'',	'4/2013',	'prehľad faktúr za obdobie apríl 2013',	0.00,	'dodávatelia',	'2013-04-30',	'0000-00-00',	'faktry_4-2013.pdf',	3,	0,	'2017-04-27 09:41:35',	599,	9023,	0),
(215,	23,	'',	'8/2013',	'prehľad faktúr za obdobie august 2013',	0.00,	'dodávatelia',	'2013-08-30',	'0000-00-00',	'faktry_8-2013.pdf',	3,	0,	'2017-04-27 09:41:35',	586,	9023,	0),
(217,	24,	'',	'10/2013',	'',	0.00,	'prehľad objednávok za august 2013',	'2013-08-15',	'0000-00-00',	'august_2013.pdf',	3,	0,	'2017-04-27 09:42:01',	435,	9025,	0),
(218,	24,	'',	'11/2013',	'',	0.00,	'prehľad objednávok za september 2013',	'2013-09-16',	'0000-00-00',	'sept_2013.pdf',	3,	0,	'2017-04-27 09:42:01',	433,	9025,	0),
(219,	24,	'',	'12/2013',	'',	0.00,	'prehľad objednávok za september2 2013',	'2013-09-30',	'0000-00-00',	'sept2-2013.pdf',	3,	0,	'2017-04-27 09:42:01',	425,	9025,	0),
(220,	25,	'darovacia zmluva',	'54/2013',	'drevná hmota',	322.56,	'Mesto Poprad',	'2013-09-26',	'2013-12-31',	'zmluva_54-2013.pdf',	3,	0,	'2017-04-27 09:42:41',	432,	9024,	0),
(225,	23,	'',	'9/2013',	'prehľad faktúr za obdobie september 2013',	0.00,	'dodávatelia',	'2013-09-30',	'0000-00-00',	'faktry_9-2013.pdf',	3,	0,	'2017-04-27 09:41:35',	569,	9023,	0),
(226,	23,	'',	'10/2013',	'prehľad faktúr za obdobie oktober 2013',	0.00,	'dodávatelia',	'2013-10-31',	'0000-00-00',	'faktry_10-2013.pdf',	3,	0,	'2017-04-27 09:41:35',	608,	9023,	0),
(227,	24,	'',	'13/2013',	'',	0.00,	'prehľad objednávok za oktober 2013',	'2013-10-15',	'0000-00-00',	'oktober_2013.pdf',	3,	0,	'2017-04-27 09:42:01',	416,	9025,	0),
(228,	24,	'',	'14/2013',	'',	0.00,	'prehľad objednávok za oktober2 2013',	'2013-10-31',	'0000-00-00',	'oktober_2_2013.pdf',	3,	0,	'2017-04-27 09:42:01',	418,	9025,	0),
(229,	25,	'zmluva o poskytnutí dotácie',	'418/1148-10/2013',	'dotácia',	4399.70,	'PÃ´dohospodárska platobná agentúra',	'2013-11-04',	'2013-12-31',	'zmluva_418.pdf',	3,	0,	'2017-04-27 09:42:41',	410,	9024,	0),
(230,	25,	'darovacia zmluva',	'60/2013',	'ihličnatá guľatina',	840.06,	'Mesto Poprad',	'2013-12-11',	'2013-12-31',	'zmluva_60-2013.pdf',	3,	0,	'2017-04-27 09:42:41',	425,	9024,	0),
(232,	24,	'',	'16/2013',	'',	0.00,	'prehľad objednávok za november2 2013',	'2013-11-29',	'0000-00-00',	'nov2_2013.pdf',	3,	0,	'2017-04-27 09:42:01',	393,	9025,	0),
(233,	24,	'',	'17/2013',	'',	0.00,	'prehľad objednávok za december 2013',	'2013-12-16',	'0000-00-00',	'dec_2013.pdf',	3,	0,	'2017-04-27 09:42:01',	391,	9025,	0),
(234,	24,	'',	'18/2013',	'',	0.00,	'prehľad objednávok za december 2 2013',	'2013-12-20',	'0000-00-00',	'dec2_2013.pdf',	3,	0,	'2017-04-27 09:42:01',	397,	9025,	0),
(235,	24,	'',	'15/2013',	'',	0.00,	'prehľad objednávok za november 2013',	'2013-11-15',	'0000-00-00',	'november_2013.pdf',	3,	0,	'2017-04-27 09:42:01',	392,	9025,	0),
(236,	23,	'',	'11/2013',	'prehľad faktúr za obdobie november 2013',	0.00,	'dodávatelia',	'2013-11-29',	'0000-00-00',	'faktry_11-2013.pdf',	3,	0,	'2017-04-27 09:41:35',	543,	9023,	0),
(237,	23,	'',	'12/2013',	'prehľad faktúr za obdobie december 2013',	0.00,	'dodávatelia',	'2013-12-31',	'0000-00-00',	'faktry_12-2013.pdf',	3,	0,	'2017-04-27 09:41:35',	549,	9023,	0),
(238,	25,	'zmluva na vykonanie odsúhlasených postupov',	'1/2014',	'Služby audítora',	360.00,	'GemerAudit, spol. s r.o.',	'2014-01-29',	'2014-12-31',	'zmluva1-2014.pdf',	3,	0,	'2017-04-27 09:42:41',	392,	9024,	0),
(239,	25,	'Rámcová kúpna zmluva',	'9/2014',	'ihličnatá guľatina, vláknina',	0.00,	'Zolka Zvolen, s.r.o.',	'2014-02-07',	'2014-12-31',	'zmluva2-2014.pdf',	3,	0,	'2017-04-27 09:42:41',	410,	9024,	0),
(240,	23,	'',	'1/2014',	'prehľad faktúr za obdobie január  2014',	0.00,	'dodávatelia',	'2014-02-12',	'0000-00-00',	'faktry_1-2014.pdf',	3,	0,	'2017-04-27 09:41:35',	523,	9023,	0),
(241,	23,	'',	'2/2014',	'prehľad faktúr za obdobie február  2014',	0.00,	'dodávatelia',	'2014-03-14',	'0000-00-00',	'faktry_2-2014.pdf',	3,	0,	'2017-04-27 09:41:35',	549,	9023,	0),
(242,	24,	'',	'1/2014',	'',	0.00,	'prehľad objednávok za január 2013',	'2014-01-15',	'0000-00-00',	'objednvky_1-2014.pdf',	3,	0,	'2017-04-27 09:42:01',	356,	9025,	0),
(243,	24,	'',	'2/2014',	'',	0.00,	'prehľad objednávok za február 2013',	'2014-02-14',	'0000-00-00',	'objednvky_2-2014.pdf',	3,	0,	'2017-04-27 09:42:01',	367,	9025,	0),
(244,	25,	'darovacia zmluva',	'10/2014',	'ihličnatá guľatina smrekovec',	4320.00,	'Rímskokatolícka cirkev, farnosť Poprad',	'2014-04-02',	'2014-04-30',	'zmluva_10-2014.pdf',	3,	0,	'2017-04-27 09:42:41',	356,	9024,	0),
(246,	25,	'Kúpna zmluva',	'13/2014',	'Lesovňa Kolieska',	2220.00,	'Marek Kovalčík',	'2014-04-16',	'2014-04-16',	'zmluva13_2014.pdf',	3,	0,	'2017-04-27 09:42:41',	367,	9024,	0),
(247,	25,	'Rámcová zmluva',	'6/2014',	'Práce v pestovnej činnosti',	19820.00,	'Anna Jakubčáková a spol.',	'2014-02-03',	'2015-05-31',	'zmluva6-2014.pdf',	3,	0,	'2017-04-27 09:42:41',	336,	9024,	0),
(248,	25,	'Kúpna zmluva',	'7/2014',	'sadenice lesných drevín',	18915.12,	'Urbárske pozemkové spoločenstvo Vikartovce',	'2014-02-03',	'2015-05-31',	'zmluva7-2014.pdf',	3,	0,	'2017-04-27 09:42:41',	343,	9024,	0),
(249,	25,	'Dodatok k nájomnej zmluve',	'5/2014',	'lesné pozemky',	1.00,	'Mesto Poprad',	'2014-03-06',	'2019-12-31',	'zmluva5-2014.pdf',	3,	0,	'2017-04-27 09:42:41',	357,	9024,	0),
(250,	25,	'Dodatok k zmluve o udelení licencie',	'21/2014',	'Program Webles',	249.59,	'Foresta SK, a.s.',	'2014-05-20',	'2014-12-31',	'zmluva21-2014.pdf',	3,	0,	'2017-04-27 09:42:41',	349,	9024,	0),
(251,	24,	'',	'4/2014',	'',	0.00,	'prehľad objednávok za marec2 2014',	'2014-04-01',	'0000-00-00',	'objednvky3-2-2014.pdf',	3,	0,	'2017-04-27 09:42:01',	359,	9025,	0),
(253,	23,	'',	'3/2014',	'prehľad faktúr za obdobie marec  2014',	0.00,	'dodávatelia',	'2014-04-09',	'0000-00-00',	'faktry_3-2014.pdf',	3,	0,	'2017-04-27 09:41:35',	488,	9023,	0),
(254,	23,	'',	'4/2014',	'prehľad faktúr za obdobie apríl  2014',	0.00,	'dodávatelia',	'2014-05-13',	'0000-00-00',	'faktry_4-2014.pdf',	3,	0,	'2017-04-27 09:41:35',	505,	9023,	0),
(255,	25,	'Dodatok č. 5 k nájomnej zmluve',	'23/2014',	'lesné pozemky',	0.00,	'Mesto Poprad',	'2014-06-10',	'0000-00-00',	'zmluva23-2014.pdf',	3,	0,	'2017-04-27 09:42:41',	355,	9024,	0),
(256,	23,	'',	'5/2014',	'prehľad faktúr za obdobie máj  2014',	0.00,	'dodávatelia',	'2014-06-10',	'0000-00-00',	'faktry5-2014.pdf',	3,	0,	'2017-04-27 09:41:35',	457,	9023,	0),
(258,	24,	'',	'5/2014',	'',	0.00,	'prehľad objednávok za apríl 2014',	'2014-04-16',	'0000-00-00',	'objednvky4-2014.pdf',	3,	0,	'2017-04-27 09:42:01',	341,	9025,	0),
(260,	24,	'',	'6/2014',	'',	0.00,	'prehľad objednávok za máj1 2014',	'2014-05-16',	'0000-00-00',	'objednvky5-2014.pdf',	3,	0,	'2017-04-27 09:42:01',	323,	9025,	0),
(261,	24,	'',	'7/2014',	'',	0.00,	'prehľad objednávok za máj2 2014',	'2014-06-02',	'0000-00-00',	'objednvky52-2014.pdf',	3,	0,	'2017-04-27 09:42:01',	343,	9025,	0),
(262,	24,	'',	'8/2014',	'',	0.00,	'prehľad objednávok za jún1 2014',	'2014-06-16',	'0000-00-00',	'objednvky6-2014.pdf',	3,	0,	'2017-04-27 09:42:01',	338,	9025,	0),
(263,	24,	'',	'9/2014',	'',	0.00,	'prehľad objednávok za jún2 2014',	'2014-07-01',	'0000-00-00',	'objednvky62-2014.pdf',	3,	0,	'2017-04-27 09:42:01',	348,	9025,	0),
(264,	25,	'Darovacia zmluva',	'25/2014',	'ihličnaté palivo',	129.02,	'Klub Strážanov',	'2014-09-18',	'2014-09-30',	'zmluva25-2014.pdf',	3,	0,	'2017-04-27 09:42:41',	314,	9024,	0),
(265,	25,	'Dodatok č. 6 k nájomnej zmluve',	'26/2014',	'lesné pozemky',	0.00,	'Mesto Poprad',	'2014-09-19',	'0000-00-00',	'zmluva26-2014.pdf',	3,	0,	'2017-04-27 09:42:41',	320,	9024,	0),
(269,	24,	'',	'11/2014',	'',	0.00,	'prehľad objednávok za júl2 2014',	'2014-08-01',	'0000-00-00',	'objednvky72-2014.pdf',	3,	0,	'2017-04-27 09:42:01',	328,	9025,	0),
(271,	24,	'',	'12/2014',	'',	0.00,	'prehľad objednávok za august 2014',	'2014-08-18',	'0000-00-00',	'objednvky8_2014.pdf',	3,	0,	'2017-04-27 09:42:01',	318,	9025,	0),
(272,	24,	'',	'13/2014',	'',	0.00,	'prehľad objednávok za september 2014',	'2014-09-16',	'0000-00-00',	'objednvky_9-2014.pdf',	3,	0,	'2017-04-27 09:42:01',	313,	9025,	0),
(275,	24,	'',	'10/2014',	'',	0.00,	'prehľad objednávok za júl 2014',	'2014-07-16',	'0000-00-00',	'objednvky7-2014.pdf',	3,	0,	'2017-04-27 09:42:01',	317,	9025,	0),
(276,	25,	'Dodatok č. 1 k kúpnej zmluve',	'31/2014',	'sadenice lesných drevín',	8069.04,	'Urbárske poz. spol. Vikartovce',	'2014-11-24',	'2015-12-31',	'zmluva31-2014.pdf',	3,	0,	'2017-04-27 09:42:41',	298,	9024,	0),
(277,	25,	'kúpna zmluva',	'33/2014',	'sadenice lesných drevín',	6400.80,	'Urbárske poz. spol. Vikartovce',	'2014-12-15',	'2015-12-31',	'zmluva33-2014.pdf',	3,	0,	'2017-04-27 09:42:41',	310,	9024,	0),
(278,	24,	'',	'14/2014',	'',	0.00,	'prehľad objednávok za október 2014',	'2014-10-16',	'0000-00-00',	'objednvky10-2014.pdf',	3,	0,	'2017-04-27 09:42:01',	313,	9025,	0),
(279,	24,	'',	'15/2014',	'',	0.00,	'prehľad objednávok za november-1 2014',	'2014-11-17',	'0000-00-00',	'objednvky_11-2014.pdf',	3,	0,	'2017-04-27 09:42:01',	308,	9025,	0),
(280,	24,	'',	'16/2014',	'',	0.00,	'prehľad objednávok za november-2 2014',	'2014-12-01',	'0000-00-00',	'objednvky_112-2014.pdf',	3,	0,	'2017-04-27 09:42:01',	304,	9025,	0),
(286,	23,	'',	'6/2014',	'prehľad faktúr za obdobie jún 2014',	0.00,	'dodávatelia',	'2014-07-11',	'0000-00-00',	'faktry6-2014.pdf',	3,	0,	'2017-04-27 09:41:35',	366,	9023,	0),
(287,	23,	'',	'7/2014',	'prehľad faktúr za obdobie júl 2014',	0.00,	'dodávatelia',	'2014-08-12',	'0000-00-00',	'faktry7-2014.pdf',	3,	0,	'2017-04-27 09:41:35',	384,	9023,	0),
(288,	23,	'',	'8/2014',	'prehľad faktúr za obdobie august 2014',	0.00,	'dodávatelia',	'2014-09-09',	'0000-00-00',	'faktry_8-2014.pdf',	3,	0,	'2017-04-27 09:41:35',	351,	9023,	0),
(289,	23,	'',	'9/2014',	'prehľad faktúr za obdobie september 2014',	0.00,	'dodávatelia',	'2014-10-10',	'0000-00-00',	'faktry9-2014.pdf',	3,	0,	'2017-04-27 09:41:35',	385,	9023,	0),
(291,	23,	'',	'10/2014',	'prehľad faktúr za obdobie októbert 2014',	0.00,	'dodávatelia',	'2014-11-14',	'0000-00-00',	'faktry_10-2014.pdf',	3,	0,	'2017-04-27 09:41:35',	379,	9023,	0),
(292,	23,	'',	'11/2014',	'prehľad faktúr za obdobie november 2014',	0.00,	'dodávatelia',	'2014-12-10',	'0000-00-00',	'faktry_11-2014.pdf',	3,	0,	'2017-04-27 09:41:35',	384,	9023,	0),
(294,	23,	'',	'12/2014',	'prehľad faktúr za obdobie december 2014',	0.00,	'dodávatelia',	'2014-12-31',	'0000-00-00',	'faktry12-2014.pdf',	3,	0,	'2017-04-27 09:41:35',	385,	9023,	0),
(295,	24,	'',	'17/2014',	'',	0.00,	'prehľad objednávok za december 2014',	'2014-12-16',	'0000-00-00',	'objednvky_12-2014.pdf',	3,	0,	'2017-04-27 09:42:01',	302,	9025,	0),
(296,	23,	'',	'1/2015',	'prehľad faktúr za obdobie január 2015',	0.00,	'dodávatelia',	'2015-02-12',	'0000-00-00',	'faktry_1-2015.pdf',	3,	0,	'2017-04-27 09:41:35',	393,	9023,	0),
(297,	24,	'',	'1/2015',	'',	0.00,	'prehľad objednávok za január-1 2015',	'2015-01-16',	'0000-00-00',	'objednvky1-2015.pdf',	3,	0,	'2017-04-27 09:42:01',	307,	9025,	0),
(301,	24,	'',	'2/2015',	'',	0.00,	'prehľad objednávok za január-2 2015',	'2015-02-02',	'0000-00-00',	'Nobjednvky2-2015.pdf',	3,	0,	'2017-04-27 09:42:01',	299,	9025,	0),
(302,	24,	'',	'3/2014',	'',	0.00,	'prehľad objednávok za marec 2014',	'2014-03-17',	'0000-00-00',	'objednvky_3-2014.pdf',	3,	0,	'2017-04-27 09:42:01',	295,	9025,	0),
(303,	24,	'',	'3/2015',	'',	0.00,	'prehľad objednávok za februar 1 2015',	'2015-02-16',	'0000-00-00',	'objednvky3-2015.pdf',	3,	0,	'2017-04-27 09:42:01',	281,	9025,	0),
(304,	24,	'',	'4/2015',	'',	0.00,	'prehľad objednávok za februar 2 2015',	'2015-03-02',	'0000-00-00',	'objednvky4-2015.pdf',	3,	0,	'2017-04-27 09:42:01',	288,	9025,	0),
(305,	23,	'',	'2/2015',	'prehľad faktúr za obdobie február 2015',	0.00,	'dodávatelia',	'2015-03-18',	'0000-00-00',	'faktry_2-_2015.pdf',	3,	0,	'2017-04-27 09:41:35',	380,	9023,	0),
(307,	25,	'rámcová kúpna zmluva',	'1/2015',	'ihličnatá guľatina',	0.00,	'Zolka Zvolen, s.r.o.',	'2015-01-12',	'2015-12-31',	'zmluva_1-2015.pdf',	3,	0,	'2017-04-27 09:42:41',	270,	9024,	0),
(308,	25,	'rámcová zmluva',	'4/2015',	'služby mechanizačnými prostriedkami',	0.00,	'Lesostav Poprad, s.r.o.',	'2015-01-16',	'2016-12-31',	'zmluva4-2015.pdf',	3,	0,	'2017-04-27 09:42:41',	280,	9024,	0),
(309,	25,	'Kúpna zmluva',	'5/2015',	'sadenice lesných drevín',	13860.00,	'Urbárske pozemkové spoločenstvo Vikartovce',	'2015-01-16',	'2016-04-15',	'zmluva5_2015.pdf',	3,	0,	'2017-04-27 09:42:41',	288,	9024,	0),
(310,	25,	'Dodatok č. 1 k zmluve o poradenstve',	'7/2015',	'poskytovanie odborných a poradenských služieb',	0.00,	'Ing. Eva Dobisová',	'2015-01-30',	'2015-05-31',	'zmluva7-2015.pdf',	3,	0,	'2017-04-27 09:42:41',	310,	9024,	0),
(312,	24,	'',	'5/2015',	'',	0.00,	'prehľad objednávok za marec 2015',	'2015-03-16',	'0000-00-00',	'objednvky5-2015.pdf',	3,	0,	'2017-04-27 09:42:01',	271,	9025,	0),
(313,	24,	'',	'6/2015',	'',	0.00,	'prehľad objednávok za marec-2 2015',	'2015-04-01',	'0000-00-00',	'objednvky6-2015.pdf',	3,	0,	'2017-04-27 09:42:01',	275,	9025,	0),
(314,	24,	'',	'7/2015',	'',	0.00,	'prehľad objednávok za april 2015',	'2015-04-17',	'0000-00-00',	'objednvky7-2015.pdf',	3,	0,	'2017-04-27 09:42:01',	281,	9025,	0),
(315,	23,	'',	'3/2015',	'prehľad faktúr za obdobie marec 2015',	0.00,	'dodávatelia',	'2015-04-15',	'0000-00-00',	'faktry3-2015.pdf',	3,	0,	'2017-04-27 09:41:35',	308,	9023,	0),
(317,	23,	'',	'4/2015',	'prehľad faktúr za obdobie april 2015',	0.00,	'dodávatelia',	'2015-05-08',	'0000-00-00',	'faktry4-2015.pdf',	3,	0,	'2017-04-27 09:41:35',	331,	9023,	0),
(320,	25,	'Darovacia zmluva',	'10/2015',	'ihličnatá guľatina',	1900.80,	'Klub Veličanov, Scherfelova 1360/36, 058 01 Poprad',	'2015-08-03',	'2015-09-01',	'zmluva10-2015.pdf',	3,	0,	'2017-04-27 09:42:41',	192,	9024,	0),
(321,	25,	'Zmluva o poskytnutí finančného daru',	'9/2015',	'finančný dar',	300.00,	'Cirkevná spojená škola, Cirkevné gymnázium Pavla Ušáka Olivu',	'2015-03-03',	'2015-03-10',	'zmluva9-2015.pdf',	3,	0,	'2017-04-27 09:42:41',	187,	9024,	0),
(322,	25,	'Darovacia zmluva',	'19/2015',	'ihličnatá guľatina',	129.02,	'Mesto Poprad',	'2015-07-01',	'2015-07-31',	'zmluva19-2015.pdf',	3,	0,	'2017-04-27 09:42:41',	214,	9024,	0),
(323,	25,	'Zmluva o dielo č.2/2015',	'90/2015',	'Lesná cesta Kvetnica - prestavba',	179520.00,	'Lesostav Poprad s.r.o.',	'2015-09-28',	'2016-11-30',	'zmluva90-2015.pdf',	3,	0,	'2017-04-27 09:42:41',	214,	9024,	0),
(324,	25,	'Zmluva o dielo',	'88/2015',	'pestovné práce',	142536.55,	'Forest LK, s.r.o.',	'2015-09-30',	'2018-12-31',	'zmluva88-2015.pdf',	3,	0,	'2017-04-27 09:42:41',	195,	9024,	0),
(326,	25,	'Zmluva o výpožičke',	'107/2015',	'drobný vodný tok Vysová',	0.00,	'LESY SR, š.p.',	'2015-09-30',	'2030-12-31',	'Nzmluva107-2015.pdf',	3,	0,	'2017-04-27 09:42:41',	217,	9024,	0),
(327,	23,	'',	'7/2015',	'prehľad faktúr za obdobie júl 2015',	0.00,	'dodávatelia',	'2015-08-14',	'0000-00-00',	'faktry7-2015.pdf',	3,	0,	'2017-04-27 09:41:35',	276,	9023,	0),
(328,	23,	'',	'8/2015',	'prehľad faktúr za obdobie august 2015',	0.00,	'dodávatelia',	'2015-09-10',	'0000-00-00',	'faktry8-2015.pdf',	3,	0,	'2017-04-27 09:41:35',	284,	9023,	0),
(329,	23,	'',	'9/2015',	'prehľad faktúr za obdobie september 2015',	0.00,	'dodávatelia',	'2015-10-14',	'0000-00-00',	'faktry9-2015.pdf',	3,	0,	'2017-04-27 09:41:35',	300,	9023,	0),
(330,	23,	'',	'5/2015',	'prehľad faktúr za obdobie máj 2015',	0.00,	'dodávatelia',	'2015-06-11',	'0000-00-00',	'faktry5-2015.pdf',	3,	0,	'2017-04-27 09:41:35',	266,	9023,	0),
(332,	24,	'',	'9/2015',	'',	0.00,	'prehľad objednávok za máj-2 2015',	'2015-06-01',	'0000-00-00',	'objednvky9-2015.pdf',	3,	0,	'2017-04-27 09:42:01',	209,	9025,	0),
(336,	24,	'',	'10/2015',	'',	0.00,	'prehľad objednávok za jún 2015',	'2015-06-16',	'0000-00-00',	'objednvky10-2015.pdf',	3,	0,	'2017-04-27 09:42:01',	207,	9025,	0),
(337,	24,	'',	'11/2015',	'',	0.00,	'prehľad objednávok za júl 2015',	'2015-07-16',	'0000-00-00',	'objednvky11-2015.pdf',	3,	0,	'2017-04-27 09:42:01',	213,	9025,	0),
(338,	24,	'',	'12/2015',	'',	0.00,	'prehľad objednávok za júl-2 2015',	'2015-08-03',	'0000-00-00',	'objednvky12-2015.pdf',	3,	0,	'2017-04-27 09:42:01',	205,	9025,	0),
(339,	24,	'',	'13/2015',	'',	0.00,	'prehľad objednávok za august 2015',	'2015-08-17',	'0000-00-00',	'objednvky13-2015.pdf',	3,	0,	'2017-04-27 09:42:01',	209,	9025,	0),
(341,	24,	'',	'14/2015',	'',	0.00,	'prehľad objednávok za september 2015',	'2015-09-16',	'0000-00-00',	'objednvky14-2015.pdf',	3,	0,	'2017-04-27 09:42:01',	201,	9025,	0),
(342,	24,	'',	'15/2015',	'',	0.00,	'prehľad objednávok za september2 2015',	'2015-10-01',	'0000-00-00',	'objednvky15-2015.pdf',	3,	0,	'2017-04-27 09:42:01',	207,	9025,	0),
(343,	25,	'Zmluva o dielo',	'109/2015',	'Protipožiarne nádrže Blech a Preslop',	34460.11,	'Lesostav Poprad s.r.o.',	'2015-10-09',	'2016-11-30',	'zmluva109-2015.pdf',	3,	0,	'2017-04-27 09:42:41',	208,	9024,	0),
(344,	23,	'',	'10/2015',	'prehľad faktúr za obdobie október 2015',	0.00,	'dodávatelia',	'2015-11-09',	'0000-00-00',	'faktry10-2015.pdf',	3,	0,	'2017-04-27 09:41:35',	222,	9023,	0),
(345,	23,	'',	'11/2015',	'prehľad faktúr za obdobie november 2015',	0.00,	'dodávatelia',	'2015-12-14',	'0000-00-00',	'faktry11-2015.pdf',	3,	0,	'2017-04-27 09:41:35',	213,	9023,	0),
(346,	23,	'',	'12/2015',	'prehľad faktúr za obdobie december 2015',	0.00,	'dodávatelia',	'2016-01-26',	'0000-00-00',	'faktry12-2015.pdf',	3,	0,	'2017-04-27 09:41:35',	220,	9023,	0),
(347,	24,	'',	'16/2015',	'',	0.00,	'prehľad objednávok za október 2015',	'2015-10-16',	'0000-00-00',	'objednvky16-2015.pdf',	3,	0,	'2017-04-27 09:42:01',	150,	9025,	0),
(348,	24,	'',	'17/2015',	'',	0.00,	'prehľad objednávok za november 2015',	'2015-11-16',	'0000-00-00',	'objednvky17-2015.pdf',	3,	0,	'2017-04-27 09:42:01',	150,	9025,	0),
(349,	24,	'',	'18/2015',	'',	0.00,	'prehľad objednávok za november-2 2015',	'2015-12-01',	'0000-00-00',	'objednvky18-2015.pdf',	3,	0,	'2017-04-27 09:42:01',	152,	9025,	0),
(350,	24,	'',	'19/2015',	'',	0.00,	'prehľad objednávok za december 2015',	'2015-12-16',	'0000-00-00',	'objednvky19-2015.pdf',	3,	0,	'2017-04-27 09:42:01',	164,	9025,	0),
(352,	25,	'Dodatok č. 2015/1 k Zmluve o udelení licencie',	'122/2015',	'software WebLES',	249.59,	'Foresta SK, a.s.',	'2015-12-04',	'2015-12-31',	'zmluva122-2015.pdf',	3,	0,	'2017-04-27 09:42:41',	135,	9024,	0),
(353,	25,	'kúpno - predajná zmluva',	'119/2015',	'osobný automobil',	1200.00,	'Stanislav Čonka',	'2015-12-01',	'2015-12-01',	'zmluva119-2015.pdf',	3,	0,	'2017-04-27 09:42:41',	140,	9024,	0),
(356,	25,	'rámcová kúpna zmluva',	'1/2016',	'drevná hmota',	0.00,	'Zolka Zvolen, s.r.o.',	'2016-01-13',	'2016-12-31',	'zmluva2-2016.pdf',	3,	0,	'2017-04-27 09:42:41',	138,	9024,	0),
(362,	25,	'rámcová zmluva',	'52/2014',	'pestovné práce - zalesnenie',	23400.00,	'Anna Jakubčáková a spol.',	'2015-04-01',	'2015-12-31',	'zmluva_52-2014.pdf',	3,	0,	'2017-04-27 09:42:41',	79,	9024,	0),
(363,	25,	'rámcová zmluva',	'53/2014',	'pestovné práce - ochrana mladých lesných porastov',	23760.00,	'Anna Jakubčáková a spol.',	'2015-04-01',	'2015-12-31',	'zmluva53-2014.pdf',	3,	0,	'2017-04-27 09:42:41',	77,	9024,	0),
(364,	25,	'rámcová zmluva',	'54/2014',	'ostatné pestovné práce',	23820.00,	'Anna Jakubčáková a spol.',	'2015-04-01',	'2015-12-31',	'zmluva54-2014.pdf',	3,	0,	'2017-04-27 09:42:41',	79,	9024,	0),
(366,	23,	'',	'6/2015',	'prehľad faktúr za obdobie jún 2015',	0.00,	'dodávatelia',	'2015-07-17',	'0000-00-00',	'faktry6-2015.pdf',	3,	0,	'2017-04-27 09:41:35',	116,	9023,	0),
(368,	24,	'',	'8/2015',	'',	0.00,	'prehľad objednávok za máj 2015',	'2015-05-15',	'0000-00-00',	'Nobjednvky5-2015.pdf',	3,	0,	'2017-04-27 09:42:01',	91,	9025,	0),
(373,	24,	'',	'2/2016',	'',	0.00,	'prehľad objednávok za február 2016',	'2016-02-16',	'0000-00-00',	'objednvky-2.pdf',	3,	0,	'2017-04-27 09:42:01',	48,	9025,	0),
(375,	24,	'',	'4/2016',	'',	0.00,	'prehľad objednávok za marec 2 2016',	'2016-04-01',	'0000-00-00',	'objednvky-32.pdf',	3,	0,	'2017-04-27 09:42:01',	48,	9025,	0),
(377,	24,	'',	'6/2016',	'',	0.00,	'prehľad objednávok za apríl -2 2016',	'2016-05-02',	'0000-00-00',	'objednvky-42.pdf',	3,	0,	'2017-04-27 09:42:01',	52,	9025,	0),
(378,	24,	'',	'7/2016',	'',	0.00,	'prehľad objednávok za máj 2016',	'2016-05-16',	'0000-00-00',	'objednvky-5.pdf',	3,	0,	'2017-04-27 09:42:01',	50,	9025,	0),
(379,	24,	'',	'8/2016',	'',	0.00,	'prehľad objednávok za máj 2-2016',	'2016-06-01',	'0000-00-00',	'objednvky-52.pdf',	3,	0,	'2017-04-27 09:42:01',	50,	9025,	0),
(380,	24,	'',	'9/2016',	'',	0.00,	'prehľad objednávok za jún 2016',	'2016-06-16',	'0000-00-00',	'objednvky-6.pdf',	3,	0,	'2017-04-27 09:42:01',	45,	9025,	0),
(381,	24,	'',	'10/2016',	'',	0.00,	'prehľad objednávok za jún 2- 2016',	'2016-07-01',	'0000-00-00',	'objednvky-62.pdf',	3,	0,	'2017-04-27 09:42:01',	43,	9025,	0),
(382,	24,	'',	'11/2016',	'',	0.00,	'prehľad objednávok za júl 2016',	'2016-07-18',	'0000-00-00',	'objednvky-7.pdf',	3,	0,	'2017-04-27 09:42:01',	48,	9025,	0),
(383,	23,	'',	'1/2016',	'prehľad faktúr za obdobie január 2016',	0.00,	'dodávatelia',	'2016-02-15',	'0000-00-00',	'faktry_2016-1.pdf',	3,	0,	'2017-04-27 09:41:35',	68,	9023,	0),
(384,	23,	'',	'2/2016',	'prehľad faktúr za obdobie február 2016',	0.00,	'dodávatelia',	'2016-03-14',	'0000-00-00',	'faktry_2016-2.pdf',	3,	0,	'2017-04-27 09:41:35',	66,	9023,	0),
(385,	23,	'',	'3/2016',	'prehľad faktúr za obdobie marec 2016',	0.00,	'dodávatelia',	'2016-04-12',	'0000-00-00',	'faktry_2016-3.pdf',	3,	0,	'2017-04-27 09:41:35',	73,	9023,	0),
(386,	23,	'',	'4/2016',	'prehľad faktúr za obdobie apríl 2016',	0.00,	'dodávatelia',	'2016-05-17',	'0000-00-00',	'faktry_2016-4.pdf',	3,	0,	'2017-04-27 09:41:35',	72,	9023,	0),
(387,	23,	'',	'5/2016',	'prehľad faktúr za obdobie máj 2016',	0.00,	'dodávatelia',	'2016-06-10',	'0000-00-00',	'faktry_2016-5.pdf',	3,	0,	'2017-04-27 09:41:35',	78,	9023,	0),
(388,	23,	'',	'6/2016',	'prehľad faktúr za obdobie jún 2016',	0.00,	'dodávatelia',	'2016-07-14',	'0000-00-00',	'faktry_2016-6.pdf',	3,	0,	'2017-04-27 09:41:35',	75,	9023,	0),
(389,	23,	'',	'7/2016',	'prehľad faktúr za obdobie júl 2016',	0.00,	'dodávatelia',	'2016-08-12',	'0000-00-00',	'faktry_2016-7.pdf',	3,	0,	'2017-04-27 09:41:35',	89,	9023,	0),
(391,	25,	'Dodatok k nájomnej zmluve',	'3/2016',	'prenájom lesných pozemkov za účelom včelárenia',	70.80,	'Mgr. Peter Sklenka',	'2016-02-01',	'0000-00-00',	'zmluva3-2016.tif',	3,	0,	'2017-04-27 09:42:41',	27,	9024,	0),
(392,	25,	'Kúpna zmluva',	'4/2016',	'Sadenice lesných drevín',	13096.44,	'Urbárske poz. spol. Vikartovce',	'2016-02-02',	'2016-12-31',	'zmluva4-2016.pdf',	3,	0,	'2017-04-27 09:42:41',	26,	9024,	0),
(393,	25,	'Rámcová zmluva',	'9/2016',	'Pestovné práce zalesnenie',	23400.00,	'Skupina dodávateľov Anna Jakubčáková a spol.',	'2016-03-07',	'2016-12-31',	'zmluva9-2016.pdf',	3,	0,	'2017-04-27 09:42:41',	23,	9024,	0),
(394,	25,	'Rámcová zmluva',	'10/2016',	'Pestovné práce ochrana MLP',	23760.00,	'Skupina dodávateľov Anna Jakubčáková a spol.',	'2016-03-07',	'2016-12-31',	'zmluva10-2016.pdf',	3,	0,	'2017-04-27 09:42:41',	26,	9024,	0),
(395,	25,	'Rámcová zmluva',	'11/2016',	'Pestovné práce ostatné',	23988.00,	'Skupina dodávateľov Anna Jakubčáková a spol.',	'2016-03-07',	'2016-12-31',	'zmluva11-2016.pdf',	3,	0,	'2017-04-27 09:42:41',	24,	9024,	0),
(396,	25,	'Darovacia zmluva',	'31/2016',	'ihličnaté palivo',	129.02,	'Mesto Poprad',	'2016-06-22',	'2016-06-30',	'zmluva31-2016.pdf',	3,	0,	'2017-04-27 09:42:41',	26,	9024,	0),
(397,	25,	'Darovacia zmluva',	'32/2016',	'ihličnatá guľatina',	121.18,	'Mesto Poprad',	'2016-07-25',	'2016-07-31',	'zmluva32-2016.pdf',	3,	0,	'2017-04-27 09:42:41',	25,	9024,	0),
(398,	25,	'Darovacia zmluva',	'33/2016',	'ihličnatá guľatina',	552.00,	'3AL biketrial club Poprad',	'2016-08-22',	'2016-08-31',	'zmluva33-2016.pdf',	3,	0,	'2017-04-27 09:42:41',	27,	9024,	0),
(399,	25,	'Zmluva o dodávke vody',	'1072/144/16Pv',	'dodávka  vody verejným vodovodom',	1.09,	'Podtatranská vodárenská prevádzková spoločnosť a.s.',	'2016-09-09',	'1970-01-01',	'zmluva36-2016.pdf',	3,	0,	'2017-04-27 09:42:41',	26,	9024,	0),
(400,	25,	'Dodatok zmluvy o udelení licencie',	'2016/1',	'Software Webles',	249.59,	'Foresta SK, a.s.',	'2016-10-04',	'2016-12-31',	'zmluva37-2016.pdf',	3,	0,	'2017-04-27 09:42:41',	26,	9024,	0),
(401,	24,	'',	'12/2016',	'',	0.00,	'prehľad objednávok za august 2016',	'2016-08-16',	'0000-00-00',	'objednvky8.pdf',	3,	0,	'2017-04-27 09:42:01',	25,	9025,	0),
(402,	24,	'',	'13/2016',	'',	0.00,	'prehľad objednávok za august 2-2016',	'2016-08-31',	'0000-00-00',	'objednvky82.pdf',	3,	0,	'2017-04-27 09:42:01',	24,	9025,	0),
(403,	24,	'',	'14/2016',	'',	0.00,	'prehľad objednávok za september 2016',	'2016-09-16',	'0000-00-00',	'objednvky9.pdf',	3,	0,	'2017-04-27 09:42:01',	24,	9025,	0),
(404,	25,	'nájomná zmluva',	'121/2015',	'prenájom lesných pozemkov za účelom včelárenia',	6.30,	'Ľubomír Mazúr',	'2016-01-11',	'2016-12-31',	'zmluva_1-2016.tif',	3,	0,	'2017-04-27 09:42:41',	24,	9024,	0),
(405,	23,	'',	'8/2016',	'prehľad faktúr za obdobie august 2016',	0.00,	'dodávatelia',	'2016-09-09',	'0000-00-00',	'faktry_2016-8.pdf',	3,	0,	'2017-04-27 09:41:35',	38,	9023,	0),
(406,	23,	'',	'9/2016',	'prehľad faktúr za obdobie september 2016',	0.00,	'dodávatelia',	'2016-10-10',	'0000-00-00',	'faktry_1016-9.pdf',	3,	0,	'2017-04-27 09:41:35',	48,	9023,	0),
(407,	23,	'',	'10/2016',	'prehľad faktúr za obdobie október 2016',	0.00,	'dodávatelia',	'2016-11-09',	'0000-00-00',	'faktry_2016-10.pdf',	3,	0,	'2017-04-27 09:41:35',	40,	9023,	0),
(408,	24,	'',	'15/2016',	'',	0.00,	'prehľad objednávok za október 2016',	'2016-10-31',	'0000-00-00',	'objednvky_10-2016.pdf',	3,	0,	'2017-04-27 09:42:01',	21,	9025,	0),
(409,	24,	'',	'16/2016',	'',	0.00,	'prehľad objednávok za november 2016',	'2016-11-30',	'0000-00-00',	'objednvky_11-2016.pdf',	3,	0,	'2017-04-27 09:42:01',	6,	9025,	0),
(410,	23,	'',	'11/2016',	'prehľad faktúr za obdobie november 2016',	0.00,	'dodávatelia',	'2016-12-13',	'0000-00-00',	'faktry_2016-11.pdf',	3,	0,	'2017-04-27 09:41:35',	16,	9023,	0),
(411,	23,	'',	'12/2016',	'prehľad faktúr za obdobie december 2016',	0.00,	'dodávatelia',	'2017-01-13',	'0000-00-00',	'faktry_2016-12.pdf',	3,	0,	'2017-04-27 09:41:35',	8,	9023,	0),
(412,	24,	'',	'1/2016',	'',	0.00,	'prehľad objednávok za január 2016',	'2016-01-18',	'0000-00-00',	'objednvky_1-2016.pdf',	3,	0,	'2017-04-27 09:42:01',	2,	9025,	0),
(413,	24,	'',	'3/2016',	'',	0.00,	'prehľad objednávok za marec 2016',	'2016-03-16',	'0000-00-00',	'objednvky_3.1-2016.pdf',	3,	0,	'2017-04-27 09:42:01',	2,	9025,	0),
(414,	24,	'',	'5/2016',	'',	0.00,	'prehľad objednávok za apríl 2016',	'2016-04-18',	'0000-00-00',	'objednvky_4.1-2016.pdf',	3,	0,	'2017-04-27 09:42:01',	2,	9025,	0),
(415,	24,	'',	'17/2016',	'',	0.00,	'prehľad objednávok za december 2016',	'2016-12-16',	'0000-00-00',	'objednvky_12-2016.pdf',	3,	0,	'2017-04-27 09:42:01',	3,	9025,	0),
(416,	23,	'',	'1/2017',	'prehľad faktúr za obdobie január 2017',	0.00,	'dodávatelia',	'2017-02-09',	NULL,	'Faktury-1-2017.pdf',	3,	0,	'2017-05-09 09:11:09',	0,	0,	0),
(417,	23,	'',	'2/2017',	'prehľad faktúr za obdobie február 2017',	0.00,	'dodávatelia',	'2017-03-13',	NULL,	'Faktury-2-2017.pdf',	3,	0,	'2017-05-09 09:12:08',	0,	0,	0),
(418,	23,	'',	'3/2017',	'prehľad faktúr za obdobie marec 2017',	0.00,	'dodávatelia',	'2017-04-18',	NULL,	'Faktury-3-2017.pdf',	3,	0,	'2017-05-09 09:12:57',	0,	0,	0),
(419,	24,	'',	'1.1/2017',	'',	0.00,	'prehľad objednávok za január 2017 - 1',	'2017-01-13',	NULL,	'objednavky-1.1-2017.pdf',	3,	0,	'2017-05-09 10:16:02',	0,	0,	0),
(420,	24,	'',	'1.2/2017',	'prehľad objednávok za január 2017 - 2',	0.00,	'dodávatelia',	'2017-01-19',	NULL,	'objednavky-1.2-2017.pdf',	3,	0,	'2017-07-06 07:00:24',	0,	0,	0),
(421,	24,	'',	'2/2017',	'prehľad objednávok za február 2017',	0.00,	'dodávatelia',	'2017-02-14',	NULL,	'objednavky-2-2017.pdf',	3,	0,	'2017-07-06 07:00:05',	0,	0,	0),
(422,	24,	'',	'3.1/2017',	'prehľad objednávok za marec 2017 - 1',	0.00,	'dodávatelia',	'2017-03-07',	NULL,	'objednavky-3.1-2017.pdf',	3,	0,	'2017-07-06 06:59:50',	0,	0,	0),
(423,	23,	'',	'4/2017',	'prehľad faktúr za obdobie apríl 2017',	0.00,	'dodávatelia',	'2017-05-17',	NULL,	'Faktury-4-2017.pdf',	1,	0,	'2017-07-06 06:58:00',	0,	0,	0),
(424,	24,	'',	'3.2/2017',	'prehľad objednávok za marec 2016 - 2',	0.00,	'dodávatelia',	'2017-03-28',	NULL,	'objednavky-2017-3.2.pdf',	1,	0,	'2017-07-06 06:59:34',	0,	0,	0);

DROP TABLE IF EXISTS `fotky`;
CREATE TABLE `fotky` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
  `id_user_main` int(11) NOT NULL DEFAULT '1' COMMENT 'Id užívateľa',
  `id_galery` int(11) NOT NULL DEFAULT '0' COMMENT 'Identifikácia príslušnosti ku galérii',
  `nazov` varchar(70) NOT NULL DEFAULT '.jpg' COMMENT 'Názov súboru obrázku',
  `pocitadlo` int(11) NOT NULL DEFAULT '0' COMMENT 'Počet zobrazení obrázku',
  PRIMARY KEY (`id`),
  KEY `id_akcia` (`id_galery`),
  KEY `nazov` (`nazov`),
  KEY `id_user_main` (`id_user_main`),
  CONSTRAINT `fotky_ibfk_1` FOREIGN KEY (`id_user_main`) REFERENCES `user_main` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Obrázky vo fotogalérii';

INSERT INTO `fotky` (`id`, `id_user_main`, `id_galery`, `nazov`, `pocitadlo`) VALUES
(1,	1,	1,	'p_1.jpg',	0),
(2,	1,	1,	'p_2.jpg',	0),
(3,	1,	1,	'p_3.jpg',	0),
(4,	1,	1,	'p_4.jpg',	0),
(5,	1,	1,	'p_5.jpg',	0),
(6,	1,	1,	'p_6.jpg',	0),
(7,	1,	1,	'p_7.jpg',	0),
(8,	1,	1,	'p_8.jpg',	0),
(9,	1,	1,	'p_9.jpg',	0),
(25,	1,	3,	'ml7-02_001.jpg',	0),
(26,	1,	3,	'ml7-02_002.jpg',	0),
(27,	1,	3,	'ml7-02_003.jpg',	0),
(28,	1,	3,	'ml7-02_004.jpg',	0),
(29,	2,	3,	'trnky1.jpg',	0),
(30,	2,	3,	'100_0059.JPG',	0),
(34,	2,	4,	'nch_08.jpg',	0),
(35,	2,	4,	'nch_02.jpg',	0),
(36,	2,	4,	'nch_09.jpg',	0),
(37,	2,	4,	'nch_03.jpg',	0),
(38,	2,	4,	'nch_12.jpg',	0),
(39,	2,	4,	'nch_07.jpg',	0),
(40,	2,	4,	'nch_01.jpg',	0),
(41,	2,	4,	'nch_04.jpg',	0),
(42,	2,	4,	'nch_06.jpg',	0),
(43,	2,	4,	'nch_05.jpg',	0),
(44,	2,	4,	'nch_10.jpg',	0),
(45,	2,	4,	'nch_11.jpg',	0),
(47,	3,	5,	'cestapreslop_028.jpg',	0),
(48,	3,	5,	'cestapreslop 019.jpg',	0),
(49,	3,	5,	'cestapreslop 049.jpg',	0),
(50,	3,	5,	'cestapreslop 045.jpg',	0),
(51,	3,	5,	'cestapreslop 016.jpg',	0),
(52,	3,	5,	'cestapreslop 021.jpg',	0),
(53,	3,	6,	'leto_79.JPG',	0),
(54,	3,	6,	'jun14-04_035.jpg',	0),
(55,	3,	6,	'jun14-04_041.jpg',	0),
(56,	3,	6,	'krizova19-10_005.jpg',	0),
(57,	3,	6,	'leto_85.JPG',	0),
(58,	3,	6,	'maj-24_029.jpg',	0),
(59,	3,	6,	'obora25-06_072.jpg',	0),
(60,	3,	6,	'paviln_003.jpg',	0),
(61,	3,	6,	'erven_kltor_017.jpg',	0),
(62,	3,	6,	'pavilon_019.jpg',	0),
(63,	3,	6,	'obora25-06_077.jpg',	0),
(64,	3,	6,	'nch13-05_041.jpg',	0),
(65,	3,	6,	'npr_025.jpg',	0),
(66,	3,	6,	'npr_043.jpg',	0),
(67,	3,	7,	'dolka04_031.jpg',	0),
(68,	3,	7,	'dolka04_032.jpg',	0),
(69,	3,	7,	'jun-1_084.jpg',	0),
(70,	3,	7,	'jun-1_114.jpg',	0),
(71,	3,	7,	'jun05-04_030.jpg',	0),
(72,	3,	7,	'jun14-04_045.jpg',	0),
(73,	3,	7,	'jun14-04_066.jpg',	0),
(74,	3,	7,	'jun19-04_013.jpg',	0),
(75,	3,	7,	'Kavca5-10_038.jpg',	0),
(76,	3,	7,	'maj-04_016.jpg',	0),
(77,	3,	7,	'ml19-08_010.jpg',	0),
(78,	3,	7,	'ml17-04_041.jpg',	0),
(79,	3,	7,	'ml19-08_002.jpg',	0),
(80,	3,	7,	'nch24-05_006.jpg',	0),
(81,	3,	7,	'obora25-06_012.jpg',	0),
(82,	3,	7,	'talavaek_009.jpg',	0),
(83,	3,	7,	'D4A21-6_011.jpg',	0),
(84,	3,	7,	'D4A21-6_020.jpg',	0),
(85,	3,	7,	'D4A21-6_035.jpg',	0),
(86,	3,	7,	'jun-1_034.jpg',	0),
(87,	3,	7,	'jun05-04_020.jpg',	0),
(88,	3,	7,	'Kavca5-10_029.jpg',	0),
(89,	3,	7,	'npr_024.jpg',	0),
(90,	3,	7,	'obora25-06_005.jpg',	0),
(91,	3,	7,	'talavaek_013.jpg',	0),
(92,	3,	7,	'jun-1_029.jpg',	0),
(93,	3,	7,	'nch24-05_001.jpg',	0),
(94,	3,	7,	'kava29-07_006.jpg',	0),
(95,	3,	8,	'altnky_008.jpg',	0),
(96,	3,	8,	'cestaobora_010.jpg',	0),
(97,	3,	8,	'cestaobora_019.jpg',	0),
(98,	3,	8,	'cestaobora_020.jpg',	0),
(99,	3,	8,	'cestaobora_008.jpg',	0),
(100,	3,	8,	'znaenie_028.jpg',	0),
(101,	3,	8,	'znaenie_029.jpg',	0),
(102,	3,	8,	'znaenie_037.jpg',	0),
(103,	3,	8,	'P6090008.JPG',	0),
(104,	3,	8,	'P5250163.JPG',	0),
(105,	3,	8,	'kontrolnde_002.jpg',	0),
(106,	3,	8,	'kontrolnde_003.jpg',	0),
(107,	3,	8,	'kontrolnde_004.jpg',	0),
(108,	3,	8,	'P5250166.JPG',	0),
(109,	3,	8,	'kontrolnde_026.jpg',	0),
(110,	3,	8,	'kontrolnde_007.jpg',	0),
(111,	3,	8,	'kontrolnde_024.jpg',	0),
(112,	3,	8,	'kontrolnde_009.jpg',	0),
(113,	3,	8,	'kontrolnde_010.jpg',	0),
(114,	3,	8,	'kontrolnde_022.jpg',	0),
(115,	3,	8,	'kontrolnde_018.jpg',	0),
(116,	3,	8,	'zvernkpreberanie_001.jpg',	0),
(117,	3,	8,	'zvernkpreberanie_006.jpg',	0),
(118,	3,	8,	'zvernkpreberanie_007.jpg',	0),
(119,	3,	8,	'zvernkpreberanie_012.jpg',	0),
(120,	3,	8,	'zvernkpreberanie_004.jpg',	0),
(121,	3,	8,	'altnky_010.jpg',	0),
(122,	3,	9,	'028.JPG',	0),
(123,	3,	9,	'034.JPG',	0),
(124,	3,	9,	'cesta12-03_078.jpg',	0),
(125,	3,	9,	'cestavysova_028.jpg',	0),
(126,	3,	9,	'cestavysova_031.jpg',	0),
(127,	3,	9,	'dostojevskeho_043.jpg',	0),
(128,	3,	9,	'dostojevskeho_105.jpg',	0),
(129,	3,	9,	'dostojevskeho_117.jpg',	0),
(130,	3,	9,	'dostojevskeho_124.jpg',	0),
(131,	3,	9,	'vysov_004.JPG',	0),
(132,	3,	9,	'dostojevskeho_128.jpg',	0),
(133,	3,	9,	'vysov_017.JPG',	0),
(134,	3,	9,	'vysov_014.JPG',	0),
(135,	3,	9,	'vysovakalamita_046.jpg',	0),
(136,	3,	9,	'cesta12-03_079.jpg',	0),
(137,	3,	9,	'vysov_005.JPG',	0),
(138,	3,	9,	'vysovakalamita_049.jpg',	0);

DROP TABLE IF EXISTS `hlavicka`;
CREATE TABLE `hlavicka` (
  `id` int(11) NOT NULL COMMENT '[A]Index',
  `nazov` varchar(40) COLLATE utf8_bin NOT NULL DEFAULT 'Veľká' COMMENT 'Zobrazený názov pre daný typ hlavičky',
  `pripona` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT 'Prípona názvu súborov',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `hlavicka` (`id`, `nazov`, `pripona`) VALUES
(0,	'Nerozhoduje',	' '),
(1,	'Veľká',	'normal'),
(2,	'Malá',	'small'),
(3,	'Veľká bez ponuky podčlánkov',	'normal'),
(4,	'Malá bez ponuky podčlánkov',	NULL);

DROP TABLE IF EXISTS `hlavne_menu`;
CREATE TABLE `hlavne_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[5]Id položky hlavného menu',
  `spec_nazov` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT 'Názov položky menu pre URL',
  `id_hlavne_menu_cast` int(11) NOT NULL DEFAULT '1' COMMENT '[5]Ku ktorej časti hl. menu patrí položka',
  `id_user_roles` int(11) NOT NULL DEFAULT '0' COMMENT 'Id min úrovne registrácie pre zobrazenie',
  `id_ikonka` int(11) DEFAULT NULL COMMENT '[4]Názov súboru ikonky aj s koncovkou',
  `id_druh` int(11) NOT NULL DEFAULT '1' COMMENT '[5]Výber druhu priradenej položky. Ak 1 tak je možné priradiť článok v náväznosti na tab. druh',
  `uroven` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Úroveň položky menu',
  `id_nadradenej` int(11) DEFAULT NULL COMMENT 'Id nadradenej položky menu z tejto tabuľky ',
  `id_user_main` int(11) NOT NULL DEFAULT '1' COMMENT 'Id užívateľa',
  `poradie` int(11) NOT NULL DEFAULT '1' COMMENT 'Poradie v zobrazení',
  `poradie_podclankov` int(11) NOT NULL DEFAULT '0' COMMENT 'Poradie podčlánkov ak sú: 0 - od 1-9, 1 - od 9-1',
  `id_hlavicka` int(11) NOT NULL DEFAULT '0' COMMENT '[5]Druh hlavičky podľa tabuľky hlavicka. 1 - velka',
  `id_hlavne_menu_opravnenie` int(11) NOT NULL DEFAULT '0' COMMENT 'Povolenie pre nevlastníkov (0-žiadne,1- podčlánky,2-editacia,4-všetko)',
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
  KEY `id_reg` (`id_user_roles`),
  KEY `druh` (`id_druh`),
  KEY `id_ikonka` (`id_ikonka`),
  KEY `id_hlavicka` (`id_hlavicka`),
  KEY `id_hlavne_menu_cast` (`id_hlavne_menu_cast`),
  KEY `id_user_profiles` (`id_user_main`),
  KEY `id_dlzka_novinky` (`id_dlzka_novinky`),
  KEY `id_hlavne_menu_opravnenie` (`id_hlavne_menu_opravnenie`),
  CONSTRAINT `hlavne_menu_ibfk_10` FOREIGN KEY (`id_user_roles`) REFERENCES `user_roles` (`id`),
  CONSTRAINT `hlavne_menu_ibfk_11` FOREIGN KEY (`id_hlavne_menu_opravnenie`) REFERENCES `hlavne_menu_opravnenie` (`id`),
  CONSTRAINT `hlavne_menu_ibfk_2` FOREIGN KEY (`id_ikonka`) REFERENCES `ikonka` (`id`),
  CONSTRAINT `hlavne_menu_ibfk_4` FOREIGN KEY (`id_hlavicka`) REFERENCES `hlavicka` (`id`),
  CONSTRAINT `hlavne_menu_ibfk_5` FOREIGN KEY (`id_hlavne_menu_cast`) REFERENCES `hlavne_menu_cast` (`id`),
  CONSTRAINT `hlavne_menu_ibfk_6` FOREIGN KEY (`id_druh`) REFERENCES `druh` (`id`),
  CONSTRAINT `hlavne_menu_ibfk_8` FOREIGN KEY (`id_dlzka_novinky`) REFERENCES `dlzka_novinky` (`id`),
  CONSTRAINT `hlavne_menu_ibfk_9` FOREIGN KEY (`id_user_main`) REFERENCES `user_main` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Položky hlavného menu';

INSERT INTO `hlavne_menu` (`id`, `spec_nazov`, `id_hlavne_menu_cast`, `id_user_roles`, `id_ikonka`, `id_druh`, `uroven`, `id_nadradenej`, `id_user_main`, `poradie`, `poradie_podclankov`, `id_hlavicka`, `id_hlavne_menu_opravnenie`, `zvyrazni`, `pocitadlo`, `nazov_ul_sub`, `absolutna`, `ikonka`, `avatar`, `komentar`, `modified`, `datum_platnosti`, `aktualny_projekt`, `redirect_id`, `id_dlzka_novinky`) VALUES
(1,	'home',	1,	0,	NULL,	3,	0,	NULL,	2,	1,	0,	0,	0,	0,	0,	NULL,	'Homepage:',	NULL,	NULL,	0,	'2017-07-06 07:29:44',	NULL,	0,	NULL,	1),
(2,	'sluzby',	1,	0,	NULL,	1,	0,	NULL,	2,	2,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	'36ubhgr5s6abwjj.png',	0,	'2017-07-06 07:29:44',	NULL,	0,	NULL,	1),
(3,	'pre-turistov',	1,	0,	NULL,	1,	0,	NULL,	2,	3,	0,	3,	0,	0,	0,	NULL,	NULL,	NULL,	'ho4dhulx5z9nlcu.png',	0,	'2017-07-06 07:29:44',	NULL,	0,	NULL,	1),
(4,	'zverejnovanie-dokumentov',	1,	0,	NULL,	3,	0,	NULL,	2,	4,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	'2017-07-06 07:29:44',	NULL,	0,	23,	1),
(5,	'verejne-obstaravanie',	1,	0,	NULL,	3,	0,	NULL,	2,	5,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	'2017-07-06 07:29:44',	NULL,	0,	21,	1),
(7,	'fotogaleria',	1,	0,	NULL,	1,	0,	NULL,	2,	7,	0,	3,	0,	0,	0,	'foto_album',	NULL,	NULL,	'hxrw6ib3oz3axu2.png',	0,	'2017-07-06 07:29:44',	NULL,	0,	NULL,	1),
(9,	'o-nas',	2,	0,	NULL,	1,	0,	NULL,	2,	1,	0,	0,	0,	0,	0,	'LesyPP_Homepage',	NULL,	NULL,	NULL,	0,	'2017-07-06 07:29:44',	NULL,	0,	NULL,	1),
(12,	'naucny-chodnik-kvetnica',	1,	0,	NULL,	1,	1,	3,	2,	1,	0,	0,	0,	0,	0,	NULL,	NULL,	'compass',	NULL,	0,	'2017-07-06 07:29:44',	NULL,	0,	NULL,	1),
(13,	'okruh-zdravia',	1,	0,	NULL,	1,	1,	3,	2,	2,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	'2017-07-06 07:29:44',	NULL,	0,	NULL,	1),
(14,	'zelena-turisticka-trasa',	1,	0,	NULL,	1,	1,	3,	2,	3,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	'2017-07-06 07:29:44',	NULL,	0,	NULL,	1),
(15,	'zakazky-ss-9-ods-9-zakona-c-25-2006',	1,	0,	NULL,	1,	1,	5,	2,	2,	0,	3,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	'2017-07-06 07:29:44',	NULL,	0,	NULL,	1),
(16,	'zakazka-1-2013',	1,	0,	NULL,	1,	2,	15,	2,	1,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	'2017-07-06 07:29:44',	NULL,	0,	NULL,	1),
(17,	'zakazka-1-2014',	1,	0,	NULL,	1,	2,	15,	2,	2,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	'2017-07-06 07:29:44',	NULL,	0,	NULL,	1),
(18,	'zakazka-2-2014',	1,	0,	NULL,	1,	2,	15,	2,	3,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	'2017-07-06 07:29:44',	NULL,	0,	NULL,	1),
(19,	'zakazka-1-2015',	1,	0,	NULL,	1,	2,	15,	2,	4,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	'2017-07-06 07:29:44',	NULL,	0,	NULL,	1),
(20,	'profil-verejneho-obstaravatela',	1,	0,	NULL,	1,	1,	5,	2,	1,	0,	3,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	'2017-07-06 07:29:44',	NULL,	0,	NULL,	1),
(21,	'pripravovane-vyzvy',	1,	0,	NULL,	1,	1,	5,	2,	3,	0,	3,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	'2017-07-06 07:29:44',	NULL,	0,	NULL,	1),
(22,	'lesna-cesta-vysova',	1,	0,	NULL,	1,	1,	7,	2,	1,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	'1b2uuhyticp5l58.jpg',	0,	'2017-07-06 07:29:44',	NULL,	0,	NULL,	1),
(23,	'faktury',	1,	0,	NULL,	1,	1,	4,	2,	1,	0,	3,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	'2017-07-06 07:29:44',	NULL,	0,	NULL,	1),
(24,	'objednavky',	1,	0,	NULL,	1,	1,	4,	2,	2,	0,	3,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	'2017-07-06 07:29:44',	NULL,	0,	NULL,	1),
(25,	'zmluvy',	1,	0,	NULL,	1,	1,	4,	2,	3,	0,	3,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	'2017-07-06 07:29:44',	NULL,	0,	NULL,	1),
(26,	'zakazky-s-nizkou-hodnotou',	1,	0,	NULL,	1,	1,	4,	2,	4,	0,	3,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	'2017-07-06 07:29:44',	NULL,	0,	NULL,	1),
(30,	'pokusny',	2,	0,	NULL,	3,	0,	NULL,	2,	4,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	'2017-07-06 07:29:44',	NULL,	0,	NULL,	1),
(34,	'kontakt1',	1,	0,	NULL,	1,	0,	NULL,	2,	8,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	'2017-07-06 07:29:44',	NULL,	0,	NULL,	1);

DROP TABLE IF EXISTS `hlavne_menu_cast`;
CREATE TABLE `hlavne_menu_cast` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
  `nazov` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT 'Časť' COMMENT 'Názov časti',
  `id_user_roles` int(11) NOT NULL DEFAULT '5' COMMENT 'Id min úrovne registrácie pre editáciu',
  `mapa_stranky` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Ak 1 tak je časť zahrnutá do mapy',
  PRIMARY KEY (`id`),
  KEY `id_registracia` (`id_user_roles`),
  CONSTRAINT `hlavne_menu_cast_ibfk_2` FOREIGN KEY (`id_user_roles`) REFERENCES `user_roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Časti hlavného menu';

INSERT INTO `hlavne_menu_cast` (`id`, `nazov`, `id_user_roles`, `mapa_stranky`) VALUES
(1,	'Hlavná ponuka',	4,	1),
(2,	'Druhá časť',	4,	1);

DROP TABLE IF EXISTS `hlavne_menu_lang`;
CREATE TABLE `hlavne_menu_lang` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
  `id_lang` int(11) NOT NULL DEFAULT '1' COMMENT 'Id Jazyka',
  `id_hlavne_menu` int(11) NOT NULL COMMENT 'Id hlavného menu, ku ktorému patrí',
  `id_clanok_lang` int(11) DEFAULT NULL COMMENT 'Id jazka článku ak ho má',
  `menu_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT 'Názov položky v hlavnom menu pre daný jazyk',
  `h1part2` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT 'Druhá časť názvu pre daný jazyk',
  `view_name` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'Zobrazený názov položky pre daný jazyk',
  PRIMARY KEY (`id`),
  KEY `id_hlavne_menu` (`id_hlavne_menu`),
  KEY `id_lang` (`id_lang`),
  KEY `id_clanok_lang` (`id_clanok_lang`),
  CONSTRAINT `hlavne_menu_lang_ibfk_1` FOREIGN KEY (`id_hlavne_menu`) REFERENCES `hlavne_menu` (`id`),
  CONSTRAINT `hlavne_menu_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `lang` (`id`),
  CONSTRAINT `hlavne_menu_lang_ibfk_3` FOREIGN KEY (`id_clanok_lang`) REFERENCES `clanok_lang` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Popis položiek hlavného menu pre iný jazyk';

INSERT INTO `hlavne_menu_lang` (`id`, `id_lang`, `id_hlavne_menu`, `id_clanok_lang`, `menu_name`, `h1part2`, `view_name`) VALUES
(1,	1,	1,	NULL,	'home',	NULL,	'Príroda blízko mesta'),
(2,	1,	2,	4,	'služby',	NULL,	'Aktuálna ponuka služieb'),
(3,	1,	3,	25,	'Pre turistov',	NULL,	'Turistický sprievodca po mestských lesoch'),
(4,	1,	4,	NULL,	'Dokumenty',	NULL,	'Zverejňovanie dokumentov'),
(5,	1,	5,	NULL,	'Obstarávanie',	NULL,	'Verejné obstarávanie'),
(7,	1,	7,	26,	'Fotogaléria',	NULL,	'Fotogaléria'),
(9,	1,	9,	2,	'Príroda blízko mesta',	NULL,	'Príroda blízko mesta'),
(12,	1,	12,	5,	'Náučný chodník Kvetnica',	NULL,	'Náučný chodník Kvetnica'),
(13,	1,	13,	6,	'Okruh zdravia',	NULL,	'Okruh zdravia'),
(14,	1,	14,	7,	'Zámčisko',	NULL,	'Zámčisko'),
(15,	1,	15,	8,	'Zákazky',	'§ 9 ods. 9 zákona č. 25/2006',	'Zákazky § 9 ods. 9 zákona č. 25/2006'),
(16,	1,	16,	9,	'zákazka 1/2013',	NULL,	'zákazka 1/2013'),
(17,	1,	17,	10,	'zákazka 1/2014',	NULL,	'zákazka 1/2014'),
(18,	1,	18,	11,	'zákazka 2/2014',	NULL,	'zákazka 2/2014'),
(19,	1,	19,	12,	'zákazka 1/2015',	NULL,	'zákazka 1/2015'),
(20,	1,	20,	13,	'Profil VO',	NULL,	'Profil verejného obstarávateľa'),
(21,	1,	21,	14,	'Pripravované výzvy',	NULL,	'Pripravované výzvy'),
(22,	1,	22,	15,	'Lesná cesta Vysová',	NULL,	'Lesná cesta Vysová'),
(23,	1,	23,	16,	'Faktúry',	NULL,	'Faktúry'),
(24,	1,	24,	17,	'Objednávky',	NULL,	'Objednávky'),
(25,	1,	25,	18,	'Zmluvy',	NULL,	'Zmluvy'),
(26,	1,	26,	19,	'Zákazky s nízkou hodnotou',	NULL,	'Zákazky s nízkou hodnotou'),
(32,	1,	34,	23,	'Kontakt',	NULL,	'Kontakt');

DROP TABLE IF EXISTS `hlavne_menu_opravnenie`;
CREATE TABLE `hlavne_menu_opravnenie` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
  `nazov` varchar(40) COLLATE utf8_bin NOT NULL COMMENT 'Názov oprávnenia',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Oprávnenia nevlastníkov položiek hlavného menu';

INSERT INTO `hlavne_menu_opravnenie` (`id`, `nazov`) VALUES
(0,	'Žiadne'),
(1,	'Pridávanie podčlánkov'),
(2,	'Editácia položky'),
(3,	'Pridávanie podčlánkov a editácia položky');

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

DROP TABLE IF EXISTS `news`;
CREATE TABLE `news` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
  `text` text COLLATE utf8_bin NOT NULL COMMENT 'Text novinky',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Dátum novinky',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `oznam`;
CREATE TABLE `oznam` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
  `id_user_main` int(11) NOT NULL DEFAULT '1' COMMENT 'Id užívateľa',
  `id_user_roles` int(11) NOT NULL DEFAULT '0' COMMENT 'Id min úrovne registrácie pre zobrazenie',
  `id_ikonka` int(11) DEFAULT NULL COMMENT 'Id použitej ikonky',
  `datum_platnosti` date NOT NULL DEFAULT '0000-00-00' COMMENT 'Dátum platnosti',
  `datum_zadania` date NOT NULL DEFAULT '0000-00-00' COMMENT 'Dátum zadania oznamu',
  `nazov` varchar(50) DEFAULT NULL COMMENT 'Názov oznamu',
  `text` text COMMENT 'Text oznamu',
  `oznam_kluc` varchar(10) DEFAULT NULL COMMENT 'Kľúč pre potvrdenie účasti',
  `title_image` varchar(200) DEFAULT NULL COMMENT 'Názov titulného obrázku',
  `title_fa_class` varchar(20) DEFAULT NULL COMMENT 'Názov ikonky pre font awesome',
  `title_image_url` varchar(200) DEFAULT NULL COMMENT 'Odkaz titulného obrázka',
  PRIMARY KEY (`id`),
  KEY `id_user_profiles` (`id_user_main`),
  KEY `id_registracia` (`id_user_roles`),
  KEY `id_ikonka` (`id_ikonka`),
  CONSTRAINT `oznam_ibfk_3` FOREIGN KEY (`id_ikonka`) REFERENCES `ikonka` (`id`),
  CONSTRAINT `oznam_ibfk_4` FOREIGN KEY (`id_user_main`) REFERENCES `user_main` (`id`),
  CONSTRAINT `oznam_ibfk_5` FOREIGN KEY (`id_user_roles`) REFERENCES `user_roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Oznamy';

INSERT INTO `oznam` (`id`, `id_user_main`, `id_user_roles`, `id_ikonka`, `datum_platnosti`, `datum_zadania`, `nazov`, `text`, `oznam_kluc`, `title_image`, `title_fa_class`, `title_image_url`) VALUES
(5,	1,	0,	NULL,	'2017-12-31',	'2017-06-23',	'Súťaž - Objav Mestské lesy Poprad',	'<p class=\"card-block text-justify\">\n	Objav pr&iacute;rodn&eacute; prostredie mestsk&yacute;ch lesov, kr&aacute;su a rozmanitosť pr&iacute;rody a hist&oacute;rie. Zaznamenaj r&ocirc;znou formou zauj&iacute;mavosti &uacute;zemia, pom&ocirc;ž k vytvoreniu nov&yacute;ch poznatkov o &uacute;zem&iacute; a vyhraj zauj&iacute;mav&eacute; ceny...</p>\n<p>\n	{end}</p>\n<p class=\"card-block text-justify\">\n	S&uacute;ťaž je určen&aacute; žiakom &scaron;k&ocirc;l na &uacute;zem&iacute; mesta Poprad a jeho občanov, ktor&iacute; sa do s&uacute;ťaže zaregistruj&uacute; na str&aacute;nke sutaz.lesypoprad.sk. S&uacute;ťaž potrv&aacute; v obdob&iacute; od od 7.4. - do 30. 9 2017. S&uacute;ťaže sa m&ocirc;žu z&uacute;častniť aj t&iacute;my žiakov z rovnakej &scaron;koly, ktor&iacute; sa do s&uacute;ťaže prihl&aacute;sia spoločne. Web s&uacute;ťaže:</p>\n<p>\n	<strong><a href=\"http://sutaz.lesypoprad.sk\" target=\"new\">sutaz.lesypoprad.sk</a></strong></p>\n',	'ltqdqvhjno',	'snezienka.jpg',	NULL,	'http://sutaz.lesypoprad.sk/');

DROP TABLE IF EXISTS `slider`;
CREATE TABLE `slider` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
  `poradie` int(11) NOT NULL DEFAULT '1' COMMENT 'Určuje poradie obrázkov v slidery',
  `nadpis` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT 'Nadpis obrázku',
  `popis` varchar(150) COLLATE utf8_bin DEFAULT NULL COMMENT 'Popis obrázku slideru vypisovaný v dolnej časti',
  `subor` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '*.jpg' COMMENT 'Názov obrázku slideru aj s relatívnou cestou',
  `zobrazenie` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT 'Kedy sa obrázok zobrazí',
  `id_hlavne_menu` int(11) DEFAULT NULL COMMENT 'Odkaz na položku hlavného menu',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Popis obrázkou slideru aj s názvami súborov';

INSERT INTO `slider` (`id`, `poradie`, `nadpis`, `popis`, `subor`, `zobrazenie`, `id_hlavne_menu`) VALUES
(2,	5,	NULL,	NULL,	'02_mravenisko.jpg',	NULL,	NULL),
(3,	6,	NULL,	NULL,	'03_ml.jpg',	NULL,	NULL),
(4,	2,	NULL,	NULL,	'04_poprad.jpg',	NULL,	NULL),
(5,	0,	NULL,	NULL,	'05_tatry.jpg',	NULL,	NULL),
(6,	7,	NULL,	NULL,	'06_preslop.jpg',	NULL,	NULL),
(7,	2,	NULL,	NULL,	'07_obloha.jpg',	NULL,	NULL),
(8,	4,	NULL,	NULL,	'08_preslop.jpg',	NULL,	NULL);

DROP TABLE IF EXISTS `udaje`;
CREATE TABLE `udaje` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
  `id_user_roles` int(11) NOT NULL DEFAULT '5' COMMENT 'Id min úrovne pre editáciu',
  `id_druh` int(11) DEFAULT NULL COMMENT 'Druhová skupina pre nastavenia',
  `id_udaje_typ` int(11) NOT NULL DEFAULT '1' COMMENT 'Typ input-u',
  `nazov` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT 'nazov' COMMENT 'Názov prvku',
  `text` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT 'Definícia' COMMENT 'Hodnota prvku',
  `comment` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'Komentár k hodnote',
  PRIMARY KEY (`id`),
  KEY `id_reg` (`id_user_roles`),
  KEY `id_druh` (`id_druh`),
  KEY `id_udaje_typ` (`id_udaje_typ`),
  CONSTRAINT `udaje_ibfk_2` FOREIGN KEY (`id_druh`) REFERENCES `druh` (`id`),
  CONSTRAINT `udaje_ibfk_3` FOREIGN KEY (`id_udaje_typ`) REFERENCES `udaje_typ` (`id`),
  CONSTRAINT `udaje_ibfk_4` FOREIGN KEY (`id_user_roles`) REFERENCES `user_roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tabuľka na uschovanie základných údajov o stránke';

INSERT INTO `udaje` (`id`, `id_user_roles`, `id_druh`, `id_udaje_typ`, `nazov`, `text`, `comment`) VALUES
(1,	5,	NULL,	1,	'titulka-sk',	'Mestské Lesy Poprad',	'Názov zobrazený v titulke'),
(2,	4,	NULL,	1,	'titulka_2-sk',	'',	'Druhá časť titulky pre jazyk: sk'),
(3,	4,	NULL,	1,	'titulka_citat_enable',	'0',	'Povolenie zobrazenia citátu'),
(4,	4,	NULL,	1,	'titulka_citat_podpis',	'',	'Podpis pod citát na titulke'),
(5,	4,	NULL,	1,	'titulka_citat-sk',	'',	'Text citátu, ktorý sa zobrazí na titulke pre jazyk: sk'),
(6,	5,	NULL,	1,	'keywords-sk',	'Mestské lesy Poprad, Turistika, oddych, ochrana životného prostredia.',	'Kľúčové slová'),
(7,	5,	NULL,	1,	'autor',	'Ing. Peter VOJTECH ml. - VZ',	'Autor stránky'),
(8,	4,	NULL,	1,	'log_out-sk',	'Odhlás sa...',	'Text pre odkaz na odhlásenie sa'),
(9,	4,	NULL,	1,	'log_in-sk',	'Prihlás sa',	'Text pre odkaz na prihlásenie sa'),
(10,	4,	NULL,	1,	'forgot_password-sk',	'Zabudnuté heslo?',	'Text pre odkaz na zabudnuté heslo'),
(11,	4,	NULL,	1,	'register-sk',	'Registrácia',	'Text pre odkaz na registráciu'),
(12,	4,	NULL,	1,	'last_update-sk',	'Posledná aktualizácia',	'Text pre odkaz na poslednú aktualizáciu'),
(13,	4,	NULL,	1,	'spravca-sk',	'Správca obsahu',	'Text pre odkaz na správcu'),
(14,	4,	NULL,	1,	'copy',	'MLPP',	'Text, ktorý sa vypíše za znakom copyright-u'),
(15,	4,	NULL,	1,	'no_exzist-sk',	'To čo hľadáte nie je ešte v tomto jazyku vytvorené!',	'Text ak položka v danom jazyku neexzistuje pre jazyk:sk'),
(16,	4,	NULL,	1,	'nazov_uvod-sk',	'Úvod',	'Text pre odkaz na východziu stránku pre jazyk:sk'),
(17,	5,	NULL,	3,	'komentare',	'0',	'Globálne povolenie komentárov'),
(18,	4,	NULL,	3,	'registracia_enabled',	'0',	'Globálne registrácie(ak 1 tak áno, ak 0 tak nie)'),
(19,	4,	1,	1,	'clanok_hlavicka',	'0',	'Nastavuje, ktoré hodnoty sa zobrazia v hlavičke článku Front modulu. Výsledok je súčet čísel.[1=Dátum, 2=Zadávateľ, 4=Počet zobrazení]'),
(21,	4,	5,	3,	'oznam_komentare',	'0',	'Povolenie komentárov k aktualitám(oznamom).'),
(22,	5,	5,	2,	'oznam_usporiadanie',	'1',	'Usporiadanie aktualít podľa dátumu platnosti. [1=od najstaršieho; 0=od najmladšieho]'),
(23,	4,	5,	3,	'oznam_ucast',	'0',	'Povolenie potvrdenia účasti.'),
(24,	5,	5,	1,	'oznam_prva_stranka',	'1',	'Id stránky, ktorá sa zobrazí ako 1. po načítaní webu'),
(25,	4,	5,	3,	'oznam_title_image_en',	'1',	'Povolenie pridávania titulného obrázku k oznamu. Ak je zakázané používajú sa ikonky.');

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

DROP TABLE IF EXISTS `user_main`;
CREATE TABLE `user_main` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
  `id_user_roles` int(11) NOT NULL DEFAULT '0' COMMENT 'Úroveň registrácie a rola',
  `id_user_profiles` int(11) DEFAULT NULL COMMENT 'Užívateľský profil',
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
  `last_ip` varchar(40) COLLATE utf8_bin DEFAULT NULL COMMENT 'Posledná IP',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Vytvorenie užívateľa',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Posledná zmena',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `id_registracia` (`id_user_roles`),
  KEY `id_user_profiles` (`id_user_profiles`),
  CONSTRAINT `user_main_ibfk_2` FOREIGN KEY (`id_user_profiles`) REFERENCES `user_profiles` (`id`) ON DELETE SET NULL,
  CONSTRAINT `user_main_ibfk_3` FOREIGN KEY (`id_user_roles`) REFERENCES `user_roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hlavné údaje užívateľa';

INSERT INTO `user_main` (`id`, `id_user_roles`, `id_user_profiles`, `password`, `meno`, `priezvisko`, `email`, `activated`, `banned`, `ban_reason`, `new_password_key`, `new_password_requested`, `new_email`, `new_email_key`, `last_ip`, `created`, `modified`) VALUES
(1,	5,	1,	'$2y$10$RnzAjUCyc/B1GgiJ9k43/e27BDz5j1vsbN.DYlfnXIxweBvqxkABq',	'Peter',	'Vojtech',	'petak23@gmail.com',	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	'217.12.48.22',	'2017-05-15 09:11:19',	'2017-07-06 07:22:19'),
(2,	4,	2,	'$2y$10$xHr8SFTodJJUqNL3SIz52uATlRdRXA2zMelzkknjWpzWTRGOQuk26',	'Róbert',	'Dula',	'lesypp@stonline.sk',	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'2017-05-15 09:13:38',	'2017-05-15 08:10:58'),
(3,	4,	3,	'$2y$10$VOeK4y3ozjaUM1aMtiVmcuHRmtcmoVvC6J4yFX4j0LZoNbXlejyMi',	'Jozef',	'Petrenčík',	'jozue@anigraph.eu',	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'2017-05-15 09:12:22',	'2017-05-22 07:59:39');

DROP TABLE IF EXISTS `user_permission`;
CREATE TABLE `user_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
  `id_user_roles` int(11) NOT NULL DEFAULT '0' COMMENT 'Užívateľská rola',
  `id_user_resource` int(11) NOT NULL COMMENT 'Zdroj',
  `actions` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT 'Povolenie na akciu. (Ak viac oddelené čiarkou, ak null tak všetko)',
  PRIMARY KEY (`id`),
  KEY `id_user_roles` (`id_user_roles`),
  KEY `id_user_resource` (`id_user_resource`),
  CONSTRAINT `user_permission_ibfk_1` FOREIGN KEY (`id_user_roles`) REFERENCES `user_roles` (`id`),
  CONSTRAINT `user_permission_ibfk_2` FOREIGN KEY (`id_user_resource`) REFERENCES `user_resource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Užívateľské oprávnenia';

INSERT INTO `user_permission` (`id`, `id_user_roles`, `id_user_resource`, `actions`) VALUES
(1,	0,	4,	NULL),
(2,	0,	6,	NULL),
(3,	0,	7,	NULL),
(4,	0,	8,	NULL),
(5,	0,	1,	NULL),
(6,	0,	5,	NULL),
(7,	0,	2,	NULL),
(8,	0,	9,	'default'),
(9,	0,	3,	'activateNewEmail'),
(10,	1,	3,	'default,mailChange,passwordChange'),
(11,	3,	19,	'default,edit,edit2,add,add2,del'),
(12,	3,	13,	'default,edit,edit2,add,add2'),
(13,	3,	10,	NULL),
(14,	3,	15,	NULL),
(15,	4,	9,	NULL),
(16,	4,	19,	'addpol'),
(17,	4,	13,	'addpol'),
(18,	4,	12,	'default'),
(19,	4,	11,	'default'),
(20,	4,	14,	'default,edit'),
(21,	4,	18,	NULL),
(22,	4,	17,	NULL),
(23,	4,	20,	NULL),
(24,	4,	16,	'default,edit'),
(25,	5,	16,	NULL),
(26,	5,	14,	NULL),
(27,	5,	11,	NULL),
(28,	5,	12,	NULL),
(29,	5,	13,	NULL),
(30,	5,	19,	NULL);

DROP TABLE IF EXISTS `user_prihlasenie`;
CREATE TABLE `user_prihlasenie` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
  `id_user_main` int(11) NOT NULL COMMENT 'Id užívateľa',
  `log_in_datetime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Dátum a čas prihlásenia',
  PRIMARY KEY (`id`),
  KEY `id_user_profiles` (`id_user_main`),
  CONSTRAINT `user_prihlasenie_ibfk_1` FOREIGN KEY (`id_user_main`) REFERENCES `user_main` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Evidencia prihlásenia užívateľov';

INSERT INTO `user_prihlasenie` (`id`, `id_user_main`, `log_in_datetime`) VALUES
(1,	1,	'2017-05-29 10:55:25'),
(2,	1,	'2017-06-06 07:02:13'),
(3,	1,	'2017-06-19 10:23:00'),
(4,	1,	'2017-06-23 09:17:05'),
(5,	1,	'2017-07-03 08:36:54'),
(6,	1,	'2017-07-06 07:42:12'),
(7,	1,	'2017-07-06 07:43:26'),
(8,	1,	'2017-07-06 08:07:04'),
(9,	1,	'2017-07-06 08:08:03'),
(10,	1,	'2017-07-06 08:28:09'),
(11,	1,	'2017-07-06 09:22:19');

DROP TABLE IF EXISTS `user_profiles`;
CREATE TABLE `user_profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rok` int(11) DEFAULT NULL COMMENT 'Rok narodenia',
  `telefon` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT 'Telefón',
  `poznamka` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'Poznámka',
  `pocet_pr` int(11) NOT NULL DEFAULT '0' COMMENT 'Počet prihlásení',
  `pohl` enum('Z','M') COLLATE utf8_bin NOT NULL DEFAULT 'M' COMMENT 'Pohlavie',
  `prihlas_teraz` datetime DEFAULT NULL COMMENT 'Posledné prihlásenie',
  `avatar` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT 'Cesta k avatarovi veľkosti 75x75',
  `news` enum('A','N') COLLATE utf8_bin NOT NULL DEFAULT 'A' COMMENT 'Posielanie info emailou',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `user_profiles` (`id`, `rok`, `telefon`, `poznamka`, `pocet_pr`, `pohl`, `prihlas_teraz`, `avatar`, `news`) VALUES
(1,	NULL,	NULL,	NULL,	13,	'M',	'2017-07-06 09:22:19',	'files/1/4roakz37gkh1k25mrmcu2ov74.jpg',	'A'),
(2,	NULL,	NULL,	NULL,	0,	'M',	NULL,	NULL,	'A'),
(3,	NULL,	NULL,	NULL,	0,	'M',	NULL,	NULL,	'A');

DROP TABLE IF EXISTS `user_resource`;
CREATE TABLE `user_resource` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
  `name` varchar(30) COLLATE utf8_bin NOT NULL COMMENT 'Názov zdroja',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Zdroje oprávnení';

INSERT INTO `user_resource` (`id`, `name`) VALUES
(1,	'Front:Homepage'),
(2,	'Front:User'),
(3,	'Front:UserLog'),
(4,	'Front:Dokumenty'),
(5,	'Front:Error'),
(6,	'Front:Oznam'),
(7,	'Front:Clanky'),
(8,	'Front:Menu'),
(9,	'Front:Faktury'),
(10,	'Admin:Homepage'),
(11,	'Admin:User'),
(12,	'Admin:Verzie'),
(13,	'Admin:Menu'),
(14,	'Admin:Udaje'),
(15,	'Admin:Dokumenty'),
(16,	'Admin:Lang'),
(17,	'Admin:Slider'),
(18,	'Admin:Oznam'),
(19,	'Admin:Clanky'),
(20,	'Admin:Texyla');

DROP TABLE IF EXISTS `user_roles`;
CREATE TABLE `user_roles` (
  `id` int(11) NOT NULL COMMENT '[A]Index',
  `role` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT 'guest' COMMENT 'Rola pre ACL',
  `inherited` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT 'Dedí od roli',
  `name` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT 'Registracia cez web' COMMENT 'Názov úrovne registrácie',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Úrovne registrácie a ich názvy';

INSERT INTO `user_roles` (`id`, `role`, `inherited`, `name`) VALUES
(0,	'guest',	NULL,	'Bez registrácie'),
(1,	'register',	'guest',	'Registrácia cez web'),
(2,	'passive',	'register',	'Pasívny užívateľ'),
(3,	'active',	'passive',	'Aktívny užívateľ'),
(4,	'manager',	'active',	'Správca obsahu'),
(5,	'admin',	'manager',	'Administrátor');

DROP TABLE IF EXISTS `verzie`;
CREATE TABLE `verzie` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '[A]Index',
  `id_user_main` int(11) NOT NULL DEFAULT '1' COMMENT 'Id užívateľa',
  `cislo` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Číslo verzie',
  `subory` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'Zmenené súbory',
  `text` text COLLATE utf8_bin COMMENT 'Popis zmien',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Dátum a čas zmeny',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cislo` (`cislo`),
  KEY `datum` (`modified`),
  KEY `id_clena` (`id_user_main`),
  CONSTRAINT `verzie_ibfk_1` FOREIGN KEY (`id_user_main`) REFERENCES `user_main` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Verzie webu';

INSERT INTO `verzie` (`id`, `id_user_main`, `cislo`, `subory`, `text`, `modified`) VALUES
(1,	1,	'0.1.',	NULL,	'Východzia verzia',	'2017-02-13 08:03:32'),
(2,	1,	'0.1.5',	'Datagrid, verzia',	'<ul>\n	<li>\n		&Uacute;prava sql s&uacute;borov DB&nbsp;a pr&iacute;prava na prechod na nov&yacute; sp&ocirc;sob.</li>\n	<li>\n		Upgrade adminer-a na 4.3.1.</li>\n	<li>\n		Pridanie Ublaboo datagridu.</li>\n	<li>\n		Pridanie možnosti edit&aacute;cie a prid&aacute;vania dokumentov - fakt&uacute;r.</li>\n	<li>\n		Vymazanie nepotrebnej časti pokladničky.</li>\n	<li>\n		Odstr&aacute;nenie chyby v administr&aacute;cii verzi&iacute;.</li>\n</ul>\n',	'2017-05-05 05:32:49'),
(3,	1,	'0.4.1',	'Vzhľad',	'<ul>\n	<li>\n		Kompletne prepracovan&yacute; vzhľad str&aacute;nky.</li>\n	<li>\n		Odstr&aacute;nenie zisten&yacute;ch ch&yacute;b.</li>\n</ul>\n',	'2017-07-06 07:44:33');

-- 2017-07-06 07:57:19
