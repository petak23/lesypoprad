<?php
/* Tento súbor slúži ako formulár a výpis prihlásenia člena
   Zmena: 11.05.2011 - PV
*/
if ($bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód
if ($GLOBALS["prip_db"]) { //Len ak je pripojená DB 
 $zobrazime=true;
 if ($chyba_pr<0) echo("<div class=chyba>Meno a/alebo heslo je chybné!!!</div>"); //Chybné zadanie
 elseif ($chyba_pr>0 && @(int)$_SESSION["id"]>0) { //Ak prihlásenie prebehlo úspešne a následne ses. id je viac ako 0
    $zobrazime=false;
    echo("<a href=\"./index.php?odhlas=odhlas\">odhl&aacute;s</a>");  
 }
 if ($zobrazime) { //Formulár pre prihlásenie
  echo("<form name=\"prihlas\" action=\"index.php\" method=post>");
  echo("<label for=\"prihlas_meno\">M:</label><input type=\"text\" id=\"prihlas_meno\" name=\"prihlas_meno\" size=15 maxlength=15>");
  echo("<label for=\"prihlas_heslo\">H:</label><input type=\"password\" id=\"prihlas_heslo\" name=\"prihlas_heslo\" size=15 maxlength=15>");
  echo("<input type=\"submit\" name=\"prihlas_tlac\" value=\"Prihlás\">");
  echo("<input type=\"hidden\" name=\"clanok\" value=\"$zobr_clanok\">"); //Nasledujúce položky sú tu preto, aby keď sa prihlásim
  echo("<input type=\"hidden\" name=\"id_clanok\" value=\"$zobr_pol\">"); //a nie som na úvodnej stránke po prihlásení zobrazila tá
  echo("<input type=\"hidden\" name=\"cast\" value=\"$zobr_cast\">");     //stránka, na ktorej som. hihi... komplikovaná veta...
  echo("<input type=\"hidden\" name=\"co\" value=\"$zobr_co\">");     
  echo("</form>");
 }
}
?>