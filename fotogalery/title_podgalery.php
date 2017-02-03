<?php 
/* Tento súbor slúži na určenie titulnej fotky podgalérie
   Zmena: 23.06.2011 - PV
*/
if (@$bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód
$navrat_fotky=prikaz_sql("SELECT nazov, pocitadlo FROM fotky WHERE id_galery=$zobr_cast ORDER BY nazov", // Výber fotiek k akcii 
                         "Výber fotiek k podgalérii (".__FILE__ ." on line ".__LINE__ .")", "Bohužiaľ sa nepodarilo spojiť s databázou. Skúste prosím neskôr!"); 
echo("<table id=kategoriaF border=0 cellpadding=0 cellspacing=0><tr>");$i=1;
while($vyp_min=mysql_fetch_array($navrat_fotky)){ // Vykreslenie miniatúr obrázkov 
 echo("<td>");
 echo("<a href=\"./fotogalery/images/$vyp_min[nazov]\" title=\"$vyp_min[nazov]\" rel=\"fotky\">
       <img src=\"./fotogalery/small/$vyp_min[nazov]\" alt=\"$vyp_min[nazov]\" /></a>");
 echo("</td>");
 if ($i==7) {
  $i=1;
  echo("</tr><tr>");
 } 
 else $i++;
}
echo("</tr></table>");
?>
