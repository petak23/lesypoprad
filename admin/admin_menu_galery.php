<?php
/* Tento súbor slúži na obsluhu pridania/opravy/vymazania menu galérie
   Zmena: 21.06.2011 - PV
*/

// Hlavička stránky
if (@$bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód
echo("<h2>Pridanie/Oprava/Mazanie menu galérie</h2><br />"); //Hlavička článku

//Inicializácia premených
 $id_polozka=0;  
 $nazov=" ";     //Zobrazený názov
 $id_reg=0;      //Úroveň registrácie
 $zobrazenie=1;  //Či sa má položka zobraziť v ponuke
 $vysledok="";   //Výsledok zápisu do DB 
  /*-------- Časť zápisu do databázy    ---------- */ 
function pridaj_menu_galery()
 /* Funkcia zapíše položku menu galérie databázy.
     Vstupy: - hodnoty prichádzajú cez $_POST z formulára
	 Výstupy: ok-ak všetko prebehlo správne inak chybová hláška
	 Obmedzenie: Zatiaľ neznáme.
	 Zmena: 21.06.2011 - PV
  */
{
if (@(int)$_REQUEST["pr_zobrazenie"]>0) $pr_zobrazenie=(int)$_REQUEST["pr_zobrazenie"]; else $pr_zobrazenie=0;
$pridanie_menu_galeria=prikaz_sql("INSERT INTO menu_galeria (id_polozka, nazov, id_reg, zobrazenie) 
                               VALUES('".$_REQUEST["pr_id_polozka"]."', '".$_REQUEST["pr_nazov"]."', ".$_REQUEST["pr_id_reg"].", $pr_zobrazenie)",
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
if (@(int)$_REQUEST["pr_zobrazenie"]>0) $pr_zobrazenie=(int)$_REQUEST["pr_zobrazenie"]; else $pr_zobrazenie=0;
$oprava_menu_galeria=prikaz_sql("UPDATE menu_galeria SET nazov='".$_REQUEST["pr_nazov"]."', id_polozka='".$_REQUEST["pr_id_polozka"]."', zobrazenie='$pr_zobrazenie',
                                        id_reg=".$_REQUEST["pr_id_reg"]." WHERE id_polozka=".$_REQUEST["pr_id_polozka"]." LIMIT 1",
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
if (@$_REQUEST["menu_galery"]=="Pridaj")    $vysledok=pridaj_menu_galery();
elseif (@$_REQUEST["menu_galery"]=="Oprav") $vysledok=oprav_menu_galery();
elseif (@$_REQUEST["menu_galery"]=="Áno")   $vysledok=maz_menu_galery();

if (@$zobr_co=="adm_del_menu_galery" AND @$vysledok<>"ok") { // vymazanie položky sub. menu
 $vys_sub=prikaz_sql("SELECT * FROM menu_galeria WHERE id_polozka=".$_REQUEST["id"]." LIMIT 1",
                     "Nájdenie položky(".__FILE__ ." on line ".__LINE__ .")","Žiaľ sa momentálne nepodarilo nájsť položku a teda ani vymazať! Skúste neskôr.");
 if (@$vys_sub) {
  $zaz_sub=mysql_fetch_array($vys_sub);
  echo("\n<div class=st_zle>Vymazanie položky menu galérie!!!<br />");
  echo("Naozaj chceš vymazať položku <B><U>$zaz_sub[nazov]</U></B>!!!");
  echo("\n<form action=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol\" method=post>");
  echo("\n<input name=\"pr_id_polozka\" type=\"hidden\" value=\"$zaz_sub[id_polozka]\">");
  echo("\n<input name=\"menu_galery\" type=\"submit\" value=\"Áno\">");
  echo("\n<input name=\"menu_galery\" type=\"submit\" value=\"Nie\"></form></div>\n");

 }
}
else {
  /* ----------- Časť spracovania formulára ---------- */
if ($vysledok<>"") { // Zapisovalo sa do databázy
  if ($vysledok<>"ok") {  // Načítanie údajov po chybnom zápise do databázy
    stav_zle("Záznam nebol pridaný. Niektorý údaj bol zadaný chybne alebo nebolo možné uskutočniť spojenie s databázou!:<br /><b>$vysledok</b>");
    $id_polozka=$_POST["pr_id_polozka"];  // Opätovné načítanie údajou ak došlo k chybe
    $nazov=$_POST["pr_nazov"];
	$id_reg=$_POST["pr_id_reg"];
	$zobrazenie=$_POST["pr_zobrazenie"];
  }
  else {                // Správny zápis aktualizácie do DB
    echo("<div class=st_dobre>Položka menu galérie bola ");  //Vypísanie info o operácii
    if (@$_REQUEST["menu_galery"]=="Pridaj") echo("pridaná!");   
    elseif(@$_REQUEST["menu_galery"]=="Oprav") echo("opravená!");
	elseif (@$_REQUEST["menu_galery"]=="Áno") echo("zmazaná!");
    else echo("zmenená!");
    echo("</div>");
  }
}
if (!(@$_REQUEST["menu_galery"]=="Áno" AND $vysledok=="ok")) {
 echo("\n<form name=\"zadanie\" action=\"./index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol\" method=post>"); // Začiatok formulára pre zadanie údajov
 if ($zobr_co=="adm_edit_menu_galery"){ //Ak prišiel údaj o požiadavke na editáciu položky tak sa položka nájde v databáze a načíta do premených
  $navrat_e=prikaz_sql("SELECT * FROM menu_galeria WHERE id_polozka=".$_REQUEST["id"]." LIMIT 1",
                       "Načítanie položky menu_galery (".__FILE__ ." on line ".__LINE__ .")","Žiaľ sa momentálne nepodarilo položku nájsť! Skúste neskôr.");
  if ($navrat_e) { //Ak bola požiadavka do DB úspečná
   $zaz_e = mysql_fetch_array($navrat_e);
   $id_polozka=$zaz_e["id_polozka"];
   $nazov=$zaz_e["nazov"];
   $id_reg=$zaz_e["id_reg"];
   $zobrazenie=$zaz_e["zobrazenie"];
   echo("<input type=\"hidden\" name=\"pr_id_polozka\" value=\"$zaz_e[id_polozka]\">");
  }
 }  
 echo("\n<div id=admin><fieldset>"); //Samotny formular na zadanie
 form_pole("pr_id_polozka","ID položky",$id_polozka,"POZOR! táto položka určuje poradie ale NESMIE sa opakovať!!!", 5);
 form_pole("pr_nazov","Zobrazený názov",$nazov,"Názov položky galérie", 50);
 form_registr("pr_id_reg", $id_reg, jeadmin());
 form_zaskrt("pr_zobrazenie", "Zobrazenie v bočnej ponuke", $zobrazenie);
 echo("<input name=\"menu_galery\" type=\"submit\" value=\"");
 echo(@(int)$_REQUEST["id"]>0 ? "Oprav" : "Pridaj");
 echo("\"></fieldset></form></div>"); //
}
  /* ----- Výpis všetkých položiek menu galérie ----- */
$navrat=prikaz_sql("SELECT id_polozka, menu_galeria.nazov as mnazov, registracia.nazov as rnazov, registracia.id as id_reg, zobrazenie
                    FROM menu_galeria, registracia
                    WHERE menu_galeria.id_reg=registracia.id ORDER BY id_polozka",
                   "Výpis položiek menu galérie (".__FILE__ ." on line ".__LINE__ .")","Žiaľ sa momentálne nepodarilo zoznam vypísať! Skúste neskôr."); 
if ($navrat) { //Ak bola požiadavka do DB úspečná
  echo("<table id=vyp_adm cellpadding=2 cellspacing=0><tr><th>Id</th><th>Názov</th><th>Registrácia</th><th>Zobr.?</th><th colspan=2></th></tr>\n");
  $pom=true;
  while ($polozka = mysql_fetch_array($navrat)){ 
   echo($pom ? "<tr class=\"r1" : "<tr class=\"r2");
   if($polozka["zobrazenie"]==-1) echo(" zmaz");
   echo("\">");
   if ($pom) $pom=false; else $pom=true;
   echo("<td>$polozka[id_polozka]</td><td><b>$polozka[mnazov]</b></td><td>");  
   echo($polozka["id_reg"]==0 ? "$polozka[id_reg]-$polozka[rnazov]" : "<div style=\"display: inline;\" class=st_zeleno>$polozka[id_reg]-$polozka[rnazov]</div>");
   echo("</td><td>$polozka[zobrazenie]");
   echo("</td><td>
         <a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol&amp;id=$polozka[id_polozka]&amp;co=adm_edit_menu_galery\" class=edit title=\"Editácia položky $polozka[mnazov]\">
		 &nbsp;&nbsp;&nbsp;&nbsp;</a></td><td>
         <a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol&amp;id=$polozka[id_polozka]&amp;co=adm_del_menu_galery\" class=vymaz title=\"Vymazanie položky $polozka[mnazov]\">&nbsp;&nbsp;&nbsp;&nbsp;</a>
         </td></tr>\n");
  }
  echo("</table>");
} 
}