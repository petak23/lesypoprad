<?php
/* Tento súbor slúži na obsluhu výpisu článkou
   Zmena: 09.01.2012 - PV
*/
if (@$bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód
if ($zobr_pol>0){  //Ide sa zobrazovať konkrétny článok
  if ($zobr_cast>0) $hladaj=$zobr_cast; else $hladaj=$zobr_pol;
  /*$clanok_vyb=prikaz_sql("SELECT id_clanok, id_hlavne_menu, podclanok, DATE_FORMAT(datum,'%d.%m.%Y') as datum1, DATE_FORMAT(datum_platnosti,'%d.%m.%Y') as datum_pl,
                                 clanok.nazov as nazov, text, meno, id_typ, ikonka.nazov as inazov, clenovia.id_clena as c_clena, pocitadlo, clanok.id_ikonka as iikonka
                          FROM clanok, clenovia, ikonka 
                          WHERE clanok.id_clena=clenovia.id_clena AND clanok.id_ikonka=ikonka.id_ikonka AND 
						        id_clanok=$hladaj AND zmazane=0 LIMIT 1",
  						 "Nájdenie článku (".__FILE__ ." on line ".__LINE__ .")","Žiaľ doško k chybe v databáze. Prosím skúste neskôr!",1);*/ //AND id_reg<=".jeadmin()."
  $clanok_vyb=prikaz_sql("SELECT id_clanok, id_hlavne_menu, podclanok, DATE_FORMAT(datum,'%d.%m.%Y') as datum1, DATE_FORMAT(datum_platnosti,'%d.%m.%Y') as datum_pl,
                                 clanok.nazov as nazov, text, meno, id_typ, clenovia.id_clena as c_clena, pocitadlo, clanok.id_ikonka as iikonka, postscript
                          FROM clanok, clenovia WHERE clanok.id_clena=clenovia.id_clena AND id_clanok=$hladaj AND zmazane=0 LIMIT 1",
  						 "Nájdenie článku (".__FILE__ ." on line ".__LINE__ .")","Žiaľ doško k chybe v databáze. Prosím skúste neskôr!");						 
  if ($clanok_vyb && mysql_numrows($clanok_vyb)==1) { //Ak bol vyber v DB uspesny a našiel sa članok
   $zaznam_cl = mysql_fetch_array($clanok_vyb);
   if ($zobr_co=="edit_clanok") { //Ak idem editovať konkrétny článok 
    include("./function/edit_clanok.php");
   }
   elseif ($zobr_co=="del_clanok") { //Ak chcem zmazať konkrétny článok
	if (@$_REQUEST["clanky_edit"]=="Nie") {
	 stav_dobre("Vymazanie bolo stornované!");
	}
	else include("./function/edit_clanok.php");
   }
   else { //Ak idem článok len zobraziť
    $zaznam_cl["pocitadlo"]++;
    $clanok_vyb=prikaz_sql("UPDATE clanok SET pocitadlo=pocitadlo+1 WHERE id_clanok=$hladaj LIMIT 1",
  	 					   "Update počítadla (".__FILE__ ." on line ".__LINE__ .")","Žiaľ doško k chybe v databáze. Prosím skúste neskôr!");
    echo("<h2>$zaznam_cl[nazov]</h2>");
    echo("<span class=\"datum\">$zaznam_cl[datum1]");
	if (jeadmin()>2) {
	 echo("&nbsp;&nbsp;|&nbsp;&nbsp;Zobrazení: $zaznam_cl[pocitadlo]");
     echo($zaznam_cl["id_typ"]==1 ? "&nbsp;&nbsp;|&nbsp;&nbsp;Článok je aktuálny do: <b>$zaznam_cl[datum_pl]!</b>" : "");	  
     echo("&nbsp;&nbsp;|&nbsp;&nbsp;Článok pridal: <b>$zaznam_cl[meno]</b><br />");
	}
	echo("</span>");
    //Vypísanie odkazov na podčlánky
    $me1_clanky=prikaz_sql("SELECT id_clanok, nazov FROM clanok 
                           WHERE id_hlavne_menu=$zobr_pol AND id_reg<=".jeadmin()." AND zmazane=0 AND (podclanok=1 OR podclanok=3)
						   ORDER BY nazov", //, DATE_FORMAT(datum,'%d.%m.%Y') as datum1
                           "Výpis podčlánkov (".__FILE__ ." on line ".__LINE__ .")","Podčlánky sa nenašli! Nabudúce...");
    if ($me1_clanky AND mysql_numrows($me1_clanky)>0) { //Ak bola požiadavka v DB úspešná a ak je počet návratových hodnôt viac ako 0.
	 echo("<ul id=\"sub2\">"); 
     while ($pclanky1 = mysql_fetch_array($me1_clanky)) {
	  echo("<li><a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol&amp;cast=$pclanky1[id_clanok]\" title=\"$pclanky1[nazov]\">
	        $pclanky1[nazov]</a></li>"); 
	 }
	 echo("</ul>");
	} //Koniec výpisu odkazov na podčlánky
    echo("<div id=\"oznamy\">");
	//if ($zaznam_cl["iikonka"]>0) echo("<img src=\"./images/ikonky/128/".$zaznam_cl["inazov"]."128.png\" width=96 height=96 class=far128><br />");
	$odkaz="index.php?clanok=$zobr_clanok&amp;id_clanok="; //vytvorenie odkazu
	if ($zaznam_cl["podclanok"]==0) $odkaz=$odkaz."$zaznam_cl[id_clanok]"; //Ak je to článok
	else $odkaz=$odkaz."$zaznam_cl[id_hlavne_menu]&amp;cast=$zaznam_cl[id_clanok]";
	if (@(int)$zaznam_cl["c_clena"]==@(int)$_SESSION["id"]) {
  	 echo("<p class=\"oznam\">");
	 if ($zobr_cast==0) { //Výpis odkazov pre článok
	    echo("<a href=\"$odkaz&amp;co=edit_clanok\" title=\"Editácia článku\">Editácia článku</a>");
	    echo("&nbsp;|&nbsp;<a href=\"$odkaz&amp;co=del_clanok\" title=\"Vymazanie článku\">Vymazanie článku</a>");
		if ($zaznam_cl["id_clanok"]>3) //id_clanok>2 je len preto aby sa mi odkaz nezobrazil pri o nás, kontakty, cert. FSC
	    echo("&nbsp;|&nbsp;<a href=\"$odkaz&amp;co=new_clanok\" title=\"Pridanie podčlánku\">Pridanie podčlánku</a>");
	 }
	 else {
	    echo("<a href=\"$odkaz&amp;co=edit_clanok\" title=\"Editácia podčlánku\">Editácia podčlánku</a>");
	    echo("&nbsp;|&nbsp;<a href=\"$odkaz&amp;co=del_clanok\" title=\"Vymazanie podčlánku\">Vymazanie podčlánku</a>");
	 }
	 echo("</p>");
	}
    elseif (jeadmin()==5) { //Možnosť editácie pre ADMINA aj tam kde inak nemá prístup lebo to zadal niekto iný
	 echo("<p class=\"oznam\"><a href=\"$odkaz&amp;co=edit_clanok\" title=\"Editácia článku\">Editácia článku ako ADMIN</a>");
	 echo("&nbsp;|&nbsp;<a href=\"$odkaz&amp;co=del_clanok\" title=\"Vymazanie článku\">Vymazanie článku ako ADMIN</a>");
	 if ($zobr_cast==0 AND $zaznam_cl["id_clanok"]>2) //id_clanok>2 je len preto aby sa mi odkaz nezobrazil pri o nás a kontakty
 	  echo("&nbsp;|&nbsp;<a href=\"$odkaz&amp;co=new_clanok\" title=\"Pridanie podčlánku\">Pridanie podčlánku ako ADMIN</a>");
	 echo("</p>");
    }	
	echo("$zaznam_cl[text]");
	if ($zaznam_cl["postscript"]<>NULL) include($zaznam_cl["postscript"]);
	echo("</div>");
   }
   //if ($zaznam_cl["postscript"]<>NULL) include($zaznam_cl["postscript"]);
  }
  else stav_zle("Došlo k chybe. Nič som nenašiel!");
}
else { //Ak sa práve nezobrazuje žiaden konkrétny článok vyberie všetky články kde je príslušnosť k hl. menu: článok
 if ($zobr_co=="new_clanok") include("./function/edit_clanok.php");
 else {
  $me_clanky=prikaz_sql("SELECT id_clanok, DATE_FORMAT(datum,'%d.%m.%Y') as datum1, clenovia.id_clena as c_clena, meno, pocitadlo, clanok.nazov as nazov, 
                                DATE_FORMAT(datum_platnosti,'%d.%m.%Y') as datum_pl, id_typ, id_ikonka
                         FROM clanok, clenovia
                         WHERE clanok.id_clena=clenovia.id_clena AND id_hlavne_menu=$zobr_clanok AND clanok.id_reg<=".jeadmin()." 
						       AND zmazane=0
	 					 ORDER BY datum DESC LIMIT 30",
  	 				   "Nájdenie článku (".__FILE__ ." on line ".__LINE__ .")","Žiaľ došlo k chybe v databáze. Prosím skúste neskôr!");
  if ($me_clanky) {  //Ak bola požiadavka v DB úspešná
   if (mysql_numrows($me_clanky)>0) { //Ak je počet návratových hodnôt viac ako 0
    while ($pclanky = mysql_fetch_array($me_clanky)){
	 $pomtxt="";
	 if ($pclanky["id_ikonka"]==-1){ //Test či to nie je "prázdny" článok. Ak áno nájdi 1. podčlánok
	  $me1_clanky=prikaz_sql("SELECT id_clanok, nazov FROM clanok 
                              WHERE id_hlavne_menu=$pclanky[id_clanok] AND id_reg<=".jeadmin()." AND zmazane=0 AND podclanok>0
						      ORDER BY id_clanok", //, DATE_FORMAT(datum,'%d.%m.%Y') as datum1
                              "Výpis podčlánkov (".__FILE__ ." on line ".__LINE__ .")","Podčlánky sa nenašli! Nabudúce...");
	  if ($me1_clanky AND mysql_numrows($me1_clanky)>0) {
	   $pclanky1 = mysql_fetch_array($me1_clanky);
	   $pomtxt="&amp;cast=$pclanky1[id_clanok]";
	  } 
	 }
     echo("<p class=\"oznam\"><a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$pclanky[id_clanok]$pomtxt\" title=\"$pclanky[nazov]\" class=\"spec\">");
     echo("$pclanky[datum1] - $pclanky[nazov]</a>Zobrazení: <b>$pclanky[pocitadlo]</b>;&nbsp;"); 
	 if (jeadmin()>2) {
	  echo("Pridal: $pclanky[meno];&nbsp;");
 	  echo($pclanky["id_typ"]==1 ? "Článok je aktuálny do: $pclanky[datum_pl]." : "Aktuálnosť článku sa nesleduje.");
	 }
	 if (@(int)$pclanky["c_clena"]==@(int)$_SESSION["id"]) {
	  echo("&nbsp;<a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$pclanky[id_clanok]&amp;co=edit_clanok\" title=\"Editácia článku\">Editácia článku</a>");
	  echo("&nbsp;|&nbsp;<a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$pclanky[id_clanok]&amp;co=del_clanok\" title=\"Vymazanie článku\">Vymazanie článku</a>");
	 } 
	 echo("</p>");
    }  
   }
   else {
    echo("<h2>V tejto časti ešte nie je žiaden článok zadaný!</h2>");
	if (jeadmin()>2) {
	 echo("<p class=\"uvod\"><a href=\"index.php?clanok=$zobr_clanok&amp;co=new_clanok\" title=\"Pridanie článku do časti\">Môžete ho pridať tu!</a></p>");
	}
   }
  }
 }
} 
?>
