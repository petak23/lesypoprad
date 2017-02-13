<?php
/* Tento súbor slúži na obsluhu pridania/opravy/vymazania dokumentu
   Zmena: 13.02.2017 - PV
*/

// Hlavička stránky
if (@$bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód

$default = array (
	"id_polozka" 			=> 0,  
	"nazov"						=> "",
	"cislo"						=> NULL,
	"predmet"					=> NULL,
	"cena"						=> NULL,
	"subjekt"					=> NULL,
	"datum_vystavenia"=> NULL,
	"datum_ukoncenia"	=> NULL,	
	"id_clena"				=> (isset($_SESSION["id"])) ? (int)$_SESSION["id"] : 0,
	"id_reg"					=> 5,
	"id_skupina"				=> 0,
	"id_rok"					=> 0,
);

  // ----------- Časť spracovania formulára ---------- 
if (isset($vysledok) && $vysledok<>"ok") { $zaz_e = $_POST; }  // Načítanie údajov po chybnom zápise do databázy

if ($zobr_cast>0){ //Načítanie údajov, keď sa ide opravovať dokument
  $navrat_e=prikaz_sql("SELECT * FROM dokumenty WHERE id_polozka=$zobr_cast LIMIT 1",
                       "Edit dokumentu údaje(".__FILE__ ." on line ".__LINE__ .")",
											 "Momentálne sa nepodarilo údaje nájsť! Prosím skúste neskôr.");
  if (!$navrat_e) { return;}
	$zaz_e = mysql_fetch_array($navrat_e);
}
$dataDokument = (isset($zaz_e)) ? array_merge($default, $zaz_e) : $default; // Zlúčenie nastavení
$dataDokument['odkaz']="index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol&amp;co=$zobr_co";
require("./view/dokumenty_edit_form.php");