<?php
/* Tento súbor slúži na obsluhu pridania/opravy/vymazania oznamu
   Zmena: 13.02.2017 - PV
*/

// Hlavička stránky
if (@$bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód

//Inicializácia premených
 $datum=StrFTime("%Y-%m-%d", time()); //Aktuálny dátum
 $news=1;     //Posielanie noviniek
 $nazov="";  //Nazov oznamu
 $text="";   //Text oznamu
 $mazanie=0;  //Mazanie po 90 dňoch
 $id_reg=0;   //Úroveň registrácie
 $id_ikonka=1;//Ikonka oznamu
 $co=$zobr_co; //Čo sa bude robiť na stránke
 if (@$_REQUEST["oznamy"]<>"") $operacia=$_REQUEST["oznamy"]; else $operacia="Nič"; //Čo sa robilo na stránke

function vymaz_oznam()
  /* Funkcia vymaže oznam z databázy.
     Vstupy: - hodnoty prichádzajú cez $_POST z formulára
	 Výstupy: ok-ak všetko prebehlo správne inak chybová hláška
	 Obmedzenie: Zatiaľ neznáme.
	 Zmena: 28.07.2011 - PV
  */
{
$vymaz_oznamu=mysql_query("UPDATE oznam SET zmazane = -1 WHERE id_oznamu = ".$_POST["id_oznamu"]." LIMIT 1 ");						 
if (!$vymaz_oznamu) return mysql_error();
return "ok";
}
 
if (@$_REQUEST["vymaz_oznam"]=="Áno")  {$vysledok=vymaz_oznam(); $co="deleted";$operacia="vymazane";} 
 
echo("<h2>"); //Hlavička stránky
if ($co=="new_oznam") echo("Pridanie");
elseif ($co=="del_oznam") echo("Vymazanie");
elseif ($co=="edit_oznam") echo("Oprava");
else echo("Spracovanie"); //Kôli chybe
echo("&nbsp;oznamu</h2>");

if (@$co=="del_oznam") { /* vymazanie clena */
 $vys_oznam=prikaz_sql("SELECT * FROM oznam WHERE id_oznamu=$zobr_pol LIMIT 1",
                        "Nájdenie oznamu(".__FILE__ ." on line ".__LINE__ .")","Žiaľ sa momentálne nepodarilo nájsť tento oznam! Skúste neskôr.");
 if (@$vys_oznam) {
  $zaz_oznam=mysql_fetch_array($vys_oznam);
  echo("\n<div class=st_zle>Vymazanie oznamu !!!<br />");
  echo("Naozaj chceš vymazať oznam <B><U>$zaz_oznam[nazov]</U></B>!!!");
  echo("\n<form action=\"./index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol&amp;co=$zobr_co\" method=post>");
  echo("\n<input name=\"id_oznamu\" type=\"hidden\" value=\"$zaz_oznam[id_oznamu]\">");
  echo("\n<input name=\"vymaz_oznam\" type=\"submit\" value=\"Áno\">");
  echo("\n<input name=\"vymaz_oznam\" type=\"submit\" value=\"Nie\"></form></div>\n");
 }
}
  /* ----------- Časť spracovania formulára ---------- */
if (@$vysledok<>"") {     // Zapisovalo sa do databázy
  if ($vysledok<>"ok") {  // Načítanie údajov po chybnom zápise do databázy
  stav_zle("Záznam nebol pridaný. Niektorý údaj bol zadaný chybne alebo nebolo možné uskutočniť spojenie s databázou!<BR>$vysledok");
  $datum=$_POST["datum"];  // Opätovné načítanie údajou ak došlo k chybe
  $nazov=$_POST["nazov"];
  $text=$_POST["oznam_t"];
  $id_reg=$_POST["id_reg"];
  $id_ikonka=$_POST["id_ikonka"];
  $mazanie=$_POST["mazanie"];
  $news=$_POST["news"];
 }
 else {   // Správny zápis oznamu do databázy
  $text="Oznam bol ";  //Vypísanie info o operácii
  $oznam_datum=StrFTime("%d.%m.%Y %H:%M", strtotime($datum));
  if ($operacia=="Pridaj") {
   $text .="pridaný!";
   $nazov=$_POST["nazov"];   
   $oznam_n=prikaz_sql("SELECT id_oznamu FROM oznam WHERE datum='$datum' AND nazov='$nazov' AND zmazane=0 ORDER BY id_oznamu DESC LIMIT 1", 
                       "Najdenie id oznamu (".__FILE__ ." on line ".__LINE__ .")",""); //Usporiadanie je len ak by sa v jeden deň boli dva rovnaké názvy
   if ($oznam_n AND mysql_numrows($oznam_n)>0) { //Zistenie id článku, ktorý sa práve zapísal.
    $poznam=mysql_fetch_array($oznam_n);
	$id_oznamu=$poznam["id_oznamu"];
   }
  } 
  elseif($operacia=="Oprav") {
   $text .="opravený!";
   $id_oznamu=$_POST["id_oznamu"]; //Zistenie id čláku, ktorý sa práve opravil
  }
  elseif($operacia=="vymazane") {  
   $text .="zmazaný!";
  }
  else $text .="zmenený!";
  stav_dobre($text); 
 }
}
if (@$co=="del_oznam") $vysledok="ok"; //Aby sa nezobrazil formulár pri mazaní článku 
if  (@$vysledok<>"ok") {
  echo("<form name=\"zadanie\" action=\"./index.php?clanok=$zobr_clanok&amp;co=$co\" method=post>"); //Začiatok formulára
  if ($zobr_pol>0){ //Načítanie údajov, keď sa ide opravovať oznam
     $navrat_e=prikaz_sql("SELECT * FROM oznam WHERE id_oznamu=$zobr_pol",
                          "Edit oznamu údaje(".__FILE__ ." on line ".__LINE__ .")","Momentálne sa nepodarilo údaje o ozname nájsť! Prosím skúste neskôr.");
     if ($navrat_e) {
      $zaz_e = mysql_fetch_array($navrat_e);
      $datum=$zaz_e["datum"];
      $nazov=$zaz_e["nazov"];
      $text=$zaz_e["text"];
      $id_reg=$zaz_e["id_reg"];
      $id_ikonka=$zaz_e["id_ikonka"];
      $mazanie=$zaz_e["mazanie"];
      echo("<input type=\"hidden\" name=\"id_oznamu\" value=\"$zaz_e[id_oznamu]\">"); //Pri oprave sa do fomulára pridá id_oznamu
     }	
  }
  echo("<div id=admin><fieldset>\n");// Formulár na zadanie/opravu údajou
  echo("<label for=\"datepicker\">Dátum:</label>"); //[RRRR-MM-DD]
  echo("<input type=\"text\" id=\"datepicker\" value=\"".StrFTime("%d.%m.%Y", strtotime($datum))."\" size=10 maxlength=10>
        <input type=\"hidden\" id=\"alternate\" name=\"datum\" size=\"10\" value=\"$datum\"/>");
  echo("<div>(Dátum kedy sa má konať daná akcia, alebo dokedy je daný oznam aktuálny. Dovtedy sa bude zobrazovať aj v strednom stĺpci)</div>");
  form_pole("nazov", "Nadpis", $nazov, "", 30);
  form_registr("id_reg", $id_reg, jeadmin());
  echo("<fieldset><legend><label for=\"id_ikonka\">Ikonka pred oznamom:</label></legend>");
  $ur_ikonky=prikaz_sql("SELECT * FROM ikonka WHERE id>0 ORDER BY id", "Výpis ikoniek (".__FILE__ ." on line ".__LINE__ .")", "");
  if ($ur_ikonky) {  // Ak bola požiadavka v DB úspešná
    echo("<div>(Označ aká ikonka sa objavý na začiatku oznamu)</div>");
    while($ikonky=mysql_fetch_array($ur_ikonky)) {
      echo("<input type=\"radio\" name=\"id\" value=\"$ikonky[id]\"");
      if ($id_ikonka==$ikonky["id"]) echo(" checked");  
      echo("><img src=\"./www/ikonky/128/".$ikonky["nazov"]."128.png\" width=32 height=32>\n");
    }
  }
  else echo("Nie je možné zmeniť z dôvodu chyby v databáze. Skúste prosím neskôr.<input type=\"hidden\" name=\"id\" value=1>"); //náhrada ak zlyhá DB
  echo("</fieldset><br />");
  form_textarea("oznam_t", "Text oznamu", $text, "", 70);
  echo("Podpis:&nbsp;".$_SESSION["prezyvka"]."<input type=\"hidden\" name=\"id_clena\" size=8 maxlength=8 value=\"".(int)$_SESSION["id"]."\">&nbsp;&nbsp;
         -&gt;&nbsp;&nbsp;<input name=\"oznamy\" type=\"submit\" value=\"");
  echo($co=="new_oznam" ? "Pridaj" : "Oprav");
  echo("\"></fieldset></form></div>");
}