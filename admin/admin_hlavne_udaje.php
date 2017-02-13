<?php
/* Tento súbor slúži na obsluhu pridania/opravy/vymazania hlavných programových údajov
   Zmena: 13.02.2017 - PV
*/

// Hlavička stránky
if (@$bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód
echo("<h2>Pridanie/Oprava/Mazanie hlavných údajov</h2><br />"); //Hlavička článku

//Inicializácia premených
 $id_sub_menu=0;  
 $nazov="";     //Názov premennej
 $text="";      //Hodnote danej premennej
 $comment="";    //Komentár k premennej
 $id_reg=3;      //Úroveň registrácie
 $vysledok="";   //Výsledok zápisu do DB 
  /*-------- Časť zápisu do databázy    ---------- */ 
function pridaj_udaj()
 /* Funkcia zapíše položku udaju do databázy.
     Vstupy: - hodnoty prichádzajú cez $_POST z formulára
	 Výstupy: ok-ak všetko prebehlo správne inak chybová hláška */
{
$pridanie_udaju=prikaz_sql("INSERT INTO udaje (nazov, text, comment, id_registracia) 
                               VALUES('".$_REQUEST["nazov_f"]."', '".$_REQUEST["text_f"]."', '".$_REQUEST["comment_f"]."', ".$_REQUEST["id_reg_f"].")",
							  "Pridanie udaju ".__FILE__ ." on line ".__LINE__ ."","");
if (!$pridanie_udaju) return mysql_error();
return "ok";
}

function oprav_udaj()
 /* Funkcia aktualizuje položku udaju v databáze.
     Vstupy: - hodnoty prichádzajú cez $_POST z formulára
	 Výstupy: ok-ak všetko prebehlo správne inak chybová hláška */
{
$oprava_udaju=prikaz_sql("UPDATE udaje SET nazov='".$_REQUEST["nazov_f"]."', text='".$_REQUEST["text_f"]."', comment='".$_REQUEST["comment_f"]."',
                                                 id_registracia=".$_REQUEST["id_reg_f"]." WHERE id=".$_REQUEST["id_polozka"]." LIMIT 1",
						 "Oprava udaju ".__FILE__ ." on line ".__LINE__ ."","");
if (!$oprava_udaju) return mysql_error();
return "ok";
}
  /* --- Pridanie/Oprava položky sub menu ak bola daná požiadavka --- */
if (@$_REQUEST["udaj_f"]=="Pridaj")    $vysledok=pridaj_udaj();
elseif (@$_REQUEST["udaj_f"]=="Oprav") $vysledok=oprav_udaj();
  /* ----------- Časť spracovania formulára ---------- */
if ($vysledok<>"") { // Zapisovalo sa do databázy
  if ($vysledok<>"ok") {  // Načítanie údajov po chybnom zápise do databázy
    stav_zle("Záznam nebol pridaný. Niektorý údaj bol zadaný chybne alebo nebolo možné uskutočniť spojenie s databázou!:<br /><b>$vysledok</b>");
    $id_polozka=$_POST["id_polozka"];  // Opätovné načítanie údajou ak došlo k chybe
    $nazov=$_POST["nazov_f"];
    $text=$_POST["text_f"];
	$id_reg=$_POST["id_reg_f"];
	$comment=$_POST["comment_f"];
  }
  else {                // Správny zápis aktualizácie do DB
    echo("<div class=st_dobre>Položka udaju bola ");  //Vypísanie info o operácii
    if (@$_REQUEST["sub_menu"]=="Pridaj") echo("pridaná!");   
    elseif(@$_REQUEST["sub_menu"]=="Oprav") echo("opravená!");
    else echo("zmenená!");
    echo("</div>");
  }
}
if (!(@$_REQUEST["udaj_f"]=="Áno" AND $vysledok=="ok")) {
 echo("\n<form name=\"zadanie\" action=\"./index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol\" method=post>"); // Začiatok formulára pre zadanie údajov
 if ($zobr_co=="adm_edit_udaj"){ //Ak prišiel údaj o požiadavke na editáciu položky tak sa položka nájde v databáze a načíta do premených
  $navrat_e=prikaz_sql("SELECT * FROM udaje WHERE id=".$_REQUEST["id"]." LIMIT 1",
                       "Načítanie položky udaju (".__FILE__ ." on line ".__LINE__ .")","Žiaľ sa momentálne nepodarilo položku nájsť! Skúste neskôr.");
  if ($navrat_e) { //Ak bola požiadavka do DB úspečná
   $zaz_e = mysql_fetch_array($navrat_e);
   $id_polozka=$zaz_e["id"];
   $nazov=$zaz_e["nazov"];
   $text=$zaz_e["text"];
   $id_reg=$zaz_e["id_reg"];
   $comment=$zaz_e["comment"];
   echo("<input type=\"hidden\" name=\"id\" value=\"$zaz_e[id]\">");
  }
 }  
 echo("\n<div id=admin><fieldset>"); //Samotny formular na zadanie
 if (jeadmin()==5) {
  form_pole("nazov_f","Názov premennej údaju",$nazov,"Názov položky údaju použitý v kóde webu.", 20);
  form_pole("comment_f","Komentár k údaju",$comment,"", 255, 70);
  form_registr("id_registracia_f", $id_reg, 5);
 } 
 else {
  echo("Názov premennej údaju: $nazov<input name=\"nazov_f\" type=\"hidden\" value=\"$nazov\"><br />");
  echo("Komentár premennej údaju: $comment<input name=\"comment_f\" type=\"hidden\" value=\"$comment\"><br />");
 } 
 form_pole("text_f","Hodnota údaja",$text,"", 255, 70);
 echo("<input name=\"udaj_f\" type=\"submit\" value=\"");
 echo(@$_REQUEST["id"]<>"" ? "Oprav" : "Pridaj");
 echo("\"></fieldset></form></div>"); //
}
  /* ----- Výpis všetkých položiek sub. udajov ----- */
$navrat=prikaz_sql("SELECT udaje.id as uid, udaje.nazov as unazov, text, comment, udaje.id_registracia as id_reg, registracia.nazov as rnazov
                    FROM udaje, registracia
                    WHERE udaje.id_registracia=registracia.id AND udaje.id_registracia<=".jeadmin(),
                   "Výpis položiek udajov (".__FILE__ ." on line ".__LINE__ .")","Žiaľ sa momentálne nepodarilo zoznam vypísať! Skúste neskôr."); 
if ($navrat) { //Ak bola požiadavka do DB úspečná
  echo("<table id=vyp_adm cellpadding=2 cellspacing=0><tr><th>Id</th><th>Názov</th><th>Komentár</th><th>Hodnota</th>");
  if (jeadmin()==5) echo("<th>Registrácia</th>");
  echo("<th ></th></tr>\n");//colspan=2
  $pom=true;
  while ($polozka = mysql_fetch_array($navrat)){ 
   echo($pom ? "<tr class=r1>" : "<tr class=r2>");
   if ($pom) $pom=false; else $pom=true;
   echo("<td>$polozka[uid]</td><td><b>$polozka[unazov]</b></td><td>$polozka[comment]</td><td>$polozka[text]</td>");  
   if (jeadmin()==5)
    echo($polozka["id_reg"]==0 ? "<td>$polozka[id_reg]-$polozka[rnazov]</td>" : "<td><div style=\"display: inline;\" class=st_zeleno>$polozka[id_reg]-$polozka[rnazov]</div></td>");
   echo("<td>
         <a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol&amp;id=$polozka[uid]&amp;co=adm_edit_udaj\" class=edit title=\"Editácia položky $polozka[unazov]\">
		 &nbsp;&nbsp;&nbsp;&nbsp;</a></td>");
   echo("</tr>\n");
  }
  echo("</table>");
}