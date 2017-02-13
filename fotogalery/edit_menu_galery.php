<?php
/* Tento súbor slúži na obsluhu pridania/opravy/vymazania menu galérie
   Zmena: 13.02.2017 - PV
*/
if (@$bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód

// ------------- Hlavička stránky ----------- 
echo("\n<h2>&nbsp;</h2>\n"); //Zatiaľ ostáva kôly medzere

//Inicializácia premených
$id_polozka=0;  
$nazov="";     //Zobrazený názov
$id_reg=0;      //Úroveň registrácie
if ($zobr_co=="new_menu_galery") $vysledok=""; //Ak pridávam tak vymažem výsledok - inicializácia 

if (@$zobr_co=="del_menu_galery" AND @$vysledok<>"ok") { // vymazanie položky sub. menu
 $vys_sub=prikaz_sql("SELECT nazov FROM menu_galeria WHERE id_polozka=$zobr_pol LIMIT 1",
                     "Nájdenie položky(".__FILE__ ." on line ".__LINE__ .")","Žiaľ sa momentálne nepodarilo nájsť položku a teda ani vymazať! Skúste neskôr.");
 if (@$vys_sub) {
  $zaz_sub=mysql_fetch_array($vys_sub);
  echo("\n<div class=st_zle>Vymazanie položky menu galérie!!!<br />");
  echo("Naozaj chceš vymazať položku <B><U>$zaz_sub[nazov]</U></B>!!!");
  echo("\n<form action=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol\" method=post>");
  echo("\n<input name=\"pr_id_polozka\" type=\"hidden\" value=\"$zobr_pol\">");
  echo("\n<input name=\"menu_galery\" type=\"submit\" value=\"Áno\">");
  echo("\n<input name=\"menu_galery\" type=\"submit\" value=\"Nie\"></form></div>\n");
 }
}
else {
  /* ----------- Časť spracovania formulára ---------- */
if (@$vysledok<>"") { // Zapisovalo sa do databázy
  if ($vysledok<>"ok") {  // Načítanie údajov po chybnom zápise do databázy
    $id_polozka=$_POST["pr_id_polozka"];  // Opätovné načítanie údajou ak došlo k chybe
    $nazov=$_POST["pr_nazov"];
	$id_reg=$_POST["pr_id_reg"];
  }
}
if (!(@$_REQUEST["menu_galery"]=="Áno" AND $vysledok=="ok")) { //Nezobrazím ak sa mazalo, alebo úspešne zapisovalo do DB
 echo("\n<form name=\"zadanie\" action=\"./index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol\" method=post>"); // Začiatok formulára pre zadanie údajov
 if ($zobr_co=="edit_menu_galery"){ //Ak prišiel údaj o požiadavke na editáciu položky tak sa položka nájde v databáze a načíta do premených
  $navrat_e=prikaz_sql("SELECT nazov, id_reg FROM menu_galeria WHERE id_polozka=$zobr_pol LIMIT 1", 
                       "Načítanie položky menu_galery (".__FILE__ ." on line ".__LINE__ .")","Žiaľ sa momentálne nepodarilo položku nájsť! Skúste neskôr.");
  if ($navrat_e && mysql_numrows($navrat_e)==1) { //Ak bola požiadavka do DB úspečná a našiel sa 1 záznam
   $zaz_e = mysql_fetch_array($navrat_e);
   $nazov=$zaz_e["nazov"];
   $id_reg=$zaz_e["id_reg"];
   echo("<input type=\"hidden\" name=\"pr_id_polozka\" value=\"$zobr_pol\">");
  }
 }  
 echo("\n<div id=admin><fieldset>"); //Samotny formular na zadanie
 form_pole("pr_nazov","Zobrazený názov",$nazov,"Názov položky galérie", 50);
 form_registr("pr_id_reg", $id_reg, jeadmin());
 echo("<input name=\"menu_galery\" type=\"submit\" value=\"");
 echo($zobr_pol>0 ? "Oprav" : "Pridaj");
 echo("\"></fieldset></form></div>"); //
}
}