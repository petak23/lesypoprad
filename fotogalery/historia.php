<?php 
/* Tento súbor slúži na vypísanie histórie fotogalérie
   Zmena: 10.12.2010 - PV
*/
if (@$bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód
//echo("<div id=foto_history>"); // <div align=center id=oznamy>
@$nav_hist=prikaz_sql("SELECT id_polozka, text, DATE_FORMAT(datum,'%d.%m.%Y') as hdatum FROM historia ORDER BY datum DESC",
                      "Načítanie histórie(".__FILE__ ." on line ".__LINE__ .")","Žiaľ sa momentálne nepodarilo históriu vypísať! Skúste neskôr.");
if ($nav_hist AND mysql_numrows($nav_hist)>0) {       //Ak bola požiadavka úspešná a je čo vypisovať
$pomoc=TRUE;
 while ($hist_pol = mysql_fetch_array($nav_hist)){
  if ($pomoc) {  //1. položka vo výpise
   echo("<h2 class=uvod>Novoty:</h2>");
   echo("<p class=uvod><b>$hist_pol[hdatum]&nbsp;-&nbsp;$hist_pol[text]<la/b></p>"); //</p>
   echo("<h2 class=uvod>História:</h2><p class=uvod>");
   $pomoc=FALSE;
  }
  else { //Ostatné položky výpisu
   echo("&nbsp;&raquo;&nbsp;$hist_pol[hdatum]&nbsp;&nbsp;-&nbsp;&nbsp;$hist_pol[text]<br />");
  }
 }
 echo("</p>");
}
//echo("</div>");//</div>
?>
