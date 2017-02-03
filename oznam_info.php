<?php
/* Tento súbor slúži na obsluhu výpisu a editácie oznamu
   Zmena: 05.08.2011 - PV
*/
if (@$bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód

if ($zobr_pol>0){  //Ide sa zobrazovať konkrétny oznam
  $oznam_vyb=prikaz_sql("SELECT id_oznamu, datum, DATE_FORMAT(datum_pridania,'%d.%m.%Y') as pdatum, text, oznam.nazov as onazov, meno, pocitadlo, ikonka.nazov as inazov, clenovia.id_clena as c_clena 
                          FROM oznam, clenovia, ikonka
                          WHERE oznam.id_clena=clenovia.id_clena AND id_oznamu=$zobr_pol AND oznam.id_ikonka=ikonka.id_ikonka AND zmazane>0 LIMIT 1",
  						 "Nájdenie oznamu (".__FILE__ ." on line ".__LINE__ .")","Žiaľ doško k chybe v databáze. Prosím skúste neskôr!");
  if ($oznam_vyb) { //Ak bol vyber v DB uspesny
   $oznam = mysql_fetch_array($oznam_vyb);
   $oznam["pocitadlo"]++;
   $clanok_vyb=prikaz_sql("UPDATE oznam SET pocitadlo=pocitadlo+1 WHERE id_oznamu=$zobr_pol LIMIT 1",
  	 					  "Update počítadla (".__FILE__ ." on line ".__LINE__ .")","Žiaľ doško k chybe v databáze. Prosím skúste neskôr!");
   if ($zobr_co=="edit_oznam") { //Ak idem editovať konkrétny oznam 
    include("./function/edit_oznam.php");
   }
   elseif ($zobr_co=="del_oznam") { //Ak chcem zmazať konkrétny oznam
	if (@$_REQUEST["vymaz_oznam"]=="Nie") {
	 stav_dobre("Vymazanie bolo stornované!");
	}
	else include("./function/edit_oznam.php");
   }
   else {
    $oznam_datum=StrFTime("%d.%m.%Y", strtotime($oznam["datum"]));
    echo("<h2>Oznam:</h2>");
    echo("<img src=\"./ikonky/128/".$oznam["inazov"]."128.png\" style=\"float: left; margin: 0px 10px 0px 5px; \" width=96 height=96  class=\"far".vyp_oznam($oznam["datum"])."\">"); 
    echo("<div id=oznamy><h3>$oznam[onazov]</h3><p><span>Pridané $oznam[pdatum]");
    if (jeadmin()>2) echo(" | Platí do: $oznam_datum | Zobrazený: $oznam[pocitadlo]");
    echo("</span>");
    if (@(int)$oznam["c_clena"]==(int)@$_SESSION["id"]) {
	  echo("<br />&nbsp;<a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$oznam[id_oznamu]&amp;co=edit_oznam\" title=\"Editácia oznamu\">Editácia oznamu</a>");
	  echo("&nbsp;|&nbsp;<a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$oznam[id_oznamu]&amp;co=del_oznam\" title=\"Vymazanie oznamu\">Vymazanie oznamu</a>");
    }
	elseif (jeadmin()==5) { //Možnosť editácie pre ADMINA aj tam kde inak nemá prístup lebo to zadal niekto iný
	  echo("<br />&nbsp;<a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$oznam[id_oznamu]&amp;co=edit_oznam\" title=\"Editácia oznamu\">Editácia oznamu ako ADMIN</a>");
	  echo("&nbsp;|&nbsp;<a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$oznam[id_oznamu]&amp;co=del_oznam\" title=\"Vymazanie oznamu\">Vymazanie oznamu ako ADMIN</a>");
    }
    echo("</span></p>");
    echo("<p class=oznam>$oznam[text]");
    if (jeadmin()>2) echo("<br /><span><b>$oznam[meno]</b></span>");
    echo("</p></div>");
   }
  }  
}
else { //Výpis všetkých oznamov
 if ($zobr_co=="new_oznam") include("./function/edit_oznam.php");
 else {
 echo("<h2>Oznamy: </h2>");
 $datumc_ozn=StrFTime("%Y-%m-%d",strtotime("0 day"));   // Aktuálne oznamy sú tie čo nie sú staršie ako dnes
 $navrat_oznam=prikaz_sql("SELECT id_oznamu, datum, DATE_FORMAT(datum_pridania,'%d.%m.%Y') as pdatum, oznam.nazov as onazov, text, meno, ikonka.nazov as inazov, pocitadlo, clenovia.id_clena as c_clena 
                           FROM oznam, clenovia, ikonka  
						   WHERE oznam.id_clena=clenovia.id_clena AND oznam.id_ikonka=ikonka.id_ikonka AND oznam.id_reg<=".jeadmin()." AND zmazane>0
						   ORDER BY datum DESC", //AND datum>='$datumc_ozn'
						  "Vypis akual. oznamou (".__FILE__ ." on line ".__LINE__ .")","Žiaľ doško k chybe v databáze. Prosím skúste neskôr!");
 if ($navrat_oznam AND mysql_numrows($navrat_oznam)>0) {	//Výpis aktuálnych oznamov	
  echo("<div id=oznamy>");
  while ($oznam = mysql_fetch_array($navrat_oznam)){
   $oznam_datum=StrFTime("%d.%m.%Y", strtotime($oznam["datum"]));
   if ($oznam["datum"]>=$datumc_ozn) {
    echo("<div class=oznam>"); //Začiatok id-oznamy 
    echo("<img src=\"./ikonky/128/".$oznam["inazov"]."128.png\" width=72 height=72 class=\"far".vyp_oznam($oznam["datum"])." ikonky\" alt=\"Oznam - $oznam[onazov]\">");
	echo("<h3>$oznam[onazov]</h3><p><span>Pridané $oznam[pdatum]");
    if (jeadmin()>2) echo(" | Platí do: $oznam_datum | Zobrazený: $oznam[pocitadlo]");
    echo("</span>");
    if (@(int)$oznam["c_clena"]==(int)$_SESSION["id"]) {
	  echo("<br />&nbsp;<a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$oznam[id_oznamu]&amp;co=edit_oznam\" title=\"Editácia oznamu\">Editácia oznamu</a>");
	  echo("&nbsp;|&nbsp;<a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$oznam[id_oznamu]&amp;co=del_oznam\" title=\"Vymazanie oznamu\">Vymazanie oznamu</a>");
    }
	echo("<br />");
    if (strlen($oznam["text"])>150) {
     $text_oznam=substr(strip_tags($oznam["text"]),0,150)."...";
     $text_oznam=$text_oznam."<a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$oznam[id_oznamu]\" title=\"Zobrazenie celého oznamu\">&gt;&gt;&gt; celý oznam</a>"; //&amp;hlavicka=Oznam
    }
    else $text_oznam=strip_tags($oznam["text"]);
   }
   else {
    echo("<div class=\"oznam neaktivne\">"); //Začiatok id-oznamy oznam 
	echo("<h3>$oznam[onazov]</h3><p><span>Pridané $oznam[pdatum]");
    if (jeadmin()>2) echo(" | Platí do: $oznam_datum | Zobrazený: $oznam[pocitadlo]");
    echo("</span>");
    if (@(int)$oznam["c_clena"]==(int)$_SESSION["id"]) {
	  echo("<br />&nbsp;<a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$oznam[id_oznamu]&amp;co=edit_oznam\" title=\"Editácia oznamu\">Editácia oznamu</a>");
	  echo("&nbsp;|&nbsp;<a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$oznam[id_oznamu]&amp;co=del_oznam\" title=\"Vymazanie oznamu\">Vymazanie oznamu</a>");
    }
    echo("<br />");
    if (strlen($oznam["text"])>150) {
     $text_oznam=substr(strip_tags($oznam["text"]),0,150)."...";
     $text_oznam=$text_oznam."<a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$oznam[id_oznamu]\" title=\"Zobrazenie celého oznamu\">&gt;&gt;&gt; celý oznam</a>"; //&amp;hlavicka=Oznam
    }
    else $text_oznam=strip_tags($oznam["text"]);
   }
   echo("<p>");
   echo("$text_oznam"); 
   if (jeadmin()>2) echo("<br /><span><b>$oznam[meno]</b></span>");
   echo("</p>");
   echo("</div>");
  }
  echo("</div>");
 }
 else stav_dobre("Momentálne nie sú žiadne oznamy!"); // aktuálne
 }
}