<?php
 /* Tento súbor vypísanie názvov článkov a sub menu, ktoré mu prislúcha a
    názvy člankov, ktoré mu prislúchajú a odkazy na nich
    Zmena: 13.02.2017 - PV
*/
if ($bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód
$hl_menu=prikaz_sql("SELECT * FROM old_hlavne_menu WHERE id_hlavne_menu>0 AND id_reg<=".jeadmin()." ORDER BY id_hlavne_menu", //Načítanie hlavného menu z DB
	                     "Hlavne menu (".__FILE__ ." on line ".__LINE__ .")","Došlo k chybe a hlavné menu nie je možné načíta. Prosím skúste neskôr"); 
if ($hl_menu) { //Ak bol dotaz v DB úspešný 
  $ip=1;
  while ($hl_menu_v=mysql_fetch_array($hl_menu)) {
    $pocet_sub_menu=0;  // Zistenie počtu nadpisov článkov a položiek sub_menu na vypísanie - inicializácia
    $sub_menu1=prikaz_sql("SELECT polozka FROM sub_menu WHERE id_hl_menu=$hl_menu_v[id_hlavne_menu] AND zobrazenie=1 AND id_reg<=".jeadmin(),
                          "Počet položiek sub-menu (".__FILE__ ." on line ".__LINE__ .")","");
    if ($sub_menu1 AND mysql_numrows($sub_menu1)>0) $pocet_sub_menu=$pocet_sub_menu+mysql_numrows($sub_menu1); //Ak bola požiadavka v DB úspešná a ak sa našli položky sub-menu
    $me_clanky1=prikaz_sql("SELECT id_clanok FROM clanok WHERE id_hlavne_menu=$hl_menu_v[id_hlavne_menu] AND podclanok=0 AND id_reg<=".jeadmin(),
                          "Počet článkov (".__FILE__ ." on line ".__LINE__ .")","");
    if ($me_clanky1 AND mysql_numrows($me_clanky1)>0) $pocet_sub_menu=$pocet_sub_menu+mysql_numrows($me_clanky1);  //Ak bola požiadavka v DB úspešná a ak je počet návratových hodnôt viac ako 0.
    //---------------- Koniec zistenia počtu -------------------
    echo($ip==1 ? "<li style=\"border-top: none;\"" : "<li"); //Začiatok LI základnej 0. úrovne - hlavné menu
	$class_li=""; //Tvorba class-u pre položku hl. menu
	if ($hl_menu_v["id_reg"]>2) $class_li="adminPol"; //Ak je to administračná položka
	if ($hl_menu_v["id_hlavne_menu"]==$zobr_clanok) $class_li=$class_li." aktivny"; //Ak je to aktívna položka
	echo($class_li<>"" ? " class=\"$class_li\">" : ">"); //Pridanie class-u
	echo("<a href=\"./index.php?clanok=$hl_menu_v[id_hlavne_menu]\" title=\"$hl_menu_v[title]&nbsp;[Klávesová skratka $hl_menu_v[kl_skratka]]\" 
	       accesskey=\"$hl_menu_v[kl_skratka]\" tabindex=\"$ip\">".ltrim($hl_menu_v["nazov"])."</a>\n"); //Zákl. odkaz s odstránením prázdnych reťazcov zo začiatku názvu
	$ip++;
    if ($hl_menu_v["id_hlavne_menu"]==$zobr_clanok AND $zobr_clanok>1) { //Pre aktívnu položku hlavného menu vypíš príslušné sub menu
    //----*********************--- Výpis podmenu, článkov, podčlánkov pre aktívnu položku---*********************---
	 if ($pocet_sub_menu>0 OR $hl_menu_v["clanky"]==1 OR $zobr_clanok==$index_oznam) echo("<ul id=sub1>\n");//Začiatok 1. úrovne t.j. sub menu sa zobrazí ak je čo vypisovať, alebo je možné pridať článok
      //Výpis operácií pre danú kategóriu napr. pridanie článku ...
     if (jeadmin()>=3) { //Pridávanie článku a oznamu je možné len od úrovne regist. 3
       if ($hl_menu_v["clanky"]==1 AND $hl_menu_v["id_hlavne_menu"]<>9) { //Odkaz pre pridanie článku do časti len ak je to možné  a ak nie je o nás a kontakty
        echo("<li><a href=\"index.php?clanok=$hl_menu_v[id_hlavne_menu]&amp;co=new_clanok\" title=\"Pridanie článku do časti\" >
              Pridanie článku do časti $hl_menu_v[nazov]</a></li>\n"); 
       }
       if ($zobr_clanok==$index_oznam) { //Odkaz pre pridávanie oznamu v časti oznamov  
        echo("<li><a href=\"index.php?clanok=$zobr_clanok&amp;co=new_oznam\" title=\"Pridanie nového oznamu\">Pridanie oznamu</a></li>\n");
       }
     }
      //---------------- Koniec výpisu operácií -----------------
     // -------------- Vypísanie bočnej ponuky t.j. názvy článkov a sub_menu ----------------
     if ($pocet_sub_menu>0) { // Ak je čo vypisovať t.j. našli sa články alebo sub_menu
      if ($zobr_clanok>0) {    //Ak je premenná clanok >0, tak najdi id a nazov položky sub menu
       $sub_menu=prikaz_sql("SELECT sub_menu.nazov as snazov, id_sub_menu, sub_menu.clanky as prir_cl FROM sub_menu, old_hlavne_menu 
                             WHERE sub_menu.id_hl_menu=old_hlavne_menu.id_hlavne_menu AND id_hl_menu=$zobr_clanok AND sub_menu.id_reg<=".jeadmin()." AND zobrazenie>0
		 	         			 ORDER BY sub_menu.nazov",
                            "Výber položiek sub-menu (".__FILE__ ." on line ".__LINE__ .")","Pod-menu sa nenašlo! Nabudúce...");
       if ($sub_menu && mysql_numrows($sub_menu)>0)  //Ak bola požiadavka v DB úspešná a ak sa našli položky sub-menu
	    //echo("<ul>");
        while ($sub_pol = mysql_fetch_array($sub_menu)) {  //Vypísanie položiek sub-menu
		 if ($sub_pol["id_sub_menu"]==$zobr_pol) { 
		  echo("<li class=aktivny2>$sub_pol[snazov]</li>\n");    //LI úrovne 1 pre sub menu pre aktívnu položku
		  $omrvinky["id_clanok"]["url"]=$sub_pol["id_sub_menu"]; //Pre omrvinky
          $omrvinky["id_clanok"]["txt"]=$sub_pol["snazov"];
		 }
		 else                                     //LI úrovne 1 pre sub menu pre NEaktívnu položku
		  echo("<li><a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$sub_pol[id_sub_menu]\" title=\"$sub_pol[snazov]\">$sub_pol[snazov]</a></li>\n");
        }
      } //Nasleduje vypísanie odkazov na príslušné články
      $me_clanky=prikaz_sql("SELECT id_clanok, nazov, DATE_FORMAT(datum,'%d.%m.%Y') as datum1, id_ikonka FROM clanok 
                             WHERE id_hlavne_menu=$zobr_clanok AND id_reg<=".jeadmin()." AND zmazane=0 AND podclanok=0 ORDER BY datum DESC",
                            "Výpis článkov (".__FILE__ ." on line ".__LINE__ .")","Články sa nenašli! Nabudúce...");
     if ($me_clanky AND mysql_numrows($me_clanky)>0)  //Ak bola požiadavka v DB úspešná a ak je počet návratových hodnôt viac ako 0.
      while ($pclanky = mysql_fetch_array($me_clanky)) { 
       if ($pclanky["id_ikonka"]>-1) {  //Výpis odkazu na klasický článok
	    echo($pclanky["id_clanok"]==$zobr_pol ? "<li class=aktivny2>" : "<li>"); //Začiatok č.1 LI úrovne 1
	    if ($zobr_pol<>$pclanky["id_clanok"]) {
         echo("<a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$pclanky[id_clanok]\" title=\"$pclanky[nazov]\"");
	     echo($pclanky["id_clanok"]==$zobr_pol ? " class=aktivny2>" : ">");
		}
        if (@$pclanky["id_clanok"]==$zobr_pol) { //Pre omrvinky
	      $omrvinky["id_clanok"]["url"]=$pclanky["id_clanok"];
          $omrvinky["id_clanok"]["txt"]=$pclanky["nazov"];
	     }		
		echo($hl_udaje["sub_menu_date"]>0 ? "$pclanky[datum1]&nbsp;-&nbsp;$pclanky[nazov]" : "$pclanky[nazov]"); //Či sa má zobraziť aj dátum
		if ($zobr_pol<>$pclanky["id_clanok"]) 
		 echo("</a>");
       }	 
       else {                          // Výpis odkazu na "prázdny" článok
        echo($pclanky["id_clanok"]==$zobr_pol ? "<li class=aktivny2>" : "<li>"); //Začiatok č.2 LI úrovne 1
		if (@$pclanky["id_clanok"]==$zobr_pol) { //Pre omrvinky
	      $omrvinky["id_clanok"]["url"]=$pclanky["id_clanok"];
          $omrvinky["id_clanok"]["txt"]=$pclanky["nazov"];
	     }
	    echo($hl_udaje["sub_menu_date"]>0 ? "$pclanky[datum1]&nbsp;-&nbsp;$pclanky[nazov]" : "$pclanky[nazov]"); //Či sa má zobraziť aj dátum
        if (jeadmin()>=3 AND $zobr_pol==$pclanky["id_clanok"]) // Odkaz na pridanie podčlánku
         echo("<ul id=sub2><li><a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$pclanky[id_clanok]&amp;co=new_clanok\" title=\"Pridanie podčlánku\">Pridanie podčlánku</a></li></ul>");
       }
       echo("</li>\n");	   //Koniec č.1 a 2 LI úrovne 1
      }
     }
    //---************************--- KONIEC Výpis podmenu, článkov, podčlánkov ---*****************************---
    if ($pocet_sub_menu>0 OR $hl_menu_v["clanky"]==1 OR $zobr_clanok==$index_oznam) echo("</ul>");	//Ukončenie 1. úrovne - sub menu
    }
	echo("</li>"); //Ukončenie základnej 0. úrovne - hlavné menu
  }
}