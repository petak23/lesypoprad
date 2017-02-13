<?php
 /* Tento súbor vypísanie názvov článkov a sub menu, ktoré mu prislúcha a
    názvy člankov, ktoré mu prislúchajú a odkazy na nich ako mapa stránky
    Zmena: 13.02.2017 - PV
*/
if ($bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód
$hl_menu=prikaz_sql("SELECT * FROM old_hlavne_menu WHERE id_hlavne_menu>0 ORDER BY id_hlavne_menu", //Načítanie hlavného menu z DB
	                "Hlavne menu (".__FILE__ ." on line ".__LINE__ .")","Došlo k chybe a hlavné menu nie je možné načítať! Prosím, skúste neskôr."); 
if ($hl_menu) { //Ak bol dotaz v DB úspešný 
 while ($hl_menu_v=mysql_fetch_array($hl_menu)) {
  if (jeadmin()>=$hl_menu_v["id_reg"]) { //Zobrazí sa len tá položka, na ktorú je oprávnenie
   echo("<div class=\"mapaStlpec\"><h3><a href=\"./index.php?clanok=$hl_menu_v[id_hlavne_menu]\" title=\"$hl_menu_v[title]\">".ltrim($hl_menu_v["nazov"])."</a></h3>\n");
   if ($hl_menu_v["id_hlavne_menu"]>1) { //Výpis sub položiek okrem uvodu
    
    //Najdi položky sub-menu
    $sub_menu=prikaz_sql("SELECT nazov, id_sub_menu FROM sub_menu WHERE id_hl_menu=$hl_menu_v[id_hlavne_menu] AND id_reg<=".jeadmin()." AND zobrazenie>0
	          			  ORDER BY nazov",
                         "Výber položiek sub-menu (".__FILE__ ." on line ".__LINE__ .")","Pod-menu sa nenašlo! Prosím, skúste neskôr.");
    if (!$sub_menu) return;
    $me_clanky=prikaz_sql("SELECT id_clanok, nazov, id_ikonka FROM clanok 
                           WHERE id_hlavne_menu=$hl_menu_v[id_hlavne_menu] AND id_reg<=".jeadmin()." AND zmazane=0 AND podclanok=0 ORDER BY datum DESC",
                          "Výpis článkov (".__FILE__ ." on line ".__LINE__ .")","Články sa nenašli! Prosím, skúste neskôr.");
    if (!$me_clanky) return;

		$pocet=mysql_numrows($sub_menu)+mysql_numrows($me_clanky);
		if ($pocet>0) {
			echo("<ul>"); //Začiatok výpisu submenu, článkov
		}
		if (mysql_numrows($sub_menu)>0)  //Ak bola požiadavka v DB úspešná a ak sa našli položky sub-menu
     while ($sub_pol = mysql_fetch_array($sub_menu)) {  //Vypísanie položiek sub-menu
      echo("<li><a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$sub_pol[id_sub_menu]\" title=\"$sub_pol[nazov]\">$sub_pol[nazov]</a></li>");
     }
     //Nasleduje vypísanie odkazov na príslušné články

		if (mysql_numrows($me_clanky)>0)  //Ak bola požiadavka v DB úspešná a ak je počet návratových hodnôt viac ako 0.
     while ($pclanky = mysql_fetch_array($me_clanky)) { 
      if ($pclanky["id_ikonka"]>-1)  //Výpis odkazu na klasický článok
       echo("<li><a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$pclanky[id_clanok]\" title=\"$pclanky[nazov]\">$pclanky[nazov]</a></li>");
      else echo("<li>$pclanky[nazov]</li>");  // Výpis odkazu na "prázdny" článok
    }
		if ($pocet>0) {
    	echo("</ul>");
		}
   }
   echo("</div>\n");
  }
 }
}