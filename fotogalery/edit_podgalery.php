<?php
/* Tento súbor slúži na obsluhu pridania/opravy/vymazania podgalérie
   Zmena: 13.02.2017 - PV
*/
if (@$bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód

 // ------------- Hlavička stránky ----------- 
echo("\n<h3>&nbsp;</h3>\n"); //Zatiaľ ostáva kôly medzere

//Inicializácia premených
 $id_polozka=0;  
 $nazov="";          //Zobrazený názov
 $popis="";          //Zobrazený popis
 $id_menu=$zobr_pol; //Priradené menu
 $id_reg=0;          //Úroveň registrácie
 $zobrazenie=0;      //Či sa má položka zobraziť v ponuke
 if ($zobr_co=="new_podgalery") $vysledok="";   //Výsledok zápisu do DB 

if (@$zobr_co=="del_podgalery" AND @$vysledok<>"ok") { // vymazanie položky sub. menu
 $vys_sub=prikaz_sql("SELECT nazov FROM podgaleria WHERE id_polozka=$zobr_cast LIMIT 1",
                     "Nájdenie položky(".__FILE__ ." on line ".__LINE__ .")","Žiaľ sa momentálne nepodarilo nájsť položku a teda ani vymazať! Skúste neskôr.");
 if (@$vys_sub) {
  $zaz_sub=mysql_fetch_array($vys_sub);
  echo("\n<div class=st_zle>Vymazanie položky podgalérie!!!<br />");
  echo("Naozaj chceš vymazať položku <B><U>$zaz_sub[nazov]</U></B>!!!");
  echo("<br />Všetky fotky priradené k tejto podgalérii sa stanú nepriradenými!");
  echo("\n<form action=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol\" method=post>");
  echo("\n<input name=\"pr_id_polozka\" type=\"hidden\" value=\"$zobr_cast\">");
  echo("\n<input name=\"podgalery\" type=\"submit\" value=\"Áno\">");
  echo("\n<input name=\"podgalery\" type=\"submit\" value=\"Nie\"></form></div>\n");
 }
}
else {
  /* ----------- Časť spracovania formulára ---------- */
if (@$vysledok<>"") { // Zapisovalo sa do databázy
  if ($vysledok<>"ok") {  // Načítanie údajov po chybnom zápise do databázy
    $nazov=$_POST["pr_nazov"];
	$popis=$_POST["pr_popis"];
	$id_menu=$_POST["pr_id_menu"];
	$id_reg=$_POST["pr_id_reg"];
	$zobrazenie=$_POST["pr_zobrazenie"];
  }
}
if (!(@$_REQUEST["podgalery"]=="Áno" AND $vysledok=="ok")) { //Nezobrazím ak sa mazalo, alebo úspešne zapisovalo do DB
 echo("\n<form name=\"zadanie\" action=\"./index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol&amp;cast=$zobr_cast\" method=post>"); // Začiatok formulára pre zadanie údajov
 if ($zobr_co=="edit_podgalery"){ //Ak prišiel údaj o požiadavke na editáciu položky tak sa položka nájde v databáze a načíta do premených
  $navrat_e=prikaz_sql("SELECT * FROM podgaleria WHERE id_polozka=$zobr_cast LIMIT 1",
                       "Načítanie položky podgalery (".__FILE__ ." on line ".__LINE__ .")","Žiaľ sa momentálne nepodarilo položku nájsť! Skúste neskôr.");
  if ($navrat_e) { //Ak bola požiadavka do DB úspečná
   $zaz_e = mysql_fetch_array($navrat_e);
   $id_polozka=$zaz_e["id_polozka"];
   $nazov=$zaz_e["nazov"];
   $popis=$zaz_e["popis"];
   $id_menu=$zaz_e["id_menu"];
   $id_reg=$zaz_e["id_reg"];
   $zobrazenie=$zaz_e["zobrazenie"];
   echo("<input type=\"hidden\" name=\"pr_id_polozka\" value=\"$id_polozka\">");
  }
 }  
 echo("\n<div id=admin><fieldset>"); //Samotny formular na zadanie
 form_pole("pr_nazov","Zobrazený názov",$nazov,"Názov položky galérie", 50);
 form_registr("pr_id_reg", $id_reg, jeadmin());
 echo("<input type=\"hidden\" name=\"pr_id_menu\" id=\"pr_id_menu\" value=1>");
 form_textarea("pr_popis","Popis podgalérie",$popis,"");
 if ($zobr_co=="edit_podgalery") form_zaskrt("pr_del_pocitadlo", "Zmazať počítadlo", 1);
 echo("<input name=\"podgalery\" type=\"submit\" value=\"");
 echo($zobr_cast>0 ? "Oprav" : "Pridaj");
 echo("\"></fieldset></form></div>"); 
}
}