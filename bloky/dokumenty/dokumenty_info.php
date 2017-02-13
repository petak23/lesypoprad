<?php 
/* Tento súbor slúži na obsluhu výpisu a editácie dokumentov
   Zmena: 13.02.2017 - PV
*/ 

if (@$bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód
if ($zobr_cast>0 AND $zobr_co=="") { //Slúži na evidenciu downloadu súborov t.j. ak nie je operácia a mám konkrétne id
 $_REQUEST=0;
 @$navrat=prikaz_sql("SELECT subor FROM dokumenty WHERE id_polozka=$zobr_cast AND id_skupina=$zobr_pol",
                     "Download (".__FILE__ ." on line ".__LINE__ .")","Žiaľ sa momentálne nepodarilo dokument nájsť! Skúste neskôr.");
 if ($navrat){
  $zaznam=mysql_fetch_array($navrat);
  @$zmena_p=prikaz_sql("UPDATE dokumenty SET pocitadlo=pocitadlo+1 WHERE id_polozka=$zobr_cast AND id_skupina=$zobr_pol",
                       "Update počítadla (".__FILE__ ." on line ".__LINE__ .")","Nedalo sa pripočítať...");
  if ($zmena_p){ 
   header("Content-Description: File Transfer");
   header("Content-Type: application/force-download");
   header("Content-Disposition: attachment; filename=\"$zaznam[subor]\"");
   header("Location: ./www/files/dokumenty/$zaznam[subor]");
  } 
 }
}

if (isset($vysledok)) {     // Zapisovalo sa do databázy
  if ($vysledok<>"ok") {  // Načítanie údajov po chybnom zápise do databázy
		$dataDok['errorText']="Záznam nebol pridaný. Niektorý údaj bol zadaný chybne alebo nebolo možné uskutočniť spojenie s dataDokbázou!<br />$vysledok";
	}
	else {   // Správny zápis oznamu do dataDokbázy a vypísanie info o operácii
		if ($zobr_co=="add_dokumenty")  	$dataDok['text']="Dokument bol pridaný!";
		elseif($zobr_co=="del_dokumenty") $dataDok['text']="Dokument bol opravený!";
		elseif($zobr_co=="deleted") 			$dataDok['text']="Dokument bol zmazaný!";
		else 															$dataDok['text']="Dokument bol zmenený!";
		$zobr_co="";
	}
} 

//-- Priradenie skriptu pre záložky --
$pomreg=jeadmin(); //Len pre zjednodušenie
// ----- SQL príkaz pre zistenie, ktoré roky treba vypísať ----- 
$navcast=prikaz_sql("SELECT nazov, polozka FROM sub_menu WHERE id_sub_menu=$zobr_pol LIMIT 1",
                    "Zistenie časti (".__FILE__ ." on line ".__LINE__ .")","Žiaľ sa momentálne nepodarilo zistiť! Skúste neskôr.");
if (!$navcast) return; //Ak nebola požiadavka do DB úspešná
$polozkaCast = mysql_fetch_array($navcast);
$pom = explode('-', $polozkaCast['polozka']);
$triedenie = array (
	'1' => array('podm' => "DATE_FORMAT(datum_vystavenia, '%Y')", 'nazov' => ''),
	'2'	=> array('podm' => "CONCAT(DATE_FORMAT(datum_vystavenia, '%Y-'), IF(QUARTER(datum_vystavenia)>2,'2','1'))", 'nazov' => '. polrok'),
	'4' => array('podm' => "CONCAT(DATE_FORMAT(datum_vystavenia, '%Y-'), QUARTER(datum_vystavenia))", 'nazov' => '. štvrťrok'),
	'12'=> array('podm' => "DATE_FORMAT(datum_vystavenia, '%Y-%c')", 'nazov' => '. mesiac'),
	'53'=> array('podm' => "DATE_FORMAT(datum_vystavenia, '%Y-%V')", 'nazov' => '.týždeň'),
);
$dataDok = array (
	'castNazov'	=> $polozkaCast['nazov'],
	'castU'			=> $pom[0],
	'triedenie'	=> $pom[1],
	'subjektN'	=> ($pom[0]=="zmluvy") ? "Zmluvná strana" : "Dodávateľ",
	'cenaN'			=> ($pom[0]=="zmluvy") ? "Cena vrátane DPH" : "Suma",
	'datumVN'		=> ($pom[0]=="zmluvy") ? "Dátum uzatvorenia zmluvy" : "Dátum vystavenia",
);
$navRokDokumenty=prikaz_sql("SELECT id_polozka, ".$triedenie[$dataDok['triedenie']]['podm']." as drok, 
																		DATE_FORMAT(datum_vystavenia,'%d.%m.%Y') as datumV, dokumenty.nazov as dnazov, 
																		registracia.nazov as rnazov, registracia.id as rid_reg, 
																		cislo, predmet, cena, subjekt, DATE_FORMAT(datum_vystavenia,'%d.%m.%Y') as datumV, DATE_FORMAT(datum_ukoncenia,'%d.%m.%Y') as datumU,	subor, DATE_FORMAT(kedy,'%d.%m.%Y') as datum,
																		meno, pocitadlo FROM dokumenty, registracia, clenovia
                             WHERE dokumenty.id_reg=registracia.id 
																	 AND dokumenty.id_clena=clenovia.id_clena 
																	 AND dokumenty.id_reg<=".jeadmin()." 
																	 AND id_skupina=$zobr_pol	 
														 ORDER by drok DESC, datum_vystavenia DESC",
                            "Výpis položiek dokumenty (".__FILE__ ." on line ".__LINE__ .")",
														"Žiaľ sa momentálne nepodarilo zoznam vypísať! Skúste neskôr.");												
if (!$navRokDokumenty) return; //Ak nebola požiadavka do DB úspešná
if ($zobr_co=="add_dokumenty" OR $zobr_co=="edit_dokumenty") include("./bloky/dokumenty/edit_dokumenty.php"); //Ak idem vkladať, alebo editovať dokument
elseif ($zobr_co=="del_dokumenty") { //Ak chcem zmazať konkrétny dokument
	if (isset($_REQUEST["dokumenty_vymaz"]) && $_REQUEST["dokumenty_vymaz"]=="Nie") 
		$dataDok['errorText']="Vymazanie bolo stornované!";
	else {
		include("./bloky/dokumenty/delete_dokumenty.php");
		return;
	}
}
$dataDok["nazov"]=$omrvinky['id_clanok']['txt'];
if (mysql_numrows($navRokDokumenty)>0) {
	$ip1=0;$ip2=1;$rok = 0;$zaciatok = 0;
	while ($polozkaRok = mysql_fetch_array($navRokDokumenty)) {
		if (!$zaciatok) { 
			$rok = $polozkaRok['drok'];
			$zaciatok++;
		}
		if ($rok <> $polozkaRok['drok']) {
			$dataDok["rok"][(string)$rok] = $pom_rok;
			$rok = $polozkaRok['drok'];
			unset($pom_rok);
			$ip2=1;
		}
		$pom = explode('-',$polozkaRok['drok']);
		$polozkaRok['dskupina'] = (isset($pom[1])) ? $pom[1].$triedenie[$dataDok['triedenie']]['nazov'].' '.$pom[0] : $polozkaRok['drok'];
		$pom_rok[$ip2] = $polozkaRok;
		$ip2++;
	}
	if (isset($pom_rok)) $dataDok["rok"][(string)$rok] = $pom_rok;
	unset($polozkaRok);
	unset($pom_rok);
	mysql_free_result($navRokDokumenty); //Uvolnenie pamäte
}
require("./view/dokumenty_view.php");