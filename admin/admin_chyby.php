<?php
/* Tento súbor slúži na vypísanie chybových stavou zo súboru chyby.txt
   Zmena: 06.09.2011 - PV
*/

// Hlavička stránky
if (@$bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód
if (jeadmin()>3) { //Pre admina nad úroveň 3
 if (@$_REQUEST["zmaz_chyby"]=="Vymaž výpis!") {
  $soubor=fopen("./chyby.txt", "w");
  fclose($soubor);
 }
 echo("<h2>Výpis chýb</h2><br />");
 echo("<form name=\"zadanie\" action=\"./index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol\" method=post>"); // Začiatok formulára pre zadanie údajov
 echo("<input name=\"zmaz_chyby\" type=\"submit\" value=\"Vymaž výpis!\"></form><p class=uvod>"); //&nbsp;&nbsp;<br />
 if (is_file("./chyby.txt")) readfile("./chyby.txt"); else echo("<b>Žiadne chyby.</b>");
 echo("</p>");
}
else echo("<h2>Administračná časť stránky!</h2><br />"); //Pre admina do úrovne 3
?>