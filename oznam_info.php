<?php
/* Tento súbor slúži na obsluhu výpisu a editácie oznamu
   Zmena: 13.02.2017 - PV
*/
if (@$bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód

if ($zobr_pol>0){  //Ide sa zobrazovať konkrétny oznam
  $oznam_vyb=prikaz_sql("SELECT oznam.id as oid, datum_platnosti, DATE_FORMAT(datum_zadania,'%d.%m.%Y') as pdatum, text, oznam.nazov as onazov, meno, priezvisko, ikonka.nazov as inazov, user_profiles.id as c_clena 
                         FROM oznam, user_profiles, ikonka
                         WHERE oznam.id_user_profiles=user_profiles.id AND oznam.id=$zobr_pol AND oznam.id_ikonka=ikonka.id LIMIT 1",
                        "Nájdenie oznamu (".__FILE__ ." on line ".__LINE__ .")","Žiaľ doško k chybe v databáze. Prosím skúste neskôr!");
  if ($oznam_vyb) { //Ak bol vyber v DB uspesny
   $oznam = mysql_fetch_array($oznam_vyb);
   if ($zobr_co=="edit_oznam") { //Ak idem editovať konkrétny oznam 
    include("./function/edit_oznam.php");
   }
   else {
    $oznam_datum=StrFTime("%d.%m.%Y", strtotime($oznam["datum_platnosti"]));
    echo("<h2>Oznam:</h2>");
    if ($oznam["inazov"] != "---") {
      echo("<img src=\"./www/ikonky/128/".$oznam["inazov"]."128.png\" style=\"float: left; margin: 0px 10px 0px 5px; \" width=96 height=96  class=\"far".vyp_oznam($oznam["datum_platnosti"])."\">"); 
    }
    echo("<div id=oznamy><h3>$oznam[onazov]</h3><p><span>Pridané $oznam[pdatum]");
    if (jeadmin()>2) echo(" | Platí do: ".$oznam_datum);
    echo("</span>");
    if (@(int)$oznam["c_clena"]==(int)@$_SESSION["id"]) {
	  echo("<br />&nbsp;<a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$oznam[oid]&amp;co=edit_oznam\" title=\"Editácia oznamu\">Editácia oznamu</a>");
    }
	elseif (jeadmin()==5) { //Možnosť editácie pre ADMINA aj tam kde inak nemá prístup lebo to zadal niekto iný
	  echo("<br />&nbsp;<a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$oznam[oid]&amp;co=edit_oznam\" title=\"Editácia oznamu\">Editácia oznamu ako ADMIN</a>");
    }
    echo("</span></p>");
    echo("<p class=oznam>$oznam[text]");
    if (jeadmin()>2) echo("<br /><span><b>$oznam[meno] $oznam[priezvisko]</b></span>");
    echo("</p></div>");
   }
  }  
}
else { //Výpis všetkých oznamov
 if ($zobr_co=="new_oznam") include("./function/edit_oznam.php");
 else {
 echo("<h2>Oznamy: </h2>");
 $datumc_ozn=StrFTime("%Y-%m-%d",strtotime("0 day"));   // Aktuálne oznamy sú tie čo nie sú staršie ako dnes
 $navrat_oznam=prikaz_sql("SELECT oznam.id as oid, datum_platnosti, DATE_FORMAT(datum_zadania,'%d.%m.%Y') as pdatum, oznam.nazov as onazov, text, ikonka.nazov as inazov, user_profiles.id as c_clena 
                           FROM oznam, user_profiles, ikonka  
                           WHERE oznam.id_user_profiles=user_profiles.id AND oznam.id_ikonka=ikonka.id AND oznam.id_registracia<=".jeadmin()."
                           ORDER BY datum_platnosti DESC", //AND datum>='$datumc_ozn'
                          "Vypis akual. oznamou (".__FILE__ ." on line ".__LINE__ .")","Žiaľ doško k chybe v databáze. Prosím skúste neskôr!");
 if ($navrat_oznam AND mysql_numrows($navrat_oznam)>0) {	//Výpis aktuálnych oznamov	
  echo("<div id=oznamy>");
  while ($oznam = mysql_fetch_array($navrat_oznam)){
   $oznam_datum=StrFTime("%d.%m.%Y", strtotime($oznam["datum_platnosti"]));
   if ($oznam["datum_platnosti"]>=$datumc_ozn) {
    echo("<div class=oznam>"); //Začiatok id-oznamy
    if ($oznam["inazov"] != "---") {
      echo("<img src=\"./www/ikonky/128/".$oznam["inazov"]."128.png\" width=72 height=72 class=\"far".vyp_oznam($oznam["datum_platnosti"])." ikonky\" alt=\"Oznam - $oznam[onazov]\">");
    }
    echo("<h3>$oznam[onazov]</h3><p><span>Pridané $oznam[pdatum]");
    if (jeadmin()>2) echo(" | Platí do: ".$oznam_datum);
    echo("</span>");
    if (@(int)$oznam["c_clena"]==(int)$_SESSION["id"]) {
	  echo("<br />&nbsp;<a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$oznam[oid]&amp;co=edit_oznam\" title=\"Editácia oznamu\">Editácia oznamu</a>");
    }
    echo("<br />");
    if (strlen($oznam["text"])>150) {
     $text_oznam=substr(strip_tags($oznam["text"]),0,150)."...";
     $text_oznam=$text_oznam."<a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$oznam[oid]\" title=\"Zobrazenie celého oznamu\">&gt;&gt;&gt; celý oznam</a>";
    }
    else $text_oznam=strip_tags($oznam["text"]);
   }
   else {
    echo("<div class=\"oznam neaktivne\">"); //Začiatok id-oznamy oznam 
	echo("<h3>$oznam[onazov]</h3><p><span>Pridané $oznam[pdatum]");
    if (jeadmin()>2) echo(" | Platí do: ". $oznam_datum);
    echo("</span>");
    if (@(int)$oznam["c_clena"]==(int)$_SESSION["id"]) {
	  echo("<br />&nbsp;<a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$oznam[oid]&amp;co=edit_oznam\" title=\"Editácia oznamu\">Editácia oznamu</a>");
    }
    echo("<br />");
    if (strlen($oznam["text"])>150) {
     $text_oznam=substr(strip_tags($oznam["text"]),0,150)."...";
     $text_oznam=$text_oznam."<a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$oznam[oid]\" title=\"Zobrazenie celého oznamu\">&gt;&gt;&gt; celý oznam</a>"; //&amp;hlavicka=Oznam
    }
    else $text_oznam=strip_tags($oznam["text"]);
   }
   echo("<p>");
   echo("$text_oznam"); 
   if (jeadmin()>2) echo("<br /><span><b>$oznam[meno] $oznam[priezvisko]</b></span>");
   echo("</p>");
   echo("</div>");
  }
  echo("</div>");
 }
 else stav_dobre("Momentálne nie sú žiadne oznamy!"); // aktuálne
 }
}