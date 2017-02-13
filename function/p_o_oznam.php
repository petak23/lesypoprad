<?php
/* Tento súbor slúži na obsluhu pridania/opravy oznamu
   Zmena: 13.02.2017 - PV
*/

// Hlavička stránky
if (@$bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód

  /*-------- Časť zápisu do databázy    ---------- */
function pridaj_oznam()
  /* Funkcia skontroluje vstupy a zapíše oznam do databázy.
     Vstupy: - hodnoty prichádzajú cez $_POST z formulára
	 Výstupy: ok-ak všetko prebehlo správne inak chybová hláška
	 Obmedzenie: Zatiaľ neznáme.
	 Zmena: 13.09.2011 - PV
  */
{
if (!kontrola_datumu($_POST["datum"])) return "Chybný dátum!"; //Kontrola na RRRR-MM-DD a existenciu datumu
$nazov=strip_tags($_POST["nazov"]); /* -- odstranenie HTML tagov z nazvu -- */
$id_reg=@(int)$_POST["id_reg"];
$id_ikonka=@(int)$_POST["id_ikonka"];
$pridanie_oznamu=prikaz_sql("INSERT INTO oznam (datum_platnosti, nazov, text, id_user_profiles, id_registracia, id_ikonka)
                       values('".$_POST["datum"]."', '$nazov','".$_POST["oznam_t"]."', ".$_POST["id_clena"].",$id_reg, $id_ikonka)",
					        "Pridanie oznamu(".__FILE__ ." on line ".__LINE__ .")", "Žiaľ sa z dôvodu chyby nepodarilo oznam pridať. Prosím, skúste neskôr...");
if (!$pridanie_oznamu) return mysql_error();
return "ok";
}

function oprav_oznam()
  /* Funkcia skontroluje vstupy a aktualizuje oznam v databáze.
     Vstupy: - hodnoty prichádzajú cez $_POST z formulára
	 Výstupy: ok-ak všetko prebehlo správne inak chybová hláška
	 Obmedzenie: Zatiaľ neznáme.
	 Zmena: 13.09.2011 - PV
  */
{
if (!kontrola_datumu($_POST["datum"])) return "Chybný dátum!"; //Kontrola na RRRR-MM-DD a existenciu datumu
$nazov=strip_tags($_POST["nazov"]); /* -- odstranenie HTML tagov z nazvu -- */
$id_reg=@(int)$_POST["id_reg"];
$id_ikonka=@(int)$_POST["id_ikonka"];
$oprava_oznamu=mysql_query("UPDATE oznam SET datum_platnosti ='".$_POST["datum"]."', nazov = '$nazov',
                                        text = '".$_POST["oznam_t"]."', id_user_profiles = ".$_POST["id_clena"].",
										id_registracia = $id_reg, id_ikonka = $id_ikonka
										WHERE id = ".$_POST["id"]." LIMIT 1 "); //potvrdenie = $ucast,
if (!$oprava_oznamu) return mysql_error();
return "ok";
}

  /* --- Pridanie/Oprava oznamu ak bola daná požiadavka --- */
if ($operacia=="Pridaj")   $vysledok=pridaj_oznam(); 
elseif($operacia=="Oprav") $vysledok=oprav_oznam();