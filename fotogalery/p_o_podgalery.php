<?php
/* Tento súbor slúži na obsluhu pridania/opravy/vymazania podgalérie
   Zmena: 13.02.2017 - PV
*/

  /*-------- Časť zápisu do databázy    ---------- */ 
function pridaj_podgalery()
 /* Funkcia zapíše položku podgalérie databázy.
     Vstupy: - hodnoty prichádzajú cez $_POST z formulára
	 Výstupy: ok-ak všetko prebehlo správne inak chybová hláška
	 Obmedzenie: Zatiaľ neznáme.
	 Zmena: 23.06.2011 - PV
  */
{
$datum=StrFTime("%Y-%m-%d",strtotime("0 day"));
if (@(int)$_SESSION["id"]>0) $id_clena=(int)$_SESSION["id"]; else return "NEPRIHLÁSENÝ !!!";
$pridanie_podgaleria=prikaz_sql("INSERT INTO podgaleria (nazov, popis, id_menu, id_reg, id_clena, datum) 
                                 VALUES('".$_REQUEST["pr_nazov"]."', '".$_REQUEST["pr_popis"]."', ".$_REQUEST["pr_id_menu"].", ".$_REQUEST["pr_id_reg"].", 
								        $id_clena, '$datum')",
							    "Pridanie podgalérie ".__FILE__ ." on line ".__LINE__ ."","");
if (!$pridanie_podgaleria) return mysql_error();
return "ok";
}

function oprav_podgalery()
 /* Funkcia aktualizuje položku podgalérie v databáze.
     Vstupy: - hodnoty prichádzajú cez $_POST z formulára
	 Výstupy: ok-ak všetko prebehlo správne inak chybová hláška
	 Obmedzenie: Zatiaľ neznáme.
	 Zmena: 23.06.2011 - PV
  */
{
if (@(int)$_REQUEST["pr_del_pocitadlo"]>0) $pocitadlo=", pocita=0"; else $pocitadlo="";
$oprava_podgaleria=prikaz_sql("UPDATE podgaleria SET nazov='".$_REQUEST["pr_nazov"]."', popis='".$_REQUEST["pr_popis"]."', id_menu=".$_REQUEST["pr_id_menu"].",
                                                     id_reg=".$_REQUEST["pr_id_reg"]." $pocitadlo
                               WHERE id_polozka=".$_REQUEST["pr_id_polozka"]." LIMIT 1",
							  "Oprava podgalérie ".__FILE__ ." on line ".__LINE__ ."","");
if (!$oprava_podgaleria) return mysql_error();
return "ok";
}

function maz_podgalery()
 /* Funkcia "maže" položku podgalérie v databáze (označí ju ako zmazanú t.j. zobrazenie = -1)
     Vstupy: - hodnoty prichádzajú cez $_POST z formulára
	 Výstupy: ok-ak všetko prebehlo správne inak chybová hláška
	 Obmedzenie: Zatiaľ neznáme.
	 Zmena: 23.06.2011 - PV
  */
{
$mazanie_podgaleria=prikaz_sql("UPDATE podgaleria SET zobrazenie=-1 WHERE id_polozka=".$_REQUEST["pr_id_polozka"]." LIMIT 1","Mazanie podgalérie ".__FILE__ ." on line ".__LINE__ ."","");
if (!$mazanie_podgaleria) return mysql_error();
return "ok";
}

function title_podgalery()
 /* Funkcia aktualizuje položku titulnej fotky podgalérie v databáze.
     Vstupy: - hodnoty prichádzajú cez $_POST z formulára
	 Výstupy: ok-ak všetko prebehlo správne inak chybová hláška
	 Obmedzenie: Zatiaľ neznáme.
	 Zmena: 23.06.2011 - PV
  */
{
if (@(int)$_REQUEST["pr_tit_foto"]>0) $tit_foto=(int)$_REQUEST["pr_tit_foto"]; else $tit_foto=0;
$title_podgaleria=prikaz_sql("UPDATE podgaleria SET tit_foto=$tit_foto WHERE id_polozka=".$_REQUEST["pr_id_polozka"]." LIMIT 1",
							  "Oprava titulky podgalérie ".__FILE__ ." on line ".__LINE__ ."","");
if (!$title_podgaleria) return mysql_error();
return "ok";
}

function pridaj_foto_podgalery()
  /* Funkcia zaktualizuje číslo podgalérie vybraných fotiek v databáze.
     Vstupy: - hodnoty prichádzajú cez $_POST z formulára
	 Výstupy: ok-ak všetko prebehlo správne inak chybová hláška
	 Obmedzenie: Zatiaľ neznáme.
	 Zmena: 23.6.2011 - PV
  */
{
if (@count($_POST["prid_foto"])>0) { //Zistenie či je čo pridať
  for ($i=0; $i<count($_POST["prid_foto"]); $i++) {
    $pridaj_foto=prikaz_sql("UPDATE fotky SET id_galery=".$_POST["pr_id_polozka"]." WHERE id_foto=".$_POST["prid_foto"][$i]." LIMIT 1",
	                        "Pridanie fotiek k podgalérii (".__FILE__ .")","");
	if (!$pridaj_foto) return mysql_error();
  }
}
else return "Neboli vybrané žiadne fotky";
return "ok";
}


  /* --- Pridanie/Oprava položky sub menu ak bola daná požiadavka --- */
$vysledok_podgalery="";  
if (@$_REQUEST["podgalery"]=="Pridaj")    $vysledok_podgalery=pridaj_podgalery();
elseif (@$_REQUEST["podgalery"]=="Oprav") $vysledok_podgalery=oprav_podgalery();
elseif (@$_REQUEST["podgalery"]=="Áno")   {
 $vysledok_podgalery=maz_podgalery();
 $co=" ";
 $operacia="vymazane";
}
if (@$_REQUEST["title_podgalery_tl"]=="Vyber")    $vysledok_podgalery=title_podgalery();
if (@$_REQUEST["add_podgalery_tl"]=="Vyber")      $vysledok_podgalery=pridaj_foto_podgalery();