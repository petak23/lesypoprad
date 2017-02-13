<?php
/* Tento súbor slúži na obsluhu pridania/opravy/vymazania sub menu
   Zmena: 13.02.2017 - PV
*/

// Hlavička stránky
if (@$bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód
echo("<h2>Pridanie/Oprava/Mazanie sub menu</h2><br />"); //Hlavička článku

//Inicializácia premených
 $id_sub_menu=0;  
 $nazov=" ";     //Zobrazený názov
 $id_hl_menu=" ";//Priradený článok
 $polozka="";    //Priradená položka sub menu
 $id_reg=0;      //Úroveň registrácie
 $subor=".php";  //Priradený súbor
 $clanky=0;      //Či je možné k danej položke priradiť články
 $zobrazenie=0;  //Či sa má položka zobraziť v bočnej ponuke
 $vysledok="";   //Výsledok zápisu do DB 
  /*-------- Časť zápisu do databázy    ---------- */ 
function pridaj_sub_menu()
 /* Funkcia zapíše položku sub menu do databázy.
     Vstupy: - hodnoty prichádzajú cez $_POST z formulára
	 Výstupy: ok-ak všetko prebehlo správne inak chybová hláška
	 Obmedzenie: Zatiaľ neznáme.
	 Zmena: 21.06.2011 - PV
  */
{
if (@(int)$_REQUEST["pr_clanky"]>0) $pr_clanky=(int)$_REQUEST["pr_clanky"]; else $pr_clanky=0;
if (@(int)$_REQUEST["pr_zobrazenie"]>0) $pr_zobrazenie=(int)$_REQUEST["pr_zobrazenie"]; else $pr_zobrazenie=0;
$pridanie_sub_menu=prikaz_sql("INSERT INTO sub_menu (nazov, id_hl_menu, id_reg, polozka, subor, clanky, zobrazenie) 
                               VALUES('".$_REQUEST["nazov_f"]."', ".$_REQUEST["e_id_hl_menu"].", ".$_REQUEST["pr_id_reg"].", 
							          '".$_REQUEST["pr_polozka"]."', '".$_REQUEST["pr_subor"]."', $pr_clanky, $pr_zobrazenie)",
							  "Pridanie sub_menu ".__FILE__ ." on line ".__LINE__ ."","");
if (!$pridanie_sub_menu) return mysql_error();
return "ok";
}

function oprav_sub_menu()
 /* Funkcia aktualizuje položku sub menu v databáze.
     Vstupy: - hodnoty prichádzajú cez $_POST z formulára
	 Výstupy: ok-ak všetko prebehlo správne inak chybová hláška
	 Obmedzenie: Zatiaľ neznáme.
	 Zmena: 21.06.2011 - PV
  */
{
if (@(int)$_REQUEST["pr_clanky"]>0) $pr_clanky=(int)$_REQUEST["pr_clanky"]; else $pr_clanky=0;
if (@(int)$_REQUEST["pr_zobrazenie"]>0) $pr_zobrazenie=(int)$_REQUEST["pr_zobrazenie"]; else $pr_zobrazenie=0;
$oprava_sub_menu=prikaz_sql("UPDATE sub_menu SET nazov='".$_REQUEST["nazov_f"]."', id_hl_menu='".$_REQUEST["e_id_hl_menu"]."', 
                                                 id_reg=".$_REQUEST["pr_id_reg"].", polozka='".$_REQUEST["pr_polozka"]."',
												 subor='".$_REQUEST["pr_subor"]."', clanky='$pr_clanky', zobrazenie='$pr_zobrazenie'
					             WHERE id_sub_menu=".$_REQUEST["id_sub_menu_f"]." LIMIT 1","Oprava sub_menu ".__FILE__ ." on line ".__LINE__ ."","");
if (!$oprava_sub_menu) return mysql_error();
return "ok";
}

function maz_sub_menu()
 /* Funkcia "maže" položku sub menu v databáze (označí ju ako zmazanú t.j. zobrazenie = -1)
     Vstupy: - hodnoty prichádzajú cez $_POST z formulára
	 Výstupy: ok-ak všetko prebehlo správne inak chybová hláška
	 Obmedzenie: Zatiaľ neznáme.
	 Zmena: 03.06.2011 - PV
  */
{
$mazanie_sub_menu=prikaz_sql("UPDATE sub_menu SET zobrazenie=-1 WHERE id_sub_menu=".$_REQUEST["id_sub_menu"]." LIMIT 1","Mazanie sub_menu ".__FILE__ ." on line ".__LINE__ ."","");
if (!$mazanie_sub_menu) return mysql_error();
return "ok";
}
  /* --- Pridanie/Oprava položky sub menu ak bola daná požiadavka --- */
if (@$_REQUEST["sub_menu"]=="Pridaj")    $vysledok=pridaj_sub_menu();
elseif (@$_REQUEST["sub_menu"]=="Oprav") $vysledok=oprav_sub_menu();
elseif (@$_REQUEST["sub_menu"]=="Áno")   $vysledok=maz_sub_menu();

if (@$zobr_co=="adm_del_sub_menu" AND @$vysledok<>"ok") { // vymazanie položky sub. menu
 $vys_sub=prikaz_sql("SELECT * FROM sub_menu WHERE id_sub_menu=".$_REQUEST["id"]." LIMIT 1",
                     "Nájdenie položky(".__FILE__ ." on line ".__LINE__ .")","Žiaľ sa momentálne nepodarilo nájsť položku a teda ani vymazať! Skúste neskôr.");
 if (@$vys_sub) {
  $zaz_sub=mysql_fetch_array($vys_sub);
  echo("\n<div class=st_zle>Vymazanie položky sub. menu !!!<br />");
  echo("Naozaj chceš vymazať položku <B><U>$zaz_sub[nazov]</U></B>!!!");
  echo("\n<form action=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol\" method=post>");
  echo("\n<input name=\"id_sub_menu\" type=\"hidden\" value=\"$zaz_sub[id_sub_menu]\">");
  echo("\n<input name=\"sub_menu\" type=\"submit\" value=\"Áno\">");
  echo("\n<input name=\"sub_menu\" type=\"submit\" value=\"Nie\"></form></div>\n");

 }
}
else {
  /* ----------- Časť spracovania formulára ---------- */
if ($vysledok<>"") { // Zapisovalo sa do databázy
  if ($vysledok<>"ok") {  // Načítanie údajov po chybnom zápise do databázy
    stav_zle("Záznam nebol pridaný. Niektorý údaj bol zadaný chybne alebo nebolo možné uskutočniť spojenie s databázou!:<br /><b>$vysledok</b>");
    $id_sub_menu=$_POST["id_sub_menu_f"];  // Opätovné načítanie údajou ak došlo k chybe
    $nazov=$_POST["nazov_f"];
    $id_hl_menu=$_POST["e_id_hl_menu"];
	$id_reg=$_POST["pr_id_reg"];
	$polozka=$_POST["pr_polozka"];
	$subor=$_POST["pr_subor"];
	$clanky=$_POST["pr_clanky"];
	$zobrazenie=$_POST["pr_zobrazenie"];
  }
  else {                // Správny zápis aktualizácie do DB
    echo("<div class=st_dobre>Položka sub menu bola ");  //Vypísanie info o operácii
    if (@$_REQUEST["sub_menu"]=="Pridaj") echo("pridaná!");   
    elseif(@$_REQUEST["sub_menu"]=="Oprav") echo("opravená!");
    else echo("zmenená!");
    echo("</div>");
  }
}
if (!(@$_REQUEST["sub_menu"]=="Áno" AND $vysledok=="ok")) {
 echo("\n<form name=\"zadanie\" action=\"./index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol\" method=post>"); // Začiatok formulára pre zadanie údajov
 if ($zobr_co=="adm_edit_sub_menu"){ //Ak prišiel údaj o požiadavke na editáciu položky tak sa položka nájde v databáze a načíta do premených
  $navrat_e=prikaz_sql("SELECT * FROM sub_menu WHERE id_sub_menu=".$_REQUEST["id"]." LIMIT 1",
                       "Načítanie položky sub-menu (".__FILE__ ." on line ".__LINE__ .")","Žiaľ sa momentálne nepodarilo položku nájsť! Skúste neskôr.");
  if ($navrat_e) { //Ak bola požiadavka do DB úspečná
   $zaz_e = mysql_fetch_array($navrat_e);
   $id_sub_menu=$zaz_e["id_sub_menu"];
   $nazov=$zaz_e["nazov"];
   $id_hl_menu=$zaz_e["id_hl_menu"];
   $id_reg=$zaz_e["id_reg"];
   $polozka=$zaz_e["polozka"];
   $subor=$zaz_e["subor"];
   $clanky=$zaz_e["clanky"];
   $zobrazenie=$zaz_e["zobrazenie"];
   echo("<input type=\"hidden\" name=\"id_sub_menu_f\" value=\"$zaz_e[id_sub_menu]\">");
  }
 }  
 echo("\n<div id=admin><fieldset>"); //Samotny formular na zadanie
 form_pole("nazov_f","Zobrazený názov",$nazov,"Názov položky pod-menu, ktorý sa zobrazí v bočnom menu.", 50);
 form_pole("pr_polozka","Názov priradenej položky",$polozka,"Názov položky, ktorá je priradená k položke pod-menu.", 20);
 form_pole("pr_subor","Názov priradeného súboru",$subor,"Vrátane relatívnej cesty k súboru od hlavného adresára kde je index.php napr. skolka/o_nas.php", 30);
 form_registr("pr_id_reg", $id_reg, 5);
 echo("<label for=\"e_id_hl_menu\">Priradené k položke hlavného menu: </label>");
 $us_str=prikaz_sql("SELECT * FROM old_hlavne_menu ORDER BY id_hlavne_menu", 
                   "Usporiadanie stránky (".__FILE__ ." on line ".__LINE__ .")", "Momentálne sa nepodarilo vypísať!");
 if ($us_str) {  // Ak bola požiadavka v DB úspešná
  echo("<select name=\"e_id_hl_menu\" id=\"e_id_hl_menu\">\n");
  while($usporiadanie=mysql_fetch_array($us_str)) {
    echo("<option value=\"$usporiadanie[id_hlavne_menu]\"");
    if ($id_hl_menu==$usporiadanie["id_hlavne_menu"]) echo(" selected");  
    echo("> $usporiadanie[nazov]</option>\n");
  }
  echo("</select><br />");
 }
 else echo("<input type=\"hidden\" name=\"e_id_hl_menu\" id=\"e_id_hl_menu\" value=10>Nie je možné zmeniť z dôvodu chyby v databáze. Skúste prosím neskôr. 
           Prednastavená hodnota je: Článok<br />");//!!! POZOR zmeniť číslo value pre iný WEB !!!
 form_zaskrt("pr_clanky", "Je možné priradiť články", $clanky);
 form_zaskrt("pr_zobrazenie", "Zobrazenie v bočnej ponuke", $zobrazenie);
 echo("<input name=\"sub_menu\" type=\"submit\" value=\"");
 echo(@$_REQUEST["id"]<>"" ? "Oprav" : "Pridaj");
 echo("\"></fieldset></form></div>"); //
}
  /* ----- Výpis všetkých položiek sub. menu ----- */
$navrat=prikaz_sql("SELECT id_sub_menu, sub_menu.nazov as snazov, registracia.nazov as rnazov, clanok, old_hlavne_menu.nazov as hnazov, 
                           registracia.id as id_reg, subor, polozka, sub_menu.clanky as prir_cl, zobrazenie
                    FROM sub_menu, registracia, old_hlavne_menu
                    WHERE sub_menu.id_reg=registracia.id AND sub_menu.id_hl_menu=old_hlavne_menu.id_hlavne_menu
					ORDER BY id_hl_menu, zobrazenie DESC",
                   "Výpis položiek sub. menu (".__FILE__ ." on line ".__LINE__ .")","Žiaľ sa momentálne nepodarilo zoznam vypísať! Skúste neskôr."); 
if ($navrat) { //Ak bola požiadavka do DB úspečná
  echo("<table id=vyp_adm cellpadding=2 cellspacing=0><tr><th>Id</th><th>Názov</th><th>Položka</th><th>Súbor</th><th>Registrácia</th><th>Hl. menu</th><th>Podčl.?</th><th>Zobr.?</th><th colspan=2></th></tr>\n");
  $pom=true;
  while ($polozka = mysql_fetch_array($navrat)){ 
   echo($pom ? "<tr class=\"r1" : "<tr class=\"r2");
   if($polozka["zobrazenie"]==-1) echo(" zmaz");
   echo("\">");
   if ($pom) $pom=false; else $pom=true;
   echo("<td>$polozka[id_sub_menu]</td><td><b>$polozka[snazov]</b></td><td>$polozka[polozka]</td><td>$polozka[subor]</td><td>");  
   echo($polozka["id_reg"]==0 ? "$polozka[id_reg]-$polozka[rnazov]" : "<div style=\"display: inline;\" class=st_zeleno>$polozka[id_reg]-$polozka[rnazov]</div>");
   echo("</td><td>$polozka[hnazov]</td><td>");
   echo(@$polozka["prir_cl"]==1 ? "<div style=\"display: inline;\" class=st_zeleno>Áno</div>" : "Nie");
   echo("</td><td>$polozka[zobrazenie]");
   echo("</td><td>
         <a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol&amp;id=$polozka[id_sub_menu]&amp;co=adm_edit_sub_menu\" class=edit title=\"Editácia položky $polozka[snazov]\">
		 &nbsp;&nbsp;&nbsp;&nbsp;</a></td><td>
         <a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol&amp;id=$polozka[id_sub_menu]&amp;co=adm_del_sub_menu\" class=vymaz title=\"Vymazanie položky $polozka[snazov]\">&nbsp;&nbsp;&nbsp;&nbsp;</a>
         </td></tr>\n");
  }
  echo("</table>");
} 
}