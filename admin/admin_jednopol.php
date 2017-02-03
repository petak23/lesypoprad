<?php
/* Tento súbor slúži na obsluhu pridania/opravy/vymazania jednopoložkových tabuliek v DB. 
   (t.j. v tabuľke je len id_polozka a nazov)
   Zmena: 17.06.2011 - PV
*/

$navrat_sub=prikaz_sql("SELECT polozka FROM sub_menu WHERE id_sub_menu=$zobr_pol AND id_hl_menu=$zobr_clanok AND id_reg<=".jeadmin()." LIMIT 1",
                       "Položka sub menu-súbor (".__FILE__ ." on line ".__LINE__ .")",
	 		           "Požadovaný článok sa nenašiel! Buď neexzistuje, došlo k chybe alebo nemáte dostatočné oprávnenie na prezeranie. Skúste, prosím, neskôr.");					   
if ($navrat_sub AND mysql_numrows($navrat_sub)==1){ //Ak bol dopit v DB úspešný - pre  zobr_pol a id_hl_menu sa našiel v DB jeden názov súboru 
   $ad_clanok=mysql_fetch_array($navrat_sub); //Načítaj z DB
   $tabulka=$ad_clanok["polozka"];        //Do tabulka vlož nájdenú hodnotu zo sub menu
}
//$tabulka=$_REQUEST["pol"]; //Názov tabulky aj ostatných polí sa berie z položky pol
$tab_input="";

// Hlavička stránky
if (@$bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód
echo("<h2>Pridanie/Oprava tabuľky: $tabulka</h2><br />");

//Inicializácia premených
 $id_polozka=0; //Id danej položky 
 $nazov="";     //Zobrazený názov
 $vysledok="";  //Výsledok zápisu do DB 

  /*-------- Časť zápisu do databázy    ---------- */ 
function pridaj_jednopol($tabulka)
 /* Funkcia zapíše položku "jednopoložkovej" tabuľky do databázy.
     Vstupy: - hodnoty prichádzajú cez $_REQUEST z formulára
	 Výstupy: ok-ak všetko prebehlo správne inak chybová hláška
	 Obmedzenie: Zatiaľ neznáme.
	 Zmena: 13.9.2010 - PV
  */
{
$pridanie_jednopol=prikaz_sql("INSERT INTO $tabulka (id_polozka, nazov) VALUES(".$_REQUEST["id_polozka"].", '".$_REQUEST["nazov"]."')",
                              "Pridanie položky (".__FILE__ ." on line ".__LINE__ .")","Záznam nebol pridaný! Niektorý údaj bol zadaný chybne alebo nebolo možné uskutočniť spojenie s databázou!");
if (!$pridanie_jednopol) return mysql_error();
return "ok";
}
function oprav_jednopol($tabulka)
 /* Funkcia aktualizuje položku "jednopoložkovej" tabuľky v databáze.
     Vstupy: - hodnoty prichádzajú cez $_REQUEST z formulára
	 Výstupy: ok-ak všetko prebehlo správne inak chybová hláška
	 Obmedzenie: Zatiaľ neznáme.
	 Zmena: 12.9.2010 - PV
  */
{
$oprava_jednopol=prikaz_sql("UPDATE $tabulka SET id_polozka=".$_REQUEST["id_polozka"].", nazov='".$_REQUEST["nazov"]."' WHERE id_polozka=".$_REQUEST["id"]." LIMIT 1",
                            "Oprava položky (".__FILE__ ." on line ".__LINE__ .")","Záznam nebol opravený! Niektorý údaj bol zadaný chybne alebo nebolo možné uskutočniť spojenie s databázou!");
if (!$oprava_jednopol) return mysql_error();
return "ok";
}
function vymaz_jednopol($tabulka)
  /* Funkcia vymaže položku "jednopoložkovej" tabuľky z databázy.
     Vstupy: - hodnoty prichádzajú cez $_REQUEST z formulára
	 Výstupy: ok-ak všetko prebehlo správne inak chybová hláška
	 Obmedzenie: Zatiaľ neznáme.
	 Zmena: 12.9.2010 - PV
  */
 {
$vymaz_jednopol=prikaz_sql("DELETE FROM $tabulka WHERE id_polozka=".$_REQUEST["id_polozka"],
                           "Zmazanie položky (".__FILE__ ." on line ".__LINE__ .")","Záznam nebol vymazaný! Niektorý údaj bol zadaný chybne alebo nebolo možné uskutočniť spojenie s databázou!");
if (!$vymaz_jednopol) return mysql_error();
return "ok";
}
  /* --- Pridanie/Oprava položky menu akcie ak bola daná požiadavka --- */
$tab_vymaz=$tabulka."_vymaz";
if (@$_REQUEST[$tabulka]=="Pridaj")    $vysledok=pridaj_jednopol($tabulka);
elseif (@$_REQUEST[$tabulka]=="Oprav") $vysledok=oprav_jednopol($tabulka);
elseif (@$_REQUEST[$tab_vymaz]=="Áno") $vysledok=vymaz_jednopol($tabulka);

  /* ----------- Časť spracovania po zápise do DB ---------- */
if ($vysledok<>"") { // Zapisovalo sa do databázy
  if ($vysledok<>"ok") {  // Načítanie údajov po chybnom zápise do databázy
    $id_polozka=@$_REQUEST["id_polozka"];  // Opätovné načítanie údajou ak došlo k chybe
    $nazov=$_REQUEST["nazov"];
  }
  else {                // Správny zápis aktualizácie do DB
    echo("<div class=st_dobre>Položka v tabuľke $tabulka bola ");  //Vypísanie info o operácii
    if (@$_REQUEST[$tabulka]=="Pridaj") echo("pridaná!");   
    elseif(@$_REQUEST[$tabulka]=="Oprav") echo("opravená!");
	elseif(@$_REQUEST[$tab_vymaz]=="Áno") echo("vymazaná!");
    else echo("zmenená!"); // Len v prípade chyby
    echo("</div>");
	$_REQUEST["id"]=0;
  }
}
  /* ------------ Časť pre vymazanie položky ----------- */
if (@$_REQUEST["operacia"]=="d") { 
 $vys_polozka=prikaz_sql("SELECT nazov FROM $tabulka WHERE id_polozka=".$_REQUEST["id"]." LIMIT 1",
                         "Nájdenie položky $tabulka (".__FILE__ ." on line ".__LINE__ .")","Žiaľ sa momentálne nepodarilo položku nájsť! Skúste neskôr.");
 if (@$vys_polozka) {
  $zaz_pol=mysql_fetch_array($vys_polozka);
  echo("<div class=st_zle>Vymazanie položky !!!</div>");
  echo("<div class=st_cerveno>Naozaj chceš vymazať položku <b><u>$zaz_pol[nazov]</u></b>!!! z tabuľky $tabulka ???");
  echo("<form action=\"./index.php?clanok=$zobr_clanok&amp;pol=$tabulka\" method=post>");
  echo("<input name=\"id_polozka\" type=\"hidden\" value=\"".$_REQUEST["id"]."\">");
  echo("<input name=\"$tab_vymaz\" type=\"submit\" value=\"Áno\">");
  echo("<input name=\"$tab_vymaz\" type=\"submit\" value=\"Nie\"></form></div>");
 }
}
else {  
  /* ----------- Časť spracovania formulára ---------- */
 echo("<form name=\"zadanie\" action=\"./index.php?clanok=$zobr_clanok&amp;pol=$tabulka\" method=post>"); // Začiatok formulára pre zadanie údajov
 if (@$_REQUEST["co"]=="e"){ //Ak prišiel údaj o požiadavke na editáciu položky tak sa položka nájde v databáze a načíta do premených //&amp;bl=2
  $navrat_e=prikaz_sql("SELECT * FROM $tabulka WHERE id_polozka=".$_REQUEST["id"]." LIMIT 1",
                       "Načítanie položky $tabulka (".__FILE__ ." on line ".__LINE__ .")","Žiaľ sa momentálne nepodarilo položku nájsť! Skúste neskôr.");
  if ($navrat_e) { //Ak bola požiadavka do DB úspečná
   $zaz_e = mysql_fetch_array($navrat_e);
   $id_polozka=$zaz_e["id_polozka"];
   $nazov=$zaz_e["nazov"];
   echo("<input name=\"id\" type=\"hidden\" value=\"$id_polozka\">");
  }
 }
 echo("<div id=admin>");  //Samotny formular na zadanie
 echo("Id položky:<input type=\"text\" name=\"id_polozka\" size=5 maxlength=5 value=\"$id_polozka\"><div>(Jedinečná číselná identifikácia položky)</div>");
 echo("Zobrazený názov: <input type=\"text\" name=\"nazov\" size=30 maxlength=30 value=\"$nazov\"><br>");
 echo("<input name=$tabulka type=\"submit\" value=\"");
echo(@(int)$_REQUEST["id"]>0 ? "Oprav" : "Pridaj");
 echo("\"></form></div>"); 

  /* ----- Výpis všetkých položiek hl. menu ----- */
 $navrat=prikaz_sql("SELECT * FROM $tabulka ORDER BY id_polozka",
                    "Výpis položiek $tabulka (".__FILE__ ." on line ".__LINE__ .")","Žiaľ sa momentálne nepodarilo zoznam vypísať! Skúste neskôr."); 
 if ($navrat) { //Ak bola požiadavka do DB úspečná
  echo("<table id=adm_vyp>"); //Výpis položiek menu
  echo("<tr><th>Id</th><th width=200>Názov</th><th>Operácie</th></tr>");
  while ($polozka = mysql_fetch_array($navrat)){ 
    echo("<tr><td><span class=zvr>$polozka[id_polozka]</span></td><td class=zvb>$polozka[nazov]</td>");
    echo("<td><a href=\"index.php?clanok=$zobr_clanok&amp;pol=$tabulka&amp;operacia=e&amp;id=$polozka[id_polozka]\" class=edit title=\"Editácia položky\">&nbsp;</a>"); //Odkaz na editáciu
    echo("&nbsp;&nbsp;"); 
    echo("<a href=\"index.php?clanok=$zobr_clanok&amp;pol=$tabulka&amp;operacia=d&amp;id=$polozka[id_polozka]\" class=vymaz title=\"Vymazanie položky\">&nbsp;</a>");    //Odkaz na vymazanie
    echo("</td></tr>");
  }
  echo("</table>");
 }  
}
?>