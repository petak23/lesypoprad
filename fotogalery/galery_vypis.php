<!--prehliadac--> 



<!-- koniec prehliadac -->
<?php
 /* Tento súbor slúži na vypísísanie obsahu zložky fotogalérie a obsluhu pridania/opravy komentáru k akcii
   Zmena: 21.09.2011 - PV
   Časti, ktoré sú zakomentované cez hviezdičku sú nezaujímavé pre LesyPP
 */
if (@$bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód
 //Inicializácia premených

$text_koment_akcia="";        //Komentár člena k akcii
$vysledok="";                 //Výsledok zápisu do DB 
$naz_tit_foto="";			  //Názov titulnej fotky

$navrat_podgalery=prikaz_sql("SELECT id_polozka, nazov, popis, id_oznamu, tit_foto, pocita, DATE_FORMAT(datum,'%d.%m.%Y') as adatum, meno 
                          FROM podgaleria, clenovia 
                          WHERE podgaleria.id_clena=clenovia.id_clena AND id_polozka=$zobr_cast AND podgaleria.id_reg<=".jeadmin()." AND zobrazenie>0 LIMIT 1",  
                         "Výber akcie(".__FILE__ ." on line ".__LINE__ .")","Teraz nie je možné nájsť akciu. Skúste prosím neskôr!" ); // Výber podgalérie
if ($navrat_podgalery && mysql_numrows($navrat_podgalery)>0) { //Ak bol dotaz úspešný a niečo sa našlo
 $zaz_podgalery = mysql_fetch_array($navrat_podgalery); // Načítanie údajov o akcii a inicializacia  
 $pocet=$zaz_podgalery["pocita"]+1; //Koľko krát sa zobrazila akcia
 $navrat_fotky=prikaz_sql("SELECT * FROM fotky WHERE id_galery=$zaz_podgalery[id_polozka] ORDER BY nazov", // Výber fotiek k akcii 
                          "Výber fotiek k akcii (".__FILE__ ." on line ".__LINE__ .")", "Bohužiaľ sa nepodarilo spojiť s databázou. Skúste prosím neskôr!"); 
 if ($navrat_fotky) { //Ak bole požiadavka v DB úspešná a našli sa nejaké fotky 
  if ($zobr_co=="") //Ak ideme niečo robiť, tak nepočítam zobrazenia
   $zmena_p=prikaz_sql("UPDATE podgaleria SET pocita=$pocet WHERE id_polozka=$zaz_podgalery[id_polozka]",  // Ak bolo načítanie fotiek úspešné tak pripočítaj zobrazenie akcie 
                       "Pripočítanie akcie (".__FILE__ ." on line ".__LINE__ .")", "Chyba"); 
  $pocet_fotiek=mysql_numrows($navrat_fotky); //Počet fotiek priradených k akcii
  if ($pocet_fotiek>0) { //Ak boli nájdené fotky k galérii
   while($vyp_min=mysql_fetch_array($navrat_fotky)){
    if ($zaz_podgalery["tit_foto"]==$vyp_min["id_foto"]) $naz_tit_foto=$vyp_min["nazov"]; //Názov súboru titulnej fotky z databázy
   }
   /*
   if ($naz_tit_foto<>"") echo("<div class=oznam><div class=imga><img src=\"./fotogalery/small/$naz_tit_foto\" ></div>"); 
   else echo("<div class=oznam><img src=\"./images/bez_titulky.gif\" >");
   */
  }
  //else echo("<div class=oznam><img src=\"./images/bez_titulky.gif\" >");
  if ($zobr_co=="title_podgalery") $text="<br />Určenie titulnej fotky";           //Určenie druhej časti podnadpisu
  elseif ($zobr_co=="add_podgalery") $text="<br />Pridanie fotiek do albumu"; 
  elseif ($zobr_co=="odstr_podgalery") $text="<br />Odobratie fotiek z albumu";
  else $text="";
  echo("<h2>$zaz_podgalery[nazov] $zaz_podgalery[adatum]<span>&nbsp;- fotiek: $pocet_fotiek</span>$text</h2>"); //Nadpis akcie
  if (jeadmin()>2) { //Časť prístupná len pre správcu a admina
   $odkaz="./index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol&amp;cast=$zobr_cast"; //Vytvorenie kmeňa odkazu 
   echo("<p class=\"oznam menu\">");  //Menu pre obsluhu podgalérie
   echo("<a href=\"$odkaz&amp;co=edit_podgalery\" title=\"Editácia albumu\">Editácia albumu</a>");
   echo("&nbsp;|&nbsp;<a href=\"$odkaz&amp;co=del_podgalery\" title=\"Vymazanie albumu\">Vymazanie albumu</a>");
   echo("&nbsp;|&nbsp;<a href=\"$odkaz&amp;co=add_podgalery\" title=\"Pridanie fotiek do albumu\">Pridanie fotiek</a>");
   echo("&nbsp;|&nbsp;<a href=\"$odkaz&amp;co=odstr_podgalery\" title=\"Odobratie fotiek z albumu\">Odobratie fotiek</a>");
   echo("<br /><a href=\"$odkaz&amp;co=title_podgalery\" title=\"Určenie titulnej fotky albumu\">Určenie titulnej fotky</a></p>");
  }
  /* Pre lesy PP toto nie je nutné vidieť
  if ($zobr_co=="") { //Ak ideme niečo robiť, tak toto nie je nutné vidieť
   echo("<p class=oznam><br />");
   echo("Zobrazená: <b>$pocet</b> x&nbsp;|&nbsp;"); 
   echo("Pridal: <b>$zaz_podgalery[meno]</b><br />");
   echo("$zaz_podgalery[popis] </p>"); 
  }*/
  //if ($pocet_fotiek>0) {
   if ($zobr_co=="add_podgalery") { //Ak idem pridávať fotky do podgalérie tak vyberem fotky, kde nie je priradená podgaléria
    $navrat_fotky=prikaz_sql("SELECT * FROM fotky WHERE id_galery=0 ORDER BY nazov", // Výber fotiek k podgalérii 
                             "Výber fotiek k podgalérii (".__FILE__ ." on line ".__LINE__ .")", "Bohužiaľ sa nepodarilo spojiť s databázou. Skúste prosím neskôr!"); 
   }
   else if ($pocet_fotiek>0) mysql_data_seek($navrat_fotky,0); //Ak nepridávam fotky presun pointeru na začiatok DB tabuľky ak mám nejaké fotky
   //echo("<table id=kategoriaF border=0 cellpadding=0 cellspacing=0><tr>");
   
   $i=1;
   if ($zobr_co=="title_podgalery" OR ($zobr_co=="add_podgalery" AND mysql_numrows($navrat_fotky)>0) OR $zobr_co=="odstr_podgalery") { // Začiatok formulára pre zadanie údajov v prípade voľby titulnej fotky
    echo("\n<form name=\"praca_fotka\" action=\"./index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol&amp;cast=$zobr_cast\" method=post>");	
   }
   echo("<div class=\"albumRiadok\">"); //Začiatok riadku
   if ($zobr_co=="add_podgalery" AND mysql_numrows($navrat_fotky)==0) { //Ak chcem pridať fotky do galérie, ale žiadna sa nenašla.
    //echo("<td>");
	echo("<div>");
    stav_zle("V databáze sa nenašla žiadna nepriradená fotka!");
	//echo("</td>");
	echo("</div>");
   }
   while($vyp_min=mysql_fetch_array($navrat_fotky)){ // Vykreslenie miniatúr obrázkov 
    //echo("<td>");
	echo("<div>");
	if ($zobr_co=="title_podgalery") { //Pridanie formulárového prvku ak volím titulnú fotku
	 echo("\n<input type=\"radio\" id=\"pr_tit_foto\" name=\"pr_tit_foto\" value=\"$vyp_min[id_foto]\""); 
	 if ($zaz_podgalery["tit_foto"]==$vyp_min["id_foto"]) echo(" checked");
     echo("><img src=\"./fotogalery/small/$vyp_min[nazov]\" alt=\"$zaz_podgalery[nazov]\" />");
	}
	elseif ($zobr_co=="add_podgalery") { //Pridanie formulárového prvku ak pridávam fotky do galérie
	 if (mysql_numrows($navrat_fotky)>0) { //Ak sa našli fotky na pridanie
	  echo("<input type=checkbox name=\"prid_foto[]\" value=$vyp_min[id_foto]>");
	  echo("<a href=\"./fotogalery/images/$vyp_min[nazov]\" title=\"$vyp_min[id_foto]\" rel=\"fotky\">
           <img src=\"./fotogalery/small/$vyp_min[nazov]\" alt=\"$vyp_min[id_foto]\" /></a>");    
	 }
	 else {                                //Ak sa nenašli fotky na pridanie
	  stav_zle("V databáze sa nenašla žiadna nepriradená fotka!");
	 }
	}
	elseif ($zobr_co=="odstr_podgalery") { //Pridanie formulárového prvku ak odoberám fotky z galérie
	 if (mysql_numrows($navrat_fotky)>0) { //Ak sa našli fotky na odobratie
	  echo("<input type=checkbox name=\"odober_foto[]\" value=$vyp_min[id_foto]>");
	  echo("<a href=\"./fotogalery/images/$vyp_min[nazov]\" title=\"$vyp_min[id_foto]\" rel=\"fotky\">
           <img src=\"./fotogalery/small/$vyp_min[nazov]\" alt=\"$vyp_min[id_foto]\" /></a>");    
	 }
	 else {                                //Ak sa nenašli fotky na odobratie
	  stav_zle("V databáze sa nenašla žiadna fotka!");
	 }
	}
	else {                                 //Ak len zobrazujem fotky z galérie
     echo("<a href=\"./fotogalery/images/$vyp_min[nazov]\" title=\"$zaz_podgalery[nazov]\" rel=\"fotky\">
           <img src=\"./fotogalery/small/$vyp_min[nazov]\" alt=\"$zaz_podgalery[nazov]\" /></a>");
    }
    //echo("</td>");
	echo("</div>");
    if ($i==4) {
	 $i=1;
	 //echo("</tr><tr>");
	 echo("</div><div class=\"albumRiadok\">");
	} 
	else $i++;
   }
   //echo("</tr></table>");
   echo("</div>");
   if ($zobr_co=="title_podgalery" OR ($zobr_co=="add_podgalery" AND mysql_numrows($navrat_fotky)>0) OR $zobr_co=="odstr_podgalery" ) {
      //V prípade, že sa niečo robí tak pridám na koniec ukončenie formulára
    if ($zobr_co=="odstr_podgalery") echo("<input type=\"hidden\" name=\"pr_title_foto\" value=\"$zaz_podgalery[tit_foto]\">");
	echo("<input type=\"hidden\" name=\"pr_id_polozka\" value=\"$zaz_podgalery[id_polozka]\">");
	echo("&nbsp;&nbsp;&nbsp;&nbsp;<input name=\"".$zobr_co."_tl\" type=\"submit\" value=\"Vyber\">");
   }	
  //}
  echo("</div>");
  if ($zobr_co=="title_podgalery" OR ($zobr_co=="add_podgalery" AND mysql_numrows($navrat_fotky)>0) OR $zobr_co=="odstr_podgalery" ) echo("</form>");
 }
 //else { //Ak sa nepodarilo nájsť fotky v DB kôli chybe, alebo fotky niesú
 //echo("</div>"); //Ak sa nepodarilo nájsť fotky v DB kôli chybe
 // if (mysql_numrows($navrat_fotky)==0) stav_zle("K danej podgalérii sa nenašli priradené žiadne fotky!");
 //}
}
else if (mysql_numrows($navrat_podgalery)==0) stav_zle("Daný album sa nenašiel, alebo ho nieje možné zobraziť!");
?>