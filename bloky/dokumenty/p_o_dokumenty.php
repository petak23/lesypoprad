<?php
/* Tento súbor slúži na obsluhu pridania/opravy/vymazania dokumentu
   Zmena: 13.02.2017 - PV
*/

// Hlavička stránky
if (@$bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód

  /*-------- Časť zápisu do databázy    ---------- */
function validate_dokument()
/* Funkcia skontroluje vstupy .
    Vstupy: - hodnoty prichádzajú cez $_POST z formulára
		Výstupy: pole hodnôt ak všetko prebehlo správne inak chybová hláška */
{

$dataCl = array (
	"id_polozka" 			=> (isset($_POST["id_polozka"])) ? (int)$_POST["id_polozka"] : 0,  
	"nazov"						=> (isset($_POST["nazov"])) ? trim(strip_tags($_POST["nazov"])) : "",
	"cislo"						=> (isset($_POST["cislo"])) ? trim(strip_tags($_POST["cislo"])) : NULL,
	"predmet"					=> (isset($_POST["predmet"])) ? trim(strip_tags($_POST["predmet"])) : NULL,
	"cena"						=> (isset($_POST["cena"])) ? trim(str2num($_POST["cena"])) : NULL,
	"subjekt"					=> (isset($_POST["subjekt"])) ? trim(strip_tags($_POST["subjekt"])) : NULL,
	"datum_vystavenia"=> (isset($_POST["datum_vystavenia"])) ? strftime("%Y-%m-%d",strtotime($_POST["datum_vystavenia"])) : NULL,
	"datum_ukoncenia"	=> (isset($_POST["datum_ukoncenia"])) ? strftime("%Y-%m-%d",strtotime($_POST["datum_ukoncenia"])) : NULL,
	"id_clena"				=> (isset($_POST["id_clena"])) ? (int)$_POST["id_clena"] : 0,
	"id_reg"					=> (isset($_POST["id_reg"])) ? (int)$_POST["id_reg"] : 5,
	"id_skupina"			=> (isset($_POST["id_skupina"])) ? (int)$_POST["id_skupina"] : 0,
	"id_rok"					=> (isset($_POST["id_rok"])) ? (int)$_POST["id_rok"] : 0,
);

if (strlen($dataCl["nazov"])<2) $dataCl["error"]="Nadpis musí mať aspoň 2 písmená!";
if ($dataCl["id_clena"]<1) $dataCl["error"]="Niekto musí zadávať!";
if (isset($dataCl["datum_vystavenia"]) && !kontrola_datumu($dataCl["datum_vystavenia"])) 
	$dataCl["error"]="Chybný dátum vystavenia!"; //Kontrola na RRRR-MM-DD a existenciu datumu 
if (isset($dataCl["datum_ukoncenia"]) && !kontrola_datumu($dataCl["datum_ukoncenia"])) 
	$dataCl["error"]="Chybný dátum ukončenia!"; //Kontrola na RRRR-MM-DD a existenciu datumu 
return $dataCl;
}
	
function pridaj_subor()
  /* Funkcia skontroluje vstupy a zapíše údaje o súbore do databázy.
     Vstupy: - hodnoty prichádzajú cez $_POST z formulára
	 Výstupy: ok-ak všetko prebehlo správne inak chybová hláška  */
{
$dataCl=validate_dokument();

if (isset($data["error"])) return $data["error"];
if ($_FILES['pr_file']['error']>0) upload_stav($_FILES['pr_file']['error']);
elseif ($_FILES['pr_file']['size'] > 2000000) { //Kontrola na veľkosť súboru max 2MB
 return "Je mi ľúto, ale pokúšate sa nahrať príliš veľký súbor! <br />Max veľkosť je: 2Mb (má ".($_FILES['pr_file']['size']/1000000)."Mb)!"; 
}
elseif ($_FILES['pr_file']['size'] ==0) { //Kontrola na veľkosť súboru 
  return "Je mi ľúto, ale pokúšate sa nahrať prázdny súbor!"; 
}
else { //Ak kontroly prebehli v poriadku
  $uploaddir = "www/files/dokumenty/";
  $safe_filename = preg_replace( 
                      array("/\s+/", "/[^-\.\w]+/"), 
                      array("_", ""), 
                      trim($_FILES['pr_file']['name']));
  while (is_file($uploaddir.$safe_filename)) {
  	$safe_filename = 'N'.$safe_filename;
  }
  $uploadfile = $uploaddir.$safe_filename; //Vytvorenie samotného názvu súboru pre adresár dokumenty
  if (move_uploaded_file($_FILES['pr_file']['tmp_name'], $uploadfile)) {
		$pridanie_subor=mysql_query("INSERT INTO dokumenty (nazov, cislo, predmet, cena, subjekt, datum_vystavenia, datum_ukoncenia, subor, id_clena, id_reg, id_skupina, id_rok) 
																 VALUES('".$dataCl['nazov']."', '".$dataCl['cislo']."','".$dataCl['predmet']."','".$dataCl['cena']."','".$dataCl['subjekt']."','".$dataCl['datum_vystavenia']."','".$dataCl['datum_ukoncenia']."','$safe_filename', ".$dataCl["id_clena"].", ".$dataCl["id_reg"].", ".$dataCl["id_skupina"].", ".$dataCl["id_rok"].")");
		if (!$pridanie_subor) return mysql_error();
    return "ok";
  }
  else return "Upload súboru sa nepodaril!";
}
}

function oprav_subor()
  /* Funkcia skontroluje vstupy a aktualizuje údaje o súbore v databáze.
     Vstupy: - hodnoty prichádzajú cez $_POST z formulára
     Výstupy: ok-ak všetko prebehlo správne inak chybová hláška */
{
$dataCl=validate_dokument();
if (isset($data["error"])) return $data["error"];
$oprava_subor=mysql_query("UPDATE dokumenty SET nazov = '".$dataCl['nazov']."', 
																								cislo = '".$dataCl['cislo']."', 
																								predmet = '".$dataCl['predmet']."', 
																								cena = '".$dataCl['cena']."', 
																								subjekt = '".$dataCl['subjekt']."', 
																								datum_vystavenia = '".$dataCl['datum_vystavenia']."', 
																								datum_ukoncenia = '".$dataCl['datum_ukoncenia']."',
																								id_clena = ".$dataCl["id_clena"].", 
																								id_reg = ".$dataCl["id_reg"].", 
                                                id_skupina=".$dataCl["id_skupina"].", 
																								id_rok=".$dataCl["id_rok"]."
						   WHERE id_polozka = ".$dataCl["id_polozka"]." LIMIT 1 "); 
if (!$oprava_subor) return mysql_error();
return "ok";
}

  // --- Pridanie/Oprava oznamu ak bola daná požiadavka --- 
if ($_REQUEST["dokumenty_rob"]=="Pridaj")   $vysledok=pridaj_subor();   
elseif ($_REQUEST["dokumenty_rob"]=="Oprav") $vysledok=oprav_subor();