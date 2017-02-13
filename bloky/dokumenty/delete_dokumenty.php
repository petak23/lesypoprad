<?php
/* Tento súbor slúži na obsluhu pridania/opravy/vymazania dokumentu
   Zmena: 13.02.2017 - PV
*/

// Hlavička stránky
if (@$bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód

function vymaz_subor()
  /* Funkcia vymaže dokument z databázy.
     Vstupy: - hodnoty prichádzajú cez $_POST z formulára
	 Výstupy: ok-ak všetko prebehlo správne inak chybová hláška */
{
	$vys_dok=prikaz_sql("SELECT subor FROM dokumenty WHERE id_polozka=".$_REQUEST["id_polozka"]." LIMIT 1", 
                     "Nájdenie dokumentu(".__FILE__ ." on line ".__LINE__ .")",											
										 "Žiaľ sa momentálne nepodarilo nájsť tento dokument! Skúste neskôr.");
	if (!$vys_dok) return mysql_error();$zaz_sub=mysql_fetch_array($vys_dok);
	$subor=strip_tags(@$_POST["subor"]);
	if (is_file("www/files/dokumenty/".$zaz_sub['subor'])) {
		chmod("www/files/dokumenty/".$zaz_sub['subor'], 0777);
		if (!unlink("www/files/dokumenty/".$zaz_sub['subor'])) return "Vzmazanie sa nepodarilo!";
	}
	$vymaz_subor=prikaz_sql("DELETE FROM dokumenty WHERE id_polozka=".$_REQUEST["id_polozka"], 
													"Zmazanie dokumentu(".__FILE__ ." on line ".__LINE__ .")","",1);	
	if (!$vymaz_subor) return mysql_error();

	return "ok";
}

if (@$_REQUEST["dokumenty_vymaz"]=="Áno"){ //Ak prišla požiadavka na mazanie
	$vysledok=vymaz_subor(); 
	$zobr_co="deleted";	if ($vysledok=="ok") stav_dobre('Dokument bol zmazaný!');
	return;
}

if ($zobr_co=="del_dokumenty") { // pre vypísanie formuláru na mazanie dokumentu
	$vys_dok=prikaz_sql("SELECT subor FROM dokumenty WHERE id_polozka=$zobr_cast LIMIT 1",
                      "Nájdenie dokumentu(".__FILE__ ." on line ".__LINE__ .")",
											"Žiaľ sa momentálne nepodarilo nájsť tento dokument! Skúste neskôr.");
	if ($vys_dok) {
		$zaz_sub=mysql_fetch_array($vys_dok);
		$delPol = array (
			"nazov"					=> "dokumenty_vymaz",
			"nadpis" 				=> "Vymazanie dokumentu !!!",
			"text"					=> "Naozaj chceš vymazať dokument",
			"polozkaPopis"	=> $zaz_sub['subor'],
			"odkaz"					=> "index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol&amp;co=$zobr_co",
			"idPolozka"			=> $zobr_cast,
			"idPolozkaNaz"	=> "id_polozka",
			"zobr_clanok"		=> $zobr_clanok,
			"zobr_pol"			=> $zobr_pol,
		);
		unset($zaz_sub);
		mysql_free_result($vys_dok); //Uvolnenie pamäte
		require("./view/delete_polozka_view.php");
	}
}