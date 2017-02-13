<?php
/* Tento súbor slúži na obsluhu pridania/opravy/vymazania menu galérie
   Zmena: 13.02.2017 - PV
*/

  /*-------- Časť zápisu do databázy    ---------- */ 
function pridaj_menu_galery()
 /* Funkcia zapíše položku menu galérie databázy.
     Vstupy: - hodnoty prichádzajú cez $_POST z formulára
	 Výstupy: ok-ak všetko prebehlo správne inak chybová hláška
	 Obmedzenie: Zatiaľ neznáme.
	 Zmena: 21.06.2011 - PV
  */
{
$pridanie_menu_galeria=prikaz_sql("INSERT INTO menu_galeria (nazov, id_reg) VALUES('".$_REQUEST["pr_nazov"]."', ".$_REQUEST["pr_id_reg"].")",
							      "Pridanie menu_galery ".__FILE__ ." on line ".__LINE__ ."","");
if (!$pridanie_menu_galeria) return mysql_error();
return "ok";
}

function oprav_menu_galery()
 /* Funkcia aktualizuje položku menu galérie v databáze.
     Vstupy: - hodnoty prichádzajú cez $_POST z formulára
	 Výstupy: ok-ak všetko prebehlo správne inak chybová hláška
	 Obmedzenie: Zatiaľ neznáme.
	 Zmena: 21.06.2011 - PV
  */
{
$oprava_menu_galeria=prikaz_sql("UPDATE menu_galeria SET nazov='".$_REQUEST["pr_nazov"]."', id_reg=".$_REQUEST["pr_id_reg"]." 
                                 WHERE id_polozka=".$_REQUEST["pr_id_polozka"]." LIMIT 1",
								"Oprava menu_galery ".__FILE__ ." on line ".__LINE__ ."","");
if (!$oprava_menu_galeria) return mysql_error();
return "ok";
}

function maz_menu_galery()
 /* Funkcia "maže" položku menu galérie v databáze (označí ju ako zmazanú t.j. zobrazenie = -1)
     Vstupy: - hodnoty prichádzajú cez $_POST z formulára
	 Výstupy: ok-ak všetko prebehlo správne inak chybová hláška
	 Obmedzenie: Zatiaľ neznáme.
	 Zmena: 03.06.2011 - PV
  */
{
$mazanie_menu_galeria=prikaz_sql("UPDATE menu_galeria SET zobrazenie=-1 WHERE id_polozka=".$_REQUEST["pr_id_polozka"]." LIMIT 1","Mazanie menu_galery ".__FILE__ ." on line ".__LINE__ ."","");
if (!$mazanie_menu_galeria) return mysql_error();
return "ok";
}
  /* --- Pridanie/Oprava položky sub menu ak bola daná požiadavka --- */
$vysledok_menu_galery="";  
if (@$_REQUEST["menu_galery"]=="Pridaj")    $vysledok_menu_galery=pridaj_menu_galery();
elseif (@$_REQUEST["menu_galery"]=="Oprav") $vysledok_menu_galery=oprav_menu_galery();
elseif (@$_REQUEST["menu_galery"]=="Áno")   {
 $vysledok_menu_galery=maz_menu_galery();
 $co=" ";
 $operacia="vymazane";
}